Return-Path: <stable+bounces-144420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF2AB7681
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C169179210
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D712A295511;
	Wed, 14 May 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNcdbi8s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96767295503
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253598; cv=none; b=P/w7d+HK0CGEx7kCHifOIpF5gy/oCSX4t9JJqxV1P3AeuEazASi0FykINn2JPw8UrwuCrttsLIy7vnqbdVSjYk6zw0iaIAF2bzdVsQPM8O1yf86JooclWQrCaysXkPfdHbRVZA/NJW3SKgQ0Rbi1nIIHJfHHR6YE+2DXtTsUc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253598; c=relaxed/simple;
	bh=QDV4ACbQk+/MbHKujr63MGl+Ihwr+7eKUvw1FbUJVL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUyZ7lkXySRGD+wfmA/FTthnB70xSBfynwuSzl2l+m+HvK00QcCJKxJckWGNsbp0unmLSsKOqdAsD2dHUsZv0EdKppI0SWl4bn+3oaCzPqQhr1tU9Tkn2fgv2oaqBU+TUJr4HL/W4X6LSZCcJSWsgWThyEBPgaNewlz3VhX5ts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNcdbi8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF52C4CEE3;
	Wed, 14 May 2025 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253594;
	bh=QDV4ACbQk+/MbHKujr63MGl+Ihwr+7eKUvw1FbUJVL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNcdbi8sJK0ES04k6gA9fCJhI36QtoC7c2tZtFprBXMqT8Lu7I5PJiQ2Onx+RFcUc
	 BJVy9RokD04RYFJFjReM/8sQNKVOhN44vmLsNl3cpcQi+e/fjua5jVLksUGYNlDttZ
	 IyYZ+HpYMb9D0D4Ewvs/AmqBBmPHDsCs08IZ/13KjCREzwMT+YeLRd+t3MH1Sn/VuT
	 J3+Phx7ZeALfzGlHrK+wjXWvOfkm7u9B3jallaH0aklvjrLy2kPkl7QTNnptNDtza6
	 O3aTxN7SaULKEyY+z5AComLJogUNSwXlMcve/K+LpqXf4OLqC2Aab2eurK/6wXiIKN
	 zcDhjw3jAwTbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] platform/x86/amd/pmc: Only disable IRQ1 wakeup where i8042 actually enabled it
Date: Wed, 14 May 2025 16:13:12 -0400
Message-Id: <20250514095114-301f15bfb9f56bf3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250514020632.387957-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: dd410d784402c5775f66faf8b624e85e41c38aaf

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Maciej S. Szmigiero<mail@maciej.szmigiero.name>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: b25778c87a6b)
6.6.y | Present (different SHA1: 5cc621085e2b)

Note: The patch differs from the upstream commit:
---
1:  dd410d784402c < -:  ------------- platform/x86/amd/pmc: Only disable IRQ1 wakeup where i8042 actually enabled it
-:  ------------- > 1:  d10815aec89a2 platform/x86/amd/pmc: Only disable IRQ1 wakeup where i8042 actually enabled it
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

