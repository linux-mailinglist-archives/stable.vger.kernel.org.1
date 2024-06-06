Return-Path: <stable+bounces-49622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 686928FEE16
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092CD1F233D3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9A19EEC6;
	Thu,  6 Jun 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obPdz9Oc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9519EEAD;
	Thu,  6 Jun 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683557; cv=none; b=owbE2jO455LDxgMiVU3nO0VAykIBmz1aaqBq/MWOPMl6rmkiTXX9PFGI2P4dmstYTlUG90nZcVbXjRAnPRFpvsHPXfEdEn5GeTFml2m1AJ8H1ypx66uaabOXE/8Zyyd3deECc2JFy/ley4L97cadELqGxsfrvYChOi9K/azD+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683557; c=relaxed/simple;
	bh=DPX9PwIiWYoazgt0VP9EOHRYTxAbT9h2D/C3Jhn0wyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0Fn03b1whj/6uf5IURJaoURueP/0nSfc/kpU3TukclXwF/ECwOTkRmpEOIdKx6n3zE9/3h0HY+0tMN6jAHncHwBT54BVBf4QT7bnt0IEEd2Fr3MR68vsN32x4irz9w7F2lrSYBl9h8RFnrNKVR9xPd/iRyFh6DE0zYGHfAvDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obPdz9Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873C6C2BD10;
	Thu,  6 Jun 2024 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683557;
	bh=DPX9PwIiWYoazgt0VP9EOHRYTxAbT9h2D/C3Jhn0wyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obPdz9OcsHxX6el3C7+55WXezRwMFwRXJPGjI0O2JiIRTbPWIywGU5a3wXHp9GBFv
	 itR3KJHxZG4gU9+tt1mTb89KjILvL4CpcJxXKf3XjLGiTVrT37jy5tm4U1Znfnr+n2
	 VKwXUQi3kBJFcJJfS1VxR9I6QlIXsbV0s/NEKjAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	Satish Thatchanamurthy <Satish.Thatchanamurt@Dell.com>
Subject: [PATCH 6.6 499/744] PCI/EDR: Align EDR_PORT_LOCATE_DSM with PCI Firmware r3.3
Date: Thu,  6 Jun 2024 16:02:51 +0200
Message-ID: <20240606131748.445695821@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

[ Upstream commit e2e78a294a8a863898b781dbcf90e087eda3155d ]

The "Downstream Port Containment related Enhancements" ECN of Jan 28, 2019
(document 12888 below), defined the EDR_PORT_LOCATE_DSM function with
Revision ID 5 with a return value encoding (Bits 2:0 = Function, Bits 7:3 =
Device, Bits 15:8 = Bus).  When the ECN was integrated into PCI Firmware
r3.3, sec 4.6.13, Bit 31 was added to indicate success or failure.

Check Bit 31 for failure in acpi_dpc_port_get().

Link: https://lore.kernel.org/r/20240501022543.1626025-1-sathyanarayanan.kuppuswamy@linux.intel.com
Link: https://members.pcisig.com/wg/PCI-SIG/document/12888
Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
[bhelgaas: split into two patches, update commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Satish Thatchanamurthy <Satish.Thatchanamurt@Dell.com> # one platform
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/edr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index fa085677c91de..e86298dbbcff6 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -80,8 +80,9 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 	u16 port;
 
 	/*
-	 * Behavior when calling unsupported _DSM functions is undefined,
-	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
+	 * If EDR_PORT_LOCATE_DSM is not implemented under the target of
+	 * EDR, the target is the port that experienced the containment
+	 * event (PCI Firmware r3.3, sec 4.6.13).
 	 */
 	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
 			    1ULL << EDR_PORT_LOCATE_DSM))
@@ -98,6 +99,16 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 		return NULL;
 	}
 
+	/*
+	 * Bit 31 represents the success/failure of the operation. If bit
+	 * 31 is set, the operation failed.
+	 */
+	if (obj->integer.value & BIT(31)) {
+		ACPI_FREE(obj);
+		pci_err(pdev, "Locate Port _DSM failed\n");
+		return NULL;
+	}
+
 	/*
 	 * Firmware returns DPC port BDF details in following format:
 	 *	15:8 = bus
-- 
2.43.0




