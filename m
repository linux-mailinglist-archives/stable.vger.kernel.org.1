Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4821A7E243F
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjKFNT4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjKFNTy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:19:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A2C136
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:19:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5978AC433C9;
        Mon,  6 Nov 2023 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276789;
        bh=sL06BvBMqlt8ADRq0dLr9TR9KIUc5aOuCNLFTIpeBHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpfOFmMIQdr7kFzRwQHt5o6gHYqXJlQij1prDy4v7nCJE0+lrYAzmlgOdXtCWfkA8
         lwSrogkWuTfiQnRARBoAc/yNj+E+Qi9D1UIJoK+3cz5QG7n+P43bVpNvwL7NAIqQbQ
         4S8hEyCiJfMMUAwVOkV2z5zzfoJgBGN1V7ZpF1kg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cameron Williams <cang1@live.co.uk>
Subject: [PATCH 6.5 76/88] tty: 8250: Add support for additional Brainboxes UC cards
Date:   Mon,  6 Nov 2023 14:04:10 +0100
Message-ID: <20231106130308.534059712@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cameron Williams <cang1@live.co.uk>

commit c563db486db7d245c0e2f319443417ae8e692f7f upstream.

Add device IDs for some more Brainboxes UC cards, namely
UC-235/UC-246, UC-253/UC-734, UC-302, UC-313, UC-346, UC-357,
UC-607 and UC-836.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Link: https://lore.kernel.org/r/DU0PR02MB789969998A6C3FAFCD95C85DC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |   57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4938,6 +4938,17 @@ static const struct pci_device_id serial
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
+	/*
+	 * Brainboxes UC-253/UC-734
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0CA1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-260/271/701/756
 	 */
@@ -4970,6 +4981,14 @@ static const struct pci_device_id serial
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-310
 	 */
@@ -4980,6 +4999,14 @@ static const struct pci_device_id serial
 	/*
 	 * Brainboxes UC-313
 	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -4994,6 +5021,10 @@ static const struct pci_device_id serial
 	/*
 	 * Brainboxes UC-346
 	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5005,6 +5036,10 @@ static const struct pci_device_id serial
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A82,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5023,6 +5058,28 @@ static const struct pci_device_id serial
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-607
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-836
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	/*
 	 * Brainboxes PX-101
 	 */


