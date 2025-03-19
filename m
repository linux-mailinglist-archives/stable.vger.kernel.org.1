Return-Path: <stable+bounces-125597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B4A69742
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D703B8A2F74
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C21207DE6;
	Wed, 19 Mar 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvta72lD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468221FCCF2
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407070; cv=none; b=b+xa8IYiDFxWD8JSM8Pyj1axHUzFN3RksNqjQUS41U1X8GHm0szCpAMjq2OBGLSJk9APdmiKvhi5qwZalyVWmsqVCSPs88rynMf5HFF0PFy5tMJD1LM63cUZ+pqCWXA0WOUuvirvYGvneIDGmRV58PYKeHhkwcGGQS9iFUZ72Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407070; c=relaxed/simple;
	bh=LlsBQX7hhvcLCEckC4XlxagJ61/f38xMe0TXANkJ3uM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l25gesQ+Tpxe3qbOXk9AjCclZolnjbtf/qEiC3H7kIkWaDwXKDEOCdk9O5/WXL0Qm0qT/+dUNL7zhk+Gj2p7xVqLtbbIA7l6OhBAKIHPmXPq00ABZieGhgqFmFTOgxHrrrpzwcuZV7QDErzlJzBcVM9Pg8DMYfsnM5h+2E4Ebgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvta72lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CD0C4CEE4;
	Wed, 19 Mar 2025 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742407069;
	bh=LlsBQX7hhvcLCEckC4XlxagJ61/f38xMe0TXANkJ3uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvta72lDIvu7juTzcCpQXyJFtVLJrxTnpHVlWBcOOMFpaXJ7poZKz+sylDoFtpJPV
	 eH7EVD34ZiyDKJJXfUA0nkQt+GW5F9d7OjEfFnF1TeqnJoxP9SzbSmeNuXU248bFRH
	 +kwML+WkcRXahyrjUNkb/bvYs1ukX4sFjiWwEj3aCa+Rxcfot58601z88RpVmRsTZI
	 nIn75xIij/ALHc7+Yv1lwGrRf+RAWI1auaFrHNjJPtq6cMwwsgw74V53cmTGjF6OfU
	 t6oEQZxN9VgiWEFXohekvCSXAzM5gCYia4jKuzt5DT3K3z/R+ClGf6qtyoWJNwIDCd
	 c5RuSjLuIPrEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Change new sparse cluster processing
Date: Wed, 19 Mar 2025 13:57:37 -0400
Message-Id: <20250319134209-1bad56b94d979534@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250319145436.79713-1-miguelgarciaroman8@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: c380b52f6c5702cc4bdda5e6d456d6c19a201a0b

WARNING: Author mismatch between patch and upstream commit:
Backport author: <miguelgarciaroman8@gmail.com>
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  c380b52f6c570 ! 1:  d24d9a62db4cb fs/ntfs3: Change new sparse cluster processing
    @@ Metadata
      ## Commit message ##
         fs/ntfs3: Change new sparse cluster processing
     
    +    commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b upstream.
    +
    +    This patch is a backport.
         Remove ntfs_sparse_cluster.
         Zero clusters in attr_allocate_clusters.
         Fixes xfstest generic/263
     
    +    The fix has been verified by executing the syzkaller reproducer test case.
    +
    +    Bug: https://syzkaller.appspot.com/bug?extid=f3e5d0948a1837ed1bb0
    +    Reported-by: syzbot+f3e5d0948a1837ed1bb0@syzkaller.appspotmail.com
    +    Cc: <stable@vger.kernel.org>
         Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    +    Signed-off-by: Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
    +    (cherry picked from commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b)
     
      ## fs/ntfs3/attrib.c ##
     @@ fs/ntfs3/attrib.c: static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
    @@ fs/ntfs3/attrib.c: int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST
      	struct mft_inode *mi, *mi_b;
     -	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end;
     +	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
    -+	unsigned fr;
    ++	unsigned int fr;
      	u64 total_size;
     -	u32 clst_per_frame;
     -	bool ok;
    @@ fs/ntfs3/file.c: static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vb
     -{
     -	struct address_space *mapping = inode->i_mapping;
     -	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
    --	u8 cluster_bits = sbi->cluster_bits;
    --	u64 vbo = (u64)vcn << cluster_bits;
    --	u64 bytes = (u64)len << cluster_bits;
    +-	u64 vbo = (u64)vcn << sbi->cluster_bits;
    +-	u64 bytes = (u64)len << sbi->cluster_bits;
     -	u32 blocksize = 1 << inode->i_blkbits;
     -	pgoff_t idx0 = page0 ? page0->index : -1;
     -	loff_t vbo_clst = vbo & sbi->cluster_mask_inv;
    @@ fs/ntfs3/file.c: static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vb
     -
     -		zero_user_segment(page, from, to);
     -
    --		if (!partial)
    --			SetPageUptodate(page);
    --		flush_dcache_page(page);
    --		set_page_dirty(page);
    +-		if (!partial) {
    +-			if (!PageUptodate(page))
    +-				SetPageUptodate(page);
    +-			set_page_dirty(page);
    +-		}
     -
     -		if (idx != idx0) {
     -			unlock_page(page);
    @@ fs/ntfs3/file.c: static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vb
     -		}
     -		cond_resched();
     -	}
    +-	mark_inode_dirty(inode);
     -}
     -
      /*
    @@ fs/ntfs3/file.c: static long ntfs_fallocate(struct file *file, int mode, loff_t
      		u32 frame_size;
      		loff_t mask, vbo_a, end_a, tmp;
      
    --		err = filemap_write_and_wait_range(mapping, vbo, LLONG_MAX);
    +-		err = filemap_write_and_wait_range(mapping, vbo, end - 1);
    +-		if (err)
    +-			goto out;
    +-
    +-		err = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
     +		err = filemap_write_and_wait_range(mapping, vbo_down,
     +						   LLONG_MAX);
      		if (err)
    @@ fs/ntfs3/file.c: static long ntfs_fallocate(struct file *file, int mode, loff_t
      			goto out;
      
      		if (is_supported_holes) {
    --			CLST vcn_v = bytes_to_cluster(sbi, ni->i_valid);
    +-			CLST vcn_v = ni->i_valid >> sbi->cluster_bits;
      			CLST vcn = vbo >> sbi->cluster_bits;
      			CLST cend = bytes_to_cluster(sbi, end);
     +			CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

