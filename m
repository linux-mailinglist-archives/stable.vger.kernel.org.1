Return-Path: <stable+bounces-220678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGcNDPtSo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:41:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B289F1C87DC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B745233DC59E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282963F6255;
	Sat, 28 Feb 2026 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5WSiGRz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2623F624B;
	Sat, 28 Feb 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300559; cv=none; b=Ke6F3kcGl/U3SGdOOozJOjCzUWfMuJCdpONEEkOKYRdkaaud75YywDcIXI5VcGvIww5olhQTjr5wKi57Qxjnr6BG3ZKWwx26looUBtEx66LE4ptaZRZRpctjBBDdBNB3hAZrebMzUho0dtkZM0pN/mqqFJLqGSovXkPirrR/ycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300559; c=relaxed/simple;
	bh=bhJ5Yb/Na+yEVffXP00Rs2919cK6E4A6fCdILB2J4UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuHxJjkta8GEHrbz2C/3DJ5LhyTpj9CCQnkkTFupIfwQen8aHDDxeRCa/KR4LoHMOpgkH3TwlhOz39Qj2zXGz3dUwfN3HUB6dfodczMj8+bB5iieaRgbiDEJ8FhoVrn5Ya0Z8YdP9toS1SS7YD+qgodQeXzURBnuu0qP0NMh4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5WSiGRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353D3C19425;
	Sat, 28 Feb 2026 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300559;
	bh=bhJ5Yb/Na+yEVffXP00Rs2919cK6E4A6fCdILB2J4UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5WSiGRzlal6s0hS2JfoRN/QY57rkYHNhziRmrjncOcBIKFvvn8HoiiGUW+QADJGh
	 yiV0pg6HeBfr+4J9OwZsS4ZcFAasL5nlxBkfi+JM6wQqCpp1Xg6VMQSjd9aKgJ6vNZ
	 FvAGgN01YbfAK6Ta7DGHg7YaqAk1qr+rsls8qJrY05WKN+4lZ2ukKB9IqCGdKlFv09
	 /gkID0LdNRKnqv6rB4rhnOzja574Vwarci2dfa6a84lTLjEbPo7szusnYnogDrTAGz
	 cpccEfsqbnNi+XwWTWHqjobArE6SuxvORLIwySjVz2AVKrTMTGzTNHk5PObojoqLHm
	 MYMtpID6E6wGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 599/844] platform/x86: ISST: Store and restore all domains data
Date: Sat, 28 Feb 2026 12:28:32 -0500
Message-ID: <20260228173244.1509663-600-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220678-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B289F1C87DC
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


