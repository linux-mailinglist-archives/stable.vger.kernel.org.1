Return-Path: <stable+bounces-145958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2857AC0206
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31009E2695
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2D2B9B7;
	Thu, 22 May 2025 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1WZV3W7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B551758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879457; cv=none; b=Vvd8/FEfMqAkTRiKE1Q8KmxaAVJnCvDcZRzUzmElvIPcb1AGZ5sSrjo3e1yQ+FAZUcPZuv2jLBPGt31bv3JCym3pYNz22kCi8igXPAz9SRdVlxr/x+RT0bzviP7mCuWobGUwvOdjQrfzdtgyxq8WKRtGmooszNYfblZGEK6ZAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879457; c=relaxed/simple;
	bh=kRsW24jjvKNtOlhF4Suybm8UIz+P5QMFCsTU3jn+6r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKqbdySqVr+66RWotGJFy0ww1WuC4aaiGTtW/xQaoyBsbzlUW8NJrjLD+cLdRLK+ZCOV3DLbt08bD1HoQjRMeL8gB5iTMqq7UT9O/s0lAKh7IgkVMlBGGViQq/nGF/PefmJXz9jwBJJLklT0BlXuz4z39mInumz3t7LbemWInUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1WZV3W7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7ABC4CEE4;
	Thu, 22 May 2025 02:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879455;
	bh=kRsW24jjvKNtOlhF4Suybm8UIz+P5QMFCsTU3jn+6r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1WZV3W7LIsMEo9rf+cIrtVGux1aaJnStm/fu73sQy7uckT8LHKG2zPBCT9HtZhDk
	 S6Ikutcp0Z192s6QQIex1j+O2+saO8XefxizZI96tkUo4tMZdbELDmYRFC9DJ3LYwu
	 OkR0C2gbrSHh9J/Ji7G8nFPehqspAOAhf1HksEQmphjHv49KaHtlWAulZK0pfOE6f3
	 0MmjmrtmxGbVAyTQpRfl5cb1uM4t2sOOjsdBedMxxmpl0yiYKoT1GO6uqrY4qGgx0M
	 EQAtv9P/0eBgriXFgopvZZFyDH3a1f9DmItH0iOu74qcl9sMPSdVAb5mW/E7ocURQK
	 px5qBpGaiH8ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 02/26] af_unix: Run GC on only one CPU.
Date: Wed, 21 May 2025 22:04:11 -0400
Message-Id: <20250521161150-533f63d7769e9e37@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-3-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 8b90a9f819dc2a06baae4ec1a64d875e53b824ec

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8b90a9f819dc2 ! 1:  5a28bb0004cb3 af_unix: Run GC on only one CPU.
    @@ Metadata
      ## Commit message ##
         af_unix: Run GC on only one CPU.
     
    +    [ Upstream commit 8b90a9f819dc2a06baae4ec1a64d875e53b824ec ]
    +
         If more than 16000 inflight AF_UNIX sockets exist and the garbage
         collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
         Also, they wait for unix_gc() to complete.
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240123170856.41348-5-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 8b90a9f819dc2a06baae4ec1a64d875e53b824ec)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

