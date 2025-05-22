Return-Path: <stable+bounces-145994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1489EAC0232
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D8F9E395D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B654640;
	Thu, 22 May 2025 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+GNvazA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7340C03
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879640; cv=none; b=lqIOUrjX10a3GuI3n+r9thdZ8xuJiFihr36ZP/48Dfv2DEJQ59JbeOdnbrkUxYSBtzM/8goZgxkTLb3mCfh81Ww/OrmAINEk4sxeNSIzkTW1IBMXIv6mQIn/F1WXkats9Yn8tmOvbdOEIpsS9sjR5WXMAoaPpJAw+brAAP2liuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879640; c=relaxed/simple;
	bh=h1uOSJC87hrY+8JuH/YILueLWS56l4I/hCy0xfdqheQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fy7KzZ91ZwJCmmr5sgV91v7zZ5uYFPRPGLT77VBRFqyXQi8mw3vFHrWP2RPyyDFeiov8v+7598c2MWUDX5R62syO6PMuoz3U7K9VMcB3jOaduZTllFmCQDT0C+dqa9Y2gXLCyWDX099kDIlTApAZZ90PVb7tt1zp6sdCItYT4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+GNvazA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E937C4CEE4;
	Thu, 22 May 2025 02:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879640;
	bh=h1uOSJC87hrY+8JuH/YILueLWS56l4I/hCy0xfdqheQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+GNvazAnRh8FN8UYVINUsJSAILGPmLNLl1ZnBlJ24UAKOvauR6XcKg09jL/jWAPJ
	 fWQ6XPxL1AXI6lWI4dKgH4jFqzlhGnDtweyhSbYoVvvvyesGlxjLRaI0YFGInmQxvx
	 lMpu8yWnZ60+Mox9n/EFIH3AmjtoWn2S9yHHemFg4kskv9YAXcVTn35pZZJqmFu99k
	 BEhqKX6Tbi0PBhKIt9BWS+HPrx0lrxK63XNDp9fIO1cdHs0MmjD410yrcwWIvVFCNl
	 U6Qe6Y2hIUUXDBHsthHGtkaRG0f3L3NMxbEpyOjBuExXFvhMFNu9WxwYTZbQYAsFMC
	 iTJ5aocxDJwIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 24/27] af_unix: Don't access successor in unix_del_edges() during GC.
Date: Wed, 21 May 2025 22:07:15 -0400
Message-Id: <20250521213422-3aac2bbe156eba86@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-25-lee@kernel.org>
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

Summary of potential issues:
ℹ️ This is part 24/27 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 1af2dface5d286dd1f2f3405a0d6fa9f2c8fb998

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Found fixes commits:
7172dc93d621 af_unix: Add dead flag to struct scm_fp_list.

Note: The patch differs from the upstream commit:
---
1:  1af2dface5d28 ! 1:  b9290c1b47598 af_unix: Don't access successor in unix_del_edges() during GC.
    @@ Metadata
      ## Commit message ##
         af_unix: Don't access successor in unix_del_edges() during GC.
     
    +    [ Upstream commit 1af2dface5d286dd1f2f3405a0d6fa9f2c8fb998 ]
    +
         syzbot reported use-after-free in unix_del_edges().  [0]
     
         What the repro does is basically repeat the following quickly.
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240419235102.31707-1-kuniyu@amazon.com
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 1af2dface5d286dd1f2f3405a0d6fa9f2c8fb998)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

