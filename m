Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302876AF97
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjHAJtD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjHAJss (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250B01BDB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0661B614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124BCC433C7;
        Tue,  1 Aug 2023 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883240;
        bh=EdJlco+J4sUdxUMYVRQuIKYB38LSkBEY2e1cyt17zm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFaQjIgmZTXVEB/zQtN4sc3gOyxDouLYmrun0FwZqbrGECKufKlf7qKgd9ACBaboL
         14KUVEvpq0O0XBBN6BPBbg0xQH8ZatRn1giAXyyHNa72wBFekjJ9Z5vXO7Q+8Ep0RE
         vn6XUK7jr45kapm3rLLeZ/GAOp77mUs0Kj0yLe7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guiting Shen <aarongt.shen@gmail.com>,
        stable <stable@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.4 166/239] usb: ohci-at91: Fix the unhandle interrupt when resume
Date:   Tue,  1 Aug 2023 11:20:30 +0200
Message-ID: <20230801091931.620713140@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guiting Shen <aarongt.shen@gmail.com>

commit c55afcbeaa7a6f4fffdbc999a9bf3f0b29a5186f upstream.

The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
suspend which will let the ohci_irq() skip the interrupt after resume. And
nobody to handle this interrupt.

According to the comment in ohci_hcd_at91_drv_suspend(), it need to reset
when resume from suspend(MEM) to fix by setting "hibernated" argument of
ohci_resume().

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20230626152713.18950-1-aarongt.shen@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-at91.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -673,7 +673,13 @@ ohci_hcd_at91_drv_resume(struct device *
 	else
 		at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * According to the comment in ohci_hcd_at91_drv_suspend()
+	 * we need to do a reset if the 48Mhz clock was stopped,
+	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
+	 * to reset in this case by setting its "hibernated" flag.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	return 0;
 }


