Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5002D75536B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjGPUSw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGPUSw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4738BE41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1F4160DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1A1C433C7;
        Sun, 16 Jul 2023 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538730;
        bh=8Hr3iyO+/36/RjL9z8EGbDr9VxBl2y5tHy+jZxsREd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpIMMre8VMHJJmRrnnONu+kf4h6pm8jm0E65mXdik6t5V1kmH+tel2OOZXOkSLUA8
         lBfG4JriGgyIWSZmnmR0SgFRmFoMtDH305FYrgFpmug0nujxeEZp6uGV/Y0RxrCsUu
         RgUFns71kf++29kLH2pJt14W8eCFurebd29EI22U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 555/800] xhci: Improve the XHCI system resume time
Date:   Sun, 16 Jul 2023 21:46:48 +0200
Message-ID: <20230716195001.982147177@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit 1c024241d018cf9fc17aa8d95c3fe77d671d7142 ]

Avoid extra 120ms delay during system resume.

The xHC controller may signal wake up to 120ms before showing which usb
device caused the wake on the xHC port registers.

The xhci driver therefore checks for port activity up to 120ms during
resume, making sure that the hub driver can see the port change, and
won't immediately runtime suspend back due to no port activity.

This is however only needed for runtime resume as system resume will
resume all child hubs and other child usb devices anyway.

Fixes: 253f588c70f6 ("xhci: Improve detection of device initiated wake signal.")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230428140056.1318981-3-Basavaraj.Natikar@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 65d54c8a24928..b81313ffeb768 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1117,7 +1117,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 		 * the first wake signalling failed, give it that chance.
 		 */
 		pending_portevent = xhci_pending_portevent(xhci);
-		if (!pending_portevent) {
+		if (!pending_portevent && msg.event == PM_EVENT_AUTO_RESUME) {
 			msleep(120);
 			pending_portevent = xhci_pending_portevent(xhci);
 		}
-- 
2.39.2



