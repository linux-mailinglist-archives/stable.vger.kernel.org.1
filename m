Return-Path: <stable+bounces-15525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11220838EC2
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 13:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926F41F2538F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302D5EE87;
	Tue, 23 Jan 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0g779+LT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE115C5FB;
	Tue, 23 Jan 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014176; cv=none; b=JbfscMYkZcxOBgZDhQmsa92124XPorGFsVFhKXJqWC8kmoN4Y2rnp8at+tBXEZlJbUhLvu6k9d/+9As7XYVApGFg/Hukx+S7VNJPw2J/BL+wfgivOXZ03diG7a1NWUF4H938p4DRP4jDrE5yDfdjyOeHBUYK4gfoWlzLBX0KjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014176; c=relaxed/simple;
	bh=hvrxoMiGOsUX6FGhkQ0hZ/bYlfuVaEVVRR0/XyY5pbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVs4LCuvfu2ldYPYZ3wKOhKxSV5+DkXxcifQ2wzYquXLi7LZ8tbWgv4LTI1mcKvH/ij0vDr1wx7muuktaLQDWLESXqRm/kueyQKhSFy9z7Lhu7CQEAuXPMUfekBOKrwx7GgMXuUdSjy/hSbATo7hlfWG2shRGor2e2FOoICO1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0g779+LT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B697BC43394;
	Tue, 23 Jan 2024 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706014175;
	bh=hvrxoMiGOsUX6FGhkQ0hZ/bYlfuVaEVVRR0/XyY5pbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0g779+LTIUsQB8Y1e2cejMa4OeyPNizRmdgSpeH/2YwZcU8HBXUfEAMe2hbgMgRX8
	 gjusz3+U/hgklLl0FaB+CmGnC8/p54BHBZve+5cfDZOj7nlT8PE9RpYDBHpKhcdGMv
	 IcR5WABY7C91WNy1t+DlEnVUZeJl/p8hBi4CCsAc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.1 308/417] wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
Date: Mon, 22 Jan 2024 15:57:56 -0800
Message-ID: <20240122235802.496914364@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit b3943b3c2971444364e03224cfc828c5789deada upstream.

Ever since introduction in the commit 0c8173385e54 ("rtl8192ce: Add new
driver") the rtlwifi code has, according to comments, attempted to
disable/enable ASPM of the upstream bridge by writing into its LNKCTL
register. However, the code has never been correct because it performs
the writes to the device instead of the upstream bridge.

Worse yet, the offset where the PCIe capabilities reside is derived
from the offset of the upstream bridge. As a result, the write will use
an offset on the device that does not relate to the LNKCTL register
making the ASPM disable/enable code outright dangerous.

Because of those problems, there is no indication that the driver needs
disable/enable ASPM on the upstream bridge. As the Capabilities offset
is not correctly calculated for the write to target device's LNKCTL
register, the code is not disabling/enabling device's ASPM either.
Therefore, just remove the upstream bridge related ASPM disable/enable
code entirely.

The upstream bridge related ASPM code was the only user of the struct
mp_adapter members num4bytes, pcibridge_pciehdr_offset, and
pcibridge_linkctrlreg so those are removed as well.

Note: This change does not remove the code related to changing the
device's ASPM on purpose (which is independent of this flawed code
related to upstream bridge's ASPM).

Suggested-by: Bjorn Helgaas <bhelgaas@kernel.org>
Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Fixes: 886e14b65a8f ("rtlwifi: Eliminate raw reads and writes from PCIe portion")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231124084725.12738-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c |   58 -----------------------------
 drivers/net/wireless/realtek/rtlwifi/pci.h |    5 --
 2 files changed, 1 insertion(+), 62 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -192,11 +192,8 @@ static void rtl_pci_disable_aspm(struct
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
-	u8 num4bytes = pcipriv->ndis_adapter.num4bytes;
 	/*Retrieve original configuration settings. */
 	u8 linkctrl_reg = pcipriv->ndis_adapter.linkctrl_reg;
-	u16 pcibridge_linkctrlreg = pcipriv->ndis_adapter.
-				pcibridge_linkctrlreg;
 	u16 aspmlevel = 0;
 	u8 tmp_u1b = 0;
 
@@ -221,16 +218,8 @@ static void rtl_pci_disable_aspm(struct
 	/*Set corresponding value. */
 	aspmlevel |= BIT(0) | BIT(1);
 	linkctrl_reg &= ~aspmlevel;
-	pcibridge_linkctrlreg &= ~(BIT(0) | BIT(1));
 
 	_rtl_pci_platform_switch_device_pci_aspm(hw, linkctrl_reg);
-	udelay(50);
-
-	/*4 Disable Pci Bridge ASPM */
-	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
-			      pcibridge_linkctrlreg);
-
-	udelay(50);
 }
 
 /*Enable RTL8192SE ASPM & Enable Pci Bridge ASPM for
@@ -245,9 +234,7 @@ static void rtl_pci_enable_aspm(struct i
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
-	u8 num4bytes = pcipriv->ndis_adapter.num4bytes;
 	u16 aspmlevel;
-	u8 u_pcibridge_aspmsetting;
 	u8 u_device_aspmsetting;
 
 	if (!ppsc->support_aspm)
@@ -259,25 +246,6 @@ static void rtl_pci_enable_aspm(struct i
 		return;
 	}
 
-	/*4 Enable Pci Bridge ASPM */
-
-	u_pcibridge_aspmsetting =
-	    pcipriv->ndis_adapter.pcibridge_linkctrlreg |
-	    rtlpci->const_hostpci_aspm_setting;
-
-	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_INTEL)
-		u_pcibridge_aspmsetting &= ~BIT(0);
-
-	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
-			      u_pcibridge_aspmsetting);
-
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"PlatformEnableASPM(): Write reg[%x] = %x\n",
-		(pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10),
-		u_pcibridge_aspmsetting);
-
-	udelay(50);
-
 	/*Get ASPM level (with/without Clock Req) */
 	aspmlevel = rtlpci->const_devicepci_aspm_setting;
 	u_device_aspmsetting = pcipriv->ndis_adapter.linkctrl_reg;
