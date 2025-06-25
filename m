Return-Path: <stable+bounces-158607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6BAE888C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 17:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9EA17B5857
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D5286894;
	Wed, 25 Jun 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B0CXa47x"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D441C5489
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866390; cv=none; b=WH3QE1c0KQwW9G9ymuICApTRH+0r+Ls/hEeAHZ5ngYuHNhI0cMD4PO5sfkc7/q8/hbPlSh+RAu8nr72vhjF8E3RK0BGhmHFya1RO791j2QHTsfod9AHIGAJioVLu5t8DKtRPvuIs29hz5m0tQR49CUqRE/CqLANlLIrrpKnaJdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866390; c=relaxed/simple;
	bh=DeI0Z4NDcBiv9X3rDy0BWac60fwD5tek91/6//4Bqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZdE6GVSZ6AR5X7hAJmXNaY7FfEstlOfXfVsSxYrgEZCpYOm6UPAnVfzNdKhegGclqdUlvmKnuEF3KV46hYWeSd3BKpkvLkE7XM77Cw8waDiK6Lw+rl+z81lU0HovxIFqaneZ21TbohYv1xatFKUKZSxG/pUIx1qR4pG5pcRruUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B0CXa47x; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PFC3Mf022933;
	Wed, 25 Jun 2025 15:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=i4AemWVGcsb1UvqRiVoWpcPw/XRg+
	54buC6QcfdAols=; b=B0CXa47xuzFm7ZOTekU3OIYals95VW/591K/KaPixfiic
	9tT3SplRZ8BqjeqojDiKl0hAjm9G+G8Z/tFH0fn6lumB0aPuxwOalSZ9ZIyJE59g
	8fFrkOetol0s6ZrJLy1lf/KnrzAnE6SuiOJtym31FYNW4KeoFzeiah9KMuKaV3By
	SlQhdwGCWek4O4wiNzpL2eLKDsPbZU5FIoLm0r+8atOTTaoO7r27mtiZWXaMa9dh
	1SnR/SPCoLMGzb26f+sm+S95NL0bEk7BUzVPY3grNPrMmNCdZxi58G7wHFHC2TbC
	k/tcX870X8UqnNML3rWo4WNrUMn1miJI6B0GJUzIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8mys87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 15:46:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEbQoV037917;
	Wed, 25 Jun 2025 15:46:25 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehperftg-1;
	Wed, 25 Jun 2025 15:46:25 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: fdmanana@suse.com, josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH 5.15.y] btrfs: don't drop extent_map for free space inode on write error
Date: Wed, 25 Jun 2025 08:45:57 -0700
Message-ID: <20250625154557.215947-1-larry.bassel@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506250116
X-Authority-Analysis: v=2.4 cv=IcWHWXqa c=1 sm=1 tr=0 ts=685c19d1 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=S4XxLCKVyjPM-O_9kP0A:9
 a=qR24C9TJY6iBuJVj_x8Y:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: x5Fo7jQw6DNWSEoRhanR3K_0P5XLtqS4
X-Proofpoint-GUID: x5Fo7jQw6DNWSEoRhanR3K_0P5XLtqS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDExNiBTYWx0ZWRfX/TjuE3Rw8ijK yWSV9S7OWedZ/oxPnK0l+/TBitfHfFcz0k18PcBIoXu96+dz4aT8S93o4yL71oFKYdaUsq42z2x iyOhkTeThHS9jsV7L4WdwoNphDk3kxmKljTSCV4nSbXfOqPoOIZgcGRg+vg/5mlW70KKYR4ICEV
 d1Pt9EZAzoKe22O4EPZkvRgx7Wt+aKWJOsDqu0+MCFe3ttplLhd+cGFzyvUQWNtBKqwJUnij0wx m6dVQxSGZu8vvxTkqFtSnhDCQVBbFp3uJf+ajj8ZzgXo9PSJJ5803BL804G4agY4FgtMDSmaelQ 2BWjbEvS4jKuiZEaHMZ6QdRZ1yZA/b1zqOOaoLbsHMB7sR1fcLIHeV9Db6pdAAjzTGniNFxruA5
 MOlMrVcE9vTchXbymd7ewu4uke3I+PCXYcZSEdrgLeH3rDmBy+LkNF2bruUWzNpx7nTSfAby

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 5571e41ec6e56e35f34ae9f5b3a335ef510e0ade ]

