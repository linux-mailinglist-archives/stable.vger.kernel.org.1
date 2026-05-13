Return-Path: <stable+bounces-246722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPoCCAPrA2qzAQIAu9opvQ
	(envelope-from <stable+bounces-246722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:07:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77B52C9D9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C0B030363EE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973803939AE;
	Wed, 13 May 2026 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKH/ADQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00B392C48
	for <stable@vger.kernel.org>; Wed, 13 May 2026 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641594; cv=none; b=TtqWgfbgRslpxbcpIOjPwZkcikEiQbpEOawqDyZzGSzPUZsqHKJBPTEGQAgwshfGhzqUtaLfq2ZsVDay+ivqZg1O2pr7YEQPp9x4jhX+GKpwTdNYBDphu/3YVJYuQk4I+CX9/KJvWJBBnWq92jfqjXjLeGlc4ycaezimlVmrN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641594; c=relaxed/simple;
	bh=2FYu66EO6vVTIr4kxrE0IOHu6oZkI5WGpQMrpxngQ/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPFiZ7KADr6oEJ0JGV4OwOZIEshVC4IRyu0kDXP8W9JxsVK8YYqm7GvdjmGhdE73eAvvrly5a06CmrEonO3RlALc8F0ezEsUMj806cC4va5ZVkznZYa87grN/fTA37MmVqnReFB5JqzVaSL9uRQtAOhUv+rcUpfZOS4L5zefjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKH/ADQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA62C2BCF6
	for <stable@vger.kernel.org>; Wed, 13 May 2026 03:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778641594;
	bh=2FYu66EO6vVTIr4kxrE0IOHu6oZkI5WGpQMrpxngQ/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qKH/ADQUWT4OpC0s44qwsKkp9Q+rL4BS1brg1sSt0mC27D+9BKV/hR+ZcfJM2Z4YX
	 60zE9GbP5P1IO9oo08IOYFnkpmiKapp1ifo1eqQkawI/14P2ty80e1d3YeP37bBGE/
	 MDiLeGW1/mElUaB7VOxBb704iMEpkJ/pBIqL/sTLQaab//0HnpQ8OIwSoTmBx/sJ1i
	 YHtev/4v2a8YaQ606ePAdfGek3Fny4WQBttb1rjAYUVibM8KpA1Cdmw3ts4vnxEaIE
	 b7lLmBJJmJmnIMaBY7+voM6DjD4+EkXFBajFPJCwxteWdVrRLCH41Xa3cYW5ozlxuV
	 tmegyxYbj8XJA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so9709238a12.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 20:06:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8RYw3tuMk9hTa1UwtFbbE7fCjMUFxjXjqDWllIarif2jHMSgAwrGpEPAt7r9lAwQD0AIP4/ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VILxB7KdoixCY1A5av6H027/ASll9D3K0Chi2VhX1CDjFA37
	Rf9FW0GBInz9Yadx1uLc3NiEZCsegR4zF3BiTYsLoklgQyfl7jNeAgP6jbRwk6CPLlWTUmYgLzj
	N08RHoGmnJL6xhHr4LXdvBL27W9eIDM8=
X-Received: by 2002:a17:906:4786:b0:bd3:2b8a:2164 with SMTP id
 a640c23a62f3a-bd3bfb9f635mr84611266b.16.1778641592860; Tue, 12 May 2026
 20:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512173940.376401154@linuxfoundation.org> <20260512205250.313933-1-ojeda@kernel.org>
 <agOhSMXZGSv0bPhX@google.com>
In-Reply-To: <agOhSMXZGSv0bPhX@google.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 13 May 2026 11:06:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6GFmKrJpVgaShCzUigZByvQkXQy_2qGcyaJ089Q6chWg@mail.gmail.com>
X-Gm-Features: AVHnY4JhLdvfmwJivpMfBvuNwmW2QV0KoWSoIRaMnLuYY6_EF5PB2geRX9XhU-I
Message-ID: <CAAhV-H6GFmKrJpVgaShCzUigZByvQkXQy_2qGcyaJ089Q6chWg@mail.gmail.com>
Subject: Re: [PATCH 6.18 091/270] LoongArch: KVM: Compile switch.S directly
 into the kernel
To: Sean Christopherson <seanjc@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>, 
	chenhuacai@loongson.cn, lixianglai@loongson.cn, patches@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1E77B52C9D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246722-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 5:53=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, May 12, 2026, Miguel Ojeda wrote:
> > On Tue, 12 May 2026 19:38:12 +0200 Greg Kroah-Hartman <gregkh@linuxfoun=
dation.org> wrote:
> > >
> > > 6.18-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Xianglai Li <lixianglai@loongson.cn>
> > >
> > > commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.
> > >
> > > If we directly compile the switch.S file into the kernel, the address=
 of
> > > the kvm_exc_entry function will definitely be within the DMW memory a=
rea.
> > > Therefore, we will no longer need to perform a copy relocation of the
> > > kvm_exc_entry.
> > >
> > > So this patch compiles switch.S directly into the kernel, and then re=
move
> > > the copy relocation execution logic for the kvm_exc_entry function.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > For loongarch64, I am seeing a bunch of errors like:
> >
> >     arch/loongarch/kvm/switch.S:201:1: error: unrecognized instruction =
mnemonic
> >     EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
> >     ^
> >
> > `EXPORT_SYMBOL_FOR_KVM` does not exist in 6.18. Does this need a subset
> > of commit 6276c67f2bc4 ("x86: Restrict KVM-induced symbol exports to KV=
M
> > modules where obvious/possible")?
>
> Either that or just convert EXPORT_SYMBOL_FOR_KVM() =3D> EXPORT_SYMBOL_GP=
L().  If
> that's somewhat scriptable for ongoing LTS backports, that's probably the=
 best
> option.  EXPORT_SYMBOL_FOR_KVM() will only work for 6.18, and the list of=
 backports
> needed to get EXPORT_SYMBOL_FOR_MODULES() working on older LTS kernels lo=
oks to
> be non-trivial
>
> If we do end up backporting EXPORT_SYMBOL_FOR_KVM() and others, we might =
as well
> also grab a subset of 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() fo=
r the
> mediated APIs") to ensure a kvm_types.h stub is present on all archs.  Th=
at way
> EXPORT_SYMBOL_FOR_KVM() usage in arch-neutral code will also work.
I have already noticed Greg about this before.

And I think the best solution is to use EXPORT_SYMBOL_GPL().

If Greg doesn't want to adjust manually, please drop this patch and I
will send one.



Huacai

>
> diff --git include/asm-generic/Kbuild include/asm-generic/Kbuild
> index 295c94a3ccc1..9aff61e7b8f2 100644
> --- include/asm-generic/Kbuild
> +++ include/asm-generic/Kbuild
> @@ -32,6 +32,7 @@ mandatory-y +=3D irq_work.h
>  mandatory-y +=3D kdebug.h
>  mandatory-y +=3D kmap_size.h
>  mandatory-y +=3D kprobes.h
> +mandatory-y +=3D kvm_types.h
>  mandatory-y +=3D linkage.h
>  mandatory-y +=3D local.h
>  mandatory-y +=3D local64.h
>
>

