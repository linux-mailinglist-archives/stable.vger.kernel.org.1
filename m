Return-Path: <stable+bounces-136746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6CA9DB0F
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046844A3DCF
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93413665A;
	Sat, 26 Apr 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8dRvrvm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0DC3208
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673773; cv=none; b=g913fVvRFA7brsGz2QgaWfrNlFouUtcZbRe/orv4pbTiHN3nsaCeWDowbvLmg+o8IPL34pVYH5Q2DQhxGt/uLYXJ9coZI8NAtGVjQX5Lw4p5FpWQSQhvTLgLMU5FUh7CanLROoVowgOghn5KXQnMnPLf/xGntkAI2TEdRGIx46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673773; c=relaxed/simple;
	bh=qM5PShmJ53LngAUEkSeCxHwuXjWLshh1Ls9W/C+v45A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMCGWU/jLJoK9vK9IkJGPweeI8EIN3INF1933balgpdCTx0W0A7uoGfIpFgD38+YKAy2MZIo2tL1ISb4/6IvIbdVhmtKop7ZmXfzgIG/NcYj21n9DYHe9NIZX28WWBN9iuFdIjWEqH70nwNbAhj2dfbI5qhTs2uS/tSpYzaZDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8dRvrvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063FBC4CEE2;
	Sat, 26 Apr 2025 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673772;
	bh=qM5PShmJ53LngAUEkSeCxHwuXjWLshh1Ls9W/C+v45A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8dRvrvmbVG8f+TkxK7dn9bfpoZj4ZEjTqdKFSBobvORZfNKUdy0YGG0cf+HY2+bf
	 42eHZyfzoglZR9Ljl6efbfvYVILZBUIoWG962h+y80p98JgLHB//DY6AD3I2kS0+w0
	 PstEtuiLJQCbPob+5gTba/G6Tj4jL1riBu3Fg3srx99aD6+f0GGCQJ91d4kHy4e3hz
	 unyOg7PE2LX49dyokgEAT0/hpHg587U29TTIK3MZvkHhHVPVifNMYXnBLlRMGY70//
	 C6GcQw/9QX/LFz7yYf8/hHANgTkTsEqe9q0xuDJqrKQK1CjkRoRoME1/d9NpRe1VJI
	 Q//F9Bp6pMsNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] iommu: Handle race with default domain setup
Date: Sat, 26 Apr 2025 09:22:50 -0400
Message-Id: <20250426022941-bd72e35a743b6f45@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <e1e5d56a9821b3428c561cf4b3c5017a9c41b0b5.1739903836.git.robin.murphy@arm.com>
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

The upstream commit SHA1 provided is correct: b46064a18810bad3aea089a79993ca5ea7a3d2b2

Status in newer kernel trees:
6.14.y | Present (different SHA1: 32ed1cb03461)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b46064a18810b < -:  ------------- iommu: Handle race with default domain setup
-:  ------------- > 1:  c855fb779034b iommu: Handle race with default domain setup
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

