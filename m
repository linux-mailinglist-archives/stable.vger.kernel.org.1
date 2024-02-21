Return-Path: <stable+bounces-22023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942A85D9C0
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2610B257A0
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC4763FE;
	Wed, 21 Feb 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hxzJ6pc4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8669DF6;
	Wed, 21 Feb 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521707; cv=none; b=kOM013b9hOnHPGQHQ4kcWwr9VYr+F4m5QzUOPVl7PL0LBhCjtM53ctvpuLnNYChDp17hMvwQJ2y7TzmYTqCFA4tH7fVunN++yVh1wDgMIwc+gdrqRMicLYGF79bWrG7dldgSI3f7jRpkPy0gYPXgfPLWnAjEQ/Wuix+MXkb72eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521707; c=relaxed/simple;
	bh=W/E3DBY3yKJzMQrAsEiyJbJcRKDY/Q8yRcsXEq2XE0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6RHaMm25JuruM8WpaArJ3A+gA/3Zjg8II4++NiYUD1AFWgM2D1CDvsPKMSDjqasCheBdhU5myzWLgtIIfywAROnJMj3eZK7Dj7HWwGE8lb3dfb4eqvXqe0rcW2Cd7BuICj6mcmuwGIr+THF2C/hmq2E2yE/kncfzFN6q9+tvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hxzJ6pc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFB1C433F1;
	Wed, 21 Feb 2024 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521707;
	bh=W/E3DBY3yKJzMQrAsEiyJbJcRKDY/Q8yRcsXEq2XE0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxzJ6pc4FqzOJlJGg+dYufLTRGD8rwuyxOVK/B4vSY+vEf7i2wvrGsDhTEgTTCjNw
	 UHOVvSdd0GEaPkEte/21uqE6Qm0p99l75xE7+Rg2IVUacCsx29BNO3/QixsXTjWDQD
	 Efw1Ym4aeVs9GE8we18AsBDGTGvGzCn4TjmGGjfc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Chen <harperchen1110@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.19 184/202] ext4: fix double-free of blocks due to wrong extents moved_len
Date: Wed, 21 Feb 2024 14:08:05 +0100
Message-ID: <20240221125937.761982761@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit 55583e899a5357308274601364741a83e78d6ac4 upstream.

In ext4_move_extents(), moved_len is only updated when all moves are
successfully executed, and only discards orig_inode and donor_inode
preallocations when moved_len is not zero. When the loop fails to exit
after successfully moving some extents, moved_len is not updated and
remains at 0, so it does not discard the preallocations.

If the moved extents overlap with the preallocated extents, the
overlapped extents are freed twice in ext4_mb_release_inode_pa() and
ext4_process_freed_data() (as described in commit 94d7c16cbbbd ("ext4:
Fix double-free of blocks with EXT4_IOC_MOVE_EXT")), and bb_free is
incremented twice. Hence when trim is executed, a zero-division bug is
triggered in mb_update_avg_fragment_size() because bb_free is not zero
and bb_fragments is zero.

Therefore, update move_len after each extent move to avoid the issue.

Reported-by: Wei Chen <harperchen1110@gmail.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Closes: https://lore.kernel.org/r/CAO4mrferzqBUnCag8R3m2zf897ts9UEuhjFQGPtODT92rYyR2Q@mail.gmail.com
Fixes: fcf6b1b729bc ("ext4: refactor ext4_move_extents code base")
CC:  <stable@vger.kernel.org> # 3.18
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-2-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/move_extent.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -616,6 +616,7 @@ ext4_move_extents(struct file *o_filp, s
 		goto out;
 	o_end = o_start + len;
 
+	*moved_len = 0;
 	while (o_start < o_end) {
 		struct ext4_extent *ex;
 		ext4_lblk_t cur_blk, next_blk;
@@ -671,7 +672,7 @@ ext4_move_extents(struct file *o_filp, s
 		 */
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
 		/* Swap original branches with new branches */
-		move_extent_per_page(o_filp, donor_inode,
+		*moved_len += move_extent_per_page(o_filp, donor_inode,
 				     orig_page_index, donor_page_index,
 				     offset_in_page, cur_len,
 				     unwritten, &ret);
@@ -681,9 +682,6 @@ ext4_move_extents(struct file *o_filp, s
 		o_start += cur_len;
 		d_start += cur_len;
 	}
-	*moved_len = o_start - orig_blk;
-	if (*moved_len > len)
-		*moved_len = len;
 
 out:
 	if (*moved_len) {



