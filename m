Return-Path: <stable+bounces-256660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOySOWTRGWofzQgAu9opvQ
	(envelope-from <stable+bounces-256660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:48:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ED9606D27
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040AE35100B1
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E93F888A;
	Fri, 29 May 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDiZ+ZMg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA3363C69
	for <stable@vger.kernel.org>; Fri, 29 May 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073507; cv=none; b=Q1SirJD8HNwP4keslbPxw1tAFD96bQGVSCXwSKCd7QgvnBJ9QU1hJ8Z+QB2fAFykzFhTfScW4xdgVmF7zdnTj9CDa/9igDAbOCmJUF/JhheNdjmQMBjjmzIJ8BhnDrMp1iP47jKrut+ZuIQ5tCDjcqZGodLY2B2IA/C2aQO19r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073507; c=relaxed/simple;
	bh=2irdKNgPC39PHvaOL1hYqA6pG4eJ7kDV/wskJYBqz5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8JRrYTj0881Mc/H++za59sldxacQDSA+/psNnWIvMZ+jJjPYhIZLyy5rWQE3PMifCw5tNkzFXjr8PWcdGnc4YRlLQpl2chm2rkYIusFAPKyU1uf7thrpbzwWAgBJcf7Lwa8T0aWU9R/TUZDRjj1GCj5pmm63WQdQH5PufCeGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDiZ+ZMg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47D91F0089A;
	Fri, 29 May 2026 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073503;
	bh=Xr+n0a3tI2zVzzDOJCngwsMWfUX4FkJIkAmxBOWlrw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HDiZ+ZMgPiacTj6+QDIr6q6+t9Eg7w2hTKSnsf1mPRPY2nqYv2MIxUiGoeCZ3ghFV
	 D4LhmIh7AiHdY+YenrgShYcubRk9Gu/dqqbwX/JIGoth6jRhUGfaX6fecE3LdmYr25
	 QPa7dy/kFb7Ca7/Uq8PvpQGfr6VhZih6JLozmhY4VTmhN4JmNrjdZKMsqjyqv6KQus
	 sY7nfcue23Cm1dHSukDVv44Ej6Htt4DN/AsF0seHlUW46udjS2D0esd4IngkLP7Zzh
	 OMZRsoPVp2dtDkGk9+xdtRFE6fI6tpdQRHT0wEcO5q4EzeZGOkXjDhpuS+5u0PjGGe
	 8NGGm9gRUwbig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/3] platform/x86/intel/vsec: Make driver_data info const
Date: Fri, 29 May 2026 12:51:39 -0400
Message-ID: <20260529165140.1230013-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529165140.1230013-1-sashal@kernel.org>
References: <2026052828-poplar-serrated-d1e5@gregkh>
 <20260529165140.1230013-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256660-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 53ED9606D27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "David E. Box" <david.e.box@linux.intel.com>

[ Upstream commit 9577c74c96f88d807d1ba005adbf5952e7127e55 ]

Treat PCI id->driver_data (intel_vsec_platform_info) as read-only by making
vsec_priv->info a const pointer and updating all function signatures to
accept const intel_vsec_platform_info *.

This improves const-correctness and clarifies that the platform info data
from the driver_data table is not meant to be modified at runtime.

No functional changes intended.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Link: https://patch.msgid.link/20260313015202.3660072-3-david.e.box@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 348ccc754d89 ("platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/vsec.c | 20 ++++++++++----------
 include/linux/intel_vsec.h        |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 46966edca03b9..e0096be605d9d 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -42,7 +42,7 @@ enum vsec_device_state {
 };
 
 struct vsec_priv {
-	struct intel_vsec_platform_info *info;
+	const struct intel_vsec_platform_info *info;
 	struct device *suppliers[VSEC_FEATURE_COUNT];
 	struct oobmsm_plat_info plat_info;
 	enum vsec_device_state state[VSEC_FEATURE_COUNT];
@@ -270,7 +270,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, "INTEL_VSEC");
 
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
-			      struct intel_vsec_platform_info *info,
+			      const struct intel_vsec_platform_info *info,
 			      unsigned long cap_id, u64 base_addr)
 {
 	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
@@ -406,7 +406,7 @@ static int get_cap_id(u32 header_id, unsigned long *cap_id)
 
 static int intel_vsec_register_device(struct pci_dev *pdev,
 				      struct intel_vsec_header *header,
-				      struct intel_vsec_platform_info *info,
+				      const struct intel_vsec_platform_info *info,
 				      u64 base_addr)
 {
 	const struct vsec_feature_dependency *consumer_deps;
@@ -452,7 +452,7 @@ static int intel_vsec_register_device(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_walk_header(struct pci_dev *pdev,
-				   struct intel_vsec_platform_info *info)
+				   const struct intel_vsec_platform_info *info)
 {
 	struct intel_vsec_header **header = info->headers;
 	bool have_devices = false;
@@ -468,7 +468,7 @@ static bool intel_vsec_walk_header(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
-				  struct intel_vsec_platform_info *info)
+				  const struct intel_vsec_platform_info *info)
 {
 	bool have_devices = false;
 	int pos = 0;
@@ -519,7 +519,7 @@ static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
-				 struct intel_vsec_platform_info *info)
+				 const struct intel_vsec_platform_info *info)
 {
 	bool have_devices = false;
 	int pos = 0;
@@ -565,7 +565,7 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 }
 
 int intel_vsec_register(struct pci_dev *pdev,
-			 struct intel_vsec_platform_info *info)
+			const struct intel_vsec_platform_info *info)
 {
 	if (!pdev || !info || !info->headers)
 		return -EINVAL;
@@ -578,7 +578,7 @@ int intel_vsec_register(struct pci_dev *pdev,
 EXPORT_SYMBOL_NS_GPL(intel_vsec_register, "INTEL_VSEC");
 
 static bool intel_vsec_get_features(struct pci_dev *pdev,
-				    struct intel_vsec_platform_info *info)
+				    const struct intel_vsec_platform_info *info)
 {
 	bool found = false;
 
@@ -622,7 +622,7 @@ static void intel_vsec_skip_missing_dependencies(struct pci_dev *pdev)
 
 static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct intel_vsec_platform_info *info;
+	const struct intel_vsec_platform_info *info;
 	struct vsec_priv *priv;
 	int num_caps, ret;
 	int run_once = 0;
@@ -633,7 +633,7 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 		return ret;
 
 	pci_save_state(pdev);
-	info = (struct intel_vsec_platform_info *)id->driver_data;
+	info = (const struct intel_vsec_platform_info *)id->driver_data;
 	if (!info)
 		return -EINVAL;
 
diff --git a/include/linux/intel_vsec.h b/include/linux/intel_vsec.h
index 1a0f357c24271..d551174b00491 100644
--- a/include/linux/intel_vsec.h
+++ b/include/linux/intel_vsec.h
@@ -200,13 +200,13 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
 
 #if IS_ENABLED(CONFIG_INTEL_VSEC)
 int intel_vsec_register(struct pci_dev *pdev,
-			 struct intel_vsec_platform_info *info);
+			const struct intel_vsec_platform_info *info);
 int intel_vsec_set_mapping(struct oobmsm_plat_info *plat_info,
 			   struct intel_vsec_device *vsec_dev);
 struct oobmsm_plat_info *intel_vsec_get_mapping(struct pci_dev *pdev);
 #else
 static inline int intel_vsec_register(struct pci_dev *pdev,
-				       struct intel_vsec_platform_info *info)
+				      const struct intel_vsec_platform_info *info)
 {
 	return -ENODEV;
 }
-- 
2.53.0


