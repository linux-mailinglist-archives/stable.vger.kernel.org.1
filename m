Return-Path: <stable+bounces-145974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2695AC021B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426579E28C5
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11F5D8F0;
	Thu, 22 May 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E51JNprX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AE1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879519; cv=none; b=ChBVMOTeoHfKrw2CQsFjsOfwBgfjwh5exI37wjm5Je+y0glLmXBdtF9FInU9vAaKbXs6Dev0Jok/ykisQXHDu5v67UH+PBMqsh06hMM6mRSPEgvswt5Kk60MFLcRy+ZY7J5MmAVt8bsPoU/KKFQZKqf+cIksANJauVoVpZ4ulJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879519; c=relaxed/simple;
	bh=s7uf0DdsGabI9bYUkv53YNieoY121ZYnUIiTzFgc7V4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlAgv3+g6GFOoQJgGuyjWIDgDc3F/z9cyvfdpVbegdx0l4FXP72X2X49MH65OyvvIRjLMyuXS76HssX7QrOolHdfyC0Bf5RBwDjXD91fNr+7s7kYVkTBuzCsT/U3tvHouX3r6rxGhkeER8Qtowf75Od5rGN7bRXGgG3PG007B6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E51JNprX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ACBC4CEE4;
	Thu, 22 May 2025 02:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879518;
	bh=s7uf0DdsGabI9bYUkv53YNieoY121ZYnUIiTzFgc7V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E51JNprXfm1zgL0QtFLQsNtUac7ZyHTk6VR2Vxdekq34bHXNyRBcAM8Rfbkc4mEng
	 /5HvleTswH92DMFLMsnbfvKjiBbJDYIQ3CLgHN5lHFoHE0uU9rsMBikhv2SUX+kAD2
	 5ttZjWKz65IrFH6nGNPc57jCEzLFYaWcoOlhj7LFd4+v9axkraasInmHZoBFvCn6tC
	 wRgFjBiI6MEbs1ImuXPxh5YbBteCfhIJRhXi6vZHk99FDJGmqJYb2dyjo3xtHRla2M
	 ifIo3fHgSwvXh9dllf8jk4bs3paoluu4VLUcDJVXHW4amzwhOe3oZGw0hweoGw8KqK
	 OJT7cbODBRV3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dqfext@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 2/5] kernfs: use VFS negative dentry caching
Date: Wed, 21 May 2025 22:05:14 -0400
Message-Id: <20250521153515-db10a87d7530ea53@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521015336.3450911-3-dqfext@gmail.com>
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

Summary of potential issues:
ℹ️ This is part 2/5 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: c7e7c04274b13f98f758fb69b03f2ab61976ea80

WARNING: Author mismatch between patch and upstream commit:
Backport author: Qingfang Deng<dqfext@gmail.com>
Commit author: Ian Kent<raven@themaw.net>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Found fixes commits:
410d591a1954 kernfs: don't create a negative dentry if inactive node exists
df38d852c681 kernfs: also call kernfs_set_rev() for positive dentry

Note: The patch differs from the upstream commit:
---
1:  c7e7c04274b13 ! 1:  6ca146f13dc9d kernfs: use VFS negative dentry caching
    @@ Metadata
      ## Commit message ##
         kernfs: use VFS negative dentry caching
     
    +    Commit c7e7c04274b13f98f758fb69b03f2ab61976ea80 upstream.
    +
         If there are many lookups for non-existent paths these negative lookups
         can lead to a lot of overhead during path walks.
     
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