@@ -358,22 +326,6 @@ static bool rtl_pci_check_buddy_priv(str
 	return tpriv != NULL;
 }
 
-static void rtl_pci_get_linkcontrol_field(struct ieee80211_hw *hw)
-{
-	struct rtl_pci_priv *pcipriv = rtl_pcipriv(hw);
-	struct rtl_pci *rtlpci = rtl_pcidev(pcipriv);
-	u8 capabilityoffset = pcipriv->ndis_adapter.pcibridge_pciehdr_offset;
-	u8 linkctrl_reg;
-	u8 num4bbytes;
-
-	num4bbytes = (capabilityoffset + 0x10) / 4;
-
-	/*Read  Link Control Register */
-	pci_read_config_byte(rtlpci->pdev, (num4bbytes << 2), &linkctrl_reg);
-
-	pcipriv->ndis_adapter.pcibridge_linkctrlreg = linkctrl_reg;
-}
-
 static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 					struct ieee80211_hw *hw)
 {
@@ -2033,12 +1985,6 @@ static bool _rtl_pci_find_adapter(struct
 		    PCI_SLOT(bridge_pdev->devfn);
 		pcipriv->ndis_adapter.pcibridge_funcnum =
 		    PCI_FUNC(bridge_pdev->devfn);
-		pcipriv->ndis_adapter.pcibridge_pciehdr_offset =
-		    pci_pcie_cap(bridge_pdev);
-		pcipriv->ndis_adapter.num4bytes =
-		    (pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10) / 4;
-
-		rtl_pci_get_linkcontrol_field(hw);
 
 		if (pcipriv->ndis_adapter.pcibridge_vendor ==
 		    PCI_BRIDGE_VENDOR_AMD) {
@@ -2055,13 +2001,11 @@ static bool _rtl_pci_find_adapter(struct
 		pdev->vendor, pcipriv->ndis_adapter.linkctrl_reg);
 
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-		"pci_bridge busnumber:devnumber:funcnumber:vendor:pcie_cap:link_ctl_reg:amd %d:%d:%d:%x:%x:%x:%x\n",
+		"pci_bridge busnumber:devnumber:funcnumber:vendor:amd %d:%d:%d:%x:%x\n",
 		pcipriv->ndis_adapter.pcibridge_busnum,
 		pcipriv->ndis_adapter.pcibridge_devnum,
 		pcipriv->ndis_adapter.pcibridge_funcnum,
 		pcibridge_vendors[pcipriv->ndis_adapter.pcibridge_vendor],
-		pcipriv->ndis_adapter.pcibridge_pciehdr_offset,
-		pcipriv->ndis_adapter.pcibridge_linkctrlreg,
 		pcipriv->ndis_adapter.amd_l1_patch);
 
 	rtl_pci_parse_configuration(pdev, hw);
--- a/drivers/net/wireless/realtek/rtlwifi/pci.h
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
@@ -236,11 +236,6 @@ struct mp_adapter {
 	u16 pcibridge_vendorid;
 	u16 pcibridge_deviceid;
 
-	u8 num4bytes;
-
-	u8 pcibridge_pciehdr_offset;
-	u8 pcibridge_linkctrlreg;
-
 	bool amd_l1_patch;
 };
 



