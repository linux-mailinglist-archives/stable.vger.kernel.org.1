Return-Path: <stable+bounces-141294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A62AAB227
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9435B7B90FD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890492DC3A5;
	Tue,  6 May 2025 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS1AN+Bm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BB2D644C;
	Mon,  5 May 2025 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485704; cv=none; b=vFBNkmCsQDTOHy2hlVJSsPpKwUW+7Wo5P8ylcZhWbYHngJaWYgZljVSe/LQgrj6akoXhEMU8m0dMn6Np/Y+59DMK2dfWM+ruD2TUIq05R+4tGiKugun1BFXguTFpUZ+EYSvBHzjqUQXP+1eC3hKym/yJE6ID2KE3/QMczQ3AREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485704; c=relaxed/simple;
	bh=dQta1BOK2fjAACl4oOECLi2AhgZkVpOsBPeiES22CHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=na1a2FtDr4qBeKiRXcFZtyUvU12f4qgbWJh51xLQqH5v+qmm2hFGFuEi07uT3w+mnYWxDU0CUTdDYLcVVFh3vMTUeIMCZd37SHopQoo5QI8GXCBO/X1hzaPcE/6YNvL/oUtRsgdxfFurwFfbNaei4dHt2qkKqFBMEyAnoLD/LXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS1AN+Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11F8C4CEEF;
	Mon,  5 May 2025 22:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485703;
	bh=dQta1BOK2fjAACl4oOECLi2AhgZkVpOsBPeiES22CHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TS1AN+BmbJs68lpvjPKU7i4KI13qwZS6fiKk4Q0d3dkR4iGj6N3k54BxgrxbZ5DAR
	 mSZ6gB7IbJmT4NVqZt2FGJdPk3lO/hjMJnoG3O2g3XLqiCKglf+A/7VsExgm4rnYk2
	 2ZvE7UH2TbIRHzPs6hl7DJvY9JRsdok0RhxfilH+qXO3EDtmN4B/Y6Ib4OFbbJXK82
	 H2mXFlGCdNoh4jv6g07oJhg809SjjcSgjUqyaMb4D4TIgboKsqYz9WlvwSAv4LcZbt
	 MeZVE+O1ub29tG/7ohWWwozIpZ6OfSTrV9ydr3fzSipwNGq1OuA5+X1y8PpvEZ+XyY
	 cq4WoJzW752gA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 433/486] ice: treat dyn_allowed only as suggestion
Date: Mon,  5 May 2025 18:38:29 -0400
Message-Id: <20250505223922.2682012-433-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[ Upstream commit a8c2d3932c1106af2764cc6869b29bcf3cb5bc47 ]

It can be needed to have some MSI-X allocated as static and rest as
dynamic. For example on PF VSI. We want to always have minimum one MSI-X
on it, because of that it is allocated as a static one, rest can be
dynamic if it is supported.

Change the ice_get_irq_res() to allow using static entries if they are
free even if caller wants dynamic one.

Adjust limit values to the new approach. Min and max in limit means the
values that are valid, so decrease max and num_static by one.

Set vsi::irq_dyn_alloc if dynamic allocation is supported.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_irq.c | 25 ++++++++++++------------
 drivers/net/ethernet/intel/ice/ice_lib.c |  2 ++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index ad82ff7d19957..09f9c7ba52795 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -45,7 +45,7 @@ static void ice_free_irq_res(struct ice_pf *pf, u16 index)
 /**
  * ice_get_irq_res - get an interrupt resource
  * @pf: board private structure
- * @dyn_only: force entry to be dynamically allocated
+ * @dyn_allowed: allow entry to be dynamically allocated
  *
  * Allocate new irq entry in the free slot of the tracker. Since xarray
  * is used, always allocate new entry at the lowest possible index. Set
@@ -53,11 +53,12 @@ static void ice_free_irq_res(struct ice_pf *pf, u16 index)
  *
  * Returns allocated irq entry or NULL on failure.
  */
-static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf, bool dyn_only)
+static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
+					     bool dyn_allowed)
 {
-	struct xa_limit limit = { .max = pf->irq_tracker.num_entries,
+	struct xa_limit limit = { .max = pf->irq_tracker.num_entries - 1,
 				  .min = 0 };
-	unsigned int num_static = pf->irq_tracker.num_static;
+	unsigned int num_static = pf->irq_tracker.num_static - 1;
 	struct ice_irq_entry *entry;
 	unsigned int index;
 	int ret;
@@ -66,9 +67,9 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf, bool dyn_only)
 	if (!entry)
 		return NULL;
 
-	/* skip preallocated entries if the caller says so */
-	if (dyn_only)
-		limit.min = num_static;
+	/* only already allocated if the caller says so */
+	if (!dyn_allowed)
+		limit.max = num_static;
 
 	ret = xa_alloc(&pf->irq_tracker.entries, &index, entry, limit,
 		       GFP_KERNEL);
@@ -78,7 +79,7 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf, bool dyn_only)
 		entry = NULL;
 	} else {
 		entry->index = index;
-		entry->dynamic = index >= num_static;
+		entry->dynamic = index > num_static;
 	}
 
 	return entry;
@@ -272,7 +273,7 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 /**
  * ice_alloc_irq - Allocate new interrupt vector
  * @pf: board private structure
- * @dyn_only: force dynamic allocation of the interrupt
+ * @dyn_allowed: allow dynamic allocation of the interrupt
  *
  * Allocate new interrupt vector for a given owner id.
  * return struct msi_map with interrupt details and track
@@ -285,20 +286,20 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
  * interrupt will be allocated with pci_msix_alloc_irq_at.
  *
  * Some callers may only support dynamically allocated interrupts.
- * This is indicated with dyn_only flag.
+ * This is indicated with dyn_allowed flag.
  *
  * On failure, return map with negative .index. The caller
  * is expected to check returned map index.
  *
  */
-struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_only)
+struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_allowed)
 {
 	int sriov_base_vector = pf->sriov_base_vector;
 	struct msi_map map = { .index = -ENOENT };
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_irq_entry *entry;
 
-	entry = ice_get_irq_res(pf, dyn_only);
+	entry = ice_get_irq_res(pf, dyn_allowed);
 	if (!entry)
 		return map;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 121a5ad5c8e10..8961eebe67aa2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -567,6 +567,8 @@ ice_vsi_alloc_def(struct ice_vsi *vsi, struct ice_channel *ch)
 			return -ENOMEM;
 	}
 
+	vsi->irq_dyn_alloc = pci_msix_can_alloc_dyn(vsi->back->pdev);
+
 	switch (vsi->type) {
 	case ICE_VSI_PF:
 	case ICE_VSI_SF:
-- 
2.39.5


