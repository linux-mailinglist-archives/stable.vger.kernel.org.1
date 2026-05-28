Return-Path: <stable+bounces-256434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPRBLFTEGGoWnQgAu9opvQ
	(envelope-from <stable+bounces-256434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:40:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 662EF5FB105
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B00043016004
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A53655DA;
	Thu, 28 May 2026 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TomYBcye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F4F1891A9;
	Thu, 28 May 2026 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780008016; cv=none; b=cszhA6S0WLJa/nLx1lwEBNYygGKGfGQTPUUyD3oXmf8EjKPVVgjsV/OGTFy+lt2+qLOeZSWAOz5EHKIM8qWz4UWXrynMsYOy+AjqOel2DKRnf3i3gK1TZfQdbsLkhFnm00gYCqpbvEMRiMoam4I1xlwjZK+Wn+ttRCUoJ27cBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780008016; c=relaxed/simple;
	bh=XwRyi1PU7um7q9nAfHX11Yt9Lb0ZBSjKdzhoPwM+xeE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OWmh51P/1uVBZQI+uSQxWb1ISy33IWuUQPqcv3QMr2xj3HZJ+mz/kUhF6N/aUJbaON7oXCpnkgf8ZBexRdM7G9E9mRalB1G7MxUmAsT6hVc9G7CgB8oL34PrRsIbPofv26JRb2nMIccpNuTCdioOs6E0T29UEJFGWLhIYsUo/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TomYBcye; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573D71F000E9;
	Thu, 28 May 2026 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780008015;
	bh=ZYoIC7tgDvTnn72N4qZ6BOaf6goJiUEBgxODpeKiPNc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TomYBcyexq04Y5cnuhvyWbfq++IQqybsVivOkfApAiWeUFFpmNVZGjPoI0C+3zsAe
	 YcC4/BMQQmBVRo6eG065tXr8WhBQs3d0hEa8j4dlMH7MpJ8dvO5a2Zge53EeK+/SHM
	 Sn0gkIAJdWWnRJuLGadnS7wUF3RgE+o6SGr9Qi6A7V5KLGjaamr15XspU0pH9AWcHc
	 Z2wfc62CWBEbD7MNhBtWrQgccFjR/eDwDs5wBol4eoHm2cgrJQO2+00O6pj8HXYA2Z
	 b62Qyt9d4wYYHBchJ8g1kBCbCH/jl2WACvshBHUM0sVprS3gmU3QDI1SLXvJQOSmVP
	 2RZGOCKRIlKFA==
Content-Type: multipart/mixed; boundary="===============2740736122395765729=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb81617c5327a5e1373d31f249ed8eeb9d5755e4c81d1e07464d2a0a08288e44@mail.kernel.org>
In-Reply-To: <20260529015855.364704-4-adubey@linux.ibm.com>
References: <20260529015855.364704-4-adubey@linux.ibm.com>
Subject: Re: [PATCH v6 3/6] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 28 May 2026 22:40:15 +0000 (UTC)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-256434-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 662EF5FB105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============2740736122395765729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 364c557c5115..21e3e3e68c14 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c

[ ... ]

> @@ -216,9 +218,28 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
>
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output on 64-bit and last 4 bytes on 32-bit powerpc,
> +	 * which can't disassemble to a valid instruction.
> +	 */
> +	triple = LLVMGetDefaultTargetTriple();
> +	if (triple) {
> +		if (strstr(triple, "powerpc")) {
> +			if (IS_ENABLED(CONFIG_PPC64))
> +				trunc_len = 8;
> +			else
> +				trunc_len = 4;
> +		}
> +		LLVMDisposeMessage(triple);
> +	}

Can IS_ENABLED(CONFIG_PPC64) ever be true in this file?

This is a userspace selftest (tools/testing/selftests/bpf/jit_disasm_helpers.c).
IS_ENABLED here resolves to tools/include/linux/kconfig.h:

  #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))

which ultimately tests __is_defined(CONFIG_PPC64), i.e. whether CONFIG_PPC64
is a defined preprocessor macro.

The kernel proper makes CONFIG_* macros visible by force-including
include/generated/autoconf.h via the build flags. The selftests/bpf build
does not do that: tools/testing/selftests/bpf/Makefile only adds an include
search path and -DHAVE_GENHDR, with no -include autoconf.h, and the include
chain for this file never pulls in generated/autoconf.h.

So CONFIG_PPC64 is undefined and IS_ENABLED(CONFIG_PPC64) is 0 on every
build, including ppc64/ppc64le. trunc_len then always becomes 4.

On 64-bit powerpc the JITed stub appends an 8-byte dummy trampoline address,
but only 4 bytes get truncated. The remaining 4 bytes are still handed to the
disassembler, which can decode them into a seemingly valid instruction, which
is the failure this change is meant to fix. Would a runtime check on the
triple, for example strstr(triple, "powerpc64"), be needed to distinguish
64-bit from 32-bit here, since the 8-vs-4 selection is otherwise compile-time?

> +
>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		/* Disabled JIT have zero func_lens, hence underflow */
> +		__u32 disasm_len = func_lens[i] > trunc_len ?
> +					func_lens[i] - trunc_len : 0;
> +		disasm_one_func(text_out, image + pc, disasm_len);
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}

The commit message describes fixing a powerpc JIT disassembly failure caused
by the dummy trampoline address emitted at the tail of the long_branch stub.
That trailing field was introduced by commit d243b62b7bd3 ("powerpc64/bpf:
Add support for bpf trampolines"). The two sibling commits in this series
both carry that Fixes: tag, but this selftest-side commit does not.

Should this include:

  Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26605473656
--===============2740736122395765729==--

