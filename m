Return-Path: <stable+bounces-127691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90201A7A710
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0228F1896663
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F74A24C080;
	Thu,  3 Apr 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEaF4Zad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4C273FD
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694757; cv=none; b=NxACGex6Dei7WeXteVM/stsrmgaI77JfrmET6SrQDc1DBTRZvHrcloyWPXy6OU4NDRrg/IHBRTOVU+Eq/9rmuICDdizt4ymg9V8PT00NQRANdATmqlSZOzQ00YfIbIDk72KHJoCc8MMDLY7uU5+zsO3qfbZA5/laM8bIf6cL/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694757; c=relaxed/simple;
	bh=PVeV1XLBJ5a1s4QrRO+zDq4AgF/BOB9i27fQmBKd8bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCtgoEUL4kYfJB7yBF7Uvmlm5YJ888fOLetd1Ri7CJuzzuMOJ0UHYFp80SMX3YZJ0n6ekEwA8ffkgLli8zI4N8j4+jBfg1mwz9xi0Im572y+05LlnGnM1aqxtSeKYLftqG4Qb5EAMPJyw2Pt98aKZtHMWTWDTujmrSEltOkCX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEaF4Zad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC98C4CEE3;
	Thu,  3 Apr 2025 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694753;
	bh=PVeV1XLBJ5a1s4QrRO+zDq4AgF/BOB9i27fQmBKd8bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEaF4ZadM0mrmofksNlt3DIS+e2QaCIvOOeZ3F+TD1tWqjwRrUU5qI+hzemZE2jfk
	 p6Ux2Ax/GeQgHK+T9C3ANbSuGIXPY7K7gSlmwQXV9i0Aqdq3I7Q9iNYzNkh9KUvdyW
	 Snj1+7YyHGokroqZxuJJt5n73bhDlYXMxnWc5gSCP7Mob6epuWJ8l2J2LltnmeLxXc
	 BYAz/EAHdWoMBHZSD9snEjs6eiHfKvp14RDeaybnehEkUAx7S1jJBKGukm2TBYRw0D
	 ZmzU55FVESZFU2fcuSEYdx7lus5CtMd4a6jUo6whuqV0eEFwQ1hUgKk8hV7Kh5ZeMW
	 P3vvPT1JMrg8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 10/10] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Date: Thu,  3 Apr 2025 11:39:09 -0400
Message-Id: <20250403111822-595adf0e10bd5840@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-10-30a36a78a20a@kernel.org>
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

The upstream commit SHA1 provided is correct: 59419f10045bc955d2229819c7cf7a8b0b9c5b59

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 40c2322aea4d)
6.12.y | Present (different SHA1: 8d069531b9f6)
6.6.y | Present (different SHA1: 57993d5e5b2e)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  59419f10045bc < -:  ------------- KVM: arm64: Eagerly switch ZCR_EL{1,2}
-:  ------------- > 1:  f17d0f270d709 KVM: arm64: Eagerly switch ZCR_EL{1,2}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

