Return-Path: <stable+bounces-257325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM3GMLIaG2pR/QgAu9opvQ
	(envelope-from <stable+bounces-257325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:13:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315760F29C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 620CF30D524F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A135200B;
	Sat, 30 May 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoN5eM5e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1E481DD
	for <stable@vger.kernel.org>; Sat, 30 May 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160614; cv=none; b=N5zU8oOOMQZfPuDtxtTuHTWctFq+eks3aqf1ghF4X4N4oWM0Zlp1uqSOXpVgQ9othjnSniDyWv1jbMK7+J+j3M1uePgYiabOadUmvLFANTV6vH10n0gynXmMNuDAbqQ0V6RDa2B20hAQAPXZwNb2L4CfqlGVWo9H5cg0K59D+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160614; c=relaxed/simple;
	bh=94R9a64P91vN20hff9ATaNOJmmR4tEw+Nfw7ZF8ZLDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jX9bRnjeCeURMamU82t9+7mUGWtwWuNzGZb6G7UnHXO8u4Gfunxj/ZJF5RBP2rcoeHABYi+PuJhXB789xJJUyb9ICyXvtQOh5SQhllJdfYH/cKhdTxBTFU/Cy914AWa23Qo3PJCW1FPu6s5eAYs+VaWWuHz/kQjtEn/3rI3R1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoN5eM5e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EF01F00898;
	Sat, 30 May 2026 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780160613;
	bh=S8/UVf+yenVYyzB9TTtvI2gmdt8hOmvukiHq72xYOXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RoN5eM5edgCBYYYebFhEB6akFv0MwRWSwXpCHz2pLfEy1GUgIv4OizE0u19iCwiGY
	 PtMuUmWUY/ciWY27znnkOpMfTDEN7GJW1JYKX4WCA48D7/vSvky8bnZsKoWiHs20D9
	 51ExjRVxzlONxYqONfS+AdbY+pf2yrQCHS7C1PeHLutf33pmhgnhipOMKPKlhBCa3h
	 JusxVY8KJAlKlQN56ioGrHA/3h5DqGkHiCkywoSHV+1O5WwQxtviFAUYe4S0rS1VUt
	 wIpmJWDZbwIEK7vriI+I7VgGb7BnGyUtKBUDDg2Lwr1TocWqrQdwEBOldsdjACfqdH
	 AsX39frlfZ6bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] platform/x86/intel/vsec: Add private data for per-device data
Date: Sat, 30 May 2026 13:03:28 -0400
Message-ID: <20260530170331.3037528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052831-compacter-avenue-4d0c@gregkh>
References: <2026052831-compacter-avenue-4d0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-257325-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3315760F29C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "David E. Box" <david.e.box@linux.intel.com>

[ Upstream commit dc957ab6aa05c118c3da0542428a4d6602aa2d2d ]

Introduce a new private structure, struct vsec_priv, to hold a pointer to
the platform-specific information. Although the driver didn’t previously
require this per-device data, adding it now lays the groundwork for
upcoming patches that will manage such data. No functional changes.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Link: https://lore.kernel.org/r/20250703022832.1302928-3-david.e.box@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 348ccc754d89 ("platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/vsec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 40477d1d41b59..1a9f8267b0b07 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -73,6 +73,10 @@ static enum intel_vsec_id intel_vsec_allow_list[] = {
 	VSEC_ID_SDSI,
 };
 
+struct vsec_priv {
+	struct intel_vsec_platform_info *info;
+};
+
 static const char *intel_vsec_name(enum intel_vsec_id id)
 {
 	switch (id) {
@@ -375,6 +379,7 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_vsec_platform_info *info;
+	struct vsec_priv *priv;
 	bool have_devices = false;
 	int ret;
 
@@ -387,6 +392,13 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!info)
 		return -EINVAL;
 
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->info = info;
+	pci_set_drvdata(pdev, priv);
+
 	if (intel_vsec_walk_dvsec(pdev, info))
 		have_devices = true;
 
-- 
2.53.0


