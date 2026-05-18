Return-Path: <stable+bounces-249258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI/hA+b9Cmop/AQAu9opvQ
	(envelope-from <stable+bounces-249258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:54:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445A56C055
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C0B43044C86
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544833F6C56;
	Mon, 18 May 2026 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duQFcPqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A43F6C47;
	Mon, 18 May 2026 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104696; cv=none; b=URpIT+G5YORN4TfXr1FeZUmUk1pDjZNT5uxfKUvJX8VoOx64NtJniuH85TraVjZEPidRhEbFH/YPkwYEZeBujF2THKCfPTy9dDaQtCtJessuTKkUeErpLNctbIaFb3zaZLgk2CHAizo1/fAvOW8IHdLHeF0MRkTYBpBYMo6YgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104696; c=relaxed/simple;
	bh=pWq9XAxTuPdgs7tFtyzqEWZA5ZkN0qS2ybq5p8QU1aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5vEGCkZhKPPc92zclbyNvi/bkyPci0yncX9BC2lAPxJqcnhwXIvO7BK15b1sp0UuuCwaj2c4DZEFh9MeJSGb0wV8jdMWcwreu0Gh4EfEI+bxVOCqktrsJwENgqHmDHYRaK4fDdTpNn5vSq3CVNer6WstrRrhL136GePTD+5LcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duQFcPqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55099C2BCB8;
	Mon, 18 May 2026 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104695;
	bh=pWq9XAxTuPdgs7tFtyzqEWZA5ZkN0qS2ybq5p8QU1aQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=duQFcPqh2MyBKNEEOMjP5JnEJXjkvYJoZxmfuqnTmcSSYq0SCw9FFzbjdcZrD/5gi
	 /c+se/kTKLdoe636uKqraiRM5/WAv/Tp7sR+6UMijcK/4X3zLrDSqbuRi66eX28QSl
	 u3XjE1CZRq8PXnA+PMKmXtu91Hvu/PoKC/C39HmM6jZcro5P+OKEZZPeZFzD6RSp0X
	 HdjoG81cZYjtGVNbJV8yxRk/Atj2ZuAHzL0sBg4YXkDgOQmPkJX8652QOqOVqIoeeU
	 ZQ7OpukpwEzBlF10kMpynqpvX+EwSTSkVGVZi/C/BHv0szJb9kFS0ecv2rW3H0uFce
	 Om6Y1Ru0qg2hg==
Message-ID: <cf5f932b-6586-4f64-ad2f-c9a6ff81affe@kernel.org>
Date: Mon, 18 May 2026 13:44:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] powerpc/bpf: Add support for verifier selftest
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517214043.12975-1-adubey@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260517214043.12975-1-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8445A56C055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249258-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action



Le 17/05/2026 à 23:40, adubey@linux.ibm.com a écrit :
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The verifier selftest validates JITed instructions by matching expected
> disassembly output. The first two patches fix issues in powerpc instruction
> disassembly that were causing test flow failures. The fix is common for
> 64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
> architecture tag in the third patch, enabling proper test filtering in
> verifier test files. Introduce verifier testcases for tailcalls on powerpc64
> in the final patch.

Build fails:

   DESCEND objtool
   INSTALL libsubcmd_headers
   CC      arch/powerpc/net/bpf_jit_comp32.o
arch/powerpc/net/bpf_jit_comp32.c:232:6: error: conflicting types for 
'bpf_jit_build_epilogue'; have 'void(u32 *, struct codegen_context *)' 
{aka 'void(unsigned int *, struct codegen_context *)'}
   232 | void bpf_jit_build_epilogue(u32 *image, struct codegen_context 
*ctx)
       |      ^~~~~~~~~~~~~~~~~~~~~~
In file included from arch/powerpc/net/bpf_jit_comp32.c:19:
arch/powerpc/net/bpf_jit.h:217:6: note: previous declaration of 
'bpf_jit_build_epilogue' with type 'void(u32 *, u32 *, struct 
codegen_context *)' {aka 'void(unsigned int *, unsigned int *, struct 
codegen_context *)'}
   217 | void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct 
codegen_context *ctx);
       |      ^~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/net/bpf_jit_comp32.c: In function 'bpf_jit_build_epilogue':
arch/powerpc/net/bpf_jit_comp32.c:240:43: error: passing argument 2 of 
'bpf_jit_build_fentry_stubs' from incompatible pointer type 
[-Wincompatible-pointer-types]
   240 |         bpf_jit_build_fentry_stubs(image, ctx);
       |                                           ^~~
       |                                           |
       |                                           struct codegen_context *
arch/powerpc/net/bpf_jit.h:218:50: note: expected 'u32 *' {aka 'unsigned 
int *'} but argument is of type 'struct codegen_context *'
   218 | void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct 
codegen_context *ctx);
       |                                             ~~~~~^~~~~~
arch/powerpc/net/bpf_jit_comp32.c:240:9: error: too few arguments to 
function 'bpf_jit_build_fentry_stubs'; expected 3, have 2
   240 |         bpf_jit_build_fentry_stubs(image, ctx);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/net/bpf_jit.h:218:6: note: declared here
   218 | void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct 
codegen_context *ctx);
       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:289: 
arch/powerpc/net/bpf_jit_comp32.o] Error 1
make[3]: *** [scripts/Makefile.build:548: arch/powerpc/net] Error 2
make[2]: *** [scripts/Makefile.build:548: arch/powerpc] Error 2
make[1]: *** [/home/chleroy/linux-powerpc/Makefile:2143: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


Christophe


