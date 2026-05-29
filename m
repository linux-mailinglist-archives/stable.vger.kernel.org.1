Return-Path: <stable+bounces-256663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDJUBUzJGWpzzAgAu9opvQ
	(envelope-from <stable+bounces-256663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:13:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6D60635D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 423A531B5F41
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A133F4110;
	Fri, 29 May 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTPMNZzg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4400340416
	for <stable@vger.kernel.org>; Fri, 29 May 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073970; cv=none; b=Uvl3Mv+tTDglzEbIFNXAz1Z6x0H+/knvwpjYg4KtInih77XoE+cJJ58/yudz5f6VJRVMs4LCe5URlvIvSzdtCApX9thf5fG0Pey1TAfiEewSl+qByy5ponYmevH4ZarWc+VO3sP/p6ZkAGk02RvnZYeYCBRBNUC8UGA69YrDQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073970; c=relaxed/simple;
	bh=EXWEe6AluVGEAAnVLfICZho40d8+yu30kLeq8ohLerM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxb26/sID5v1Ph0BFW5WlhJHcmICeDA4mzZPdwvTmDg3NGIEHwIDty6PPFSC0Q9vT0pnWH04qLHgsamU6H6GHp+SjJPevkCTicwZEPL9rV5MoVO47CX0TtwRA7lfZJJZ77UED76RklJSHQKYTvWSb0okCQZahnqyua9763SySgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTPMNZzg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03051F00893;
	Fri, 29 May 2026 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073969;
	bh=zoXh8qxt7Ey/coamRqdTiwUo6erz+UjwcmTyycTdapQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTPMNZzg/WTP6oSKcq+qTw5YFYfaULnCMkGKq31Dyabd4Q7xLqnYZUOZMlyXgOzpm
	 rRvCTbXmzDxUkaoGPw5hjjCUgpBGQKt8mqRgxRRwG0qFoe7TgmXuX18LTkPdxZ1/bm
	 ym2YXE3Fnli6r2GQ5Hn9N472X+JbimnoPXoWQW7curP6ywqop793f0wVya1g4djlp2
	 DGJDWE1AuYHoWdkXuAtzB5fjFh0+6YbfHMDnMdCXV5lJw+GUmTDFoav4LEg72HjQ6+
	 fZUVS9Jiet1zZyZFI2u89vXUeA4W9R9huTlEANPLK8ibB1CvUiTr8rLVLpOSYsxThX
	 JP80QXPze8baQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] platform/x86/intel/vsec: Refactor base_addr handling
Date: Fri, 29 May 2026 12:59:24 -0400
Message-ID: <20260529165926.1255525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052829-promotion-chubby-ffb5@gregkh>
References: <2026052829-promotion-chubby-ffb5@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256663-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,header.id:url]
X-Rspamd-Queue-Id: 82F6D60635D
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
index f66f0ce8559b1..1f041dc1a3f8d 100644
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


