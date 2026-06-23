Return-Path: <stable+bounces-268018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W0vdLpLnOmpGKwgAu9opvQ
	(envelope-from <stable+bounces-268018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:07:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 301936B9D9B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:07:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mtgC7vu1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268018-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268018-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4216B3070A4D
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A7C395AD3;
	Tue, 23 Jun 2026 20:07:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5353932FF;
	Tue, 23 Jun 2026 20:07:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245260; cv=none; b=On8moalM0hXDNuU5MDli4gDN2nSvVDBBBixBGF4etvVQpfeJdw+fhH6TlMq6EnkbHj9iC0Hu0AUoHcaH5PAVh7ogciddONji3IV7E184qIJMEV49rjqjXjhRodumZXnff3JjR1cAWhjiUGyQ63r92WENRpunqvVGCh0U3fay3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245260; c=relaxed/simple;
	bh=peScxMWlzri2gAH8LnxIQmX7XQWXWeurIYU2L4wVMiY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ij6W3/K1abu8vbgxKC7V0kiCDoLGCRZ3fQ8R+yYuMFByMsEZy9tSuSTkJYCvXuCl+/ZDapJSIVuUXaLjTV2Z0cGNqaBuEdz1Tl26wBGWZdAzNQ9wZyYzr1yuUmxHTwBn7guJbn98PsNP79OgsDISvNoMO76UkcKA+6uLs5oXM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtgC7vu1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996831F000E9;
	Tue, 23 Jun 2026 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245258;
	bh=6Kmx0mi/Yz50Wgq4l7LEOUoM/N7dSVgue1OpRg96emw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mtgC7vu1b8rxzkq0Xdavu/GlMTv+4n+D8qxXWeiHmpga4P5LNvQ+nuoGfBcpM26H3
	 wO3+BzB8wKxaKvlsUJtBxNgrH2jEstdh/SdmR9z6IrIIsdvCI53xkjq1dCQpwAARVh
	 B8MU+/b9X+U2/x4UGI5LsTpbfWU2x9AwlmvrGQ9n2qUFTdNPjxlLITg2lc6nKgPjqB
	 xt7XlyKXMvc5ZDJDvJlIIRTl5+dIhrLWBmYKLyi/2uxG8t8KcHn9awaeka8cGHVMXI
	 W6nk+bo/vE0TuIxyVYOohVX9QRtMEe/PEc+fM+qrwWsL8UZmGBBCvEtRQ/3crbym7P
	 mdNsp6XLBIZTQ==
Content-Type: multipart/mixed; boundary="===============2442528478780633523=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <979553f5ed74dcb555e9aba6aad660ad2a208c643ab7aeac6d5e74992427f362@mail.kernel.org>
In-Reply-To: <20260623231411.6216-4-adubey@linux.ibm.com>
References: <20260623231411.6216-4-adubey@linux.ibm.com>
Subject: Re: [PATCH bpf v9 3/8] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 20:07:38 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-268018-lists,stable=lfdr.de,bpf-ci];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:adubey@linux.ibm.com,m:bpf@vger.kernel.org,m:hbathini@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 301936B9D9B

--===============2442528478780633523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28c..11428cad5b2d 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -178,10 +178,12 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  {
>  	struct bpf_prog_info info = {};
>  	__u32 info_len = sizeof(info);
> -	__u32 jited_funcs, len, pc;
> +	__u32 jited_funcs, len, pc, disasm_len;
> +	__u32 trunc_len = 0;
>  	__u32 *func_lens = NULL;
>  	FILE *text_out = NULL;
>  	uint8_t *image = NULL;
> +	char *triple = NULL;

This isn't a bug, but would it be clearer to follow the traditional C
style by grouping related variables together? The disasm_len variable
could be declared closer to where it's used along with trunc_len, and
adding a blank line before the fprintf() statement in the loop might
improve readability.

[ ... ]

> @@ -225,9 +227,30 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
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
> +		if (strstr(triple, "powerpc64") || strstr(triple, "ppc64"))
> +			trunc_len = 8;
> +		else if (strstr(triple, "powerpc") || strstr(triple, "ppc"))
> +			trunc_len = 4;
> +		LLVMDisposeMessage(triple);
> +	}
> +
>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
> +
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		/*
> +		 * Disabled JIT have zero func_lens, hence underflow
> +		 */
> +		disasm_len = func_lens[i] > trunc_len ?
> +					func_lens[i] - trunc_len : 0;
> +		disasm_one_func(text_out, image + pc, disasm_len);
> +
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28051760380
--===============2442528478780633523==--

