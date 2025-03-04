Return-Path: <stable+bounces-120385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF5A4EFF1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 23:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2E63A35D7
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60825FA14;
	Tue,  4 Mar 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chX9JSve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4431FBC98
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126437; cv=none; b=Y6RYpMZHR6wqqS8Xo8qGUAq9BobjhODAX0OvDS//B8z4zae9zMncdLCB8KZ++/s6NQmD8ipQBwM7k2AWz1M0SKCpn1c47H9XJtPbeI5cK78J/gO+Yodv8qqR8s1c3lNV25OiEC/W3iq6boLJpcucM5RdmmEuFibZaDge795SJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126437; c=relaxed/simple;
	bh=SkO/YYssXveLC+U3a648H/0EcVkiUI2GW76/rUJBAqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAt5HK7Orbo+8VyMFCiqMtGLGqD6IOsDVONuqJJhL0Zn+xG5Dy842r+ZE6spyHKOBA8vgbsVhA/+4FGSP9iHCJbJoZezOSqKdESM2ns5dwD9UzRcC1HS0DPL61A3wwdsiIWR9a2/+KD8KyM2UY2jdL4KXPSrhyIyCys31fca5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chX9JSve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2AFC4CEE5;
	Tue,  4 Mar 2025 22:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741126436;
	bh=SkO/YYssXveLC+U3a648H/0EcVkiUI2GW76/rUJBAqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chX9JSveuDmE5q+eVSQfg7qHM1t/Iunu2POonCrlGMNMZVYKHY7OEhPf3UWHXQ3fm
	 1Aae6rlt43OV3+yPKgomPQJO5UoGwC/BeRg4+QHYY3oESKrZZqBSBVjS0gCiySKGYq
	 F4GsVBzUuammh2534n+ZY24U3YLhQ18hFPL7Qegnto3WKuFFVvITEUOsrrSI53nSE7
	 imZDb7DvDQaSmKx0gQr7yQ8BXKZ81yPZWBN/GHUrDua+3KBbkNtDOsFmv880A60ML4
	 YqrluWDPPoLPkcP+DIWj1/fviWL3VKkR0yThrO/sJzI4rjgkhfIx8JriNb/tHkQ4JV
	 eyOIN5b1BNVVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: mediatek: vcodec: Handle invalid decoder vsi
Date: Tue,  4 Mar 2025 17:13:55 -0500
Message-Id: <20250304134916-fc19c2b396844f26@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_636B6A9C2718A3062A5AAA1AB18F61C93907@qq.com>
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

The upstream commit SHA1 provided is correct: 59d438f8e02ca641c58d77e1feffa000ff809e9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Irui Wang<irui.wang@mediatek.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 1c109f23b271)

Note: The patch differs from the upstream commit:
---
1:  59d438f8e02ca < -:  ------------- media: mediatek: vcodec: Handle invalid decoder vsi
-:  ------------- > 1:  033090249f179 media: mediatek: vcodec: Handle invalid decoder vsi
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

