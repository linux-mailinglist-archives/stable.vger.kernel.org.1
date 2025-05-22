Return-Path: <stable+bounces-146010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D36AC0243
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C93B4BCD
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FA72B9B7;
	Thu, 22 May 2025 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXxNgpWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F552610D
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879707; cv=none; b=ZMPcQ/zlbE657JejM/RYrtH6lKdh84xKxrbtMKwsuN/ivpJpRlgGNQz8VufgVjjJ3h1kGNU1SG6kBhExV+p0MzdYW9AZ9UQOGYS/dnl6v+OVeRGlwCLwhV2ZJrq1fjFBfcgt29i49uokxVwMeWZPKBpFQgeC/qoYDnLm1LNowqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879707; c=relaxed/simple;
	bh=RcC4n0TRzwwDcwqI5obhsN+rMBJYB6QkL3o9TyzhO1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmn5eoTT0hVZzIboB/BYKsp4OOe59lU02PheODVmDgDcF2IK5xI+m6JHM18dqQfp2JvhLiazr3dls2wmiBYD532uMk3d0a/7ta1yIZttOfIwnnl4IMjcQXJiLKdVSnrbw4RMqPcxxaZsXF5I7T7PndFg0SdaFSdlUTBEhiOqlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXxNgpWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9081BC4CEE4;
	Thu, 22 May 2025 02:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879706;
	bh=RcC4n0TRzwwDcwqI5obhsN+rMBJYB6QkL3o9TyzhO1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXxNgpWo936Q0GEGy067teUbDNOXtxc0TssIvcKSQBMIuk8Eawrn10zJUvVlv3B0O
	 BKg1aNpdbddRtQo+yd9nMCCqPHWBIDd7ZmpE/uG//Z3/tLrl3mTFlpl6o5G1qS6YEi
	 BjEJ+BUgOSu9cjgUzmURP8r9gd9AC7cz4SumN6CfsNrGcS4cpBIK7RSdALUcMgh0DL
	 XKJ7CDhTMLwQq0eOOpr1u+72nv1txS+0+en04KaGY+v4Sx5FcUWvni3Q4jwS3zgiVm
	 thXP1JQgyil4I2ZC5gVvMCg2s9HMNu7LnrelKYLPTqYAIO9i9k/rMlBGMWjOURRB6I
	 OtB5zkjTWXiug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 03/27] af_unix: Run GC on only one CPU.
Date: Wed, 21 May 2025 22:08:21 -0400
Message-Id: <20250521191345-12a3f04f463a4667@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-4-lee@kernel.org>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8b90a9f819dc2 ! 1:  0a69126a52167 af_unix: Run GC on only one CPU.
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
| stable/linux-6.6.y        |  Success    |  Success   |

