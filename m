Return-Path: <stable+bounces-161431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789AAFE7D8
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23421887C2C
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542082D6415;
	Wed,  9 Jul 2025 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brn/t68Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A02222D4
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060742; cv=none; b=VjEP5h1/Uf8t9qrHgWuwQmQ2A5aO4D42MVWLg3CUZbNJagFx5xtPBQkouakNY78Tp3UbUy9UDcGWd36U2Y3jOd7lPulvrC9p3wLXXCpjoOlEybfICm92YDL4/k7zWiHT3I0OQYfA3faXyypdwUFNEnRxsqrh27L2qwuUXLPCAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060742; c=relaxed/simple;
	bh=Ew4vcXcwo+kD3vhNMmRjS/c40grEphlKHchEnWeAJGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLZCmJW5oaajB03ok5FTCfo2PZ1g4oKteyZxkix/nE2hDwOOvLcLyHjUXzywQZXjWmXJtQtpYMi2jOzKeTfoNd8/3cbHTbThnuwatFs8oPDIxZMDtEQQQtwTZLuFOOsC2xOh31HF1RNXRMgVq5MyGjZ2wyR9sW2koTS111FwC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brn/t68Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA54C4CEF5;
	Wed,  9 Jul 2025 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752060741;
	bh=Ew4vcXcwo+kD3vhNMmRjS/c40grEphlKHchEnWeAJGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brn/t68Y8gDjsXXrmCxziJhd1RnXkMCGaHibDyAMjRsyivMsQmAxKeNFjW5HgH1AK
	 4S1Hw3gC6c47cddLd9DGAKPcJqB25LLXzR4cyI9WM8KY09xhYRvikx9xzHJu1tdwOq
	 X4WMXQpRFpo3ZxHNmGJvwv3122bFEhVpykDnBFifE22R0tRR1ZoQUB3AT4XmHcNJ6R
	 OtSSmyzt3T+VtzLTGVlNChoaR8LobLFLMgguwPgP7qA9j1JczN9Wuc9i4zfTaC2fQj
	 KPGcJMBlYH4uQJM60nVOPMjsDHk0GJu23YJRlSVbNVxAl+epJLhGSbkA0+WLp58Q93
	 DFJmeHlJTM/uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [BACKPORT][PATCH 6.12.y 2/2] firmware: arm_ffa: Replace mutex with rwlock to avoid sleep in atomic context
Date: Wed,  9 Jul 2025 07:32:18 -0400
Message-Id: <20250708162620-e6a471e28262c64f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250708194223.937108-2-sudeep.holla@arm.com>
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

The upstream commit SHA1 provided is correct: 9ca7a421229bbdfbe2e1e628cff5cfa782720a10

Status in newer kernel trees:
6.15.y | Present (different SHA1: 6dd05bec4179)

Note: The patch differs from the upstream commit:
---
1:  9ca7a421229bb < -:  ------------- firmware: arm_ffa: Replace mutex with rwlock to avoid sleep in atomic context
-:  ------------- > 1:  df64e51d4ab83 Linux 6.12.36
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |

