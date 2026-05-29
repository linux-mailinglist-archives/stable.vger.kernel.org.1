Return-Path: <stable+bounces-256661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJxGEHfLGWqNzAgAu9opvQ
	(envelope-from <stable+bounces-256661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:23:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9426065E2
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8ECC3520807
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3E409E1C;
	Fri, 29 May 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODP/SOpM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04B4028EA
	for <stable@vger.kernel.org>; Fri, 29 May 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073507; cv=none; b=QGHSPHElLiKg6kcrXPyFQ6SQVSdarD37rSU4XeD7zu97nq5VaR/m2bzmTJpQIC/lI+zSA90PWsqXyiSIx39SfjfO5W6/ZgyUn42y1VosRBZrM/FMIAIjsV/z89XiTwGYFJ70xuBBiYvBf0jXPE4qOZ5i80dK2iSrU48lgDU7vhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073507; c=relaxed/simple;
	bh=44eo/npIa0PSGxo3CoWIWmyhyUPuohkkYlTeIrYM4+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2Xqir0LQ9e/eyIN5er3mjIO2kmdlWlcsbRiALPqQbmsghBiKkBZ9dwWGS7kv33B5shV+ys0vXZnBRnSOlL/tzndQgfylH2hu7CCfD0fRSUXIco/QLUSBpKGMlj2B66Y7ZNFuAasd++aBYHwFgGk+hwoerrB+SCngQJ7WyX3hsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODP/SOpM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063421F00898;
	Fri, 29 May 2026 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073502;
	bh=WZMZlec9L3THOG3o22+lJwGL+GIH20sNJ2vvm29Kxto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ODP/SOpMMAJ0TV+tTgl6GBdPj0ZUJRRSbkiU6cEMEudf4Vt4UtsbR8bRm2g8eij83
	 n9XpIw+5ugLcrAJ/6ItjUjeIWr6zbbQo47AKi0tVpE2UnBupZbyZBZ1Yz8JE2ip3Ys
	 zaqdf1MxwbK9Vkq547TeZNdkYT5aWYayRgQOW0Y4Zxhf9MzFeoeKh2t1zYvJByUFuX
	 Si3I+7J8lR5nUsjWtXVicCni8vXlYbM/qj2rvRK+Ne2rkRxvI9AhyS+JqPXk4HhuSR
	 /z4vuEpBol/ZYTNqX6WWFknaT3DlVYLjQAQe1Lr52eIb+T+ioUNqTqwaZK/U45NsBK
	 8HbrLbRh8Xi6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/3] platform/x86/intel/vsec: Refactor base_addr handling
Date: Fri, 29 May 2026 12:51:38 -0400
Message-ID: <20260529165140.1230013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052828-poplar-serrated-d1e5@gregkh>
References: <2026052828-poplar-serrated-d1e5@gregkh>
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
	TAGGED_FROM(0.00)[bounces-256661-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,header.id:url]
X-Rspamd-Queue-Id: 8D9426065E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "David E. Box" <david.e.box@linux.intel.com>

[ Upstream commit 904b333fc51cc045941df9656302449a0fc9978e ]

The base_addr field in intel_vsec_platform_info was originally added to
support devices that emulate PCI VSEC capabilities in MMIO. Previously,
the code would check at registration time whether base_addr was set,
falling back to the PCI BAR if not.

Refactor this by making base_addr an explicit function parameter. This
clarifies ownership of the value and removes conditional logic from
intel_vsec_add_dev(). It also enables making intel_vsec_platform_info
const in a later patch, since the function no longer needs to write to
info->base_addr.

No functional change intended.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Link: https://patch.msgid.link/20260313015202.3660072-2-david.e.box@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 348ccc754d89 ("platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/vsec.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 5059d320edf8c..46966edca03b9 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -271,14 +271,13 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, "INTEL_VSEC");
 
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
 			      struct intel_vsec_platform_info *info,
-			      unsigned long cap_id)
+			      unsigned long cap_id, u64 base_addr)
 {
 	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
 	struct resource __free(kfree) *res = NULL;
 	struct resource *tmp;
 	struct device *parent;
 	unsigned long quirks = info->quirks;
-	u64 base_addr;
 	int i;
 
 	if (info->parent)
@@ -310,11 +309,6 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
 		header->offset >>= TABLE_OFFSET_SHIFT;
 
-	if (info->base_addr)
-		base_addr = info->base_addr;
-	else
-		base_addr = pdev->resource[header->tbir].start;
-
 	/*
 	 * The DVSEC/VSEC contains the starting offset and count for a block of
 	 * discovery tables. Create a resource array of these tables to the
@@ -412,7 +406,8 @@ static int get_cap_id(u32 header_id, unsigned long *cap_id)
 
 static int intel_vsec_register_device(struct pci_dev *pdev,
 				      struct intel_vsec_header *header,
-				      struct intel_vsec_platform_info *info)
+				      struct intel_vsec_platform_info *info,
+				      u64 base_addr)
 {
 	const struct vsec_feature_dependency *consumer_deps;
 	struct vsec_priv *priv;
@@ -428,7 +423,7 @@ static int intel_vsec_register_device(struct pci_dev *pdev,
 	 * For others using the exported APIs, add the device directly.
 	 */
 	if (!pci_match_id(intel_vsec_pci_ids, pdev))
-		return intel_vsec_add_dev(pdev, header, info, cap_id);
+		return intel_vsec_add_dev(pdev, header, info, cap_id, base_addr);
 
 	priv = pci_get_drvdata(pdev);
 	if (priv->state[cap_id] == STATE_REGISTERED ||
@@ -444,7 +439,7 @@ static int intel_vsec_register_device(struct pci_dev *pdev,
 
 	consumer_deps = get_consumer_dependencies(priv, cap_id);
 	if (!consumer_deps || suppliers_ready(priv, consumer_deps, cap_id)) {
-		ret = intel_vsec_add_dev(pdev, header, info, cap_id);
+		ret = intel_vsec_add_dev(pdev, header, info, cap_id, base_addr);
 		if (ret)
 			priv->state[cap_id] = STATE_SKIP;
 		else
@@ -464,7 +459,7 @@ static bool intel_vsec_walk_header(struct pci_dev *pdev,
 	int ret;
 
 	for ( ; *header; header++) {
-		ret = intel_vsec_register_device(pdev, *header, info);
+		ret = intel_vsec_register_device(pdev, *header, info, info->base_addr);
 		if (!ret)
 			have_devices = true;
 	}
@@ -512,7 +507,8 @@ static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
 		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER2, &hdr);
 		header.id = PCI_DVSEC_HEADER2_ID(hdr);
 
-		ret = intel_vsec_register_device(pdev, &header, info);
+		ret = intel_vsec_register_device(pdev, &header, info,
+						 pci_resource_start(pdev, header.tbir));
 		if (ret)
 			continue;
 
@@ -557,7 +553,8 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
 		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
 
-		ret = intel_vsec_register_device(pdev, &header, info);
+		ret = intel_vsec_register_device(pdev, &header, info,
+						 pci_resource_start(pdev, header.tbir));
 		if (ret)
 			continue;
 
-- 
2.53.0


