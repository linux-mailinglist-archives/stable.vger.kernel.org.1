Return-Path: <stable+bounces-167074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69FB2185F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 00:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D488A680310
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2BF1D63C6;
	Mon, 11 Aug 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQkYb/ak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9938DD3
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951425; cv=none; b=ijXxF7+fM0mwlKQO1Q5HTaqn0jvjVTYGmPHp7R2yMuOUZQgrkhLr6XQTCkJ+j0GBJvCA05GKIRJqz/+CFkfeNhuIkoXpUAeOeDn5Khou1TYtvvXquzG1L1FoLFA4d8Ua8ZddHJZlV/EVytn3TUTbaKyGAf5IvLudhIhIisH0ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951425; c=relaxed/simple;
	bh=vLQ3TrBLUyKDSJo5cVlNn9TZD3sU914DhcDVFm2gzV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRjaCBtAu1VqTadF4QWitbz1iQJ1NJeLqHK4L6caTGIFMogxqSQyK9c1hu6nEghDahjB10XsVROLh2Eyotth+dnbHEE/nV22RQpglENBVIar8/4J7VdsQxbfob/AXj1oUynbN2mnRx3XpTIpuQh/5zMjxS5z2pyCRFlx4t81/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQkYb/ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9E7C4CEED;
	Mon, 11 Aug 2025 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754951424;
	bh=vLQ3TrBLUyKDSJo5cVlNn9TZD3sU914DhcDVFm2gzV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQkYb/ak6HJ47BUPgufG/ehAogZ3gdEC+nMoUjaAo/0eJ6NeTT6dlBFcsFZi8nEcD
	 Q+Tbq+Y7L7ssujH4zB/Mmy77Wx80A0Y1I2wa/ujYqzI9t4+Q5LxwIu3Hm9blscyGHT
	 gbShfuuA0JB1WV+adOnx6lfsQBrQq5JnwiSBPTGdgMp4TpcLgYZNKOePt7g7oXs0MF
	 v/sVxdjciRIZdy7ev4JpXEAva+jFiZRxD6e9k7ze5Bki1La353Og8rcjzHLXQtSzEV
	 6A2s66rXFFrWjlur/9ZVOH0W3GjJCNh1ZPsQsShY0335SD1XqvJrlwgxDX00eyc4io
	 lMITWpqIpEQEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shivani.agarwal@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10] uio_hv_generic: Fix another memory leak in error handling  paths
Date: Mon, 11 Aug 2025 18:30:21 -0400
Message-Id: <1754924868-ddff3073@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811053808.145482-1-shivani.agarwal@broadcom.com>
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
❌ Patch application failures detected

The upstream commit SHA1 provided is correct: 0b0226be3a52dadd965644bc52a807961c2c26df

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shivani Agarwal <shivani.agarwal@broadcom.com>
Commit author: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Failed      | N/A        |

