Return-Path: <stable+bounces-146008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E1AC0241
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B60A87B4962
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712353F9FB;
	Thu, 22 May 2025 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVOg57yT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C7539A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879697; cv=none; b=Q7jvVunfJIurLOBbmCTBQk0yORz+dSqMLLkm8Spad0PY/SFK7VJ0TV6rE7egci0wz7Ad4xs1uBwzFAYuoE4zPcLgT9nFbWDFonuxgz/8wiiNJ0fXxO1+yksDWWwd/y01mjk769k4wyt8EbW3ZQwwX2hBo3MGiY6eoaxatDAFeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879697; c=relaxed/simple;
	bh=ceXahnNnb1PKnq6GSmR6F2RGYFkN2jx4P4lngTeiW3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIiU66vjfcMIVSAKvp6xjfySPAxXF5BDcOtcmFO3nYE2SCT/EKGx06qxN1zorZ8gAqnbCTaxO4FPrQUpX5ZdsQHK9lrPK52oq8sEHWmlvyqF5kFxceTI/iS1smEgAgQHp6+xnO3lalFVQuFIzGb4JI7ugAcoU4BYjQEp/1rcO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVOg57yT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989B2C4CEE4;
	Thu, 22 May 2025 02:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879697;
	bh=ceXahnNnb1PKnq6GSmR6F2RGYFkN2jx4P4lngTeiW3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVOg57yTqIMoh+t01AN+Dt7cIsUQa20/UmtvV/MQlG54/bpEnhax3sd8BmUVTA7M6
	 DTtQQqUTlfQG7eaOT1gVsvXyLokLFfJ1KAtoMxQ31hd1XSrMnck/rzw95ntJ5k9PO7
	 mrXz4voG+jUcFsxmiFsTYwo/PDBYgLfmcZJ67sbhf9nup1Sjo2/Rs8MY4ZcsouMbku
	 qjIcVq7kxbd+Ro5uG1BlL8hpxhwOiJ/KtUV26o2n13kEMAg/0DffONUjXfo/hzEgsE
	 7fP8aC/E53wbCmB+D0FdpNGM5GGIv5roFqgHApEqS/kvfDv7x+zEN4SlbshxntdR7s
	 boIU6Elb2oFnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qingfang Deng <dqfext@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 5/5] kernfs: dont call d_splice_alias() under kernfs node lock
Date: Wed, 21 May 2025 22:08:12 -0400
Message-Id: <20250521155203-d448a6286c5d83d9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521015336.3450911-6-dqfext@gmail.com>
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

The upstream commit SHA1 provided is correct: df6192f47d2311cf40cd4321cc59863a5853b665

WARNING: Author mismatch between patch and upstream commit:
Backport author: Qingfang Deng<dqfext@gmail.com>
Commit author: Ian Kent<raven@themaw.net>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  df6192f47d231 ! 1:  fde730faa2db3 kernfs: dont call d_splice_alias() under kernfs node lock
    @@ Metadata
      ## Commit message ##
         kernfs: dont call d_splice_alias() under kernfs node lock
     
    +    Commit df6192f47d2311cf40cd4321cc59863a5853b665 upstream.
    +
         The call to d_splice_alias() in kernfs_iop_lookup() doesn't depend on
         any kernfs node so there's no reason to hold the kernfs node lock when
         calling it.
    @@ fs/kernfs/dir.c: static struct dentry *kernfs_iop_lookup(struct inode *dir,
     +	return d_splice_alias(inode, dentry);
      }
      
    - static int kernfs_iop_mkdir(struct user_namespace *mnt_userns,
    + static int kernfs_iop_mkdir(struct inode *dir, struct dentry *dentry,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

