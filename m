Return-Path: <stable+bounces-139348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72167AA6320
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299F91BC3ED3
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED7320C009;
	Thu,  1 May 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoK2pH1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4641C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125472; cv=none; b=eg5VmbUcmTUfi8l+aEL2unnPCZk3qKqIp3/m9YQMDf5SHUhhvtJTx36xQ1cHDH5ZrWhpcxqIoQEogyIA3F7u4tZ0lbjSL8sr3UCz9oToHsxW6vLZX6R5eLQ0ZwicmNOoahbsKo0D0Lpnj9c4nU1T4RgiN8bofBZYdXQlQw0WOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125472; c=relaxed/simple;
	bh=qmAabqkZK3nUlzcJ4CJJb2th1OrRy+yc8EYx/gpLOyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpndY4qAtMuvCVZLhGBZ6/0pbiYVfAqejLbXmA9CqVQ1wRI+3KlRd+X6nDgbL7GmcUl5xCN6MqCcnFM5nQqiEm/ovWtKiwOTxh2msMACSblardm7cGxUE32k1JKfjf6H6ktbd93SjBp74Pn6mu5B9/sh+itPspWLWdaHvm0q+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoK2pH1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE238C4CEE9;
	Thu,  1 May 2025 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125472;
	bh=qmAabqkZK3nUlzcJ4CJJb2th1OrRy+yc8EYx/gpLOyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoK2pH1ppzZvq39IIi22kZAHzjzc69uCk1dfcTZqpSpHfKrOUQLDBlZaSQaHGFnze
	 BG6/fSwYQGo2sXW2ww1eNmq6kd1W8W/RaEf/Xsgo8a1kLq639Yh0qNli0jfobPeKsb
	 bmODBeanmZXo96unPPoXK2QWanMq7VOW+qDF/TAZnizXA9BCXFbBhTB7/b0yhtZNEr
	 BZSTtDkq0XHRqWsRpDPwCYTVKFdxi8hwfFbyB7YOSJgPGcZfOdgLmeab5pTfMdCKaS
	 vGZUwxdojQajmL2M8DX4YCqYnhPlqWPkTDRFYZpJhOKBtCcEuPF/zTYHThZZXr0B0Q
	 YdgJ4AfwyEF/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 03/10] bpf: track changes_pkt_data property for global functions
Date: Thu,  1 May 2025 14:51:08 -0400
Message-Id: <20250501085016-64eccfcb476717fa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-4-shung-hsi.yu@suse.com>
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
6.12.y | Present (different SHA1: 1d572c60488b)

Note: The patch differs from the upstream commit:
---
1:  51081a3f25c74 ! 1:  5e482602aa8a7 bpf: track changes_pkt_data property for global functions
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
    +    [shung-hsi.yu: do not use bitfield in "struct bpf_subprog_info" because commit
    +    406a6fa44bfb ("bpf: use bitfields for simple per-subprog bool flags") is not
    +    present and minor context difference in check_func_call() because commit
    +    491dd8edecbc ("bpf: Emit global subprog name in verifier logs") is not present. ]
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## include/linux/bpf_verifier.h ##
     @@ include/linux/bpf_verifier.h: struct bpf_subprog_info {
    - 	bool args_cached: 1;
    - 	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
    - 	bool keep_fastcall_stack: 1;
    -+	bool changes_pkt_data: 1;
    + 	bool tail_call_reachable;
    + 	bool has_ld_abs;
    + 	bool is_async_cb;
    ++	bool changes_pkt_data;
    + };
      
    - 	enum priv_stack_mode priv_stack_mode;
    - 	u8 arg_cnt;
    + struct bpf_verifier_env;
     
      ## kernel/bpf/verifier.c ##
     @@ kernel/bpf/verifier.c: static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
      
    - 		verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
    - 			subprog, sub_name);
    + 		if (env->log.level & BPF_LOG_LEVEL)
    + 			verbose(env, "Func#%d is global and valid. Skipping.\n", subprog);
     +		if (env->subprog_info[subprog].changes_pkt_data)
     +			clear_all_pkt_pointers(env);
    - 		/* mark global subprog for verifying after main prog */
    - 		subprog_aux(env, subprog)->called = true;
      		clear_caller_saved_regs(env, caller->regs);
    -@@ kernel/bpf/verifier.c: static int check_return_code(struct bpf_verifier_env *env, int regno, const char
    + 
    + 		/* All global functions return a 64-bit SCALAR_VALUE */
    +@@ kernel/bpf/verifier.c: static int check_return_code(struct bpf_verifier_env *env)
      	return 0;
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

