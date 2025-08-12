Return-Path: <stable+bounces-168649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6FAB235CB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507AA4E4C09
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C112FABFC;
	Tue, 12 Aug 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0DeJRfRQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3A29B229;
	Tue, 12 Aug 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024875; cv=none; b=ENuzuUaV4JkEmb+GqoFRBwLE78GFE4P88t6l8gHMUtMBpbeCvyJR2Y4Ciur0BDeI1hR7hSZIgxcyCVnODnM51ut7w2ZZhLDOsxAyekTbwMatOKgkuhm0Yab1eaPVUfvaYLaMAxmDtyQfqVBVfkUKI0oewHTLVOjIyccw7SCHGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024875; c=relaxed/simple;
	bh=mJ/L2jb4DMb9NYSLNnjg35eQEFmqakWtqLUO32whMZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy/HrKPvFNe45AocNFAFX+NxRl8FCsxIY9byjsGPZDzLddgIGQ2/QzbSTv2LL+qHuVNS9C/7pJekRleFgAigYGxUBUbPJGigg2JjT/Ct/LY3MJcGnxSauhocZIIWqeT1M2WG1JcduqZ5RRCDWPTa30LUGnL6YvDxDnWqgBz/e1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0DeJRfRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB829C4CEF0;
	Tue, 12 Aug 2025 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024875;
	bh=mJ/L2jb4DMb9NYSLNnjg35eQEFmqakWtqLUO32whMZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0DeJRfRQG53g7NZa7UkIJi1nS+WEKiPsoiSAlLN1r0IaPEeYVMozT60CT3rdH70XH
	 sOACPeNB0771q0ZsvDEkZ0wT13jeFDrbx88CVgUaDwMHMvo6peMoun3grFI5g06Pf6
	 qNnURa03+lDrR8AYqsq1vCFT4yCPw8AmiFOGtT8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 503/627] PCI: pnv_php: Work around switches with broken presence detection
Date: Tue, 12 Aug 2025 19:33:18 +0200
Message-ID: <20250812173447.680621114@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timothy Pearson <tpearson@raptorengineering.com>

[ Upstream commit 80f9fc2362797538ebd4fd70a1dfa838cc2c2cdb ]

The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
was observed to incorrectly assert the Presence Detect Set bit in its
capabilities when tested on a Raptor Computing Systems Blackbird system,
resulting in the hot insert path never attempting a rescan of the bus
and any downstream devices not being re-detected.

Work around this by additionally checking whether the PCIe data link is
active or not when performing presence detection on downstream switches'
ports, similar to the pciehp_hpc.c driver.

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/505981576.1359853.1752615415117.JavaMail.zimbra@raptorengineeringinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pnv_php.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 1304329ca6f7..5476c9e7760d 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -391,6 +391,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 	return 0;
 }
 
+static int pcie_check_link_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+
+	return ret;
+}
+
 static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
@@ -403,6 +417,19 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
+		if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+			presence == OPAL_PCI_SLOT_EMPTY) {
+			/*
+			 * Similar to pciehp_hpc, check whether the Link Active
+			 * bit is set to account for broken downstream bridges
+			 * that don't properly assert Presence Detect State, as
+			 * was observed on the Microsemi Switchtec PM8533 PFX
+			 * [11f8:8533].
+			 */
+			if (pcie_check_link_active(php_slot->pdev) > 0)
+				presence = OPAL_PCI_SLOT_PRESENT;
+		}
+
 		*state = presence;
 		ret = 0;
 	} else {
-- 
2.39.5




