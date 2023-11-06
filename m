Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43C17E253A
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjKFN3o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjKFN3n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:29:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE9100
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:29:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F478C433C9;
        Mon,  6 Nov 2023 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277380;
        bh=WIOaAJEYCtBL9mCxRpl8O2XCDFTFaEDkEKkhxM9wfYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+l2iBcsNl3efjngdgIpPeqP3bHTYBAMfOpr90eVgKae4ZNLQv6Bjw8gGna4eQona
         W9X4pfcD47z2WM5mgalZIaampYX19DeVQjcZnDxN656ZVOCkp/DX7SXsv+SGgNLfns
         iRjtOne25oTojIj5f41dDb1X9hKTbAZMvUiGhgzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cameron Williams <cang1@live.co.uk>
Subject: [PATCH 5.15 124/128] tty: 8250: Add support for additional Brainboxes PX cards
Date:   Mon,  6 Nov 2023 14:04:44 +0100
Message-ID: <20231106130314.802395781@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cameron Williams <cang1@live.co.uk>

commit 9604884e592cd04ead024c9737c67a77f175cab9 upstream.

Add support for some more of the Brainboxes PX (PCIe) range
of serial cards, namely
PX-275/PX-279, PX-475 (serial port, not LPT), PX-820,
PX-803/PX-857 (additional ID).

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Link: https://lore.kernel.org/r/DU0PR02MB78996BEC353FB346FC35444BC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5616,6 +5616,13 @@ static const struct pci_device_id serial
 		0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
+	 * Brainboxes PX-275/279
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0E41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_8_115200 },
+	/*
 	 * Brainboxes PX-310
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x400E,
@@ -5662,17 +5669,39 @@ static const struct pci_device_id serial
 		0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
+	 * Brainboxes PX-475
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x401D,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
 	 * Brainboxes PX-803/PX-857
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4009,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4018,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_oxsemi_2_15625000 },
 	/*
+	 * Brainboxes PX-820
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4002,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4013,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
+	/*
 	 * Brainboxes PX-846
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4008,


