Return-Path: <stable+bounces-143507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEEBAB401C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EB93BA769
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962F2550C4;
	Mon, 12 May 2025 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yaMBHyZh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8625251782;
	Mon, 12 May 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072163; cv=none; b=r+sFeox0w/E13+RFvddvWRVDISZM2HbqK4dHCKzU71avqEUd076FM4zSp9ROR6uTbnikNnHolYpmHUs3Ne3vmlpkAvLLrslPBQMiLiaY+OCUPzx0/XS5wQ4xZlOuoBiHMBkrGO/ugLwPIiaPt9mltPswuhZlhFYpGQKYjv4DIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072163; c=relaxed/simple;
	bh=zqm5Pet0x07m+B/rmQPSwfCWTfaAxJ5TNADsJPb7zKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyikbmiO+xGpD3geKieJAAinU+0pysbFYecFiSs5GCQp0qxBCtAqDY0gTWkekUqq67f6Rfc66usm84zRVDXx+clBx+OzgdVt5F90lAACCtJ0q+22K6RdvkoZt1s4SYCW0IObtORY2ZSUf1IhUJKGmo46fMBIP/4eYPfgKYPOk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yaMBHyZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6746EC4CEF1;
	Mon, 12 May 2025 17:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072163;
	bh=zqm5Pet0x07m+B/rmQPSwfCWTfaAxJ5TNADsJPb7zKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yaMBHyZhezT8bt0nF0XXG2kvcOO0V99mWKPoYAYI+3ptiSeaVIvrkV2SwxDSpXgGU
	 QmEZgUx0BPUAvi74UGkF1waEWcHon8PP+EGwTMgzgaE13wTO4yGW0aK2ZlMrfGaqMA
	 7w1f3f3i64IaBl1GqeRXrTHBQ+6m1SNWqr75+giQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heming Zhao <heming.zhao@suse.com>,
	Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.14 130/197] ocfs2: fix the issue with discontiguous allocation in the global_bitmap
Date: Mon, 12 May 2025 19:39:40 +0200
Message-ID: <20250512172049.688054581@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heming Zhao <heming.zhao@suse.com>

commit bd1261b16d9131d79723d982d54295e7f309797a upstream.

