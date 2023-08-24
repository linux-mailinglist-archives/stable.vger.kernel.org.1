Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A078769C
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbjHXRSB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbjHXRRm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D95D19B5
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28C1B67475
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3752DC433C8;
        Thu, 24 Aug 2023 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897457;
        bh=SO8WX+LFmxXr6UUmFFPArPhPPckXGDD2R/YBK9GJ1GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiA5VDNBUZhR7iEBHnPWW+xWCDMmVIKcaE7Y17lCMerM6c7udNxHyhhtDCYsp/dLg
         ZwmTHPV//Kn7abqUvZu3kpA42DJdKT0JfrRJ53kS52c6f1kpihQUsV53FeaFVrkpXU
         fZzmBmu5Og290F7L0b0MoxnFGJhtPzJ4gDDccW9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Prashanth K <quic_prashk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 028/135] usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push
Date:   Thu, 24 Aug 2023 19:08:20 +0200
Message-ID: <20230824170618.376785621@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashanth K <quic_prashk@quicinc.com>

[ Upstream commit e5990469943c711cb00bfde6338d2add6c6d0bfe ]

When serial console over USB is enabled, gs_console_connect
queues gs_console_work, where it acquires the spinlock and
queues the usb request, and this request goes to gadget layer.
Now consider a situation where gadget layer prints something
to dmesg, this will eventually call gs_console_write() which
requires cons->lock. And this causes spinlock recursion. Avoid
this by excluding usb_ep_queue from the spinlock.

 spin_lock_irqsave //needs cons->lock
 gs_console_write
	.
	.
 _printk
 __warn_printk
 dev_warn/pr_err
	.
	.
 [USB Gadget Layer]
	.
	.
 usb_ep_queue
 gs_console_work
 __gs_console_push // acquires cons->lock
 process_one_work

Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Link: https://lore.kernel.org/r/1683638872-6885-1-git-send-email-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 3b5a6430e2418..a717b53847a8e 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -917,8 +917,11 @@ static void __gs_console_push(struct gs_console *cons)
 	}
 
 	req->length = size;
+
+	spin_unlock_irq(&cons->lock);
 	if (usb_ep_queue(ep, req, GFP_ATOMIC))
 		req->length = 0;
+	spin_lock_irq(&cons->lock);
 }
 
 static void gs_console_work(struct work_struct *work)
-- 
2.40.1



