Return-Path: <stable+bounces-144253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A45CAB5CCB
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E751636F0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97912BEC5A;
	Tue, 13 May 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQRWmRqS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC5748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162242; cv=none; b=bIbv4SciIsvQDvJ8P1Z3lT7Pm3Yxaf3TUDsU5ttFNkBVgBrfvwRoU8DP2wH334WwfCPIQFucfWgxoN9DkwnOBd0ej73RluVCBEEobQYpTsdsL25BTtwrZQr5VPIvOjpvDl7siLYVa1koDyx4DpN2vanijZErM66gg6lRuRZ5vfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162242; c=relaxed/simple;
	bh=XFC2N0Q6Sx6JCWMwXUX3cdyB/Trzrv3EO6jg1XUSP/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdz5Dxt8usUJq4ix6TwVG0VAYnSD2wi6SuyEA97u4+XyBUrZwPrWfAUR43+E4j65GCvJyzQl5CqKj8q3r4Zl/wbRewb/bK4HxOPQr0oFXGnO8267GQf083kRiL07tJx6za628XyJK5Rvnkm2r5mTC1yYLg/MXFmW+SIzgmj/UdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQRWmRqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCFBC4CEE4;
	Tue, 13 May 2025 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162242;
	bh=XFC2N0Q6Sx6JCWMwXUX3cdyB/Trzrv3EO6jg1XUSP/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQRWmRqS9/bOaw/xBwW3MV/LyZQV+4DyuaRNPKB+7HJULMJPwHjrSsh6Qf4rI+fa5
	 VCq2C49+1mhcvxC9tf80xXQkFFI/t3B57DjahXJLEZQ6r96wxb2Eu6FDy+71UKtUM5
	 SfvDtGx6vZ3GrX6VSJ1JUze9wKY4cFgGY8r2NQxQyeTRzgm+l1lFzLpOZBecNYZw0u
	 IL7vDhHzBCQA4Jz0Wwo31LqkLdd9PdTlKBTRvSjRYfi1v9vlGbl1CC00Bylc91G7zQ
	 Jwxv2lTXeqfVGdV67iDs3PzloIuFRF9CPIJCbG+Gc+13jKZNFRRwYRXSlLUjhsChNR
	 tQWCo2NebNHsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] wifi: cfg80211: check A-MSDU format more carefully
Date: Tue, 13 May 2025 14:50:38 -0400
Message-Id: <20250513073412-9a5ca8776bf0431b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513020642.3361140-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 9ad7974856926129f190ffbe3beea78460b3b7cc

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Johannes Berg<johannes.berg@intel.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 5d7a8585fbb3)
6.1.y | Present (different SHA1: 9eb3bc0973d0)

Note: The patch differs from the upstream commit:
---
1:  9ad7974856926 < -:  ------------- wifi: cfg80211: check A-MSDU format more carefully
-:  ------------- > 1:  33a029c3b922f wifi: cfg80211: check A-MSDU format more carefully
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

