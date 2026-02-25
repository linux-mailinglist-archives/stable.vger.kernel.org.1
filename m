Return-Path: <stable+bounces-219168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4zGHL8xonmmzVAQAu9opvQ
	(envelope-from <stable+bounces-219168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:13:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963A19120F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6966C30241A9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5441328D8DF;
	Wed, 25 Feb 2026 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyZBVo/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6F28851F
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771989193; cv=none; b=nbAjTo5LcfD+A1Ppa22JzOnO9Mnm7sM1+a/RRwCDKYzbG+yecPpj+H0kJZR1Lf5X8iLQfvLmE3DJ+iLXTfq8NemQFpZJ/jevS05tvMRoa6VbQb9KOuXhCH2EJ2X0gSNwgZzVUxboGWen6WXh773evREvLqvH9lvs2ABmdAqjiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771989193; c=relaxed/simple;
	bh=dp55jl/YNfww07ViHVGcTghV1CzjS5Cri8V7uK/htJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5UN/poIEx83BAl4A5B8MHHH+9blRhnpcRlXbYxMmZJVBsoXsAd36LRZ2yddUEzKLUynUe/HBhC6+jdi6iU1ck/qd+QlTqn4PuOy/RhandV4jh2BT4me+fRC1OukB3c0h1JImN2DiOdjsXDq9/MV5QEI6nhN4zwWWWguYPAjJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyZBVo/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DDFC19422;
	Wed, 25 Feb 2026 03:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771989192;
	bh=dp55jl/YNfww07ViHVGcTghV1CzjS5Cri8V7uK/htJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyZBVo/77CdxaQc/4fNCyNSw1KFe/BYFJQnLLt1tDCwhGa+DkFPJ9dXzfXrJCug5p
	 UpXkLGqLqUXVJs0T2D6X+AGjmrWQ6OgunccUN+PBJr/0k56U98XgN/yLtTa7IayDwz
	 6fMar4d6oCsmMBR8JnxgEwsU/YMIeiGhWSKLtpDTDJiJ8xi0ORyZrglMKZC0WhUKca
	 JLFdY3l6H5c/Vi1mTmPnMxvuiKPyAVLaSLF3nDfdWh26OIRdL67eXRnhb2dEwj5Ghg
	 IN+QICrpsuojcDntp5u0BSiSR8amvC/D1e++lp9kEybHzn9nz3IzAJBJkUc665fZ80
	 Pa3xuE5zGpMvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O
Date: Tue, 24 Feb 2026 22:13:10 -0500
Message-ID: <20260225031310.3856508-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022424-pellet-reclaim-d961@gregkh>
References: <2026022424-pellet-reclaim-d961@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219168-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: 2963A19120F
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit feaf2a80e78f89ee8a3464126077ba8683b62791 ]

When allocating blocks during within-EOF DIO and writeback with
dioread_nolock enabled, EXT4_GET_BLOCKS_PRE_IO was set to split an
existing large unwritten extent. However, EXT4_GET_BLOCKS_CONVERT was
set when calling ext4_split_convert_extents(), which may potentially
result in stale data issues.

Assume we have an unwritten extent, and then DIO writes the second half.

   [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
   [UUUUUUUUUUUUUUUU] extent status tree
            |<-   ->| ----> dio write this range

First, ext4_iomap_alloc() call ext4_map_blocks() with
EXT4_GET_BLOCKS_PRE_IO, EXT4_GET_BLOCKS_UNWRIT_EXT and
EXT4_GET_BLOCKS_CREATE flags set. ext4_map_blocks() find this extent and
call ext4_split_convert_extents() with EXT4_GET_BLOCKS_CONVERT and the
above flags set.

Then, ext4_split_convert_extents() calls ext4_split_extent() with
EXT4_EXT_MAY_ZEROOUT, EXT4_EXT_MARK_UNWRIT2 and EXT4_EXT_DATA_VALID2
flags set, and it calls ext4_split_extent_at() to split the second half
with EXT4_EXT_DATA_VALID2, EXT4_EXT_MARK_UNWRIT1, EXT4_EXT_MAY_ZEROOUT
and EXT4_EXT_MARK_UNWRIT2 flags set. However, ext4_split_extent_at()
failed to insert extent since a temporary lack -ENOSPC. It zeroes out
the first half but convert the entire on-disk extent to written since
the EXT4_EXT_DATA_VALID2 flag set, but left the second half as unwritten
in the extent status tree.

   [0000000000SSSSSS]  data                S: stale data, 0: zeroed
   [WWWWWWWWWWWWWWWW]  on-disk extent      W: written extent
   [WWWWWWWWWWUUUUUU]  extent status tree

Finally, if the DIO failed to write data to the disk, the stale data in
the second half will be exposed once the cached extent entry is gone.

Fix this issue by not passing EXT4_GET_BLOCKS_CONVERT when splitting
an unwritten extent before submitting I/O, and make
ext4_split_convert_extents() to zero out the entire extent range
to zero for this case, and also mark the extent in the extent status
tree for consistency.

Fixes: b8a8684502a0 ("ext4: Introduce FALLOC_FL_ZERO_RANGE flag for fallocate")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Message-ID: <20251129103247.686136-4-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ different function signatures ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 12da59c03c7cf..10958ad2f8839 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3699,11 +3699,15 @@ static int ext4_split_convert_extents(handle_t *handle,
 	/* Convert to unwritten */
 	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
 		split_flag |= EXT4_EXT_DATA_VALID1;
-	/* Convert to initialized */
-	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
+	/* Split the existing unwritten extent */
+	} else if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
+			    EXT4_GET_BLOCKS_CONVERT)) {
 		split_flag |= ee_block + ee_len <= eof_block ?
 			      EXT4_EXT_MAY_ZEROOUT : 0;
-		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
+		split_flag |= EXT4_EXT_MARK_UNWRIT2;
+		/* Convert to initialized */
+		if (flags & EXT4_GET_BLOCKS_CONVERT)
+			split_flag |= EXT4_EXT_DATA_VALID2;
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
 	return ext4_split_extent(handle, inode, ppath, map, split_flag, flags);
@@ -3868,7 +3872,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
 		ret = ext4_split_convert_extents(handle, inode, map, ppath,
-					 flags | EXT4_GET_BLOCKS_CONVERT);
+					 flags);
 		if (ret < 0) {
 			err = ret;
 			goto out2;
-- 
2.51.0


