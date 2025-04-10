Return-Path: <stable+bounces-132153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181EA848FC
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A192F9C167B
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACA91EE01A;
	Thu, 10 Apr 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g508rPi4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1371EB5D8
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300441; cv=none; b=Pn6hZQh1McPEYqYdUlTNSlzJEc/5p18JRjV8HrQNNfERCtl98ah4NoMkkFkQ5JXrIl0qkMJndynEvQzccYCQlGii2YVOkjzne7YuRsXI3ESpiI3UN93cs3X9ZsGH8c4986BHBUKjQF8y5naOvSrZuN1gC88v8L9SpItMV+HAhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300441; c=relaxed/simple;
	bh=PlD/wdYgygFC9PKpiwXOm9dTmxKLdR+R/L8gQAxiqSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT2J1nGw2jY/0HzbZDbknIJzGXK8k4CC+dn8yv3rclNX9NYzU74B5CNb50roAGy+iCCzpVv1B8y5Lof26eSRfBW5FQSIc4wFl4W2dM8RqQjNGcj2ERwvgIG+0yVjDWd+kTvvas8LkIbb9sOpBaHXvldN/DnnJrDx0urcBDyBYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g508rPi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2709AC4CEDD;
	Thu, 10 Apr 2025 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300441;
	bh=PlD/wdYgygFC9PKpiwXOm9dTmxKLdR+R/L8gQAxiqSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g508rPi4bzPp9PTsR8wat8Knf1RowEd5R+8TB9lehuRfIcFClg67CbtHX8Q8ZZrAK
	 4KI+4M/XXtdxWGDXXhDIpJ+3aOyCpk8Wy0tJLL0MWoNtsgaL2ZiknM2kk/jm8sSbxF
	 mwpzS7DbHuCKe/1ntzexbWn+8749Fa2EKC1BeBUTbdc5ZAG0m+u7NmZdELNYfXst29
	 6m1CbfZJxggJb1R4aY6HjcgqQxkg39S7ebi23MxyvFlP6TJMsHQ/RkmT7LL0UjE88N
	 E3JCx5sRGfXrdJebBNjAuJ8beBCP34PiMd6d4+IWOau5AtrwN8by1d9TcjKBzN6UuW
	 eio7RUPUYiK+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
Date: Thu, 10 Apr 2025 11:53:59 -0400
Message-Id: <20250409234023-5224c764062a89b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408032456.3437393-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: a54f7e866cc73a4cb71b8b24bb568ba35c8969df

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Hersen Wu<hersenxs.wu@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 8406158a5464)
6.1.y | Present (different SHA1: 3300a039caf8)
5.15.y | Present (different SHA1: cbf91c4598d2)

Note: The patch differs from the upstream commit:
---
1:  a54f7e866cc73 < -:  ------------- drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
-:  ------------- > 1:  6b1d07d8ebfd3 drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

