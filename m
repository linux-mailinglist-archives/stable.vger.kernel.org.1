Return-Path: <stable+bounces-76365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4AB97A166
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1B11F22156
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559C15852B;
	Mon, 16 Sep 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J47Lqm6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6913155359;
	Mon, 16 Sep 2024 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488384; cv=none; b=oG23kaGU5Z06FM+mJFgF4Bcr/pFGw2jFHjfDpGu5ZDgAd1gQaSWOVtKFNhG2J2f0kbZJnKAq96lxpSeM1dNKt2hL4+X6W8xstLhdwh6Z9mxqcF0/Bf17wsAJmYvwdKhLfqDvO+st447Xl6HuCnR6mwpeAEqlj/Og1fjleqKQHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488384; c=relaxed/simple;
	bh=m9baZ5l19VRcPO1vC4/37oe7Szrhu7wrPwrT9QR48JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7imEbu5jPjSpdgAhMMfbVDLd0mmhNyF6Guz6EJvdyyBjM9TtT0EWU8aoj45O5alggeGniOwS83lB4AiGRIAdDWU/G5FLknfNbAkBnAix1OrFEVji0ipTblcrazOzBRZqwWAZu0usdrq/85beJtcMgFvUU0pwg6sKti6ynP7up4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J47Lqm6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B61C4CEC4;
	Mon, 16 Sep 2024 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488384;
	bh=m9baZ5l19VRcPO1vC4/37oe7Szrhu7wrPwrT9QR48JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J47Lqm6NPZsG5Aczc+ghm4sWpFXor6yxjCnhXAfqoQE5zbQq5oo/mAwk+2VOKA0BZ
	 2B5s3HtbdWU/Hk5rGLBSR4HoeAYe2xzVcZPU4/vDbvRSGy/F7++1C288+macJV/6VH
	 ixEv42UfyLRrlfzq6ZC3rlFvV6WHLa2ubyDvaqcM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 067/121] cxl: Restore XORd position bits during address translation
Date: Mon, 16 Sep 2024 13:44:01 +0200
Message-ID: <20240916114231.382774815@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
References: <20240916114228.914815055@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alison Schofield <alison.schofield@intel.com>

[ Upstream commit 3b2fedcd75e3991e77c2a8c3ebcab0ea68b2d69d ]

When a device reports a DPA in events like poison, general_media,
and dram, the driver translates that DPA back to an HPA. Presently,
the CXL driver translation only considers the Modulo position and
will report the wrong HPA for XOR configured root decoders.

Add a helper function that restores the XOR'd bits during DPA->HPA
address translation. Plumb a root decoder callback to the new helper
when XOR interleave arithmetic is in use. For Modulo arithmetic, just
let the callback be NULL - as in no extra work required.

Upon completion of a DPA->HPA translation a couple of checks are
performed on the result. One simply confirms that the calculated
HPA is within the address range of the region. That test is useful
for both Modulo and XOR interleave arithmetic decodes.

A second check confirms that the HPA is within an expected chunk
based on the endpoints position in the region and the region
granularity. An XOR decode disrupts the Modulo pattern making the
chunk check useless.

To align the checks with the proper decode, pull the region range
check inline and use the helper to do the chunk check for Modulo
decodes only.

A cxl-test unit test is posted for upstream review here:
https://lore.kernel.org/20240624210644.495563-1-alison.schofield@intel.com/

Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/1a1ac880d9f889bd6384e657e810431b9a0a72e5.1719980933.git.alison.schofield@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/acpi.c        | 40 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c | 23 +++++++++++++---------
 drivers/cxl/cxl.h         |  3 +++
 3 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..6b6ae9c81368 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 	return cxlrd->cxlsd.target[n];
 }
 
+static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	int hbiw = cxlrd->cxlsd.nr_targets;
+	u64 val;
+	int pos;
+
+	/* No xormaps for host bridge interleave ways of 1 or 3 */
+	if (hbiw == 1 || hbiw == 3)
+		return hpa;
+
+	/*
+	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
+	 * the position bit to its value before the xormap was applied at
+	 * HPA->DPA translation.
+	 *
+	 * pos is the lowest set bit in an XORMAP
+	 * val is the XORALLBITS(HPA & XORMAP)
+	 *
+	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
+	 * as an operation that outputs a single bit by XORing all the
+	 * bits in the input (hpa & xormap). Implement XORALLBITS using
+	 * hweight64(). If the hamming weight is even the XOR of those
+	 * bits results in val==0, if odd the XOR result is val==1.
+	 */
+
+	for (int i = 0; i < cximsd->nr_maps; i++) {
+		if (!cximsd->xormaps[i])
+			continue;
+		pos = __ffs(cximsd->xormaps[i]);
+		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
+		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
+	}
+
+	return hpa;
+}
+
 struct cxl_cxims_context {
 	struct device *dev;
 	struct cxl_root_decoder *cxlrd;
@@ -434,6 +471,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxlrd->qos_class = cfmws->qtg_id;
 
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
+		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
+
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0e30e0a29d40..3345ccbade0b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2830,20 +2830,13 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	return ctx.cxlr;
 }
 
-static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
+static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int gran = p->interleave_granularity;
 	int ways = p->interleave_ways;
 	u64 offset;
 
-	/* Is the hpa within this region at all */
-	if (hpa < p->res->start || hpa > p->res->end) {
-		dev_dbg(&cxlr->dev,
-			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
-		return false;
-	}
-
 	/* Is the hpa in an expected chunk for its pos(-ition) */
 	offset = hpa - p->res->start;
 	offset = do_div(offset, gran * ways);
@@ -2859,6 +2852,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
 static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 			  struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	int pos = cxled->pos;
@@ -2898,7 +2892,18 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start;
 
-	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
+	/* Root decoder translation overrides typical modulo decode */
+	if (cxlrd->hpa_to_spa)
+		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
+
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_dbg(&cxlr->dev,
+			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
+		return ULLONG_MAX;
+	}
+
+	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
+	if (!cxlrd->hpa_to_spa && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
 		return ULLONG_MAX;
 
 	return hpa;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a6613a6f8923..b8e16e8697e2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -436,12 +436,14 @@ struct cxl_switch_decoder {
 struct cxl_root_decoder;
 typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
 					    int pos);
+typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
  * @qos_class: QoS performance class cookie
@@ -451,6 +453,7 @@ struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
 	cxl_calc_hb_fn calc_hb;
+	cxl_hpa_to_spa_fn hpa_to_spa;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-- 
2.43.0