While running the CI for an unrelated change I hit the following panic
with generic/648 on btrfs_holes_spacecache.

assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1385
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:1385!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 2695096 Comm: fsstress Kdump: loaded Tainted: G        W          6.8.0-rc2+ #1
RIP: 0010:__extent_writepage_io.constprop.0+0x4c1/0x5c0
Call Trace:
 <TASK>
 extent_write_cache_pages+0x2ac/0x8f0
 extent_writepages+0x87/0x110
 do_writepages+0xd5/0x1f0
 filemap_fdatawrite_wbc+0x63/0x90
 __filemap_fdatawrite_range+0x5c/0x80
 btrfs_fdatawrite_range+0x1f/0x50
 btrfs_write_out_cache+0x507/0x560
 btrfs_write_dirty_block_groups+0x32a/0x420
 commit_cowonly_roots+0x21b/0x290
 btrfs_commit_transaction+0x813/0x1360
 btrfs_sync_file+0x51a/0x640
 __x64_sys_fdatasync+0x52/0x90
 do_syscall_64+0x9c/0x190
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

This happens because we fail to write out the free space cache in one
instance, come back around and attempt to write it again.  However on
the second pass through we go to call btrfs_get_extent() on the inode to
get the extent mapping.  Because this is a new block group, and with the
free space inode we always search the commit root to avoid deadlocking
with the tree, we find nothing and return a EXTENT_MAP_HOLE for the
requested range.

This happens because the first time we try to write the space cache out
we hit an error, and on an error we drop the extent mapping.  This is
normal for normal files, but the free space cache inode is special.  We
always expect the extent map to be correct.  Thus the second time
through we end up with a bogus extent map.

Since we're deprecating this feature, the most straightforward way to
fix this is to simply skip dropping the extent map range for this failed
range.

I shortened the test by using error injection to stress the area to make
it easier to reproduce.  With this patch in place we no longer panic
with my error injection test.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
(cherry picked from commit 5571e41ec6e56e35f34ae9f5b3a335ef510e0ade)
[Larry: backport to 5.15.y. Minor conflict resolved due to missing commit 4c0c8cfc8433
btrfs: move btrfs_drop_extent_cache() to extent_map.c]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 fs/btrfs/inode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d6e43c94436d..e3e5bd4fb477 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3197,8 +3197,23 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			unwritten_start += logical_len;
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
 
-		/* Drop the cache for the part of the extent we didn't write. */
-		btrfs_drop_extent_cache(inode, unwritten_start, end, 0);
+		/*
+		 * Drop extent maps for the part of the extent we didn't write.
+		 *
+		 * We have an exception here for the free_space_inode, this is
+		 * because when we do btrfs_get_extent() on the free space inode
+		 * we will search the commit root.  If this is a new block group
+		 * we won't find anything, and we will trip over the assert in
+		 * writepage where we do ASSERT(em->block_start !=
+		 * EXTENT_MAP_HOLE).
+		 *
+		 * Theoretically we could also skip this for any NOCOW extent as
+		 * we don't mess with the extent map tree in the NOCOW case, but
+		 * for now simply skip this if we are the free space inode.
+		 */
+		if (!btrfs_is_free_space_inode(inode))
+			btrfs_drop_extent_cache(inode, unwritten_start,
+						    end, 0);
 
 		/*
 		 * If the ordered extent had an IOERR or something else went
-- 
2.46.0


