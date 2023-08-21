Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC227831A7
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjHUTwQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjHUTwO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:52:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8479011F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18AB36447C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B14C433C7;
        Mon, 21 Aug 2023 19:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647524;
        bh=iIRh+3GFTZz3w9E/zzQp5jHNkGSJoXoG9U6Uj2Xzyf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLw2lV5VCldLrZY2EdKcPNIXBHXV7HWzur++oQ9xUcZz4DvFPuRswEwzu58S/Y4se
         GMKMxS/BjNc950AIenpGVPkzeZkbDs2DIOh19KOhRC6bWAR50dDxk+d4SjnbeT2CMU
         jPAv6J5+Cr0BbJsdryhi+7O80ZOpCATIU8gPnpXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Prashanth K <quic_prashk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 045/194] usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push
Date:   Mon, 21 Aug 2023 21:40:24 +0200
Message-ID: <20230821194124.783579687@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
index ea2c5b6cde8cd..3c51355ccc94d 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -915,8 +915,11 @@ static void __gs_console_push(struct gs_console *cons)
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



