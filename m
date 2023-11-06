Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221947E2316
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjKFNIh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjKFNIg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:08:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3117BD
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:08:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBE1C433C8;
        Mon,  6 Nov 2023 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276113;
        bh=naQfqQc9JFiMbR+/tDmG/ZV5v3g7hg8emsdpfVhnBsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAZjn2VNtcYqUi6+5DgpJXHAPnfU14k3KW8bOjbejIl8LiJIKLSGZqKeFAM/2exmS
         QR1LB7SR/3Q+iJ+6Bi9oRPMsQQdLShR4U9u/t3mKJj5zerMTpKFgkVQZmOxeefaSrX
         mfUOUMGNJ2giC5w25r06V2ZgyK+Z0SoH+PyRC74s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cameron Williams <cang1@live.co.uk>
Subject: [PATCH 6.6 24/30] tty: 8250: Add support for Intashield IX cards
Date:   Mon,  6 Nov 2023 14:03:42 +0100
Message-ID: <20231106130258.761049519@linuxfoundation.org>
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

commit 62d2ec2ded278c7512d91ca7bf8eb9bac46baf90 upstream.

Add support for the IX-100, IX-200 and IX-400 serial cards.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Link: https://lore.kernel.org/r/DU0PR02MB7899614E5837E82A03272A4BC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4931,6 +4931,27 @@ static const struct pci_device_id serial
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
+	/*
+	 * IntaShield IX-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4027,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * IntaShield IX-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4028,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * IntaShield IX-400
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4029,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
 	/* Brainboxes Devices */
 	/*
 	* Brainboxes UC-101


