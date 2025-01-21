Return-Path: <stable+bounces-110060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3A7A185D9
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690123AA876
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272AB1F63EF;
	Tue, 21 Jan 2025 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cABdOi8S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89021F5433
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489174; cv=none; b=kp31S9+puAzGnJpBRTD0I33riPYNJwXfpdGf2RW68I8qpLsSQ1q65riT7pc/SXd4fLI/OdNN+eG6ue8EUclRIT5tzsgP8ewNCATIERVTlgGSXU08J9KgJaJH/xBF9qypjS/pFQmlwWHBbRHTpPbM0l4g0gXDw+DDMzdYfQf62o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489174; c=relaxed/simple;
	bh=VmlewI+91NhmCnDukRt8t045813cQVd4AgOtG2LFYl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqEoDVBCmsIfriWClTAasmSVqVi+qdEMDRC2tMpxXnbVvOo1gQlgWliDhSkFNJ4CZnTWLLhCazwuFrHfMPK8Hwbwj/9X2w3bDzXWOYE7QW6lwEWImdoz44VJovDfUnTdw65QRXnwys8m4sL9JeXGHfvOwIkiVvzetx6G6PxU1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cABdOi8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4187AC4CEDF;
	Tue, 21 Jan 2025 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737489174;
	bh=VmlewI+91NhmCnDukRt8t045813cQVd4AgOtG2LFYl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cABdOi8STwgQI0iaPkSNlpZMpkfnK9aPUYCG20KA1jeyggwfg9zlTSwE+e9tktP7S
	 ZdSNEatY+F72j3gVDCCTLItjx1ANrz9hVStIpJL+Ia7qYJxWqnhohDvMaJlmNF/kjj
	 EV+uTx9pUQ8juHJuAkwZd5/7mfiMoFx7il8N0PPvLW1eHeIgzjGKCklIm7OTeAzzT3
	 La2/LqOrl4FExikQHc37rG8IY6wFZHRLAG9TyJ1y2+ty5LbD1k+hNyD7r7SwKLVt8b
	 pSA6KRLTuEfne1ZyKxBfMyHjHXbxZPxY+Cl40pmxTvt86O1aiMDDtQCfOd9qA+SohA
	 EaRtDLSQHNxmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/3] ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
Date: Tue, 21 Jan 2025 14:52:52 -0500
Message-Id: <20250121131434-f734405aee7c8bc1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250121110815.416785-2-amir73il@gmail.com>
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

The upstream commit SHA1 provided is correct: 07aeefae7ff44d80524375253980b1bdee2396b0


Status in newer kernel trees:
6.12.y | Present (different SHA1: 668d8dea2cee)
6.6.y | Present (different SHA1: a3f8a2b13a27)

Note: The patch differs from the upstream commit:
---
1:  07aeefae7ff44 ! 1:  8f1f4e6b34fc1 ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
    @@ Metadata
      ## Commit message ##
         ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
     
    +    [ Upstream commit 07aeefae7ff44d80524375253980b1bdee2396b0 ]
    +
         We want to be able to encode an fid from an inode with no alias.
     
         Signed-off-by: Amir Goldstein <amir73il@gmail.com>
         Link: https://lore.kernel.org/r/20250105162404.357058-2-amir73il@gmail.com
         Signed-off-by: Christian Brauner <brauner@kernel.org>
    +    Stable-dep-of: c45beebfde34 ("ovl: support encoding fid from inode with no alias")
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [re-applied over v6.6.71 with conflict resolved]
    +    Signed-off-by: Amir Goldstein <amir73il@gmail.com>
     
      ## fs/overlayfs/copy_up.c ##
     @@ fs/overlayfs/copy_up.c: int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upperdentry,
    @@ fs/overlayfs/copy_up.c: struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, st
      	buflen = (dwords << 2);
      
      	err = -EIO;
    -@@ fs/overlayfs/copy_up.c: struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin)
    - 	if (!ovl_can_decode_fh(origin->d_sb))
    - 		return NULL;
    - 
    --	return ovl_encode_real_fh(ofs, origin, false);
    -+	return ovl_encode_real_fh(ofs, d_inode(origin), false);
    - }
    - 
    - int ovl_set_origin_fh(struct ovl_fs *ofs, const struct ovl_fh *fh,
    +@@ fs/overlayfs/copy_up.c: int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
    + 	 * up and a pure upper inode.
    + 	 */
    + 	if (ovl_can_decode_fh(lower->d_sb)) {
    +-		fh = ovl_encode_real_fh(ofs, lower, false);
    ++		fh = ovl_encode_real_fh(ofs, d_inode(lower), false);
    + 		if (IS_ERR(fh))
    + 			return PTR_ERR(fh);
    + 	}
     @@ fs/overlayfs/copy_up.c: static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
      	const struct ovl_fh *fh;
      	int err;
    @@ fs/overlayfs/export.c: static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct d
      
     
      ## fs/overlayfs/namei.c ##
    -@@ fs/overlayfs/namei.c: int ovl_verify_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry,
    +@@ fs/overlayfs/namei.c: int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
      	struct ovl_fh *fh;
      	int err;
      
    @@ fs/overlayfs/overlayfs.h: int ovl_copy_up_with_data(struct dentry *dentry);
     -struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
     +struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
      				  bool is_upper);
    - struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin);
    - int ovl_set_origin_fh(struct ovl_fs *ofs, const struct ovl_fh *fh,
    + int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
    + 		   struct dentry *upper);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    fs/overlayfs/copy_up.c: In function 'ovl_encode_real_fh':
    fs/overlayfs/copy_up.c:360:19: error: too many arguments to function 'exportfs_encode_inode_fh'
      360 |         fh_type = exportfs_encode_inode_fh(realinode, (void *)fh->fb.fid,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~
    In file included from fs/overlayfs/copy_up.c:21:
    ./include/linux/exportfs.h:228:12: note: declared here
      228 | extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:250: fs/overlayfs/copy_up.o] Error 1
    make[3]: Target 'fs/overlayfs/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: fs/overlayfs] Error 2
    make[2]: Target 'fs/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: fs] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2009: .] Error 2
    make: Target '__all' not remade because of errors.

