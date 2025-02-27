Return-Path: <stable+bounces-119792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D81FA47507
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED27188AD88
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE9F1E835E;
	Thu, 27 Feb 2025 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/1evF8K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5853209
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632901; cv=none; b=TmbYTzRMbY9RhuQG8LqzT7olGdAcuMbeViPU/DPYkgt5nHvd5gAbABUqwxNCB4FfrQVzUyhQBpDj+fCgvlDigLhCvLIt5o43Aqsu7BR+WdfX/GcoGj/VGUlfl/19PW0pI/PL4vR4OVXfylnP37QzPlZxRsq+DXNN177JsN/GQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632901; c=relaxed/simple;
	bh=TP4ptDc+ri5zT8bHlJo7+xtLIh8CCWYJN4e/LEPQOhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THMaPqHPrDzM8ipUFX2ap5RKYefg5dkOpfV8gSgHYFmDKKd1CCNu9uixVHC/aZETvpVzl5oyxDURCAMEFiczd6uuJFgs6U8ErPbmWAW7IGVHWbXmaY8qw/xqhQ3+9wVdWs25g7+sYdShoPNY7fbEYRlalvs/1K+G34gtOOvsUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/1evF8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499BDC4CEDD;
	Thu, 27 Feb 2025 05:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740632899;
	bh=TP4ptDc+ri5zT8bHlJo7+xtLIh8CCWYJN4e/LEPQOhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/1evF8KWG72aljP8GbGn56Sm53FfGT28zKr//MSep9EgArWzpEMGoUsjl92z2aKW
	 dDv206xCFF63XxFMSM5XOKh573huB81xgOht7/3djOe/0SwRFHcvJGesEtzXyPr9VU
	 n806tVhORK6mfepSLA6h0FuhOBxBZwT0crEkvOcOxi7Vp7pwBVB4b+S8LgLv/FIHBU
	 oVA/rNm4IK5LTCfQXM9fXHGzTzMc2lxzflrV1LYCMUvk+/YnWA/KnLb8H2TZ0fdWU8
	 24LDZmUa5kzQ1ebhzDF0iwPa2wXE2un05tqlQGh8Uo0kh00kZlfadwWI6EuwKWxxsy
	 gszMKSIV7uOkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	konishi.ryusuke@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 5.10 5.15 6.1 3/3] nilfs2: handle errors that nilfs_prepare_chunk() may return
Date: Thu, 27 Feb 2025 00:08:18 -0500
Message-Id: <20250226164725-d6ebd3b5ea822c39@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226180247.4950-4-konishi.ryusuke@gmail.com>
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
ℹ️ This is part 3/3 of a series
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: ee70999a988b8abc3490609142f50ebaa8344432

Status in newer kernel trees:
6.13.y | Present (different SHA1: 481136234dfe)
6.12.y | Present (different SHA1: eddd3176b8c4)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ee70999a988b8 < -:  ------------- nilfs2: handle errors that nilfs_prepare_chunk() may return
-:  ------------- > 1:  4477ef0e62101 nilfs2: handle errors that nilfs_prepare_chunk() may return
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

