Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3978E7E230E
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjKFNIW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjKFNIV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:08:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79AEA
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:08:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6061CC433C8;
        Mon,  6 Nov 2023 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276098;
        bh=pfvRfpJqQXxTRyP1N1B4jyzFRZqU3O4zZxzc8NYygdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n44eQ93eGyK5CSqaV3BPCzsG8R38SN7j5PXpd8mIANdyLly3am6ICb4n1creaQ0Tw
         tNOcmpxM93mmHLmnYrv8G+vBDq881Lk0GwCmikliXZg42k6Dq3GR10JAk/j1+EObhL
         NFejphjiEOJWDrM14+KBBoNnjxZAL2BC+UjRhUNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cameron Williams <cang1@live.co.uk>
Subject: [PATCH 6.6 20/30] tty: 8250: Add support for Intashield IS-100
Date:   Mon,  6 Nov 2023 14:03:38 +0100
Message-ID: <20231106130258.636766285@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
References: <20231106130257.903265688@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cameron Williams <cang1@live.co.uk>

commit 4d994e3cf1b541ff32dfb03fbbc60eea68f9645b upstream.

Add support for the Intashield IS-100 1 port serial card.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Link: https://lore.kernel.org/r/DU0PR02MB7899A0E0CDAA505AF5A874CDC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4914,6 +4914,12 @@ static const struct pci_device_id serial
 		pbn_b1_bt_1_115200 },
 
 	/*
+	 * IntaShield IS-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
+	/*
 	 * IntaShield IS-200
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS200,


