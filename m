Return-Path: <stable+bounces-139383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C3AA6396
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F911B63A37
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15874224AEF;
	Thu,  1 May 2025 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogwnNxkg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A61DF751
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126707; cv=none; b=HR5zwY4C0p1r1Ecsnqkty8K0ninv/Bp2xyHWU8A5fHrrtZcqQIMEXepOqXNl2CpCrhQnfDWdgUiN8TKrZ0XCo0Joc9kCBCD5k2WjePWo7Y7lwC42YoPfVOxtOWF3uftLidUgVqPUj5/Jdh9opH4DNZrMYoR1wfGOBNzU2Drhh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126707; c=relaxed/simple;
	bh=imc71vfWeJqCdflu4GGbsbbWryKd78qb/29zAIywTkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKI5gDQfgYQf/dvfg3UYaFxqh8xI04sMMAa8WvvPmy7+toNV0v+o5Fk5LO0ot2eHHoj9F6TTcg7o9JU3BnLLlE6ljBQ1fsux+A/L9RIV8Agiz3spohKEpQOYtvQpSW9UpZjLcpCeUkBsN2CvSC4/3pj9FnzXVx0D/DpBpx052ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogwnNxkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE491C4CEE3;
	Thu,  1 May 2025 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126707;
	bh=imc71vfWeJqCdflu4GGbsbbWryKd78qb/29zAIywTkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogwnNxkgHEERU89jDxEG30S5Up9L86XmuLjY88gVuF2uhMTJfzs+QnGn55RARdBx+
	 3e+kLucWZeU1IYc98J/OSyz0dkxIP1KcAkHWzVhcUyijqX63WC4JppUV3UCy2xzKTb
	 tcY8+bc3RNSa0m85RTrautrR9gdArJ7UA1t3Oyf7ki2NqQsSnVXdSPF8CrL+fkNziN
	 IYDOOW7vlu4GMxorhJ1Ju5dyucMFP8uvNpf/OqtjBVvlLiAx7qWBd4yXJcvZ/9cEXG
	 PmOZydOecSgK8AFeGRK95WbUrxdqpeDbdwKtE0fQPpQZaBTYm31oXWiwRMfbIRC5gT
	 BlpZ3uy91ucMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 04/10] selftests/bpf: test for changing packet data from global functions
Date: Thu,  1 May 2025 15:11:43 -0400
Message-Id: <20250501085413-c3dc132b416533b6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-5-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 3f23ee5590d9605dbde9a5e1d4b97637a4803329

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: fa1fbb67e081)

Note: The patch differs from the upstream commit:
---
1:  3f23ee5590d96 ! 1:  d9b5cb443bdde selftests/bpf: test for changing packet data from global functions
    @@ Metadata
      ## Commit message ##
         selftests/bpf: test for changing packet data from global functions
     
    +    commit 3f23ee5590d9605dbde9a5e1d4b97637a4803329 upstream.
    +
         Check if verifier is aware of packet pointers invalidation done in
         global functions. Based on a test shared by Nick Zavaritsky in [0].
     
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-5-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/progs/verifier_sock.c ##
    -@@ tools/testing/selftests/bpf/progs/verifier_sock.c: __naked void sock_create_read_src_port(void)
    +@@ tools/testing/selftests/bpf/progs/verifier_sock.c: l1_%=:	r0 = *(u8*)(r7 + 0);				\
      	: __clobber_all);
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

