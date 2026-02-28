Return-Path: <stable+bounces-221008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGW8JkFNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 443F81C8242
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59D463207644
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5B4BC03B;
	Sat, 28 Feb 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InggKbLU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303F4BC037;
	Sat, 28 Feb 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301352; cv=none; b=RthWRmVHGkVhB/BHRKZqr5/ozYqTzYUNzoV5yx22fO3bRGWoqf7kmw8TW5Jflu5Nj5XgaKrBuqPPnwt+UF5tuBDub911/GIWEG3GBwQIh5xZ9Te58dlTR/FTyZBwnmWpYzVl/xSZCo6yluH6syWM0kmAGz2UWI+aW8YC97/aWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301352; c=relaxed/simple;
	bh=bhJ5Yb/Na+yEVffXP00Rs2919cK6E4A6fCdILB2J4UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5NwaMBgbBghPrW1PupxEZm81d6i7rZMKLWfkEZjFoWe4D7wa3XKylES07utJa5YcNhJjmbfC9lwaE3u/iHYVY7OGHDQBwmsDN/pJHKtRa4m8n04y3OtKAIs2y9j3SqsJYi0oYCZgVJunfypj3pg9WsKS56nle6tJtNzmP0euUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InggKbLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AB9C19424;
	Sat, 28 Feb 2026 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301351;
	bh=bhJ5Yb/Na+yEVffXP00Rs2919cK6E4A6fCdILB2J4UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InggKbLUkqBDVEdoY6McJfZ9dQPWbKbJzIE4CGg2QmzbZCx6xh5pq081TIcC637wi
	 nSKB9BDVu+fH8bs894H6ObwkXvvxReODct+EajH7ELP70EJomX2Q0xPz0ac84ZbGsR
	 GA3QZg9UbnJMKGMSzE6AWSel3ERkmzdCiQrlI9pcD95KLuKOzXUKNblVgCeYzdycpU
	 5SptIxgWBX2/4XMz01dpiRz6cJF/Zwc5AeN2iour4p/vXHByWE9X6IpDzKtaSdQ5SX
	 30qqCI6+M/t4BfOgNqtO4tP9h6f1lsdEZIz5+Bze6lPQRdzE+cshZfd7upFKL7RZPn
	 3GjvTOH5R+ceA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 539/752] platform/x86: ISST: Store and restore all domains data
Date: Sat, 28 Feb 2026 12:44:10 -0500
Message-ID: <20260228174750.1542406-539-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221008-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 443F81C8242
X-Rspamd-Action: no action

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit dc7901b5a1563a9c9eb29b3b0b0dac3162065cd8 ]

The suspend/resume callbacks currently only store and restore the
configuration for power domain 0. However, other power domains may also
have modified configurations that need to be preserved across suspend/
resume cycles.

Extend the store/restore functionality to handle all power domains.

Fixes: 91576acab020 ("platform/x86: ISST: Add suspend/resume callbacks")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/20260107060256.1634188-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 54 +++++++++++--------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index f587709ddd473..13b11c3a2ec4e 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1723,55 +1723,67 @@ EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, "INTEL_TPMI_SST");
 void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev)
 {
 	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
-	struct tpmi_per_power_domain_info *power_domain_info;
+	struct tpmi_per_power_domain_info *power_domain_info, *pd_info;
 	struct oobmsm_plat_info *plat_info;
 	void __iomem *cp_base;
+	int num_resources, i;
 
 	plat_info = tpmi_get_platform_data(auxdev);
 	if (!plat_info)
 		return;
 
 	power_domain_info = tpmi_sst->power_domain_info[plat_info->partition];
+	num_resources = tpmi_sst->number_of_power_domains[plat_info->partition];
 
-	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
-	power_domain_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
-
-	memcpy_fromio(power_domain_info->saved_clos_configs, cp_base + SST_CLOS_CONFIG_0_OFFSET,
-		      sizeof(power_domain_info->saved_clos_configs));
+	for (i = 0; i < num_resources; i++) {
+		pd_info = &power_domain_info[i];
+		if (!pd_info || !pd_info->sst_base)
+			continue;
 
-	memcpy_fromio(power_domain_info->saved_clos_assocs, cp_base + SST_CLOS_ASSOC_0_OFFSET,
-		      sizeof(power_domain_info->saved_clos_assocs));
+		cp_base = pd_info->sst_base + pd_info->sst_header.cp_offset;
+		pd_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
+		memcpy_fromio(pd_info->saved_clos_configs, cp_base + SST_CLOS_CONFIG_0_OFFSET,
+			      sizeof(pd_info->saved_clos_configs));
+		memcpy_fromio(pd_info->saved_clos_assocs, cp_base + SST_CLOS_ASSOC_0_OFFSET,
+			      sizeof(pd_info->saved_clos_assocs));
 
-	power_domain_info->saved_pp_control = readq(power_domain_info->sst_base +
-						    power_domain_info->sst_header.pp_offset +
-						    SST_PP_CONTROL_OFFSET);
+		pd_info->saved_pp_control = readq(pd_info->sst_base +
+						  pd_info->sst_header.pp_offset +
+						  SST_PP_CONTROL_OFFSET);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_suspend, "INTEL_TPMI_SST");
 
 void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
 {
 	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
-	struct tpmi_per_power_domain_info *power_domain_info;
+	struct tpmi_per_power_domain_info *power_domain_info, *pd_info;
 	struct oobmsm_plat_info *plat_info;
 	void __iomem *cp_base;
+	int num_resources, i;
 
 	plat_info = tpmi_get_platform_data(auxdev);
 	if (!plat_info)
 		return;
 
 	power_domain_info = tpmi_sst->power_domain_info[plat_info->partition];
+	num_resources = tpmi_sst->number_of_power_domains[plat_info->partition];
 
-	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
-	writeq(power_domain_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
-
-	memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET, power_domain_info->saved_clos_configs,
-		    sizeof(power_domain_info->saved_clos_configs));
+	for (i = 0; i < num_resources; i++) {
+		pd_info = &power_domain_info[i];
+		if (!pd_info || !pd_info->sst_base)
+			continue;
 
-	memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET, power_domain_info->saved_clos_assocs,
-		    sizeof(power_domain_info->saved_clos_assocs));
+		cp_base = pd_info->sst_base + pd_info->sst_header.cp_offset;
+		writeq(pd_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
+		memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET, pd_info->saved_clos_configs,
+			    sizeof(pd_info->saved_clos_configs));
+		memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET, pd_info->saved_clos_assocs,
+			    sizeof(pd_info->saved_clos_assocs));
 
-	writeq(power_domain_info->saved_pp_control, power_domain_info->sst_base +
-				power_domain_info->sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
+		writeq(pd_info->saved_pp_control, power_domain_info->sst_base +
+		       pd_info->sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, "INTEL_TPMI_SST");
 
-- 
2.51.0


