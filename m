Return-Path: <stable+bounces-15468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436CD838559
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E101C29DC6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2F2114;
	Tue, 23 Jan 2024 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LMplLSbq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB41852;
	Tue, 23 Jan 2024 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975806; cv=none; b=XpQNVOTQxYN+gJ49izWDnrURoKHtnUyw2g0nmkphg9YTQVL74xASrmHj3lQR+0mo6EF9KTeFzHOCmxb0jbJGfxLk5YyJwsWtPFgnuOW6lX9Cat5gslv+0h7Lzqz6hDcOcwjS577JlSffRWtrglh1IA9xcSJ/dPbfqjJdf8MqgCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975806; c=relaxed/simple;
	bh=NngoCOsTAV+eWa/yHoATpxViijO+7I7o5BnfdFwdHAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLQVfPtDmOPbce1aLRXX6dt+H76BC7v7MFvPU/+KsD7SgVVfNFgTBQZ1r5tSvwDE9Q/6mE3il8qAJH1grE+hMeSnfwsp5+865osdTZ+ruH9FbQWzWzG2g2l73qk64ikrHbiHCqWBxrltaggVFwJYrr0hne4Qx5l7uriHgosimGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LMplLSbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC9C433B1;
	Tue, 23 Jan 2024 02:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975806;
	bh=NngoCOsTAV+eWa/yHoATpxViijO+7I7o5BnfdFwdHAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMplLSbqH3WZ9obRP+R4lpsK655Dfayyn2Cd+lJfhbQvSymIyodscTiFdyT30GK91
	 8SlK7HCCTBt/tNwl4C5IX0APmdfOtwo+LQKyiEq4aGij9ozWE8kaihMPhiqxSEwUu+
	 XT9IsZguPKacg1CGkvEmRMPAVRjmJ/+cxsbLH/j4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 575/583] mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure
Date: Mon, 22 Jan 2024 16:00:26 -0800
Message-ID: <20240122235829.795678378@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Cohen <amcohen@nvidia.com>

[ Upstream commit 6d6eeabcfaba2fcadf5443b575789ea606f9de83 ]

Lately, a bug was found when many TC filters are added - at some point,
several bugs are printed to dmesg [1] and the switch is crashed with
segmentation fault.

The issue starts when gen_pool_free() fails because of unexpected
behavior - a try to free memory which is already freed, this leads to BUG()
call which crashes the switch and makes many other bugs.

Trying to track down the unexpected behavior led to a bug in eRP code. The
function mlxsw_sp_acl_erp_table_alloc() gets a pointer to the allocated
index, sets the value and returns an error code. When gen_pool_alloc()
fails it returns address 0, we track it and return -ENOBUFS outside, BUT
the call for gen_pool_alloc() already override the index in erp_table
structure. This is a problem when such allocation is done as part of
table expansion. This is not a new table, which will not be used in case
of allocation failure. We try to expand eRP table and override the
current index (non-zero) with zero. Then, it leads to an unexpected
behavior when address 0 is freed twice. Note that address 0 is valid in
erp_table->base_index and indeed other tables use it.

gen_pool_alloc() fails in case that there is no space left in the
pre-allocated pool, in our case, the pool is limited to
ACL_MAX_ERPT_BANK_SIZE, which is read from hardware. When more than max
erp entries are required, we exceed the limit and return an error, this
error leads to "Failed to migrate vregion" print.

Fix this by changing erp_table->base_index only in case of a successful
allocation.

Add a test case for such a scenario. Without this fix it causes
segmentation fault:

$ TESTS="max_erp_entries_test" ./tc_flower.sh
./tc_flower.sh: line 988:  1560 Segmentation fault      tc filter del dev $h2 ingress chain $i protocol ip pref $i handle $j flower &>/dev/null

[1]:
kernel BUG at lib/genalloc.c:508!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 6 PID: 3531 Comm: tc Not tainted 6.7.0-rc5-custom-ga6893f479f5e #1
Hardware name: Mellanox Technologies Ltd. MSN4700/VMOD0010, BIOS 5.11 07/12/2021
RIP: 0010:gen_pool_free_owner+0xc9/0xe0
...
Call Trace:
 <TASK>
 __mlxsw_sp_acl_erp_table_other_dec+0x70/0xa0 [mlxsw_spectrum]
 mlxsw_sp_acl_erp_mask_destroy+0xf5/0x110 [mlxsw_spectrum]
 objagg_obj_root_destroy+0x18/0x80 [objagg]
 objagg_obj_destroy+0x12c/0x130 [objagg]
 mlxsw_sp_acl_erp_mask_put+0x37/0x50 [mlxsw_spectrum]
 mlxsw_sp_acl_ctcam_region_entry_remove+0x74/0xa0 [mlxsw_spectrum]
 mlxsw_sp_acl_ctcam_entry_del+0x1e/0x40 [mlxsw_spectrum]
 mlxsw_sp_acl_tcam_ventry_del+0x78/0xd0 [mlxsw_spectrum]
 mlxsw_sp_flower_destroy+0x4d/0x70 [mlxsw_spectrum]
 mlxsw_sp_flow_block_cb+0x73/0xb0 [mlxsw_spectrum]
 tc_setup_cb_destroy+0xc1/0x180
 fl_hw_destroy_filter+0x94/0xc0 [cls_flower]
 __fl_delete+0x1ac/0x1c0 [cls_flower]
 fl_destroy+0xc2/0x150 [cls_flower]
 tcf_proto_destroy+0x1a/0xa0
