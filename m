Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF975D2D9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjGUTEV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjGUTEU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7030CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7205761D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3CAC433CA;
        Fri, 21 Jul 2023 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966258;
        bh=iRHQi0OSE+CSjLhVrWFU4+s1i2D1Op5CsbfrJUruyis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYrepRCT3Z3N6a04EU+la4SSXmU7d8R8JB811g43bVrnMOOYCFn24WcaGfz47sCzu
         kF9eKS/R3jLqXCgsfx1zm77MaHvRPBhISZxBv2cXdVO3YJaN4MVzu5TGfDyhttpYTu
         QRfGdTNPLIQCor2Gwr5EpZzS8L4rsXn3L8UA4RTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Prashanth K <quic_prashk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 280/532] usb: gadget: u_serial: Add null pointer check in gserial_suspend
Date:   Fri, 21 Jul 2023 18:03:04 +0200
Message-ID: <20230721160629.569474918@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Prashanth K <quic_prashk@quicinc.com>

[ Upstream commit 2f6ecb89fe8feb2b60a53325b0eeb9866d88909a ]

Consider a case where gserial_disconnect has already cleared
gser->ioport. And if gserial_suspend gets called afterwards,
it will lead to accessing of gser->ioport and thus causing
null pointer dereference.

Avoid this by adding a null pointer check. Added a static
spinlock to prevent gser->ioport from becoming null after
the newly added null pointer check.

Fixes: aba3a8d01d62 ("usb: gadget: u_serial: add suspend resume callbacks")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Link: https://lore.kernel.org/r/1683278317-11774-1-git-send-email-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_serial.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 116d2e15e9b22..a8d1e8b192c55 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1419,10 +1419,19 @@ EXPORT_SYMBOL_GPL(gserial_disconnect);
 
 void gserial_suspend(struct gserial *gser)
 {
-	struct gs_port	*port = gser->ioport;
+	struct gs_port	*port;
 	unsigned long	flags;
 
-	spin_lock_irqsave(&port->port_lock, flags);
+	spin_lock_irqsave(&serial_port_lock, flags);
+	port = gser->ioport;
+
+	if (!port) {
+		spin_unlock_irqrestore(&serial_port_lock, flags);
+		return;
+	}
+
+	spin_lock(&port->port_lock);
+	spin_unlock(&serial_port_lock);
 	port->suspended = true;
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
-- 
2.39.2



