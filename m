Return-Path: <stable+bounces-139358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F025AA632C
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6927B1B61698
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613D222563;
	Thu,  1 May 2025 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcxo0t/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872562153EA
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125517; cv=none; b=DoVPobTjMsvCHcP7FSST2mzQsS5j0SXrIhkkM9rmmY0bJPkhrk4Qj6lYWtbsnNho67OkcVdYngjtMCQ4ujxPTtJbazCSIsn3vwwD/YQ33NcvFqcztwd58JX3c/g0crtH5UeVpEvgm/nzJJA01ZqVwcDcd3i6c9vCUZr3UHon8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125517; c=relaxed/simple;
	bh=NBS9Dw26HppZ4dkkvWxFDWwrb078ETcwsqZw+4Mb3LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG4LdS08Fz/urw+JWpsgy5qkd9aJqZAjKEM9JtKSoQdUCev5gGxIJXbfWR3jNi2aSwGyQhFY1nat/FA129CN2Y5qqp3fIvfbX8U5jtM8UlOS71oljdCKv6h3HZZVZzuD41+vRseev10FhtxHSqhqh4xPB32P1VxMudqDk/4O5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcxo0t/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C5FC4CEE3;
	Thu,  1 May 2025 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125517;
	bh=NBS9Dw26HppZ4dkkvWxFDWwrb078ETcwsqZw+4Mb3LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gcxo0t/uUUKaBMeGCk0qVYqcZM07waNiZy83naZxKTv2qGcc9cCv31fHppTutfl4N
	 lxfZx8ZXwHigD486cy5Ivv56aDvklqH/xbX8992kmyCOSKwcvJqopxOmN81HB2ieMr
	 rvQVNxt+m5tvfM8J1U4Xx5Mz8SnkYA6bemkfEgrKm4IbJ5tbL/RIQ2o0H41ZbfDSse
	 yIaBqbdzdYaO3dryEoIyFTVVHwvV+CW2cqrZVilJNtE594sgKKqrUEeWu2ZOCRuSOm
	 yhlufYnXR9gioBW1xxM39gbrG3x93n3axp3lSSIalIiryuaUyLGJZhMbp1w5XGleUt
	 ipXte1zv5Zjcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 02/10] bpf: refactor bpf_helper_changes_pkt_data to use helper number
Date: Thu,  1 May 2025 14:51:53 -0400
Message-Id: <20250501084603-8ea56ba1346b5be2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-3-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: b238e187b4a2d3b54d80aec05a9cab6466b79dde

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 28bcc8024033)

Note: The patch differs from the upstream commit:
---
1:  b238e187b4a2d ! 1:  3e2e06b5ee782 bpf: refactor bpf_helper_changes_pkt_data to use helper number
    @@ Metadata
      ## Commit message ##
         bpf: refactor bpf_helper_changes_pkt_data to use helper number
     
    +    commit b238e187b4a2d3b54d80aec05a9cab6466b79dde upstream.
    +
         Use BPF helper number instead of function pointer in
         bpf_helper_changes_pkt_data(). This would simplify usage of this
         function in verifier.c:check_cfg() (in a follow-up patch),
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-3-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## include/linux/filter.h ##
    -@@ include/linux/filter.h: bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
    - bool bpf_jit_supports_private_stack(void);
    - u64 bpf_arch_uaddress_limit(void);
    - void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
    +@@ include/linux/filter.h: bool bpf_jit_needs_zext(void);
    + bool bpf_jit_supports_subprog_tailcalls(void);
    + bool bpf_jit_supports_kfunc_call(void);
    + bool bpf_jit_supports_far_kfunc_call(void);
     -bool bpf_helper_changes_pkt_data(void *func);
     +bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

