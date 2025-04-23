Return-Path: <stable+bounces-135280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955AA98985
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0DC4453A9
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19171201269;
	Wed, 23 Apr 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1XdduF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85A1119A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410636; cv=none; b=DW2igjxN4ILpyCC7/8T8/ELPNVeFqNwgIYGJrH+aeupOK336iiYzNQwZIHmNVZrP5B41R6fuqbrVO8udVb5szfMmX2alTuD8cXS7LFUF3/A34YPO2FmoGs8Hq4xECz1/gTvo5JVlPUC7RbVA5wRXX8sE7OPxz9idf6aakOl8GZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410636; c=relaxed/simple;
	bh=R7gua9eLt5NWnSeXvpg3S7xMq45v+TmuLSHWZH/d6CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKScrJPRlfNBJMTStRslX5xdhFcjZc1f7CLRvpNexJcbGHiH/OuvAC55kpIhkuYQOaJeaX92SFgconj9P1o17qilUqpt1f5JSifo7umPzQORmT2hg/rkc3g9UVvC+SR2S5p+3W7nj2U+oYnoBLccXFklJhotUS1przIKkkhFVCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1XdduF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553A5C4CEEB;
	Wed, 23 Apr 2025 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410636;
	bh=R7gua9eLt5NWnSeXvpg3S7xMq45v+TmuLSHWZH/d6CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1XdduF4bTL9Yq2YS+hvJXqKRj6fT0Zs9m/5BdIxf51hcY5VzSm8u6xiSnui3VEOA
	 63k7K7TCirjEIhbEvvKm30MhLqDNaX3cNCfFbg0ofYDmKhJtOoWEWdXb8HcW94lwjx
	 Jlmi1nXAOOX+preki9btve/hGwVSo+d/kfrQMvZKngYSGGKaNNnxLiZKizT81Cbc2C
	 KVW7bNskdY09mC4geobI/X5+u6Y57WEUQLUiry8p1y16fUpimfP69dhn+2V9h3dXs8
	 xIgFB0NlvTDXb6+7F/MmrA2GbAy+oGF18dbcG5KNGsPPxJWHk9gq0Fq+jDj/CCeKxb
	 3S2bu1tlpX4vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 2/8] bpf: track changes_pkt_data property for global functions
Date: Wed, 23 Apr 2025 08:17:15 -0400
Message-Id: <20250423074616-bfadb6b016e3d6c4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423055334.52791-3-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 51081a3f25c742da5a659d7fc6fd77ebfdd555be

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  51081a3f25c74 ! 1:  6678a7d80c020 bpf: track changes_pkt_data property for global functions
    @@ Metadata
      ## Commit message ##
         bpf: track changes_pkt_data property for global functions
     
    +    commit 51081a3f25c742da5a659d7fc6fd77ebfdd555be upstream.
    +
         When processing calls to certain helpers, verifier invalidates all
         packet pointers in a current state. For example, consider the
         following program:
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-4-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## include/linux/bpf_verifier.h ##
     @@ include/linux/bpf_verifier.h: struct bpf_subprog_info {
    @@ include/linux/bpf_verifier.h: struct bpf_subprog_info {
      	bool keep_fastcall_stack: 1;
     +	bool changes_pkt_data: 1;
      
    - 	enum priv_stack_mode priv_stack_mode;
      	u8 arg_cnt;
    + 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
     
      ## kernel/bpf/verifier.c ##
     @@ kernel/bpf/verifier.c: static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

