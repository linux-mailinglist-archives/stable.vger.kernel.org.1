Return-Path: <stable+bounces-127682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32128A7A709
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E56C7A61D0
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C2024E000;
	Thu,  3 Apr 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYR9xEbg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE6223708
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694716; cv=none; b=rB6mYV94bbqL3a4ykoHgHsp4SKZomDO/xER3LV3DzwPMxPNAyleIKhU4ogG+svLhEr8bcUaiEqiIu56c5NxSr4PLCaTP+60cImGDjCvRPIzJbJcDg1jRscvv7WGjNUZfBvlXwbht2AX6CRCMuC9BC2AWOwPjPR+3Wvarmknw1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694716; c=relaxed/simple;
	bh=Se0R1BUtqVb1qs0h/P0tt+4CzrtEA5CGiQsgwZ9DBxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlPViehfAKG6m/HlbTGtBSQjXjfko4AAKOW6RrrIosEloHD1Mn0FM4VX5f/dQhvtaCSXSdVGFHkBhRhLSydYDaobrBC9IYqYcU3c/8OVs0GYsv271rq8brJJ8xiMDbWhpmTaob0VzGHcJ4cNl+p3ErvlsaOY1RLVOwwiKe/8M5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYR9xEbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5F0C4CEE3;
	Thu,  3 Apr 2025 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694715;
	bh=Se0R1BUtqVb1qs0h/P0tt+4CzrtEA5CGiQsgwZ9DBxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYR9xEbglRX+QYZU4h2oapXZSXUEM1NjP9d8AHOaAcY8j+njbIW05ISCNjHaLLnmX
	 NQzrSk60H3PsiiX0VgNsIy9xJYumVklw+CSsSj/QrXtSf2wgE5hhXehxmDgUP7eTxo
	 Fe9o3OCGfxhFITQk2GZRA0IYYzj8ypuERWRMrFTQChjmFZHx//avSM15w/Gtf0DvIO
	 6ubcZm5ZBFXwn4U6FRzpLMUkGgrLwQCP9OuUqBeix4+fn93V/3YPQ0ZyAGLPJJDke+
	 Ikm7EhDjtAgbl4CphtCBQL7ZqZbnElIHJO7bOMLsSRZ9+60UTx5XChVdUd8xst4w8Z
	 HlumpHTeoAkIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 08/10] KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
Date: Thu,  3 Apr 2025 11:38:30 -0400
Message-Id: <20250403110634-167416a09a632a75@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-8-30a36a78a20a@kernel.org>
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

The upstream commit SHA1 provided is correct: 459f059be702056d91537b99a129994aa6ccdd35

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: d2bee9b77726)
6.12.y | Present (different SHA1: a504f87f3a50)
6.6.y | Present (different SHA1: e9532540dae7)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  459f059be7020 < -:  ------------- KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
-:  ------------- > 1:  0c935c049b5c1 Linux 5.15.179
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

