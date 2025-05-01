Return-Path: <stable+bounces-139378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DAFAA638D
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB157B31CD
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7E224B12;
	Thu,  1 May 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln+Emwav"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1A215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126637; cv=none; b=jpnJBEGcteaPPbCRfZICaWprw2F04Z4hkIMGBE6T0tkZrBDh1fm3eSIpII0z7CS+FSR/Km7T4oFZ7x2OyfY4d254BgpO8bZWjkHTx5bvA5fr6AIZMY7/YWehXuUZh5r5Ntda7z12NQt7/2S+rDwa3SQj3fLQRaCRlnTaDfPWID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126637; c=relaxed/simple;
	bh=3eDCdv58rOYB99SJdt/b6eqCZum2XhiM9zH+G1LdjGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5ndyhNy+wS5+BBvWkeCXDXss4lV1AYSoRe2Al/KfT1wpolZeWAddH43bsz0VPD/Y+gLpBP8NgBgiKw6q+54ha2M47B3+Fd7y6BqSVtDRNwMjPUBOVYJFcPYc13zsR/YZz0XcN1rS6D3zt9SlM3+KliSqtTGsgXRWlzebIEHlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln+Emwav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C8FC4CEE3;
	Thu,  1 May 2025 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126636;
	bh=3eDCdv58rOYB99SJdt/b6eqCZum2XhiM9zH+G1LdjGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ln+Emwav+poh2RbWp09+BEcvGw4/dDa17Kl7TXJUeypvLJsfX+yJFLfcjSjkK99Je
	 aSSruRhoIB8Mj0CF6eP6cnSwANLGhZ6W6Dvtl0VEM4TY6DDhJOkRkJBmfifVg2viJt
	 huTAVYIXwQuucIwMgh6KTMTKqads03LUlfV6Bx8Z445y9nA0nE63imj1ShF86Fg8gV
	 g9QKZMnlKzpEs2VYcU8mUnkoXOujrzIdJAEn+vksZrwI8ukZmKX3kBRpyKAW3G87g/
	 IkdvjYe2c2bvYCXD5Pw4oF3xd8oib7/TNvxX3fNY0acrCfJdc1ReNU00PI1WE8Thhs
	 liC7HMmQupOww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 03/16] xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
Date: Thu,  1 May 2025 15:10:33 -0400
Message-Id: <20250501122937-e15b9927b12fdede@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-4-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 86de848403abda05bf9c16dcdb6bef65a8d88c41

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c299188b443a)

Note: The patch differs from the upstream commit:
---
1:  86de848403abd ! 1:  17fd2403176bf xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
    @@ Metadata
      ## Commit message ##
         xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
     
    +    [ Upstream commit 86de848403abda05bf9c16dcdb6bef65a8d88c41 ]
    +
         Accessing if_bytes without the ilock is racy.  Remove the initial
         if_bytes == 0 check in xfs_reflink_end_cow_extent and let
         ext_iext_lookup_extent fail for this case after we've taken the ilock.
    @@ Commit message
         Signed-off-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/xfs_reflink.c ##
     @@ fs/xfs/xfs_reflink.c: xfs_reflink_end_cow_extent(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

