Return-Path: <stable+bounces-241919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO6VE3k18mmxowEAu9opvQ
	(envelope-from <stable+bounces-241919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:44:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC07A497C8D
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A0B302411F
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E43FE67E;
	Wed, 29 Apr 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ox1ppIlM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC4382F1D
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481059; cv=pass; b=j96sWE18k8bQUgCqVVkO0uUorx//gN4ZmClVCNpdbhh+1UvTmXda0YUEMCGA9TLl/jMGW55DmxiY8+Xw1fRsaC/ixWZ41j4rzoJDC9L6ZxL8SJfPVMTvlTSXuH7WwQ17WEHY8qDKrdgsm6oSMcV/syjFBMwINYFayhGXKZ2QS0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481059; c=relaxed/simple;
	bh=lzm3vRpDFy8AEcM2mHbRYMhUPOKAAdECIl6UOorrAdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEimWHGe8tC7/6ELZTfI8/7koDyQhI199F/+wzTnF9B4skuKLznFZblhqMmkxoNaRo7bJmWKyj09WfH7XzkZYkc0poMFzzh5bOeBWiB+pf4+hIAWLkVrCBvsKZEbJ0mYQfxhqL8ZYKRl6Gpv86rG1lx+1qdAWVWqaBoTK/uuA6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ox1ppIlM; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so20224fac.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 09:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777481057; cv=none;
        d=google.com; s=arc-20240605;
        b=jeSeVA1E6kVi4mkL/SNvoZmhTjP7jmygqOH2W5S3CaCp6rJDjhjAEcRkXKL64ftjrt
         bT1i7F+HJVata5Qzs9g7EpOceETMV0EAw/Pt8/X2isz1hP63j+NwrmcHHRvBxGxbQ69B
         SskMJvzAfyplw/5IS9MHb2vIMrI+PjNBRTe73PyZqy0RSytwg4mRYyWN/PK+WqiLnGmm
         pLK7pAvF1qkdhk1ptd6qGXXUqz9EH0W4Kn+tr9dTBbeh99Wz0j+m/9Ay12/MATltieKX
         fQ9N/0mAB3tonnVKN185YRL1JxD/GBrkEbEhFhQARg0ltXaKtXgk7pb1chP6T9wuNWOZ
         zy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wk1Du/x2eww8W9cqGB9R2cmn0/7nSJynF16tBb+L3dE=;
        fh=Yvof8FYjp2HcqTBUyxb/KO/OMq4JGRE+SgSVd4hjskg=;
        b=NQ2x9HQtlskLrKRIzuDkEXVJrHP1EBBOs1ICEN2avhF5DasR51YiVXA4B0Jxj9eYOf
         JNH/kIeEJbVmvdxanfFhlUed+T5EEkYg5BnQE/BoFVyWngF2lORmW4ar2kCvVsln2EC7
         5fkBg8cgM9NZkGeG7M4Csnr5yfrVrDZAzgOHHVPjGrvoXIn1UznIThhyu5jUUkpz+/8r
         zzTAn5oJBGadFG51+5XDE7kWOBc6PHmfOwF89bD1mTWI+rYfdW1Yxci1Bi3VvyzE2p4l
         Ne5kocN5YF6fW+D+dhvqihz9fQA33UcoJ5TTRxlJwvGI+cA7Rn+pbokkynokQXA0iGH6
         bVOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777481057; x=1778085857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk1Du/x2eww8W9cqGB9R2cmn0/7nSJynF16tBb+L3dE=;
        b=ox1ppIlMoE3akwytK5WLrK2TVLnt8sZwX08vKdskycOQ+W7TN7lta2tll8tac7YmXi
         UnFBgNKiytqMfTcDqmWn1K1Kc0tHem803UapQW05xopdoXFMpZvYWPNFxlJthHfdcsNk
         Gef7hw76NLstZdP/zECEZXkZNC54uWrPggvtehpZHywL+jQkqqJDb1EgDjAU4+4fvmqu
         WJ9eZoNGkZ0Rpzk8T7gTSU6uNNN3s1uyobtkJ9wk62IsNmGbp/P2reNP9Hy4lMT1ZFDG
         ZoAP0+gNz9emebdd3n48OH/OY94tucaZ5jsH8j30R2A5cLVUiYfdlAcUqS/4A1YxOnCj
         KOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777481057; x=1778085857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wk1Du/x2eww8W9cqGB9R2cmn0/7nSJynF16tBb+L3dE=;
        b=bXpDpp75K6EOn5iqD1xSCmPwQP3JtBfvysbqyKMcF1EL+Ye9p2rSZmxDtqwHdEeI+s
         jEMtdlrzJo5ONAcvC+HpQPMqUFei9BT8YBphzSQ68iH5578XBk3IAsw/Yw77V/comBaZ
         gHFAJqiZbhGrs/VcqMy0QWeaeJZ/cx5iRqi/oJfcSyTZzr58dgPFRz/k4/v1FuZaCebV
         iWGtf3qurNL4LBKj9mpznbBc0nsvhVmaKtSjsEHa5WZSuOWbgFnI3eLhQoRAf2S5kdTY
         6A2Dt57Mlmhtfu+ORAY7uXYWavX5qrgzZC881TIzqdeHS+kkGmZ98O1da/FFUWstzweL
         BiAA==
X-Forwarded-Encrypted: i=1; AFNElJ/bDly0JHa834399g8D/fCTxvVDEfohHBUnVH/+Ypcn/Yb9UCU56AMGvFGVJuaA34GYYhwacfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywksi3HXEFGSBDzp8/Jt8DtcimvZFOu2QMqXm/744SapG8qyR+E
	e5uKMZg0D+Aw9Vft7P98iAm1coJHuuvCsowzC5p/k0NGk6oC4q8YdzMpvasJ5XxNwtlgR+LDxKr
	Sal0LXyT7JIfwBke5ZdBbVg/ZtKakdjk=
X-Gm-Gg: AeBDiet5OIhdCUppgZeCtwVLvCr3JC55OmdHi94V3jOl4N5UclwX1gxT8YFJOlVuja5
	3UQ1uGd9aBoUzAfkAPjl3n/dxEdW+H58Adjkr6McKQl+r6zUA3MPcezuFMe9aavDVVU47Ses8ri
	7RsungrEdtpmW3Dh0BbaVDaJ+0PE9v4Nvr2pvjp71loOAikvHxj8T6kTvtZD8MP7nX3hdzJ7BVY
	v/JXhHaqfE7spWU6CSD10775iLjiY/nspEfxufRKLL7f8ZM91RM3dcYj8FfaVAsBnI2YHXAe5tn
	Q7+uEQHVlQPrCnXMSY5JBf2SaTOdbiAoN/pLeC4qWLPJzhuj
X-Received: by 2002:a05:6871:582a:b0:42c:6ea:3227 with SMTP id
 586e51a60fabf-4340aae188cmr2594708fac.19.1777481057078; Wed, 29 Apr 2026
 09:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429000623.3356606-1-avagin@google.com> <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
In-Reply-To: <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 29 Apr 2026 09:44:05 -0700
X-Gm-Features: AVHnY4LOIJsAAHwdw0aMFR3Yh66nYh4fPiFWcrTPgmM0OEH19ZvLOJE3i9upzgY
Message-ID: <CANaxB-xvGc1A3Ga_ASh-RZbh0+abxp4e4qbiPKcMJ5-5Wtzr6Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CC07A497C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241919-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]

