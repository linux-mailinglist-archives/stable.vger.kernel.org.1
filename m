Return-Path: <stable+bounces-108232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339BCA09BC1
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 20:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB516ABB9
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB32144C4;
	Fri, 10 Jan 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRyQ74b1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F82144BA
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536855; cv=none; b=hPUeLkSHYetnrHoj2glKPb0aE2WGfutqvP76vdKMQ68fHPWzl2Ihcdt6gna7WN8mM1Pu3RtRYF+SPAziTbdqCrnfsd3WiCYQkWNDqbk9aVwLUAUH8UiQQsdeE8r3CKIjlaCyM8wPDUnkxBUdyQqv+Z3b70gCZVbWUCNjtop2xLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536855; c=relaxed/simple;
	bh=9VBVcdOdOc85FtC7aIMz8584stNNg72bI2jYTaac7vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVJFMhcarO/CYmyXeCU44jfpDM1IKjy4Pcbn3Sf85XX/zsKTUjC/RYrctYkEnmWKS874F2Wuyr9xjPt5t2V6ENV+UviSNHWDMv7h4rTfQ7rJAMaKVpKKOghx99kT3Mq+YRY9BiN8yPLZx0LKiZIcEJzAOGOh61wvPdE+p5+KIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRyQ74b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01966C4CEDD;
	Fri, 10 Jan 2025 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736536854;
	bh=9VBVcdOdOc85FtC7aIMz8584stNNg72bI2jYTaac7vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRyQ74b16FPVay0uPnlGupH/cvK3wWxVBrgwFSB59AFuwpLF8LcfKYeOP3p8nPSxO
	 Ire8G9eWhcgwBj+/QS8fh18q5cT4L1xcGkgDrP5GWkJLzLcuWI2+I2jMjkDKqKXdDC
	 e17CbBBY4QjpMK9cXLL4EEqopeqGP/1O8/m1iC8h9jqQh6JFiKjEIZqy4vKpF4+McF
	 Sg1Ug1JWiRZZAbVvFIpi9HBzEU4d/sZybjYfWzia2dh4B5/6sICSotyRYs2hK69iIl
	 UNwe44PBYzrXTe+PYw7qvbk168m/XALP11fUpR4gkmaGhtuNB1qybAtCm2abTScUHn
	 Q0bWZq6RBIEog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: hsimeliere.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 2/2] bpf: Fix overloading of MEM_UNINIT's meaning
Date: Fri, 10 Jan 2025 14:20:52 -0500
Message-Id: <20250110130335-e68cc85f814c4ef3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250110152958.92843-2-hsimeliere.opensource@witekio.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 8ea607330a39184f51737c6ae706db7fdca7628e

WARNING: Author mismatch between patch and upstream commit:
Backport author: hsimeliere.opensource@witekio.com
Commit author: Daniel Borkmann<daniel@iogearbox.net>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 48068ccaea95)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8ea607330a39 ! 1:  2a7a87725633 bpf: Fix overloading of MEM_UNINIT's meaning
    @@ Metadata
      ## Commit message ##
         bpf: Fix overloading of MEM_UNINIT's meaning
     
    +    [ Upstream commit 8ea607330a39184f51737c6ae706db7fdca7628e ]
    +
         Lonial reported an issue in the BPF verifier where check_mem_size_reg()
         has the following code:
     
    @@ Commit message
         Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
         Link: https://lore.kernel.org/r/20241021152809.33343-2-daniel@iogearbox.net
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
    +    Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
     
      ## kernel/bpf/verifier.c ##
     @@ kernel/bpf/verifier.c: static int check_stack_range_initialized(
    @@ kernel/bpf/verifier.c: static int check_helper_mem_access(struct bpf_verifier_en
      				return zero_size_allowed ? 0 : -EACCES;
      
      			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
    --						atype, -1, false, false);
    -+						access_type, -1, false, false);
    +-						atype, -1, false);
    ++						access_type, -1, false);
      		}
      
      		fallthrough;
     @@ kernel/bpf/verifier.c: static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
    -  */
    + 
      static int check_mem_size_reg(struct bpf_verifier_env *env,
      			      struct bpf_reg_state *reg, u32 regno,
     +			      enum bpf_access_type access_type,
    @@ kernel/bpf/verifier.c: static int check_mem_size_reg(struct bpf_verifier_env *en
      
      	if (reg->smin_value < 0) {
     @@ kernel/bpf/verifier.c: static int check_mem_size_reg(struct bpf_verifier_env *env,
    + 
    + 	if (reg->umin_value == 0) {
    + 		err = check_helper_mem_access(env, regno - 1, 0,
    +-					      zero_size_allowed,
    +-					      meta);
    ++				      access_type, zero_size_allowed, meta);
    + 		if (err)
    + 			return err;
    + 	}
    +@@ kernel/bpf/verifier.c: static int check_mem_size_reg(struct bpf_verifier_env *env,
      			regno);
      		return -EACCES;
      	}
    @@ kernel/bpf/verifier.c: static int check_mem_size_reg(struct bpf_verifier_env *en
      	if (!err)
      		err = mark_chain_precision(env, regno);
      	return err;
    -@@ kernel/bpf/verifier.c: static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
    +@@ kernel/bpf/verifier.c: int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
      {
      	bool may_be_null = type_may_be_null(reg->type);
      	struct bpf_reg_state saved_reg;
    @@ kernel/bpf/verifier.c: static int check_mem_reg(struct bpf_verifier_env *env, st
      	/* Assuming that the register contains a value check if the memory
      	 * access is safe. Temporarily save and restore the register's state as
      	 * the conversion shouldn't be visible to a caller.
    -@@ kernel/bpf/verifier.c: static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
    +@@ kernel/bpf/verifier.c: int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
      		mark_ptr_not_null_reg(reg);
      	}
      
    @@ kernel/bpf/verifier.c: static int check_mem_reg(struct bpf_verifier_env *env, st
      
      	if (may_be_null)
      		*reg = saved_reg;
    -@@ kernel/bpf/verifier.c: static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
    +@@ kernel/bpf/verifier.c: int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
      		mark_ptr_not_null_reg(mem_reg);
      	}
      
    @@ kernel/bpf/verifier.c: static int check_func_arg(struct bpf_verifier_env *env, u
     +					 true, meta);
      		break;
      	case ARG_PTR_TO_DYNPTR:
    - 		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
    + 		/* We only need to check for initialized / uninitialized helper
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

