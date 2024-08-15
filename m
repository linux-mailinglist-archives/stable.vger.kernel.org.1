Return-Path: <stable+bounces-68042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28895305A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7CE1F22155
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3125318D630;
	Thu, 15 Aug 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yOm1ZIsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2818D627;
	Thu, 15 Aug 2024 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729317; cv=none; b=b9ATXnI5ehRxrXYP0J53xNAyy3SnDV7uMMa6wzx/WHZBqjxzqdPoLmBsDh+vDiBZJwyh4D59dabn83G7HypW/zyggwonmcHsH0iH9a6H5I0/bYSF1jtNDxXYIg//hYWHFk9YGHDm0cRTxSYwdU2Uw6LwGewwDeoTWTyIXh6OStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729317; c=relaxed/simple;
	bh=ZgYK4b45bTMsxEsKb6tg+r2BVG4NuWeTpDp/EjqZH74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+eOL5HSl5AsbZS6LVEu/siNQrBTMXL2Kycxwrj9wCrJRjsAOlUNHaKQMvLlt7pBJcbRqSX5nG6flQtTpkoOsFNHTKvn8jEzv8Ezv3ePrEXhv7nRiWzySnpUtYHVH7PePBMESHGxKxhm54J36zcPeixSf/kM6TUUQjUx7nfFE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yOm1ZIsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67563C32786;
	Thu, 15 Aug 2024 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729316;
	bh=ZgYK4b45bTMsxEsKb6tg+r2BVG4NuWeTpDp/EjqZH74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yOm1ZIsKd1KX5O2CyGUq92NamekpFzT7s3plbvYOZO4OJKfmWWhFHP+0EEufPWVlO
	 WP51lGY/8+xx3Rxf/j/2XMuKYNzhTyw980lTSX0fAr/6oExAWoqu3thrgsKUzyFzeg
	 O1fBwi2hSbvxOQnXDGNXGMpymkdEWYwvLXKYkA9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Zubkov <green@qrator.net>,
	Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 058/484] mlxsw: spectrum_acl: Fix ACL scale regression and firmware errors
Date: Thu, 15 Aug 2024 15:18:36 +0200
Message-ID: <20240815131943.524383363@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 75d8d7a63065b18df9555dbaab0b42d4c6f20943 ]

ACLs that reside in the algorithmic TCAM (A-TCAM) in Spectrum-2 and
newer ASICs can share the same mask if their masks only differ in up to
8 consecutive bits. For example, consider the following filters:

 # tc filter add dev swp1 ingress pref 1 proto ip flower dst_ip 192.0.2.0/24 action drop
 # tc filter add dev swp1 ingress pref 1 proto ip flower dst_ip 198.51.100.128/25 action drop

The second filter can use the same mask as the first (dst_ip/24) with a
delta of 1 bit.

However, the above only works because the two filters have different
values in the common unmasked part (dst_ip/24). When entries have the
same value in the common unmasked part they create undesired collisions
in the device since many entries now have the same key. This leads to
firmware errors such as [1] and to a reduced scale.

Fix by adjusting the hash table key to only include the value in the
common unmasked part. That is, without including the delta bits. That
way the driver will detect the collision during filter insertion and
spill the filter into the circuit TCAM (C-TCAM).

Add a test case that fails without the fix and adjust existing cases
that check C-TCAM spillage according to the above limitation.

[1]
mlxsw_spectrum2 0000:06:00.0: EMAD reg access failed (tid=3379b18a00003394,reg_id=3027(ptce3),type=write,status=8(resource not available))

Fixes: c22291f7cf45 ("mlxsw: spectrum: acl: Implement delta for ERP")
Reported-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlxsw/spectrum_acl_atcam.c       | 18 +++---
 .../mlxsw/spectrum_acl_bloom_filter.c         |  2 +-
 .../mellanox/mlxsw/spectrum_acl_tcam.h        |  9 +--
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh | 55 +++++++++++++++++--
 4 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
