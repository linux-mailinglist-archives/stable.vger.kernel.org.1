Return-Path: <stable+bounces-120002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F22DA4A889
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3D9175898
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8181519BE;
	Sat,  1 Mar 2025 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiEf/Q7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB952C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802885; cv=none; b=KjnGsAD/TrM7CiWiCaP8PfntMgb0kW7WZhQCkGt4FZdCrQXtKI9xb2eHlmJmqpp10fohhkhKhSDYFOFpEUq/vrdbQPV23J13CZl1fp/Z5lKr0+mTZPbNXW0IWS1tbTIi/hqcV9KqApxrAlje0sJU9AIe/tT5/OZHDYY+y8OlUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802885; c=relaxed/simple;
	bh=5tklinKcD33+gMkI7M0I2E3le2jdr7Qw7JbmrsgUIQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqBSUReV5zM74J71e117Rl3YVCKkVcTvmudefii9dKCaJ7aZNpWppyYZ8Bpc/7RATz4fqn1T3OlKT3i8b7nj18DZJY8aiXlNCMrz+xHgSVBjifoooUKouZv6IhBBnfB3TMH8q/8mDtyKJL/S6Ur1R5my4B4pc11IXCuErqmKfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiEf/Q7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7350C4CEF3;
	Sat,  1 Mar 2025 04:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802885;
	bh=5tklinKcD33+gMkI7M0I2E3le2jdr7Qw7JbmrsgUIQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiEf/Q7VKP1I/HZrHZ4pHWNCG3nz90DSr2Kqg/jcnUCeLOJblqxFzkEILp7CPtWQb
	 yszzXEXjk6183d1IxTmU08tRv0QOw7JeJq1P48CyRV2zcvaTOsU2xtum2093TCNVc6
	 noawJLgkm0mAETru2mkziKjLyYkBf8wd7qTe72ggCaK68jQ5DSJYyKVMMYvMHq8Zve
	 LaVm1KMR4W75lBbpMp+maEYC7BdU2bvSDkFJ8H53vWap481Ir513hfTHJilWiKFF0+
	 +ZZCYbQZk8ZvnnXHTu1tWceOL5nPTyMApsxgAhmLncLIoaFvGQ6uRZXZGL5gnEHt9r
	 ZVLzqCjvwiCRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	apanov@astralinux.ru
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted images properly
Date: Fri, 28 Feb 2025 23:21:01 -0500
Message-Id: <20250228184635-1e841747ce26207f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228165103.26775-2-apanov@astralinux.ru>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexey Panov<apanov@astralinux.ru>
Commit author: Gao Xiang<hsiangkao@linux.alibaba.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 1bf7e414cac3)

Found fixes commits:
1a2180f6859c erofs: fix PSI memstall accounting

Note: The patch differs from the upstream commit:
---
1:  9e2f9d34dd12e < -:  ------------- erofs: handle overlapped pclusters out of crafted images properly
-:  ------------- > 1:  8b40df2f9aa65 erofs: handle overlapped pclusters out of crafted images properly
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

