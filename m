Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C56713F4A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjE1Tny (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjE1Tnx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:43:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51388A8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7416461F1D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937E8C433EF;
        Sun, 28 May 2023 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303030;
        bh=Lrk0sCmNEkxtu2/MlJ+jrJS74kP+1R0OConkS7V2rIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aw0vk0DpZ3CiBE6oRrPJY+dQ+ZTKlcHIhJXjsRDLB5et3WBiI3IrSKGCvR4bVSXo2
         qEcYdXpTiWy/CDneK23F7m2YnFm+JB+ZfStNAtP9K8AKtsb/WemsPNd/3MWUiJABmc
         iTsVywA2uxutGC39ELB0cEJpa0MaO/9ud+oe4A7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Subject: [PATCH 5.10 126/211] USB: UHCI: adjust zhaoxin UHCI controllers OverCurrent bit value
Date:   Sun, 28 May 2023 20:10:47 +0100
Message-Id: <20230528190846.676382686@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

commit dddb342b5b9e482bb213aecc08cbdb201ea4f8da upstream.

OverCurrent condition is not standardized in the UHCI spec.
Zhaoxin UHCI controllers report OverCurrent bit active off.
In order to handle OverCurrent condition correctly, the uhci-hcd
driver needs to be told to expect the active-off behavior.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20230423105952.4526-1-WeitaoWang-oc@zhaoxin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/uhci-pci.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/uhci-pci.c
+++ b/drivers/usb/host/uhci-pci.c
@@ -119,11 +119,13 @@ static int uhci_pci_init(struct usb_hcd
 
 	uhci->rh_numports = uhci_count_ports(hcd);
 
-	/* Intel controllers report the OverCurrent bit active on.
-	 * VIA controllers report it active off, so we'll adjust the
-	 * bit value.  (It's not standardized in the UHCI spec.)
+	/*
+	 * Intel controllers report the OverCurrent bit active on.  VIA
+	 * and ZHAOXIN controllers report it active off, so we'll adjust
+	 * the bit value.  (It's not standardized in the UHCI spec.)
 	 */
-	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA)
+	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA ||
+			to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_ZHAOXIN)
 		uhci->oc_low = 1;
 
 	/* HP's server management chip requires a longer port reset delay. */