index 4b713832fdd55..f5c0a4214c4e5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
@@ -391,7 +391,8 @@ mlxsw_sp_acl_atcam_region_entry_insert(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		return err;
 
-	lkey_id = aregion->ops->lkey_id_get(aregion, aentry->enc_key, erp_id);
+	lkey_id = aregion->ops->lkey_id_get(aregion, aentry->ht_key.enc_key,
+					    erp_id);
 	if (IS_ERR(lkey_id))
 		return PTR_ERR(lkey_id);
 	aentry->lkey_id = lkey_id;
@@ -399,7 +400,7 @@ mlxsw_sp_acl_atcam_region_entry_insert(struct mlxsw_sp *mlxsw_sp,
 	kvdl_index = mlxsw_afa_block_first_kvdl_index(rulei->act_block);
 	mlxsw_reg_ptce3_pack(ptce3_pl, true, MLXSW_REG_PTCE3_OP_WRITE_WRITE,
 			     priority, region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -428,7 +429,7 @@ mlxsw_sp_acl_atcam_region_entry_remove(struct mlxsw_sp *mlxsw_sp,
 
 	mlxsw_reg_ptce3_pack(ptce3_pl, false, MLXSW_REG_PTCE3_OP_WRITE_WRITE, 0,
 			     region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -457,7 +458,7 @@ mlxsw_sp_acl_atcam_region_entry_action_replace(struct mlxsw_sp *mlxsw_sp,
 	kvdl_index = mlxsw_afa_block_first_kvdl_index(rulei->act_block);
 	mlxsw_reg_ptce3_pack(ptce3_pl, true, MLXSW_REG_PTCE3_OP_WRITE_UPDATE,
 			     priority, region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -480,15 +481,13 @@ __mlxsw_sp_acl_atcam_entry_add(struct mlxsw_sp *mlxsw_sp,
 	int err;
 
 	mlxsw_afk_encode(afk, region->key_info, &rulei->values,
-			 aentry->ht_key.full_enc_key, mask);
+			 aentry->ht_key.enc_key, mask);
 
 	erp_mask = mlxsw_sp_acl_erp_mask_get(aregion, mask, false);
 	if (IS_ERR(erp_mask))
 		return PTR_ERR(erp_mask);
 	aentry->erp_mask = erp_mask;
 	aentry->ht_key.erp_id = mlxsw_sp_acl_erp_mask_erp_id(erp_mask);
-	memcpy(aentry->enc_key, aentry->ht_key.full_enc_key,
-	       sizeof(aentry->enc_key));
 
 	/* Compute all needed delta information and clear the delta bits
 	 * from the encrypted key.
@@ -497,9 +496,8 @@ __mlxsw_sp_acl_atcam_entry_add(struct mlxsw_sp *mlxsw_sp,
 	aentry->delta_info.start = mlxsw_sp_acl_erp_delta_start(delta);
 	aentry->delta_info.mask = mlxsw_sp_acl_erp_delta_mask(delta);
 	aentry->delta_info.value =
-		mlxsw_sp_acl_erp_delta_value(delta,
-					     aentry->ht_key.full_enc_key);
-	mlxsw_sp_acl_erp_delta_clear(delta, aentry->enc_key);
+		mlxsw_sp_acl_erp_delta_value(delta, aentry->ht_key.enc_key);
+	mlxsw_sp_acl_erp_delta_clear(delta, aentry->ht_key.enc_key);
 
 	/* Add rule to the list of A-TCAM rules, assuming this
 	 * rule is intended to A-TCAM. In case this rule does
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index 2d2e29c202770..3ab87db83b7fc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -136,7 +136,7 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 		memcpy(chunk + pad_bytes, &erp_region_id,
 		       sizeof(erp_region_id));
 		memcpy(chunk + key_offset,
-		       &aentry->enc_key[chunk_key_offsets[chunk_index]],
+		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
 		       chunk_key_len);
 		chunk += chunk_len;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
index a41df10ade9bf..f28c47ae54880 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
@@ -171,9 +171,9 @@ struct mlxsw_sp_acl_atcam_region {
 };
 
 struct mlxsw_sp_acl_atcam_entry_ht_key {
-	char full_enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded
-								 * key.
-								 */
+	char enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded key, minus
+							    * delta bits.
+							    */
 	u8 erp_id;
 };
 
@@ -185,9 +185,6 @@ struct mlxsw_sp_acl_atcam_entry {
 	struct rhash_head ht_node;
 	struct list_head list; /* Member in entries_list */
 	struct mlxsw_sp_acl_atcam_entry_ht_key ht_key;
-	char enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded key,
-							    * minus delta bits.
-							    */
 	struct {
 		u16 start;
 		u8 mask;
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index 616d3581419ca..21d0f419cc6d7 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -11,7 +11,7 @@ ALL_TESTS="single_mask_test identical_filters_test two_masks_test \
 	multiple_masks_test ctcam_edge_cases_test delta_simple_test \
 	delta_two_masks_one_key_test delta_simple_rehash_test \
 	bloom_simple_test bloom_complex_test bloom_delta_test \
-	max_erp_entries_test max_group_size_test"
+	max_erp_entries_test max_group_size_test collision_test"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/tc_common.sh
@@ -457,7 +457,7 @@ delta_two_masks_one_key_test()
 {
 	# If 2 keys are the same and only differ in mask in a way that
 	# they belong under the same ERP (second is delta of the first),
-	# there should be no C-TCAM spill.
+	# there should be C-TCAM spill.
 
 	RET=0
 
@@ -474,8 +474,8 @@ delta_two_masks_one_key_test()
 	tp_record "mlxsw:*" "tc filter add dev $h2 ingress protocol ip \
 		   pref 2 handle 102 flower $tcflags dst_ip 192.0.2.2 \
 		   action drop"
-	tp_check_hits "mlxsw:mlxsw_sp_acl_atcam_entry_add_ctcam_spill" 0
-	check_err $? "incorrect C-TCAM spill while inserting the second rule"
+	tp_check_hits "mlxsw:mlxsw_sp_acl_atcam_entry_add_ctcam_spill" 1
+	check_err $? "C-TCAM spill did not happen while inserting the second rule"
 
 	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
 		-t ip -q
@@ -1087,6 +1087,53 @@ max_group_size_test()
 	log_test "max ACL group size test ($tcflags). max size $max_size"
 }
 
+collision_test()
+{
+	# Filters cannot share an eRP if in the common unmasked part (i.e.,
+	# without the delta bits) they have the same values. If the driver does
+	# not prevent such configuration (by spilling into the C-TCAM), then
+	# multiple entries will be present in the device with the same key,
+	# leading to collisions and a reduced scale.
+	#
+	# Create such a scenario and make sure all the filters are successfully
+	# added.
+
+	RET=0
+
+	local ret
+
+	if [[ "$tcflags" != "skip_sw" ]]; then
+		return 0;
+	fi
+
+	# Add a single dst_ip/24 filter and multiple dst_ip/32 filters that all
+	# have the same values in the common unmasked part (dst_ip/24).
+
+	tc filter add dev $h2 ingress pref 1 proto ipv4 handle 101 \
+		flower $tcflags dst_ip 198.51.100.0/24 \
+		action drop
+
+	for i in {0..255}; do
+		tc filter add dev $h2 ingress pref 2 proto ipv4 \
+			handle $((102 + i)) \
+			flower $tcflags dst_ip 198.51.100.${i}/32 \
+			action drop
+		ret=$?
+		[[ $ret -ne 0 ]] && break
+	done
+
+	check_err $ret "failed to add all the filters"
+
+	for i in {255..0}; do
+		tc filter del dev $h2 ingress pref 2 proto ipv4 \
+			handle $((102 + i)) flower
+	done
+
+	tc filter del dev $h2 ingress pref 1 proto ipv4 handle 101 flower
+
+	log_test "collision test ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.43.0




