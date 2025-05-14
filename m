Return-Path: <stable+bounces-144419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFF5AB7683
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACD21BA6236
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB06295519;
	Wed, 14 May 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzLVDc9O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55E295502
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253591; cv=none; b=mPo34peScn5w4yZaWyg+/+A3X9YAuXZZc3qNh67jks4Jf8gStZzEG59jLtqK0DczZRX615IYJbCGX4OIWGFS8H+VfBW46638YDwbp6iQXeTe/PkmJK7qRlc1Ltdqm933qtQ2XoXs4cc7vWw4XW20JH/kVZmNN1gsThpldV2SGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253591; c=relaxed/simple;
	bh=CGxFCtwK/rpc9EPB8hcezGUD3Pwf1dc7aom8yhpMl68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efR2Liihk99bcIMPoAYKrPDNoxp0vzmcKLwmXtgunPjZHPpZ4l0+XHiVaFMIzbxxrrAWjI6ZRuPIdNSFubEqqGpm2lkQjByU6hEqWDRqPWhes7vaOHR2hBx8QMnWV7+hwazGyZd3sqlUx5PJpkYGKJVwSluCjLOryIYcsyplujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzLVDc9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CF5C4CEE3;
	Wed, 14 May 2025 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253591;
	bh=CGxFCtwK/rpc9EPB8hcezGUD3Pwf1dc7aom8yhpMl68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzLVDc9Oz4EVMj3kP0egtt6HitzAG9b+xON3Cs7okNRTrowrcLIEa2XAWPXQ/Y+f1
	 qX4dwDoT0W5njf+W/i4P7c04133dPJRAL1Ors/+31DVE29kAH8p3Hk1FRSkNMwzXv6
	 8qv+Jlx++/0vWsfUI+CAaXyJW/AvBvxlCTPvB832J4q7bBhZbFzFPwn69vnZZTxwHj
	 YFkYHAhI7PvKQTYj4rzqO/t82bZk2OL4XlhdJUz6ZHPwzuSPWyTq6iX66/Hkdnv3tH
	 iiLg++rbRNd0ei+yw+R95Fm/A5OdyblZ8sV8t7NOlQXIiXh3gTI4RjpWRP0Op2SsDn
	 rxrB8wvfxOvfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 01/14] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Date: Wed, 14 May 2025 16:13:08 -0400
Message-Id: <20250514105300-50f9d7308880365d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-1-90690efdc7e0@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 09d09531a51a24635bc3331f56d92ee7092f5516

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  09d09531a51a2 ! 1:  2ae24144e7424 x86,nospec: Simplify {JMP,CALL}_NOSPEC
    @@ Metadata
      ## Commit message ##
         x86,nospec: Simplify {JMP,CALL}_NOSPEC
     
    +    commit 09d09531a51a24635bc3331f56d92ee7092f5516 upstream.
    +
         Have {JMP,CALL}_NOSPEC generate the same code GCC does for indirect
         calls and rely on the objtool retpoline patching infrastructure.
     
    @@ Commit message
         compiler generated retpolines are not.
     
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/include/asm/nospec-branch.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

