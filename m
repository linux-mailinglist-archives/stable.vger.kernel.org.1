Return-Path: <stable+bounces-249138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FckGFcHCmqNwAQAu9opvQ
	(envelope-from <stable+bounces-249138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:22:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C23205630D8
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB2843009B2E
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8BD3CE096;
	Sun, 17 May 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2k0q89B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B53CD8B5;
	Sun, 17 May 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041928; cv=none; b=XxVBrmkrVF/Kw+bTR7X04ETUNxk11XjGi2EmRS6/pO5lTvBf7UkFPn/wxfkKOssq8bjtTq6KrirMF1fMfNnl0o3/h/zm2F7rgZHdArHtzKNEVugFOUrzOjhtGRFmgpJrRUhX9cBl4mGfUEAvm4lbkz7c0wqfWHJvxgGJ3wIJnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041928; c=relaxed/simple;
	bh=3HniV/owbPuyiFifJf0oVNfnNRlBq/8riIc6nhW1yCY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X3ezGUVcpAndrHfSTF7LsDPGiKmXIE0IpIw2en0yfgISm9NVdgh7czmhXIIAcUdUI7NuRSBcNqvo3g/L2gLLq+DjgDatzSRZ4s0tlkEI6Ld6AOqF23wrOqZKZhbcCoL464QT7GC+9lAlH8iUr/GMIjpCiB0QU0/N/OU+s4Sfo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2k0q89B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B173C2BCB0;
	Sun, 17 May 2026 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041927;
	bh=3HniV/owbPuyiFifJf0oVNfnNRlBq/8riIc6nhW1yCY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=l2k0q89B9VKOKo9+4tHkay3xCumeTJcaZ858CHG/+LijIOrmKsmVXEW+66yMNO3uw
	 3QiYU4dde86xgR+dmqbrUFofQoPqzKVbr0ONpqbhP7GW8H2pS2cqx9Gn5yjd78SUsO
	 hrDe5LAwKIWOZoqPtW/gT6Il4xacb/Kvis6L0CBG3ADT6beON/nQSGJl0wPT7e3C2b
	 HLl62VLwZZzjyzrdvXksQLJO+EL2UStObbfLEZNKx+P3KAQ+/dQYxaEXjvRWkKS2YR
	 rAXQBEkhSgy0gG4wk8PuUCcYLQp6On2H+pP2n795dtuWZFJeQUDxQ/HHqvUudaAfAj
	 6rj65ryJmxE5Q==
Content-Type: multipart/mixed; boundary="===============4766251417798908984=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f86a6d40190b7f1334240e90e1bc07f4cf7a04afb945c0e8b9dd19c05fc87364@mail.kernel.org>
In-Reply-To: <20260517214043.12975-5-adubey@linux.ibm.com>
References: <20260517214043.12975-5-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 4/5] selftest/bpf: Enable verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 17 May 2026 18:18:47 +0000 (UTC)
X-Rspamd-Queue-Id: C23205630D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249138-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--===============4766251417798908984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 9eeb5b0b63d6..cdc2a3de3054 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -158,6 +158,7 @@
>  #define __arch_arm64		__arch("ARM64")
>  #define __arch_riscv64		__arch("RISCV64")
>  #define __arch_s390x		__arch("s390x")
> +#define __arch_powerpc64	__arch("POWERPC64")
>  #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
>  #define __load_if_JITed()	__test_tag("load_mode=jited")
>  #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index abdb9e6e3713..d5589355ed9e 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -377,6 +377,7 @@ enum arch {
>  	ARCH_ARM64	= 0x4,
>  	ARCH_RISCV64	= 0x8,
>  	ARCH_S390X	= 0x10,
> +	ARCH_POWERPC64	= 0x20,
>  };
>
>  static int get_current_arch(void)
> @@ -389,6 +390,8 @@ static int get_current_arch(void)
>  	return ARCH_RISCV64;
>  #elif defined(__s390x__)
>  	return ARCH_S390X;
> +#elif defined(__powerpc64__)
> +	return ARCH_POWERPC64;
>  #endif
>  	return ARCH_UNKNOWN;
>  }
> @@ -580,6 +583,8 @@ static int parse_test_spec(struct test_loader *tester,
>  				arch = ARCH_RISCV64;
>  			} else if (strcmp(val, "s390x") == 0) {
>  				arch = ARCH_S390X;
> +			} else if (strcmp(val, "POWERPC64") == 0) {
> +				arch = ARCH_POWERPC64;
>  			} else {
>  				PRINT_FAIL("bad arch spec: '%s'\n", val);
>  				err = -EINVAL;

This patch looks clean. However, unaddressed review comments from earlier
versions of related patches in the series were identified:

https://lore.kernel.org/bpf/20260517180201.87B8AC2BCB0@smtp.kernel.org

Three issues were raised by sashiko-bot@kernel.org on Sun, 17 May 2026 about
alignment logic in arch/powerpc/net/bpf_jit_comp.c (from a related commit in
this series):

Issue 1: In bpf_jit_build_fentry_stubs(), the alignment NOP is only emitted
when (fimage && image) is true. During pass 0 sizing, both are NULL, so the
NOP is skipped and proglen is calculated without it.

During final passes 1 and 2, if the NOP is emitted, could this increase the
instruction count beyond proglen and overflow into the exception table or
fixups?

Issue 2: In the same function, the alignment calculation appears flawed:

    unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);
    pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10;

The comment says "11/10 instructions" but pc is a byte address. Adding 11 or
10 adds bytes instead of the intended 44 or 40 bytes (since PowerPC
instructions are 4 bytes).

Adding 4 bytes to an 8-byte aligned address makes it unaligned. Does this
force the code to emit a NOP when the target address is already aligned?

Issue 3: In bpf_jit_emit_exit_insn(), the code passes NULL for fimage:

    } else {
        ctx->alt_exit_addr = ctx->idx * 4;
        bpf_jit_build_epilogue(image, NULL, ctx);

Because fimage is strictly passed as NULL, the (fimage && image) check will
always evaluate to false. Will this cause the alignment NOP to be
unconditionally skipped for all inline epilogues, leaving their
dummy_tramp_addr fields unaligned?

These comments should be addressed in the related commits of this series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25998434343
--===============4766251417798908984==--

