Return-Path: <stable+bounces-169832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B46B28830
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 00:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9847AC39C8
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EA323956A;
	Fri, 15 Aug 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP7wSa27"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD828399
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295708; cv=none; b=rb+IdjKDu8/nbDhtWMQ49ScIfKxPC7ioNlubpHVbTSNvoV3ShDoDXhSBkJDwWorQvgSCD6w5+alDuoYlPzdS7071rQV89RChxcMriuk8YXqyN10X7a+409VNkcfEnr26A6c7HEJL0+CDDl3/8GYvdfoYuPrnwk+5fuEAMOXlgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295708; c=relaxed/simple;
	bh=/f0oqHNNYciAk8DfsDaXen0iliRLXox43bzQPOew9eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+PZZ4rs0CZPnTcOdeJevheTrxRK8YI+zIZrMZeoZnkJ6qzkUCtGzZcK0tKyaRKGtTNruIPnNA7xmOdm5MTXSXiRTprSBmNlK0FrPw9jUxhdZcNq2mDSvwe2Z5igyjdZoakw4VG975vpOJm485fdbUmfgK8QysIHFNhIYOAwK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP7wSa27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE184C4CEEB;
	Fri, 15 Aug 2025 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755295708;
	bh=/f0oqHNNYciAk8DfsDaXen0iliRLXox43bzQPOew9eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jP7wSa27JvWFkSw4HrKZI6hqyXkhUaYOzym9x6O/o/7zE7O5HGo+UDgT5jd0r/w6j
	 25Xcl6Jcj9W1xn3lmz0HjOaBQgboNQ9sNkUfEBMb052C8jK8Eyi0JdJoS4iDmLTMSv
	 Aoy7s8EU7nb36Xf/3ChS8zLw8FJCQv0KbxammDBeh1vy9k6Vt5MO67gOBvFunAkcrb
	 Sc2MKMox3E6hXI8BN1pg18wbCWOBHMatncG9jhCLX5SDWlWgcOqkBjL5FWV0aV3NY+
	 rHRKCP1eUUUD3X2J1/wsOuzm8f5vVABeEvaxjjOR5RMgKxrvzneqfIeQX5pEntr206
	 mGy8HYd47827A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] PCI: Allow PCI bridges to go to D3Hot on all non-x86
Date: Fri, 15 Aug 2025 18:08:23 -0400
Message-ID: <20250815220824.248963-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815220824.248963-1-sashal@kernel.org>
References: <2025081508-ultra-derived-f72d@gregkh>
 <20250815220824.248963-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit a5fb3ff632876d63ee1fc5ed3af2464240145a00 ]

Currently, pci_bridge_d3_possible() encodes a variety of decision factors
when deciding whether a given bridge can be put into D3. A particular one
of note is for "recent enough PCIe ports." Per Rafael [0]:

  "There were hardware issues related to PM on x86 platforms predating
   the introduction of Connected Standby in Windows.  For instance,
   programming a port into D3hot by writing to its PMCSR might cause the
   PCIe link behind it to go down and the only way to revive it was to
   power cycle the Root Complex.  And similar."

Thus, this function contains a DMI-based check for post-2015 BIOS.

The above factors (Windows, x86) don't really apply to non-x86 systems, and
also, many such systems don't have BIOS or DMI. However, we'd like to be
able to suspend bridges on non-x86 systems too.

Restrict the "recent enough" check to x86. If we find further
incompatibilities, it probably makes sense to expand on the deny-list
approach (i.e., bridge_d3_blacklist or similar).

Link: https://lore.kernel.org/r/20250320110604.v6.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid
Link: https://lore.kernel.org/linux-pci/CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com/ [0]
Link: https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/ [1]
Link: https://lore.kernel.org/linux-pci/20240828210705.GA37859@bhelgaas/ [2]
[Brian: rewrite to !X86 based on Rafael's suggestions]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: 6cff20ce3b92 ("PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e52299229b52..bfd1893d92ec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3024,7 +3024,7 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
  * @bridge: Bridge to check
  *
  * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
+ * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
@@ -3068,10 +3068,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * It should be safe to put PCIe ports from 2015 or newer
-		 * to D3.
+		 * Out of caution, we only allow PCIe ports from 2015 or newer
+		 * into D3 on x86.
 		 */
-		if (dmi_get_bios_year() >= 2015)
+		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
 			return true;
 		break;
 	}
-- 
2.50.1


