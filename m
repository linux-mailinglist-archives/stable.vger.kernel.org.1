Return-Path: <stable+bounces-251500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL0oAAryDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F45943E4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ACE030F2509
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22370369999;
	Wed, 20 May 2026 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gj1LwZAf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A553A3826;
	Wed, 20 May 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298142; cv=none; b=rmiPGuDzEamuvaay1v+QH0MC+GXT/Ezk1/E/73JFt/Q/ZhVyCOc8F4gZ1U1d0RRat8iydlCwjfTJfEhkqTLs3uLUy+LDwS286hXnqog9IqrrlySGPaq34RFz3IYN4LeSGSdFnEGx1mAujXYO8zVyhmLv2VpaWAR+OpJxGkxtkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298142; c=relaxed/simple;
	bh=gHKnIR4ZNDpjNtznWQMLOP0dtBY73VixJoTK/zIBYsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnrlBaHwWnfAeRX+tkrMBCHxiVoMKlpn7aXnyaXUfGFecx0t4iEgVNX1BEmQr0JRnYqP4cSLV5GMcNAVcRnOODazHStUOxWdSLFzc1YFv3CmG2o1EUHk94gxC/cizEhrCV7vfgRNYluQ/M0u7M8qf6HR+AfH3Sp9rB0kH28t8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gj1LwZAf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071211F000E9;
	Wed, 20 May 2026 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298141;
	bh=+f/KsJ0AxUjKqHHw02/65W7tCUCI7c1hJzST+mVIu70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gj1LwZAfKzFtJuoIyYY/sOIKUsC6TbAC/93EG4XsPavmPI9sO+o07HNGWM0QINGSF
	 Ffpn+bTiSpTqdQOf4KyMAz420sE842sIyrS04UWTL8dnYjGbakWaamBBj2Znj+2GEi
	 6qffAY0ya6jHi6wN22Qqx4KXRS7KFIEqY00W98VI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Zhang <18255117159@163.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 297/957] PCI: dwc: Fix type mismatch for kstrtou32_from_user() return value
Date: Wed, 20 May 2026 18:13:00 +0200
Message-ID: <20260520162140.975375398@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251500-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,163.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 973F45943E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Zhang <18255117159@163.com>

[ Upstream commit 445588a3b18bb0702d746cb61f7a443639027651 ]

kstrtou32_from_user() returns int, but the return value was stored in
a u32 variable 'val', risking sign loss. Use a dedicated int variable
to correctly handle the return code.

Fixes: 4fbfa17f9a07 ("PCI: dwc: Add debugfs based Silicon Debug support for DWC")
Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20260401023048.4182452-1-18255117159@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index df98fee69892b..afcc08efe2531 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -208,10 +208,11 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
 	struct dw_pcie *pci = file->private_data;
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
 	u32 lane, val;
+	int ret;
 
-	val = kstrtou32_from_user(buf, count, 0, &lane);
-	if (val)
-		return val;
+	ret = kstrtou32_from_user(buf, count, 0, &lane);
+	if (ret)
+		return ret;
 
 	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
 	val &= ~(LANE_SELECT);
@@ -347,10 +348,11 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 	struct dw_pcie *pci = pdata->pci;
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
 	u32 val, enable;
+	int ret;
 
-	val = kstrtou32_from_user(buf, count, 0, &enable);
-	if (val)
-		return val;
+	ret = kstrtou32_from_user(buf, count, 0, &enable);
+	if (ret)
+		return ret;
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
@@ -408,10 +410,11 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
 	struct dw_pcie *pci = pdata->pci;
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
 	u32 val, lane;
+	int ret;
 
-	val = kstrtou32_from_user(buf, count, 0, &lane);
-	if (val)
-		return val;
+	ret = kstrtou32_from_user(buf, count, 0, &lane);
+	if (ret)
+		return ret;
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-- 
2.53.0