On Wed, Apr 29, 2026 at 12:27=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> On 4/28/2026 5:06 PM, Andrei Vagin wrote:
> >
> > The reverted commit broke applications that construct signal frames in
> > userspace (such as CRIU and gVisor) if the frame's xstate size is
> > smaller than the kernel's fpstate->user_size.
>
> In the extended state area, the sigframe embeds the hardware-defined
> XSAVE format. If CPU A and CPU B support different XSTATE features, the
> layout (size and offsets) differ across systems. However, within a
> system, the layout is invariant. Userspace can query CPUID to obtain the
> exact offset and sizes, which effectively defines the ABI.
>
> On top of the XSAVE data, the kernel appends metadata (e.g. the xstate
> size and magic values). In particular fpstate->user_size is written by
> save_sw_bytes() at signal delivery. On sigreturn, the kernel validates
> this, which is a symmetric and straightforward check.

First of all, the reverted change broke backward compatibility for
user-space. There are at least two projects (gVisor and CRIU) that
worked correctly before this change. With the reverted commit, they
run into silent memory corruption. We usually try to avoid breaking
user-space like this without strong justification.

As for layout compatibility, in most cases CPU A (older) and CPU B
(newer) have compatible XSAVE layouts in terms of saving states on A
and restoring them on B. CPU B may feature new extended hardware
states, but the layout for previously supported components remains
the same. CRIU relies on this fact to allow users to migrate
processes from older to newer CPUs. CRIU can check whether
XSAVE states align across machines.

>
> Because the format is hardware-defined, arbitrary size mismatches should
> not be allowed. The sigframe should match the CPU-defined XSAVE layout.
> So the change in fact strengthens the sanity check.
>
> > Furthermore, this introduces a critical issue for checkpoint/restore
> > tools like CRIU. If a process is checkpointed while inside a signal
> > handler, its stack contains a signal frame formatted according to the
> > source host's xstate capabilities.  If that process is later restored o=
n
> > a destination host with larger xstate capabilities (e.g., a newer CPU
> > with more features enabled, resulting in a larger fpstate->user_size),
> > the kernel will look for FP_XSTATE_MAGIC2 at the destination host's
> > larger user_size offset instead of the offset encoded in the frame's
> > fx_sw->xstate_size.  This causes the magic2 check to fail, forcing
> > sigreturn to silently fall back to "FX-only" mode.
>
> It seems that userspace could translate the XSAVE buffer from CPU A's
> format to CPU B's format during restore. If so, the frame can be
> consistent with the destination system without modifying
> fx_sw->xstate_size, and the kernel-side validation would continue to
> work as intended.

When checkpointing a process, CRIU cannot determine whether it is
currently executing within a signal handler, and it cannot find
signal frames on a user stack. In fact, there could be multiple
nested signal frames stacked on top of each other if a process
triggered additional signals while executing in an earlier handler.

Even if CRIU were somehow able to locate these frames, extending
them would be impossible. The target application stack is not
under our control, and other user stack data or local variables
reside immediately after the frame.

Thanks,
Andrei

