Return-Path: <stable+bounces-220730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMB8OZ0/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DB01C6D21
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A8F530F9670
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720C3FFACA;
	Sat, 28 Feb 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRpZZKnW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD43FFAC3;
	Sat, 28 Feb 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300611; cv=none; b=r/3KGYJfwmSj5lnq99MNddGxUuntCUYjy/KA17TemgF3xjNPT6BawBxoXBblP5GKK1Fw0VolY5AdEUBtyUbF/dOTTAFA5VnGNNDdaimzRvpOadlVqqYduMvS2n7UPHOkWgZS085xf0+d1Kb3eNBawrEvYBBQyF0+5rLaHVuL6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300611; c=relaxed/simple;
	bh=arC2Z881uVFzGKibrZWaTBPjUaTvs4NVoNdK8HcPU3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLrkJCENcPsafdFS8YvjigbXFyBiWr0Tex5ATPg9QlYg3uxUHYhkJ7tiB6dOK8hH9awqK/3UtmZTYfmgg0IF9+oz1eUEx7Y38b/2nHdW7dhEObHx4gPJ/Alu9cZf5RQza/hVl9Z9zRy46RWH9RH5vMvPoCf6lqZGnVEKywtSaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRpZZKnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97065C2BC87;
	Sat, 28 Feb 2026 17:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300611;
	bh=arC2Z881uVFzGKibrZWaTBPjUaTvs4NVoNdK8HcPU3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRpZZKnWxhRwVMg3zIPf2v2lbZxF+jN0uNEv1pwl0bKJjJccIgTrETdLQ/hmD8wJ9
	 yfpZNtn3/lVMNMCBocwsbrRx2J6+JxSdWQWFD6Twy9pjjfU7v5qs7RH2dJHq/IW+Ym
	 kjCEHAB5GLSNIp17RHmS9hEG9EbeaSapE7r9YyBgLXM4YRJlfpD17vbxobqBhGm1Uv
	 Hk7A2WL2tqd6JhcXSds00D+gtC4BzssPVHmEr2/yBa5LagrSgnPUe2QeTfswkm8Vmq
	 Eyz8frS92uYDptvXFxkui3NIkN5gi+84gZb4wXTfrT/GdLDKeVozAYR9+TzbuulB9S
	 Mbmhz76BBkGLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 651/844] PCI: dwc: Skip waiting for L2/L3 Ready if dw_pcie_rp::skip_l23_wait is true
Date: Sat, 28 Feb 2026 12:29:24 -0500
Message-ID: <20260228173244.1509663-652-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220730-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 88DB01C6D21
X-Rspamd-Action: no action

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit 58a17b2647ba5aac47e3ffafd0a9b92bf4a9bcbe ]

In NXP i.MX6QP and i.MX7D SoCs, LTSSM registers are not accessible once
PME_Turn_Off message is broadcasted to the link. So there is no way to
verify whether the link has entered L2/L3 Ready state or not.

Hence, add a new flag 'dw_pcie_rp::skip_l23_ready' and set it to 'true' for
the above mentioned SoCs. This flag when set, will allow the DWC core to
skip polling for L2/L3 Ready state and just wait for 10ms as recommended in
the PCIe spec r6.0, sec 5.3.3.2.1.

Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[mani: renamed flag to skip_l23_ready and reworded description]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260114083300.3689672-2-hongxing.zhu@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c             |  5 +++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index dd69af0f195ff..c6dfbd57880ea 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -116,6 +116,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
 #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
 #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
+#define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1798,6 +1799,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		 */
 		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
+		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
+			pci->pp.skip_l23_ready = true;
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
@@ -1859,6 +1862,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.variant = IMX6QP,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
 			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
+			 IMX_PCIE_FLAG_SKIP_L23_READY |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
@@ -1875,6 +1879,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.variant = IMX7D,
 		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_SKIP_L23_READY |
 			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f1c7d50eba746..af2eeed55f9e5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1173,6 +1173,16 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 			return ret;
 	}
 
+	/*
+	 * Some SoCs do not support reading the LTSSM register after
+	 * PME_Turn_Off broadcast. For those SoCs, skip waiting for L2/L3 Ready
+	 * state and wait 10ms as recommended in PCIe spec r6.0, sec 5.3.3.2.1.
+	 */
+	if (pci->pp.skip_l23_ready) {
+		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
+		goto stop_link;
+	}
+
 	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
 				val == DW_PCIE_LTSSM_L2_IDLE ||
 				val <= DW_PCIE_LTSSM_DETECT_WAIT,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6f0dfdde1d577..ca3ff1fefab5d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -446,6 +446,7 @@ struct dw_pcie_rp {
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
 	bool			native_ecam;
+	bool                    skip_l23_ready;
 };
 
 struct dw_pcie_ep_ops {
-- 
2.51.0


