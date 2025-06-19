Return-Path: <stable+bounces-154760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2979AE012D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B9B5A5D3D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78127932B;
	Thu, 19 Jun 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5xZ7piJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6068278767
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323766; cv=none; b=Yk6j6uxdQW1jCX+h4B+DCOIfSaHt7h0JGCYYfXTdI4MA+WeB/i1EGJ4WXxFszw+l6oMpR6UYCXxbfy51jEFMLNAnWe8bCIMaoN2A4WVcidOAWX/WRoCktY/mKes50sQOcdR2XFNMR0bEbhlZzNcgpm3Jg0ciRpBEZa9PYltW6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323766; c=relaxed/simple;
	bh=60ukE/VPwbTlfFoOAbbkApBo3CsOu4Uw/fUlLucOGH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvbEKLK/Uj4sAoP9j0Z58/wJXhuwaNAHeowY5T7F5sisDPeewasY80rCWkFd8aEb93qfNrkDp+nV1B6kF+DUmI5zAiDSgLZBwJcbOKzwGu3bNRLCvUUoAm1w2d3mdwUXNGZ5gM6onqvkqp3CmXkqhhMRlnoQWQ+Y7C0FATo9gv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5xZ7piJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2297C4CEED;
	Thu, 19 Jun 2025 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323766;
	bh=60ukE/VPwbTlfFoOAbbkApBo3CsOu4Uw/fUlLucOGH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5xZ7piJkhBD2uMnr8zlPl+WqpNNjRP2lIl+08zOuZb+0RflS72jz1aSWcWmYFnyp
	 LKeR4PkcGl1bnOGS+WlXuf3kvdcYGUbWdmsnwGXzZpp8FG1dMOrlYbfK/Owr74Jb8b
	 JcYEMQBkQOrWyhnzmXmsxkptktIJPGXEmnOKOHmYy27IBj7SGdsziNWs01rRgmx6pH
	 T28GaHLa7+bH/2gnd59HNU51Q6LZdK+KJA9eEY5teGLCcOUN7yK0yoB9XkjH7/HtfB
	 PUIFTv9GETJDR2rkwy5z9xlDKSN5qysfsZNuTGoeXhIuL5MTfxuXdpB7YQFRAc0b2o
	 RqDMvrSFvYq6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 16/16] x86/its: FineIBT-paranoid vs ITS
Date: Thu, 19 Jun 2025 05:02:44 -0400
Message-Id: <20250618193715-2cfe996557b3e2ab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-16-3e925a1512a1@linux.intel.com>
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

The upstream commit SHA1 provided is correct: e52c1dc7455d32c8a55f9949d300e5e87d011fa6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 7e78061be78b)
6.6.y | Present (different SHA1: 772934d9062a)
6.1.y | Present (different SHA1: 69afd82670d8)
5.15.y | Present (different SHA1: cfcb2a5affbe)

Note: The patch differs from the upstream commit:
---
1:  e52c1dc7455d3 < -:  ------------- x86/its: FineIBT-paranoid vs ITS
-:  ------------- > 1:  b7b76a94faf76 x86/its: FineIBT-paranoid vs ITS
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

