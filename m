Return-Path: <stable+bounces-222883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPYqGdjnpmnjZAAAu9opvQ
	(envelope-from <stable+bounces-222883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:53:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9271F0CA8
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C945630B62DC
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD824318BA7;
	Tue,  3 Mar 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peDMvXcR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDBF29B8D9;
	Tue,  3 Mar 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545404; cv=none; b=ctn2XTBwgnXBHUqKi1bFBGL8SPaHGk9y6bLC+6v49oOEVbM5MN+sQ/fe+jZCBsF5j2ldDE25BaIdJV9eaNXOdR8EBU0dvjSd8cSFZWRTJf2bbhRKyvArM94R/VxGX4hVdlTBZrv732AnRAIYFpSTOd+H7sKzcw8zkuydW7w8/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545404; c=relaxed/simple;
	bh=F80gOnZg8UNeAX2i8hgqbTMYPyiikA8qMzpFtb0BmHY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bxZ/fyx3L8Wj+NLBXkMn0+9mmu7XxPzkLgoiIvP4laGZJuFByQWgfViPaLsiWEklpewV1CbFhiWzD2fZ/9jPBi/GlrqR0TGm5+RkY/E1MucavK+7I2Fn9yradu0YFEtaOKluPf7lvHtcVtQC84lg3MwFo2r4uioK5VHUfeQe5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peDMvXcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEFDC19422;
	Tue,  3 Mar 2026 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545404;
	bh=F80gOnZg8UNeAX2i8hgqbTMYPyiikA8qMzpFtb0BmHY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=peDMvXcRudFi64iepmVQDQab3sU82tjtA3v+K7PXodgSrlJUjyn9KHldEYenfMbel
	 f04hnZlmA44lhAyHRBL3Gm+pApmpG4jgOFRvI6nVFf8y5gLsJrEh0MpY7ERUns/rZr
	 xWmlmXFtQgjovXeHDjtsinUNJgJqLKM7qKHoMfQd8AOBr9KR/mg9BO1oNHzYNt2x8V
	 lYKMrewG7TdIU0rkRRJw8uEwQ409uHIc5S4GgTH4n3RHdOctyaLdEKll4itFqbCKR8
	 +m3yYsGRN56FZ4AM0a/uY4TaGACKgOG4LDmY65Jz5GY6DK2EjGMA4JE4mwcMhogTGK
	 mXYkpwb0gLf8A==
Content-Type: multipart/mixed; boundary="===============6513310970023974767=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10122558b739e833e2a1def0e0de2861be87f53d51b8857c7085ddb5f6057a86@mail.kernel.org>
In-Reply-To: <20260303130208.325249-7-hbathini@linux.ibm.com>
References: <20260303130208.325249-7-hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] powerpc64/bpf: fix kfunc call support
From: bot+bpf-ci@kernel.org
To: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org,maddy@linux.ibm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,skb99@linux.ibm.com,adubey@linux.ibm.com,venkat88@linux.ibm.com,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Mar 2026 13:43:22 +0000 (UTC)
X-Rspamd-Queue-Id: 1B9271F0CA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-222883-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Action: no action

--===============6513310970023974767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 04e76440d1ad..3a6bd12eecfd 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

[ ... ]

> +static int zero_extend(u32 *image, struct codegen_context *ctx, u32 src_reg, u32 dst_reg, u32 size)
> +{
> +	switch (size) {
> +	case 1:
> +		 /* zero-extend 8 bits into 64 bits */
> +		EMIT(PPC_RAW_RLDICL(dst_reg, dst_reg, 0, 56));
                                           ^^^^^^^
Should this second dst_reg be src_reg instead?

PPC_RAW_RLDICL(d, a, i, mb) takes d as the destination (RA) and a as
the source (RS). All three cases here pass dst_reg as both the source
and destination operand, which means the src_reg parameter is unused.

The companion sign_extend() function in the same patch correctly uses
both parameters:

    EMIT(PPC_RAW_EXTSB(dst_reg, src_reg));

Currently prepare_for_kfunc_call() always passes the same register for
both src and dst, so the generated code is correct. But the function
signature accepts src_reg without using it, which is inconsistent with
sign_extend() and would silently produce wrong code if a future caller
passes different registers.

> +		return 0;
> +	case 2:
> +		 /* zero-extend 16 bits into 64 bits */
> +		EMIT(PPC_RAW_RLDICL(dst_reg, dst_reg, 0, 48));
> +		return 0;
> +	case 4:
> +		 /* zero-extend 32 bits into 64 bits */
> +		EMIT(PPC_RAW_RLDICL(dst_reg, dst_reg, 0, 32));

Same issue in cases 2 and 4.

> +		fallthrough;
> +	case 8:
> +		/* Nothing to do */
> +		return 0;
> +	default:
> +		return -1;
> +	}
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22624805528
--===============6513310970023974767==--

