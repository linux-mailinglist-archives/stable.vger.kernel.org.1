Return-Path: <stable+bounces-139349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C8AA6324
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC377AEED4
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880582248A0;
	Thu,  1 May 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbNG832s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8D1C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125477; cv=none; b=du36CU3CjXDlEP/BP9JS8U8U3VgJi/apn3i/d96i3bIHVd1wfD4Sa0O/9ErZCedv5E9vEXzvtgGeefM415iv3Fb1E9FMeV7YyiJIBOsk5Vb/jDNJAfiJB4h54JholKxrKZDvKgzY5aU1hBmcSd7T6N1OemvHI5j+TGt/rbise3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125477; c=relaxed/simple;
	bh=qIVtdTroHRxDNqF3QYo6fRpuhYJmRZqnPmGVE0XWNWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyIogGAkyW7ow+BLliV5N99aKYD6hf7CB7p0xbwo7F2NERHTACwkMimPRvLmKyE3hom5KhLsCp4dog5RkVisOLMatKgb8sOeXuh+04MG7oZfK55t3ukwPg9Hm0o6IBFadjbS3VC8wZU8y8Dj/f3RkCxtBg8McHJN7UQbXTa9pW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbNG832s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A725DC4CEE3;
	Thu,  1 May 2025 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125477;
	bh=qIVtdTroHRxDNqF3QYo6fRpuhYJmRZqnPmGVE0XWNWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbNG832sOYzmhMYTEJlhgbh75PDQZuHwKWlgLpoSCA3IH6i7la7b6OpHUhVwp9rJH
	 yx0bkbO0yxdxsMERREDpj6UfMbYQ7ZjuKpAZhXYh+j3MFy5cf8GeQWXv7sFxJD6rW7
	 Sayhk08qs/XHOsYIpHE4QB5GYzga2eIXNV9wME8R4PfwI4XLervvLHDITaKat+TEg0
	 XsLMADCehocnweg42HsdnuzK4qhs8KaFUQ7DPkyDfTfH0+GoiCTnf/9XtKw7QbDwf5
	 /XImqt9fUS8Q16IosItuCrNaEEcv0WA+eD2OIS9kwcRw9+FJodxwtIKK7g49RDI55l
	 NBrl8sxWjP+2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 06/16] xfs: validate recovered name buffers when recovering xattr items
Date: Thu,  1 May 2025 14:51:12 -0400
Message-Id: <20250501124119-c582d11eff874e4b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-7-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 1c7f09d210aba2f2bb206e2e8c97c9f11a3fd880

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 9716cdcc2f9e)

Note: The patch differs from the upstream commit:
---
1:  1c7f09d210aba ! 1:  2ed17884c4e4f xfs: validate recovered name buffers when recovering xattr items
    @@ Metadata
      ## Commit message ##
         xfs: validate recovered name buffers when recovering xattr items
     
    +    [ Upstream commit 1c7f09d210aba2f2bb206e2e8c97c9f11a3fd880 ]
    +
         Strengthen the xattri log item recovery code by checking that we
         actually have the required name and newname buffers for whatever
         operation we're replaying.
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/xfs_attr_item.c ##
     @@ fs/xfs/xfs_attr_item.c: xlog_recover_attri_commit_pass2(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