commit 4eb7b93e0310 ("ocfs2: improve write IO performance when
fragmentation is high") introduced another regression.

The following ocfs2-test case can trigger this issue:
> discontig_runner.sh => activate_discontig_bg.sh => resv_unwritten:
> ${RESV_UNWRITTEN_BIN} -f ${WORK_PLACE}/large_testfile -s 0 -l \
> $((${FILE_MAJOR_SIZE_M}*1024*1024))

In my env, test disk size (by "fdisk -l <dev>"):
> 53687091200 bytes, 104857600 sectors.

Above command is:
> /usr/local/ocfs2-test/bin/resv_unwritten -f \
> /mnt/ocfs2/ocfs2-activate-discontig-bg-dir/large_testfile -s 0 -l \
> 53187969024

Error log:
> [*] Reserve 50724M space for a LARGE file, reserve 200M space for future test.
> ioctl error 28: "No space left on device"
> resv allocation failed Unknown error -1
> reserve unwritten region from 0 to 53187969024.

Call flow:
__ocfs2_change_file_space //by ioctl OCFS2_IOC_RESVSP64
 ocfs2_allocate_unwritten_extents //start:0 len:53187969024
  while()
   + ocfs2_get_clusters //cpos:0, alloc_size:1623168 (cluster number)
   + ocfs2_extend_allocation
     + ocfs2_lock_allocators
     |  + choose OCFS2_AC_USE_MAIN & ocfs2_cluster_group_search
     |
     + ocfs2_add_inode_data
        ocfs2_add_clusters_in_btree
         __ocfs2_claim_clusters
          ocfs2_claim_suballoc_bits
          + During the allocation of the final part of the large file
	    (after ~47GB), no chain had the required contiguous
            bits_wanted. Consequently, the allocation failed.

How to fix:
When OCFS2 is encountering fragmented allocation, the file system should
stop attempting bits_wanted contiguous allocation and instead provide the
largest available contiguous free bits from the cluster groups.

Link: https://lkml.kernel.org/r/20250414060125.19938-2-heming.zhao@suse.com
Fixes: 4eb7b93e0310 ("ocfs2: improve write IO performance when fragmentation is high")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Reported-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/suballoc.c |   38 ++++++++++++++++++++++++++++++++------
 fs/ocfs2/suballoc.h |    1 +
 2 files changed, 33 insertions(+), 6 deletions(-)

--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -698,10 +698,12 @@ static int ocfs2_block_group_alloc(struc
 
 	bg_bh = ocfs2_block_group_alloc_contig(osb, handle, alloc_inode,
 					       ac, cl);
-	if (PTR_ERR(bg_bh) == -ENOSPC)
+	if (PTR_ERR(bg_bh) == -ENOSPC) {
+		ac->ac_which = OCFS2_AC_USE_MAIN_DISCONTIG;
 		bg_bh = ocfs2_block_group_alloc_discontig(handle,
 							  alloc_inode,
 							  ac, cl);
+	}
 	if (IS_ERR(bg_bh)) {
 		status = PTR_ERR(bg_bh);
 		bg_bh = NULL;
@@ -1794,6 +1796,7 @@ static int ocfs2_search_chain(struct ocf
 {
 	int status;
 	u16 chain;
+	u32 contig_bits;
 	u64 next_group;
 	struct inode *alloc_inode = ac->ac_inode;
 	struct buffer_head *group_bh = NULL;
@@ -1819,10 +1822,21 @@ static int ocfs2_search_chain(struct ocf
 	status = -ENOSPC;
 	/* for now, the chain search is a bit simplistic. We just use
 	 * the 1st group with any empty bits. */
-	while ((status = ac->ac_group_search(alloc_inode, group_bh,
-					     bits_wanted, min_bits,
-					     ac->ac_max_block,
-					     res)) == -ENOSPC) {
+	while (1) {
+		if (ac->ac_which == OCFS2_AC_USE_MAIN_DISCONTIG) {
+			contig_bits = le16_to_cpu(bg->bg_contig_free_bits);
+			if (!contig_bits)
+				contig_bits = ocfs2_find_max_contig_free_bits(bg->bg_bitmap,
+						le16_to_cpu(bg->bg_bits), 0);
+			if (bits_wanted > contig_bits && contig_bits >= min_bits)
+				bits_wanted = contig_bits;
+		}
+
+		status = ac->ac_group_search(alloc_inode, group_bh,
+				bits_wanted, min_bits,
+				ac->ac_max_block, res);
+		if (status != -ENOSPC)
+			break;
 		if (!bg->bg_next_group)
 			break;
 
@@ -1982,6 +1996,7 @@ static int ocfs2_claim_suballoc_bits(str
 	victim = ocfs2_find_victim_chain(cl);
 	ac->ac_chain = victim;
 
+search:
 	status = ocfs2_search_chain(ac, handle, bits_wanted, min_bits,
 				    res, &bits_left);
 	if (!status) {
@@ -2022,6 +2037,16 @@ static int ocfs2_claim_suballoc_bits(str
 		}
 	}
 
+	/* Chains can't supply the bits_wanted contiguous space.
+	 * We should switch to using every single bit when allocating
+	 * from the global bitmap. */
+	if (i == le16_to_cpu(cl->cl_next_free_rec) &&
+	    status == -ENOSPC && ac->ac_which == OCFS2_AC_USE_MAIN) {
+		ac->ac_which = OCFS2_AC_USE_MAIN_DISCONTIG;
+		ac->ac_chain = victim;
+		goto search;
+	}
+
 set_hint:
 	if (status != -ENOSPC) {
 		/* If the next search of this group is not likely to
@@ -2365,7 +2390,8 @@ int __ocfs2_claim_clusters(handle_t *han
 	BUG_ON(ac->ac_bits_given >= ac->ac_bits_wanted);
 
 	BUG_ON(ac->ac_which != OCFS2_AC_USE_LOCAL
-	       && ac->ac_which != OCFS2_AC_USE_MAIN);
+	       && ac->ac_which != OCFS2_AC_USE_MAIN
+	       && ac->ac_which != OCFS2_AC_USE_MAIN_DISCONTIG);
 
 	if (ac->ac_which == OCFS2_AC_USE_LOCAL) {
 		WARN_ON(min_clusters > 1);
--- a/fs/ocfs2/suballoc.h
+++ b/fs/ocfs2/suballoc.h
@@ -29,6 +29,7 @@ struct ocfs2_alloc_context {
 #define OCFS2_AC_USE_MAIN  2
 #define OCFS2_AC_USE_INODE 3
 #define OCFS2_AC_USE_META  4
+#define OCFS2_AC_USE_MAIN_DISCONTIG  5
 	u32    ac_which;
 
 	/* these are used by the chain search */



