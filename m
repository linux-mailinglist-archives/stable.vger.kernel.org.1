Return-Path: <stable+bounces-220328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFobGcVFo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5103E1C7522
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16F21315F835
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A1639732D;
	Sat, 28 Feb 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RygyuXdR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CA397323;
	Sat, 28 Feb 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300229; cv=none; b=HZiJZ4JU30wdx2s5u0kRPMLtZZfJFp/cpE4/cKemxZev1ELe1nxssTkRyYYwOuMGE76dJt3VXColIkpEjACM7ocd1d2VhI7DTBDI15Tu/T2DoupNOced+gSefPPvY3jSY+r4Luc/NymSI+QyOnkEYawtG33p3zSR3Wumu/FBv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300229; c=relaxed/simple;
	bh=8AXpm2e3DYVQcceKJcF6sK9d9mzDshF09g5BH3QvSVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZ09bgHk9M59KDiqBSbU/T7mgwBgpeMaMmklUEUAicS9KscZalpnb++ntmhLiWtHaaa0C6HXphS0r3grQIhrRTUnYO0qMRFYm+Yvtut4s3DS4m76f/JF2rCLBbH0kszGPFr7zRKCjdck1YnCJzl01U9/RUbes+RuhslXZqLpyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RygyuXdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B90C19423;
	Sat, 28 Feb 2026 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300229;
	bh=8AXpm2e3DYVQcceKJcF6sK9d9mzDshF09g5BH3QvSVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RygyuXdRWcmJ3OKzCTxdRUqqOXoPD6cxszVEmB2p+ULD9x4qDQzpAb8Sucr6pgllO
	 RgSaoCckxEv4L+LQlJoI+tjwUQv+unCsbxrEAs6eZY+nculHiRQjcp/OrY/Ymf6Eis
	 RuXF6nK17YtFKkEdZ5SEurekrOKJKBBHNxV7EhLzNBvcCBj6U8zZxQRzYI+Wa+JG2h
	 4mU7eru2N0ZgGhB/dcH7ZF+bNYDTuC5rBZKLGSiIzqPNPu6TxM8+fUxkOLfEaGWm2n
	 LKvP7VcjBhaXz6QGyW9tJWvLJ7SlEnHmCgC+jN4kNbT36dq6w4q1sVBIQW1tI7Wktm
	 pW6XKKehUYAMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 250/844] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link is not up
Date: Sat, 28 Feb 2026 12:22:43 -0500
Message-ID: <20260228173244.1509663-251-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220328-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rock-chips.com:email,msgid.link:url,qualcomm.com:email,nxp.com:email]
X-Rspamd-Queue-Id: 5103E1C7522
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit cfd2fdfd0a8da2e5bbfdc4009b9c4b8bf164c937 ]

During system suspend, if the PCIe link is not up, then there is no need
to broadcast PME_Turn_Off message and wait for L2/L3 transition. So skip
them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/20251218-pci-dwc-suspend-rework-v2-1-5a7778c6094a@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 372207c33a857..250725ced9026 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1158,8 +1158,11 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	int ret = 0;
 	u32 val;
-	int ret;
+
+	if (!dw_pcie_link_up(pci))
+		goto stop_link;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -1194,6 +1197,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	 */
 	udelay(1);
 
+stop_link:
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
-- 
2.51.0


