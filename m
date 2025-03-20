Return-Path: <stable+bounces-125672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645C0A6AA95
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5F27A7D0A
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65CD1EB9E8;
	Thu, 20 Mar 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euNgXuRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE631DF980
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486651; cv=none; b=Ni6q8zxXqp75L8DXxfZ1dOMHN6H39ezwV627NhOubUtKY5g9gAsj295aZqvwx+46/N74CNS0xAGMJnWgty5ApCejzdf/E54mfdY2VRZxi013rJ//V9iODxMFkcczR5D8dfnZuAIeOcV6uPpOtIZ3cZLkbZE99X/nwnWkDjaHklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486651; c=relaxed/simple;
	bh=URbVdrz4z9kLqS2AVV79PKQq0Msn4a/nSZonaI6VjlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYfDBgHmlLbiyxGyHYyq4fTKZToRlRhlacW2oGnJF62CyhC++juAVjLGYr109k6tryk3Vvf9Zr+fZX4AJbex+zGFcHptB8p4MSjg8RJ4ux5IcKs9CwmfchUTa09q+0GR+X+TC8E7A5l3EKeKNt2XioeQ+ieeGjQ+slZkWY7VFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euNgXuRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6794BC4CEE8;
	Thu, 20 Mar 2025 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486650;
	bh=URbVdrz4z9kLqS2AVV79PKQq0Msn4a/nSZonaI6VjlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euNgXuRWKc16KvrUdbmvVA77G+/BzgasXFxoF3/HGIiofUHfFxsaz5OobAZirkWWK
	 qBs7hoFvJ3RNCE1P86t/pESDskYM3iOsqmQG5fNfhLNHICjVC636bY/Am6J/Rl1U5F
	 Rdd80eIlg45hEnYhx08+QMf2JWoO1BhVuSSZs7ag0Bgq3xv/VBiZSRsufJD+2BP52x
	 X5FftdzrimETFn2pjzhi9IWXcExPKs66dbNBJVCl9Magka9ovFQT386mfbn7KyEo1W
	 0F4uJJnyXTkjl/On4gNVt4Givsy58UIAkX0InMfrziHNWLI5pZXovYco5oeXLRLgZh
	 paUbcgFPZc5YQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Change new sparse cluster processing
Date: Thu, 20 Mar 2025 12:03:58 -0400
Message-Id: <20250320111323-b39cad62593c7f87@stable.kernel.org>
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
1:  c380b52f6c570 ! 1:  0897865442ea4 fs/ntfs3: Change new sparse cluster processing
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