...
mlxsw_spectrum3 0000:07:00.0: Failed to migrate vregion
mlxsw_spectrum3 0000:07:00.0: Failed to migrate vregion

Fixes: f465261aa105 ("mlxsw: spectrum_acl: Implement common eRP core")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/4cfca254dfc0e5d283974801a24371c7b6db5989.1705502064.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlxsw/spectrum_acl_erp.c         |  8 +--
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh | 52 ++++++++++++++++++-
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
index 4c98950380d5..d231f4d2888b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
@@ -301,6 +301,7 @@ mlxsw_sp_acl_erp_table_alloc(struct mlxsw_sp_acl_erp_core *erp_core,
 			     unsigned long *p_index)
 {
 	unsigned int num_rows, entry_size;
+	unsigned long index;
 
 	/* We only allow allocations of entire rows */
 	if (num_erps % erp_core->num_erp_banks != 0)
@@ -309,10 +310,11 @@ mlxsw_sp_acl_erp_table_alloc(struct mlxsw_sp_acl_erp_core *erp_core,
 	entry_size = erp_core->erpt_entries_size[region_type];
 	num_rows = num_erps / erp_core->num_erp_banks;
 
-	*p_index = gen_pool_alloc(erp_core->erp_tables, num_rows * entry_size);
-	if (*p_index == 0)
+	index = gen_pool_alloc(erp_core->erp_tables, num_rows * entry_size);
+	if (!index)
 		return -ENOBUFS;
-	*p_index -= MLXSW_SP_ACL_ERP_GENALLOC_OFFSET;
+
+	*p_index = index - MLXSW_SP_ACL_ERP_GENALLOC_OFFSET;
 
 	return 0;
 }
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index fb850e0ec837..7bf56ea161e3 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -10,7 +10,8 @@ lib_dir=$(dirname $0)/../../../../net/forwarding
 ALL_TESTS="single_mask_test identical_filters_test two_masks_test \
 	multiple_masks_test ctcam_edge_cases_test delta_simple_test \
 	delta_two_masks_one_key_test delta_simple_rehash_test \
-	bloom_simple_test bloom_complex_test bloom_delta_test"
+	bloom_simple_test bloom_complex_test bloom_delta_test \
+	max_erp_entries_test"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/tc_common.sh
@@ -983,6 +984,55 @@ bloom_delta_test()
 	log_test "bloom delta test ($tcflags)"
 }
 
+max_erp_entries_test()
+{
+	# The number of eRP entries is limited. Once the maximum number of eRPs
+	# has been reached, filters cannot be added. This test verifies that
+	# when this limit is reached, inserstion fails without crashing.
+
+	RET=0
+
+	local num_masks=32
+	local num_regions=15
+	local chain_failed
+	local mask_failed
+	local ret
+
+	if [[ "$tcflags" != "skip_sw" ]]; then
+		return 0;
+	fi
+
+	for ((i=1; i < $num_regions; i++)); do
+		for ((j=$num_masks; j >= 0; j--)); do
+			tc filter add dev $h2 ingress chain $i protocol ip \
+				pref $i	handle $j flower $tcflags \
+				dst_ip 192.1.0.0/$j &> /dev/null
+			ret=$?
+
+			if [ $ret -ne 0 ]; then
+				chain_failed=$i
+				mask_failed=$j
+				break 2
+			fi
+		done
+	done
+
+	# We expect to exceed the maximum number of eRP entries, so that
+	# insertion eventually fails. Otherwise, the test should be adjusted to
+	# add more filters.
+	check_fail $ret "expected to exceed number of eRP entries"
+
+	for ((; i >= 1; i--)); do
+		for ((j=0; j <= $num_masks; j++)); do
+			tc filter del dev $h2 ingress chain $i protocol ip \
+				pref $i handle $j flower &> /dev/null
+		done
+	done
+
+	log_test "max eRP entries test ($tcflags). " \
+		"max chain $chain_failed, mask $mask_failed"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.43.0




