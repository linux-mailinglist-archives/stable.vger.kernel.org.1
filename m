Return-Path: <stable+bounces-111919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2645A24C34
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7FF7A28CB
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC31CEADC;
	Sat,  1 Feb 2025 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/IcjXcI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176311CDFBE
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454018; cv=none; b=QWl/CbukoP/hBS6YCF1TwP5S9SjoFmXIHKhTTklqRbgDL2u0Bt8oKSWTyU9qhS0txueyRgRmEZ+yiE/Uvb0YI71huHNd/a1hLfHwoJQRVGosz5p4vopRjpzwM/z9C+b3zhkscRrDbhGFeS/x0QS7of7HfhSpW/wGhMVANj9vvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454018; c=relaxed/simple;
	bh=7NAgSLxzxBkBVBwUzfdS/buX0wnX2Qa8GFuf4FIwq7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vvy58TZMlVYqBeuCMpcqALM1ntbLnMwAMKoyEQ6HoG4izJ3rd3eOeRINnkNxN2XyQLETMAsbaT8HwD7QxTDtc7S3+IqRPHYp9Wf+jU13Ho8TsfxMYjyp4lKfhtTdeigMBZVlnJFWTVA47YG7DqHGokfrMh4Z/+Hs+cy7U5Fi3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/IcjXcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CC8C4CED3;
	Sat,  1 Feb 2025 23:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454017;
	bh=7NAgSLxzxBkBVBwUzfdS/buX0wnX2Qa8GFuf4FIwq7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/IcjXcIhKwkZIJ3xIO9qoUAyQ1VGEk4H1gri5YYXu38ObuoGATRTLEvcgVhd627c
	 qqFFlr+xvoYk2bUnijgOQq2iFzWPf020muPl0L1i2QTzpFoP53HrVQaBssMyBApCO5
	 fsbJ6a3/cSIdmpEQwZmURLLar2NgetRzBu3kShmXhO0ft5HNJTj2C0Y+C2q7Ek0Ci1
	 NKX2yrVaeGzNH/+e9owVyRsiRPZq2Isyp3hlkHNvdtYkHIXGp9L01Q2ZTT389hg5TH
	 DfmjDLuv+Hx1Qi0+4D3XJz1SXY/WftpDqZJ5n6rdA7TU5aGpO/VYm0x0/A+qiefqIk
	 f0EgMfa7pFRYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 12/19] xfs: only remap the written blocks in xfs_reflink_end_cow_extent
Date: Sat,  1 Feb 2025 18:53:35 -0500
Message-Id: <20250201143046-7b7e5ae2078161ef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-13-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 55f669f34184ecb25b8353f29c7f6f1ae5b313d1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 767a94d81616)
6.1.y | Present (different SHA1: 09e751cf562d)

Note: The patch differs from the upstream commit:
---
1:  55f669f34184e ! 1:  7f296145cb8e6 xfs: only remap the written blocks in xfs_reflink_end_cow_extent
    @@ Metadata
      ## Commit message ##
         xfs: only remap the written blocks in xfs_reflink_end_cow_extent
     
    +    [ Upstream commit 55f669f34184ecb25b8353f29c7f6f1ae5b313d1 ]
    +
         xfs_reflink_end_cow_extent looks up the COW extent and the data fork
         extent at offset_fsb, and then proceeds to remap the common subset
         between the two.
    @@ Commit message
         Signed-off-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_reflink.c ##
     @@ fs/xfs/xfs_reflink.c: xfs_reflink_end_cow_extent(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

