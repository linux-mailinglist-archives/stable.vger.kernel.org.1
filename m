Return-Path: <stable+bounces-142169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0AAAAE959
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CBB1C27030
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541528DF45;
	Wed,  7 May 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NJgsAGFE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092814A4C7;
	Wed,  7 May 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643425; cv=none; b=M81dtd3G5ZHzH33PGm7eFr6z3rv7GdYAv7W0sNv5rFHiRz4KoFlBMCWY+JK2zJEutnWt+OBPI/e4VKZHc8/2aVIE+h3u5CViDIRfxVatHoGYdT+9WZaPHsFnVJ8rPWPvqqrELOUiaSDRMUJJ9MzZWX7jwlC5KLwyzj6pjXlJ7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643425; c=relaxed/simple;
	bh=sOzAC4MX8Isc1E91v/QUhzQQR9Hwxm4malLzCA9S818=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh+4UsEz56FGQCsP702BB45AYsJB6zmQVjZGHc3mU0gYE2I13g5m5DFF5yZ1+/iovCsPjam0cKirZ9s4+ru1cQtc7xdiihhrIYb93ZI8r0VabY+5KP3uLvo1hLLUJnGIkfy0At9Cw3au9EKxFpC4bm6s02bmzSVHPdfiybN9GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NJgsAGFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866A8C4CEE2;
	Wed,  7 May 2025 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643425;
	bh=sOzAC4MX8Isc1E91v/QUhzQQR9Hwxm4malLzCA9S818=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJgsAGFEsauDdSCWbESgg8yw4z+dNGBQnZ5vh81vaQfKeN/Gxwy3q2IevhO0U60rO
	 Qfh34czJIziVkLRIi87Ahb5hfe9B2Viaz+moZlLNogQNVO72cDCeJA930NjQjUI0Ik
	 MpB8qrrgGiyJpP4i/3wa29OdMsDdxmBD3PyTVFqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 54/55] iommu/arm-smmu-v3: Use the new rb tree helpers
Date: Wed,  7 May 2025 20:39:55 +0200
Message-ID: <20250507183801.214785393@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183759.048732653@linuxfoundation.org>
References: <20250507183759.048732653@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit a2bb820e862d61f9ca1499e500915f9f505a2655 ]

Since v5.12 the rbtree has gained some simplifying helpers aimed at making
rb tree users write less convoluted boiler plate code. Instead the caller
provides a single comparison function and the helpers generate the prior
open-coded stuff.

Update smmu->streams to use rb_find_add() and rb_find().

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/1-v3-9fef8cdc2ff6+150d1-smmuv3_tidy_jgg@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 68 ++++++++++-----------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ec4c87095c6cd..fc07ecce426ef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1430,26 +1430,37 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_streams_cmp_key(const void *lhs, const struct rb_node *rhs)
+{
+	struct arm_smmu_stream *stream_rhs =
+		rb_entry(rhs, struct arm_smmu_stream, node);
+	const u32 *sid_lhs = lhs;
+
+	if (*sid_lhs < stream_rhs->id)
+		return -1;
+	if (*sid_lhs > stream_rhs->id)
+		return 1;
+	return 0;
+}
+
+static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
+				     const struct rb_node *rhs)
+{
+	return arm_smmu_streams_cmp_key(
+		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
+}
+
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
-	struct arm_smmu_stream *stream;
 
 	lockdep_assert_held(&smmu->streams_mutex);
 
-	node = smmu->streams.rb_node;
-	while (node) {
-		stream = rb_entry(node, struct arm_smmu_stream, node);
-		if (stream->id < sid)
-			node = node->rb_right;
-		else if (stream->id > sid)
-			node = node->rb_left;
-		else
-			return stream->master;
-	}
-
-	return NULL;
+	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct arm_smmu_stream, node)->master;
 }
 
 /* IRQ and event handlers */
@@ -2560,8 +2571,6 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 {
 	int i;
 	int ret = 0;
-	struct arm_smmu_stream *new_stream, *cur_stream;
-	struct rb_node **new_node, *parent_node = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
@@ -2572,9 +2581,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *new_stream = &master->streams[i];
 		u32 sid = fwspec->ids[i];
 
-		new_stream = &master->streams[i];
 		new_stream->id = sid;
 		new_stream->master = master;
 
@@ -2594,28 +2603,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		}
 
 		/* Insert into SID tree */
-		new_node = &(smmu->streams.rb_node);
-		while (*new_node) {
-			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
-					      node);
-			parent_node = *new_node;
-			if (cur_stream->id > new_stream->id) {
-				new_node = &((*new_node)->rb_left);
-			} else if (cur_stream->id < new_stream->id) {
-				new_node = &((*new_node)->rb_right);
-			} else {
-				dev_warn(master->dev,
-					 "stream %u already in tree\n",
-					 cur_stream->id);
-				ret = -EINVAL;
-				break;
-			}
-		}
-		if (ret)
+		if (rb_find_add(&new_stream->node, &smmu->streams,
+				arm_smmu_streams_cmp_node)) {
+			dev_warn(master->dev, "stream %u already in tree\n",
+				 sid);
+			ret = -EINVAL;
 			break;
-
-		rb_link_node(&new_stream->node, parent_node, new_node);
-		rb_insert_color(&new_stream->node, &smmu->streams);
+		}
 	}
 
 	if (ret) {
-- 
2.39.5




