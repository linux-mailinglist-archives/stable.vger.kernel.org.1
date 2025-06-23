Return-Path: <stable+bounces-155278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF7AE339B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644C71890459
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731331A08AF;
	Mon, 23 Jun 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv65u2NY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044619E7D0
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646012; cv=none; b=fai2ilEmdmEwjB/6ZnQDkz1kMXHQzDw7Kt0vAhVQGV8tckB2GA0OQzFkr8FLlThR2VJ9/8tlEigia3VvbFVxLBHhKKge9UrmkpbgE5Xj3lsTNGUqSMRXJIeXAcgVmpAEfp5pskUGBg2g7U1KtgXagpUOyK4LfUithIhgoeoHhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646012; c=relaxed/simple;
	bh=1pbbc8WWkKmKRLhtTwFLqOiHOhIyEINwOjv2aVVSFjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a93ZOMggi3NsP3cMMtudxrYM0XSsVa1t+22sIAdkFhEYu3zzbehXkEXQumTOlOsN5yEMfX2KJv/68Hc0hM7CoWxJ2lsfKgtesDy4BhtWueTISW1k5viWWglpeEUjJz8zX5Jy9pYPdzLzWLMxoSKBNsj7q1QUnuHRax58M7ppKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv65u2NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08A9C4CEE3;
	Mon, 23 Jun 2025 02:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750646012;
	bh=1pbbc8WWkKmKRLhtTwFLqOiHOhIyEINwOjv2aVVSFjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bv65u2NYeJS02m16R7m2ruUwQrXzsUujbbzMO1Uw/h9WFZAKHIyRUr5aA2goWZ5I7
	 az9kM/GO11fugug/2nJ9IiZ/mIKlvGH33x72nOa0g+AjVuJLiclqdl+W3DXdtwcLMy
	 fUa+YdGefHm+79161qCR767M2QRovX+1Wbg2+vegKkplDXlhGVm0A6gwDYHaV/twde
	 nGzTN6bp6XkREHAWoPwv9h829QYnqrvwA/SL0LojBdSyzx5Ry13dl3INcPf67y41r4
	 nZQTTyK6+jAkx9ARmeHjPQsmyCzDg5YP+cDROSiDlV44ndYXqZhqcvdxxVao102mxR
	 wbhPdq6oOIoWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Sun, 22 Jun 2025 22:33:31 -0400
Message-Id: <20250622222700-a88cf130e3158b9e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250622163439.22951-3-sergio.collado@gmail.com>
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

The upstream commit SHA1 provided is correct: f710202b2a45addea3dcdcd862770ecbaf6597ef

WARNING: Author mismatch between patch and upstream commit:
Backport author: <sergio.collado@gmail.com>
Commit author: Nathan Chancellor<nathan@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 9614c82c0ba2)

Note: The patch differs from the upstream commit:
---
1:  f710202b2a45a ! 1:  0082cb149459d x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
    @@ Metadata
      ## Commit message ##
         x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
     
    +    commit f710202b2a45addea3dcdcd862770ecbaf6597ef upstream.
    +
         After commit c104c16073b7 ("Kunit to check the longest symbol length"),
         there is a warning when building with clang because there is now a
         definition of unlikely from compiler.h in tools/include/linux, which
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

