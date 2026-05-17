Return-Path: <stable+bounces-249139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IFUCMgGCmq9wAQAu9opvQ
	(envelope-from <stable+bounces-249139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:19:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B3956308E
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B65CB3023D9E
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603663CD8AD;
	Sun, 17 May 2026 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/Xcgn3E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A53CF02D;
	Sun, 17 May 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041930; cv=none; b=d/nS/aLgeEjkwC4Qc4P2E9JdrtcjnfZkBZya3nKXgm7KDE6j53Oej2DdMUrbsHqmoIzzrVH8wAXFXGTjmtrDKxofIPgHF1qIsmNfzCrPZVuScxiqkd9oIQNiHPUEYp5n9Al8PjmK3ZYB3Ce4quSbEcFGuzLStKRFhCo/nSuBgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041930; c=relaxed/simple;
	bh=FdTz52kBiuxxnKRGyJY8LYIp811khf+rWDjvDMYs5Rc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZKZTP3kzVnZuP5dlE7sIMsG9st/236mt+k86PMCBqrfKrlMmjfXRZODWK4oCP4wyS2xWNQpUgaKMTHGeqIPLbHzfl+i4JOcsASif71G6jqU6w2oUZ4ZqhzHbSckfcqKEQSeJWCtMHzLU8vTgCMUhMQnff/xDpRdZZfmBdSThsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/Xcgn3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C784AC2BCC6;
	Sun, 17 May 2026 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041929;
	bh=FdTz52kBiuxxnKRGyJY8LYIp811khf+rWDjvDMYs5Rc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=R/Xcgn3EfpQZ7yJolrPGRQ5v3X7TKIyJpoV3r3zTXJyr7pVl517l7MMEMWPhbaMTj
	 fPtBG8CMOv1r19o6WVKylBp8Vo/jYSyozFZssnmAh196WxWScJjMvsdwGUeBc67ARs
	 PEXRSkOe6f0RHXxkaxuGLfbNBvkyQ7MUf6kOdX/RXjUEfYYWpuCFilY2EMbg9qAUby
	 +PomWpXt7M16B7riEtp3ndNl1Tr5mjKNj0IymsVlMQnTqM4a157isY1mVBPwJLdbyK
	 CAC2PrHn3LwL3nIknQS/9oTceAg1JIN6uQJ7KlFSXYIm0YkiSpnAcvuMyvD5FzipCV
	 eYcYIannNMcrA==
Content-Type: multipart/mixed; boundary="===============1283525173956514337=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <afd81a2105bb0deae207a35569bde1f3e1cf07d4a119a6fa745a3a15acd8be91@mail.kernel.org>
In-Reply-To: <20260517214043.12975-4-adubey@linux.ibm.com>
References: <20260517214043.12975-4-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 3/5] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 17 May 2026 18:18:48 +0000 (UTC)
X-Rspamd-Queue-Id: 91B3956308E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249139-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid]
X-Rspamd-Action: no action

--===============1283525173956514337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 364c557c5115..4c6bcbe08491 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -170,9 +170,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	struct bpf_prog_info info = {};
>  	__u32 info_len = sizeof(info);
>  	__u32 jited_funcs, len, pc;
> +	__u32 trunc_len = 0;
>  	__u32 *func_lens = NULL;
>  	FILE *text_out = NULL;
>  	uint8_t *image = NULL;
> +	char *triple = NULL;
>  	int i, err = 0;
>
>  	if (!llvm_initialized) {

[ ... ]

> @@ -216,9 +218,18 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
>
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output for 64-bit and 32-bit powerpc, which can't
> +	 * disassemble a to valid instruction.
> +	 */
> +	triple = LLVMGetDefaultTargetTriple();
> +	if (strstr(triple, "powerpc"))
> +		trunc_len = 8;
> +

Does this code leak the triple string? Looking at the LLVM C API,
LLVMGetDefaultTargetTriple() returns a string that must be freed with
LLVMDisposeMessage(). The sibling function disasm_one_func() in this
same file shows the correct pattern:

    if (triple)
        LLVMDisposeMessage(triple);

The cleanup section at the 'out:' label properly frees text_out, image,
and func_lens, but triple isn't included. While this is test code and
the leak is small, it violates the established cleanup pattern in the
file and can accumulate across test runs.

>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		disasm_one_func(text_out, image + pc, func_lens[i] - trunc_len);
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25998434343
--===============1283525173956514337==--

