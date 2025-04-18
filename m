Return-Path: <stable+bounces-134607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD40A93A09
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF01B67219
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B21A2144B0;
	Fri, 18 Apr 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRGfjouV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C0214212
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990970; cv=none; b=n9w55ZZIp8kH2fL8z8S1d5klsRtXSkFesaZZqTAnvSThpOXHXUIMU9BOgKFRQ64+WmKS2V3MGKdPhA47SWlvtTQKLqcQtu4l44umK7aI4C69niNYMb0Bt1MAX42W5JmZmfrVfpK0OmZa9Ehja7tMtd5IJ4Vy2dxgxlcPzFdNWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990970; c=relaxed/simple;
	bh=D2ruA27Sr70hiAJoW3fUQkvY4gzclA3evmevr/Z0ai4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl1W8PyHLDRJFjXYNMV3EKk994ivlffTZMFlnTCU/TkdPKFJ8WdG/plGkS3YHW6aLiYtLD3+BjkAb4rV1siYEbEj17/kEUhSK5tgzPdj3ws407wIhgM9pGQwKlkSo+Hp1yikKnPx1YXDY7a0lObi7z1OmFLEP9mh5F70apFSWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRGfjouV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDCAC4CEE2;
	Fri, 18 Apr 2025 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990970;
	bh=D2ruA27Sr70hiAJoW3fUQkvY4gzclA3evmevr/Z0ai4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRGfjouViyo2uIjaia/NuZ0aZ8PlCL3lcawUy6PD2XGhCmU2iJYM0n4J7yughOM7z
	 tuOsM8rN4gvjr/pmLgMkCwxRdu161/Y730eqTlLkevfVJ9Kk5YYwCOBLhTt53TduY/
	 6KDmugYR28lXRea0Djo6ESILTSSet0GDPUcXPSunqw3J7JXcc1/Rt9MhJJswRODjC8
	 SB3MKOP5bGgagsFFK6H3AUNEnGESVoU0v3uDnkhWJGxmTNavXGLLSTQVpn9ycsGeer
	 gsq/jFFopGbmG69/BDGtAubQZKfVWWPNvWJ5QHhnTpRsal3EzzBavbaNv1d142r/On
	 WzengpZfhT4nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johannes Thumshirn <jth@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 1/2] btrfs: zoned: fix zone activation with missing devices
Date: Fri, 18 Apr 2025 11:42:48 -0400
Message-Id: <20250418090300-03a89e27aa70384a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <5adc66d15dd8aace14461451b9d9668795431fca.1744891500.git.jth@kernel.org>
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

The upstream commit SHA1 provided is correct: 2bbc4a45e5eb6b868357c1045bf6f38f6ba576e0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Johannes Thumshirn<jth@kernel.org>
Commit author: Johannes Thumshirn<johannes.thumshirn@wdc.com>

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2bbc4a45e5eb6 < -:  ------------- btrfs: zoned: fix zone activation with missing devices
-:  ------------- > 1:  abb5ad2758783 btrfs: zoned: fix zone activation with missing devices
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

