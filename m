Return-Path: <stable+bounces-111920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600FA24C33
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E61F16475E
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638BC155393;
	Sat,  1 Feb 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoIYQT2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C9126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454021; cv=none; b=rPnsPK5wxHNoZFZu+XH+wfbV4tTaZTqLvYFyAQ63KoKRgzuxF3pILlzwG+X3sZL8my3EUDXBe84ovmT3iFrwECxi+rJkodsN8W/lBIaVhARBGgLVxKfHAui6qOzesOQ8zLcQJ+Cg28o20atehN+sBa6BRrBMLU3ml0Z3MVwGBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454021; c=relaxed/simple;
	bh=VwjrMFRpAr+FS0jQxJBMujECVLcqxCtxSgHx/RdFbWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jthoDhNX2V+/juHTw1weqcRNqnbPtQ3QAgeaqHAEEWrp8ifODyFqfvvjC9j3ukYrSYjAQZRQoT8URAtkdc/dz4/ZrBa6pzZGHAlLWpOCaq9Gs1pw2HD3fnqkoFvLD3TIVxxjK2PUJS79Yx/cYCGQng4l0gITVSNMF34LnL3N+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoIYQT2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333BEC4CED3;
	Sat,  1 Feb 2025 23:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454019;
	bh=VwjrMFRpAr+FS0jQxJBMujECVLcqxCtxSgHx/RdFbWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoIYQT2/2q6+QRmvjOf46QpItmCT5OBz7bhLdeeQAV1Jj65CCIqHVkT3U0LNH7377
	 ygKe9eu8iMYZF3dQ/b4kHjUD9ih+vi+dX4AcbwOua+xetmF0ahGjz1//ZT14cVmB2J
	 tBlwjqgkeV33ozVloOO/r94K6bVVNMtzHDlMzdElLKHc2sSH1MiHFPFORcDGR0yoOQ
	 5eq2xSTeSJSkmXB1J+TEzSKrEXSTBr7cfrErP8y92FIp9P+d7atqLautSelZDnMn06
	 /6MHqSCuJec0+2XlwrtJ/2ALzEga4Qje8CwXwcYJBNl9hDebpNV1XHcj3r2rE+slSB
	 Z4SHZPCgpZ6fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 18/19] xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
Date: Sat,  1 Feb 2025 18:53:37 -0500
Message-Id: <20250201151146-d45d58468b17a185@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-19-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: c421df0b19430417a04f68919fc3d1943d20ac04

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d7d5ed65364c)
6.1.y | Present (different SHA1: a426d90bf5d7)

Note: The patch differs from the upstream commit:
---
1:  c421df0b19430 ! 1:  3bbebf3ef4d3f xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
    @@ Metadata
      ## Commit message ##
         xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
     
    +    [ Upstream commit c421df0b19430417a04f68919fc3d1943d20ac04 ]
    +
         Introduce a local boolean variable if FS_XFLAG_REALTIME to make the
         checks for it more obvious, and de-densify a few of the conditionals
         using it to make them more readable while at it.
    @@ Commit message
         Link: https://lore.kernel.org/r/20231025141020.192413-4-hch@lst.de
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Christian Brauner <brauner@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_ioctl.c ##
     @@ fs/xfs/xfs_ioctl.c: xfs_ioctl_setattr_xflags(
    @@ fs/xfs/xfs_ioctl.c: xfs_ioctl_setattr_xflags(
     +	if (rtflag) {
     +		/* If realtime flag is set then must have realtime device */
      		if (mp->m_sb.sb_rblocks == 0 || mp->m_sb.sb_rextsize == 0 ||
    - 		    xfs_extlen_to_rtxmod(mp, ip->i_extsize))
    + 		    (ip->i_extsize % mp->m_sb.sb_rextsize))
      			return -EINVAL;
     -	}
      
    @@ fs/xfs/xfs_ioctl.c: xfs_ioctl_setattr_xflags(
     +			ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
     +	}
      
    - 	/* diflags2 only valid for v3 inodes. */
    - 	i_flags2 = xfs_flags2diflags2(ip, fa->fsx_xflags);
    + 	/* Don't allow us to set DAX mode for a reflinked file for now. */
    + 	if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

