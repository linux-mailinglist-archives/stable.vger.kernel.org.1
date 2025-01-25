Return-Path: <stable+bounces-110433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BADA1C3AC
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 15:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1BC3A9E14
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84F1CAAC;
	Sat, 25 Jan 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB1W7Rr0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9A25A65C
	for <stable@vger.kernel.org>; Sat, 25 Jan 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737813829; cv=none; b=JoJbfBFjSiQjM4n3/DGbpQ5tvDHEK6fH1GED2/gIyzhSCOjQA8MKxd3cSe9cUk0Dv64T3adr1n0+FYCH9qx7mSMT7HLGtCkvrMvUBJc0Vbm3nj+VJKdzExh/fLf4Q9BiRd8ekxpyx5nUvWbhezTEPxMf0w2dZp4rSms+WNEawMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737813829; c=relaxed/simple;
	bh=rf9s8p77PEbyw0Vsb5HROWoppERuHpi+52zSMVwQBgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FqIn2LY3oz/SkajMXcQ/ruC7kv6H8kj43UQOMEGDlp8Nj+zEBkA7d54NZanD4cl/uHtu4c4Neu5bBK63ly6JFv2vkDkxeZ6qklHzueGhSqpH/idW2orTl/0SSblDGt7RyM2mo+LcwaX2J3vNuRWTLyokvfK05hx0+w3xSZFherQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB1W7Rr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BF6C4CED6;
	Sat, 25 Jan 2025 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737813826;
	bh=rf9s8p77PEbyw0Vsb5HROWoppERuHpi+52zSMVwQBgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nB1W7Rr0LsU8i2K8ELV5/i1gTzkuFgHdW/56xRlCVxr5ZHq9GHB9qRFHgQt2LuNl5
	 h25+mNHepuC7EF3e81JI/d7UcN7OCVKjuEcSpoeiXUYbhcb046C2ZI8m0Gt3I8rb/Y
	 tjR/8yDAa5PYsnLUflmX9di75ltpNGYzTyyQ8yka+9wsIC6gKuadSmNcnPDOFQmSIN
	 SynvcES8sgR2yVuxe8HKDq1UtL+1mDHDBwecqH0HYMCbedmQL56so7Ym2ZjFp3Rjed
	 WtkT2Y7vHz+MoUaayf3zmet0yRXnV04RIUo/UZfLdXMNQrC9vDHqeToUr9WW71+95w
	 bBXRcQTehX7FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shaoying Xu <shaoyi@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 1/2] ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path
Date: Sat, 25 Jan 2025 09:03:44 -0500
Message-Id: <20250124204716-83bc43904f7cce15@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250125003135.11978-2-shaoyi@amazon.com>
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

The upstream commit SHA1 provided is correct: 73c384c0cdaa8ea9ca9ef2d0cff6a25930f1648e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shaoying Xu<shaoyi@amazon.com>
Commit author: Theodore Ts'o<tytso@mit.edu>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  73c384c0cdaa8 ! 1:  ad990516172ca ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path
    @@ Metadata
      ## Commit message ##
         ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path
     
    +    [ Upstream commit 73c384c0cdaa8ea9ca9ef2d0cff6a25930f1648e ]
    +
         We can't fail in the truncate path without requiring an fsck.
         Add work around for this by using a combination of retry loops
         and the __GFP_NOFAIL flag.
    @@ Commit message
         Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
         Link: https://lore.kernel.org/r/20200507175028.15061-1-pendleton@google.com
         Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    +    Stable-dep-of: c26ab35702f8 ("ext4: fix slab-use-after-free in ext4_split_extent_at()")
    +    [v5.4: resolved contextual conflict in __read_extent_tree_block]
    +    Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
     
      ## fs/ext4/ext4.h ##
     @@ fs/ext4/ext4.h: enum {
    @@ fs/ext4/extents.c: ext4_force_split_extent_at(handle_t *handle, struct inode *in
     +			flags);
      }
      
    - static int
    + /*
     @@ fs/ext4/extents.c: __read_extent_tree_block(const char *function, unsigned int line,
    - {
      	struct buffer_head		*bh;
      	int				err;
    -+	gfp_t				gfp_flags = __GFP_MOVABLE | GFP_NOFS;
    + 	ext4_fsblk_t			pblk;
    ++	gfp_t                           gfp_flags = __GFP_MOVABLE | GFP_NOFS;
     +
     +	if (flags & EXT4_EX_NOFAIL)
    -+		gfp_flags |= __GFP_NOFAIL;
    ++		 gfp_flags |= __GFP_NOFAIL;
      
    + 	pblk = ext4_idx_pblock(idx);
     -	bh = sb_getblk_gfp(inode->i_sb, pblk, __GFP_MOVABLE | GFP_NOFS);
     +	bh = sb_getblk_gfp(inode->i_sb, pblk, gfp_flags);
      	if (unlikely(!bh))
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

