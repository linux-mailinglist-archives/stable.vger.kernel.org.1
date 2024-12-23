Return-Path: <stable+bounces-105852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D079FB1FD
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C463E7A0698
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6C1B21BD;
	Mon, 23 Dec 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xAD8ZrEB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BF7E0FF;
	Mon, 23 Dec 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970360; cv=none; b=m2Pp/exg0DurP5UYdh+tD2IIQsUA0eNOb/D783Xzbk5jErUsK40k3cagxIjQAyVyI35sZf29mEAtisnl6anWZJsFzvK/KIzDXVaCmD6NXmSUQgH0pPdIq65d5yXmOZw9gnd8Xqe4HE5fWfvmc67HWgSAwmQtNywr+VIbd1RD23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970360; c=relaxed/simple;
	bh=jF5LE5eSFLee/quwe0dBfm7VPBwLMZ70CJWnjhvCp8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM4iyNXkof7p7wX/m5mbg3mAhV6uFWQFdmICsgAC7usWtk+Ji3b2OeRxwem+c4mXyH25GMF+cAn/nlM186GQt9iRD6i+f6t2WsEjYnTJ7SaLKtiFbIBO/qT/zuoeGAGo5Te7BiYgbhtLTLa3ELibOajI9TcUuDzQO+iPfC/cJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xAD8ZrEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77566C4CED3;
	Mon, 23 Dec 2024 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970360;
	bh=jF5LE5eSFLee/quwe0dBfm7VPBwLMZ70CJWnjhvCp8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xAD8ZrEBOXDqZyc/Dk8CKzSNBUc+vWyI0jyfM2TbEfUcM7UIVC6kDVTdRBGtWvZGx
	 j8cVVtMeTrg+gOR9BuMA3gDFLKqYsNF4Q/sk0jU1BZfGbTLEbRddyS9RhbjQIxUxHj
	 LdCn98x9FqB01CQU5AFzcWd+Qhui9aKj/5tm+wvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zizhi Wo <wozizhi@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/116] xfs: Fix the owner setting issue for rmap query in xfs fsmap
Date: Mon, 23 Dec 2024 16:58:22 +0100
Message-ID: <20241223155400.827809215@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
References: <20241223155359.534468176@linuxfoundation.org>
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

From: Zizhi Wo <wozizhi@huawei.com>

commit 68415b349f3f16904f006275757f4fcb34b8ee43 upstream.

I notice a rmap query bug in xfs_io fsmap:
[root@fedora ~]# xfs_io -c 'fsmap -vvvv' /mnt
 EXT: DEV    BLOCK-RANGE           OWNER              FILE-OFFSET      AG AG-OFFSET             TOTAL
   0: 253:16 [0..7]:               static fs metadata                  0  (0..7)                    8
   1: 253:16 [8..23]:              per-AG metadata                     0  (8..23)                  16
   2: 253:16 [24..39]:             inode btree                         0  (24..39)                 16
   3: 253:16 [40..47]:             per-AG metadata                     0  (40..47)                  8
   4: 253:16 [48..55]:             refcount btree                      0  (48..55)                  8
   5: 253:16 [56..103]:            per-AG metadata                     0  (56..103)                48
   6: 253:16 [104..127]:           free space                          0  (104..127)               24
   ......

Bug:
[root@fedora ~]# xfs_io -c 'fsmap -vvvv -d 0 3' /mnt
[root@fedora ~]#
Normally, we should be able to get one record, but we got nothing.

The root cause of this problem lies in the incorrect setting of rm_owner in
the rmap query. In the case of the initial query where the owner is not
set, __xfs_getfsmap_datadev() first sets info->high.rm_owner to ULLONG_MAX.
This is done to prevent any omissions when comparing rmap items. However,
if the current ag is detected to be the last one, the function sets info's
high_irec based on the provided key. If high->rm_owner is not specified, it
should continue to be set to ULLONG_MAX; otherwise, there will be issues
with interval omissions. For example, consider "start" and "end" within the
same block. If high->rm_owner == 0, it will be smaller than the founded
record in rmapbt, resulting in a query with no records. The main call stack
is as follows:

xfs_ioc_getfsmap
  xfs_getfsmap
    xfs_getfsmap_datadev_rmapbt
      __xfs_getfsmap_datadev
        info->high.rm_owner = ULLONG_MAX
        if (pag->pag_agno == end_ag)
	  xfs_fsmap_owner_to_rmap
	    // set info->high.rm_owner = 0 because fmr_owner == -1ULL
	    dest->rm_owner = 0
	// get nothing
	xfs_getfsmap_datadev_rmapbt_query

The problem can be resolved by simply modify the xfs_fsmap_owner_to_rmap
function internal logic to achieve.

After applying this patch, the above problem have been solved:
[root@fedora ~]# xfs_io -c 'fsmap -vvvv -d 0 3' /mnt
 EXT: DEV    BLOCK-RANGE      OWNER              FILE-OFFSET      AG AG-OFFSET        TOTAL
   0: 253:16 [0..7]:          static fs metadata                  0  (0..7)               8

Fixes: e89c041338ed ("xfs: implement the GETFSMAP ioctl")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 8982c5d6cbd0..85953dbd4283 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -71,7 +71,7 @@ xfs_fsmap_owner_to_rmap(
 	switch (src->fmr_owner) {
 	case 0:			/* "lowest owner id possible" */
 	case -1ULL:		/* "highest owner id possible" */
-		dest->rm_owner = 0;
+		dest->rm_owner = src->fmr_owner;
 		break;
 	case XFS_FMR_OWN_FREE:
 		dest->rm_owner = XFS_RMAP_OWN_NULL;
-- 
2.39.5




