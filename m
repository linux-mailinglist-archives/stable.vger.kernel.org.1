Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388C77CA372
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjJPJGF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjJPJFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:05:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D2124
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:05:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6434C433CC;
        Mon, 16 Oct 2023 09:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447145;
        bh=1qMljqGPOi89UeD9qfms8mi2FdJ/k1E8QJDiMwpRv5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UU6fBfR+k73jaeNqfVnosFwP9FUS/1gypILfsYpkW9aN06MfiZFVaS6q60cCi/ulz
         AkhDTXjFVBTiXSYSbpeYP8EG/IgC66SjoPns/H5soesXda63KZ6xyjTBu0IGlyBHZc
         GlLzmr3D1vQZhACel5pVSkk7DnhYnCCqdGZe+Qos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.1 125/131] usb: cdnsp: Fixes issue with dequeuing not queued requests
Date:   Mon, 16 Oct 2023 10:41:48 +0200
Message-ID: <20231016084003.173159137@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit 34f08eb0ba6e4869bbfb682bf3d7d0494ffd2f87 upstream.

Gadget ACM while unloading module try to dequeue not queued usb
request which causes the kernel to crash.
Patch adds extra condition to check whether usb request is processed
by CDNSP driver.

cc: stable@vger.kernel.org
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20230713081429.326660-1-pawell@cadence.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-gadget.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struc
 	unsigned long flags;
 	int ret;
 
+	if (request->status != -EINPROGRESS)
+		return 0;
+
 	if (!pep->endpoint.desc) {
 		dev_err(pdev->dev,
 			"%s: can't dequeue to disabled endpoint\n",


