Return-Path: <stable+bounces-111922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933BFA24C36
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183D516481C
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240A8155393;
	Sat,  1 Feb 2025 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIYXl3zM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBF126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454023; cv=none; b=XO7kmVPvt1AoP7c43ucUEPMVveFZRuVrP4SuhKGuL6APFiYBgejY7jMSGtYx2jonodmfoEVbi4fyPfzLkwfZXGtimA4d1LuXKns9PMwWlPTaeR/db2ZgMKReRniqpmeHugII+dFz3jl9LJpFNfH0BgKbyVUxctdBHxeLDFfGSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454023; c=relaxed/simple;
	bh=k3zEiCHDolb3N8urESd56f5SHYwt9SiMjSOopO/Wfvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGHROtIaXlJaK6+jk33EIITvDdmklbpjtymn9gqBNC5H2J+Z6PkwOf/dtgh30nWHsRSZo21Krx6p9GB40lpRtyFelgC50dHFvGewgpz6kP8tNjnXuL6sY4dNUTEyznQ9uEEc1lNQA/Mza3D3oa0GkZGGWp/IUwGG3EWBzTRiTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIYXl3zM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C3C4CED3;
	Sat,  1 Feb 2025 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454023;
	bh=k3zEiCHDolb3N8urESd56f5SHYwt9SiMjSOopO/Wfvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIYXl3zMPsjLmEUFKhf1JpB+pnO2SbeZLBLFOS5UIq0kgCqcL7tDDm6FrTYaIImUH
	 8Wz5tNpfxEsWbK52Nr/B1q3arzrQssyXCOnrA9vocXAOzcDa1j3CvA4xNZyBX0dJXA
	 A69ZN2YGcROUuizUZ1l4GuIcevAldUfmEVd+AZXzpODBo711zokI1qQBBeagJqlBLY
	 gMk8AcIgt1TXrdKcrhd+XS+Pz4Kdc7RrfJS8cPooeH+YtOr8XNfJtNsmfwAfVVJsJC
	 EEoxpIxyUyYxQuEpaWvOskytThKAHKIp1Jk5clTPaDuHqT+tKbN3HdXOkO3VmOKs2w
	 lzcAi/hgliZFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 05/19] xfs: fix units conversion error in xfs_bmap_del_extent_delay
Date: Sat,  1 Feb 2025 18:53:42 -0500
Message-Id: <20250201133815-c22d5dfacb87c191@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-6-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: ddd98076d5c075c8a6c49d9e6e8ee12844137f23

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e3aca4536b6b)
6.1.y | Present (different SHA1: 0af8f29df730)

Note: The patch differs from the upstream commit:
---
1:  ddd98076d5c07 ! 1:  0835e674aff6a xfs: fix units conversion error in xfs_bmap_del_extent_delay
    @@ Metadata
      ## Commit message ##
         xfs: fix units conversion error in xfs_bmap_del_extent_delay
     
    +    [ Upstream commit ddd98076d5c075c8a6c49d9e6e8ee12844137f23 ]
    +
         The unit conversions in this function do not make sense.  First we
         convert a block count to bytes, then divide that bytes value by
         rextsize, which is in blocks, to get an rt extent count.  You can't
    @@ Commit message
         Fixes: fa5c836ca8eb5 ("xfs: refactor xfs_bunmapi_cow")
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/libxfs/xfs_bmap.c ##
     @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmap_del_extent_delay(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

