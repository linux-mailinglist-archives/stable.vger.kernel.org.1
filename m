Return-Path: <stable+bounces-98830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A493A9E58BE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E1D188586B
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77699218AD3;
	Thu,  5 Dec 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhx58WPb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382FF218AD1
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409926; cv=none; b=R/IMKoTVeWZg6LwRxqJI4BH0swX8UbSnAsVSyQBLEhQQzKs6Y2as2WSPrGdZxEERFSYq75goq0LGrwQnSsIsBd+QWJubhQbCzSlcGmR0ixH9SuExzAUoMCgPw1d3PWOm+ycB/Uh0xsj3/mSBvxrM4m7CNb/+0Bd+yJ2DHYOT70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409926; c=relaxed/simple;
	bh=yy5liJyak69z8CyDXd4U+bVwe3wUUFGPNkwu9JsOW8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7z5q7o8vKiFINQO5B4F7Dzqw8H/2mWXN0G+BaKgE6T8Uh6D3ut9smkX9GUUgnOKHhnFU694vLy+RDjKLV6wJW4cycFwWl+wJWtXXW/ZLAJxgaIcZSIjtEGLKnQ4sRsWKXqMYAaITiU12py0VbVu12UHNrT+SQnxA0eqg22XgWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhx58WPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF8BC4CED1;
	Thu,  5 Dec 2024 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409925;
	bh=yy5liJyak69z8CyDXd4U+bVwe3wUUFGPNkwu9JsOW8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhx58WPbYsht2qqgjyeyixbrgax0z/RtZ0WzKLDClGN7KUCOmEzkNwii0edJB5acq
	 G04mXtU1uNzaLG33sJ81bKRVN4wqI0ENoudkcdwCEbdgi9kP5CH0GJejs3kTBC/YvJ
	 SrvP4osu+0jhg1XGO8MgEDtS+DlqEIq6l3yCf7lkfVbGjv2HfNuJZK3gVAriANGyXp
	 vFWH0w4QBuK4QpmCo2wFlPB/Bu25b5el8xK9M/mIvst4IpWinBowsLO+9FGIYoYw/j
	 g4YJMeayQ9eYhoCkMGo5rkYcOXLyzn1Kfn2aw3iUGw/8a5+CaZjNOqUOaeI3nVGYUP
	 GI9jljc0WrKFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Acs <acsjakub@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3 6.1] udf: Fold udf_getblk() into udf_bread()
Date: Thu,  5 Dec 2024 08:34:06 -0500
Message-ID: <20241205071330-ab549c39771c2672@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241205092925.43310-1-acsjakub@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 32f123a3f34283f9c6446de87861696f0502b02e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jakub Acs <acsjakub@amazon.com>
Commit author: Jan Kara <jack@suse.cz>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  32f123a3f3428 ! 1:  8293ff38b97ef udf: Fold udf_getblk() into udf_bread()
    @@
      ## Metadata ##
    -Author: Jan Kara <jack@suse.cz>
    +Author: Jakub Acs <acsjakub@amazon.com>
     
      ## Commit message ##
         udf: Fold udf_getblk() into udf_bread()
     
    +    commit 32f123a3f34283f9c6446de87861696f0502b02e upstream.
    +
         udf_getblk() has a single call site. Fold it there.
     
         Signed-off-by: Jan Kara <jack@suse.cz>
     
    +    [acsjakub: backport-adjusting changes]
    +    udf_getblk() has changed between 6.1 and the backported commit, namely
    +    in commit 541e047b14c8 ("udf: Use udf_map_block() in udf_getblk()")
    +
    +    Backport using the form of udf_getblk present in 6.1., that means use
    +    udf_get_block() instead of udf_map_block() and use dummy in buffer_new()
    +    and buffer_mapped().
    +
    +    Closes: https://syzkaller.appspot.com/bug?extid=a38e34ca637c224f4a79
    +    Signed-off-by: Jakub Acs <acsjakub@amazon.de>
    +
      ## fs/udf/inode.c ##
     @@ fs/udf/inode.c: static int udf_get_block(struct inode *inode, sector_t block,
    - 	return 0;
    + 	return err;
      }
      
     -static struct buffer_head *udf_getblk(struct inode *inode, udf_pblk_t block,
     -				      int create, int *err)
     -{
     -	struct buffer_head *bh;
    --	struct udf_map_rq map = {
    --		.lblk = block,
    --		.iflags = UDF_MAP_NOPREALLOC | (create ? UDF_MAP_CREATE : 0),
    --	};
    +-	struct buffer_head dummy;
     -
    --	*err = udf_map_block(inode, &map);
    --	if (!*err && map.oflags & UDF_BLK_MAPPED) {
    --		bh = sb_getblk(inode->i_sb, map.pblk);
    --		if (map.oflags & UDF_BLK_NEW) {
    +-	dummy.b_state = 0;
    +-	dummy.b_blocknr = -1000;
    +-	*err = udf_get_block(inode, block, &dummy, create);
    +-	if (!*err && buffer_mapped(&dummy)) {
    +-		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
    +-		if (buffer_new(&dummy)) {
     -			lock_buffer(bh);
     -			memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
     -			set_buffer_uptodate(bh);
    @@ fs/udf/inode.c: static int udf_get_block(struct inode *inode, sector_t block,
     -
     -	return NULL;
     -}
    --
    + 
      /* Extend the file with new blocks totaling 'new_block_bytes',
       * return the number of extents added
    -  */
     @@ fs/udf/inode.c: struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
      			      int create, int *err)
      {
      	struct buffer_head *bh = NULL;
    -+	struct udf_map_rq map = {
    -+		.lblk = block,
    -+		.iflags = UDF_MAP_NOPREALLOC | (create ? UDF_MAP_CREATE : 0),
    -+	};
    ++	struct buffer_head dummy;
      
     -	bh = udf_getblk(inode, block, create, err);
     -	if (!bh)
    -+	*err = udf_map_block(inode, &map);
    -+	if (*err || !(map.oflags & UDF_BLK_MAPPED))
    ++	dummy.b_state = 0;
    ++	dummy.b_blocknr = -1000;
    ++
    ++	*err = udf_get_block(inode, block, &dummy, create);
    ++	if (*err || !buffer_mapped(&dummy))
      		return NULL;
      
    -+	bh = sb_getblk(inode->i_sb, map.pblk);
    ++	bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
     +	if (!bh) {
     +		*err = -ENOMEM;
     +		return NULL;
     +	}
    -+	if (map.oflags & UDF_BLK_NEW) {
    ++
    ++	if (buffer_new(&dummy)) {
     +		lock_buffer(bh);
     +		memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
     +		set_buffer_uptodate(bh);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

