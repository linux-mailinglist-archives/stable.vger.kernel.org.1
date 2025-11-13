Return-Path: <stable+bounces-194717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D061CC591FA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E249E35987D
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB72346FB9;
	Thu, 13 Nov 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxqbiLfa"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D8345CB7
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053784; cv=none; b=PUV00CUpudJqwgSMYVPWBmfPt2P0YlzoMoYd14IXpGbOgy1kb3ELnfgPlV/UbV1nrkdzovCUCe7l+jWb6RFuiQm+uY0ys+KqhIiA4d0mKu5jrtWFAAsvK9gBwKkkT3tXc4+6daLc3x3K9ksF88KKSk00etFweJdSP85N3mG26aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053784; c=relaxed/simple;
	bh=ngM+ZnnnCclHyzCNuDtLEureIeqi7hCbdKN++rJSOvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fghXpZOq7imKoKG6DkChfBurPZh2644VwsdrxKWJqsUGTMxTycTPepTJgdbIkCyRn3h+deiWbSJ+b69AksFyeDpJ4fbZpItS9Adk2IBr3MBajqKYZjF+Mpw1cfCn1thsP4J3DuNuN+KK+q3QR1iWJGBr1xPwcgHoPIhqBzVSduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxqbiLfa; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8826b83e405so15183866d6.0
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 09:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763053782; x=1763658582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59v2C9K0MT9V1ZMYYsj7Kb2V2j1nee4AetdFuk0zEIA=;
        b=GxqbiLfaiObtpW55a3k9bEDPXfXhSvagpfjHwOYu++8b2BhzWFZKgfvNwSoOIGdL4u
         MpTk3ZGknz4ttmY+Fl369O52Iqdx5H2i8YRZtjkbmhAhFQR4KOMy75A79vriC0zvMoDR
         fRvWZAdPW9vHEq88cy6bF5sMBeRnstIC3iuB/q7kvyA+pmbE0kgPQCjgd6OUjh5l709G
         ggWHAf1EKGWuyFFeZRFjBGLr4pWzIOt0gPYpe81Gp4cfj5rG9xf+n8fGaxx2HuBBIjJU
         QpS1tdRl6y9mI8OSSYInV9/v2UG+jxBYgMrQMMwmEAMm+cFwm8no5k14dN/UxytC5Tz4
         IqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053782; x=1763658582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59v2C9K0MT9V1ZMYYsj7Kb2V2j1nee4AetdFuk0zEIA=;
        b=V7yeDr7/aTsCYs6QiAXUjjdgEMRhmL0vdJf3PFAKSADTA5jPElsnHgW7eiv/R9atZD
         tEwNhFed/BencSguPnNK7mmgPanbLLVZ5eK0WyioWuo8bxreSEkg2jihW5V2YR2dAZZ4
         IcwS6IOuO8yt9FaBGyXxPFOenBFu2nS7znhhI/mQ7J1DME+H6sLvB0OiNLxrdrFYvMTb
         pgFcyiRov3d+ezDbZ1l3chCHda6Ssi1KPAiP1ByCrq73OXbSpPh4Fch5BHUoHiSR8XPY
         77ymGOd7YVC0Tak0gqB/GXzIDDtVswAfdftBwB4BjifrAuc2lTy0KtXyFvs4ed+I2ZC4
         Svfg==
X-Gm-Message-State: AOJu0YwPLy9TJuVDHJjtFr9vVd+qZra+YYknOlm79XyEbofoEynxwiRN
	ZeSis6g/DGcPhQRhSMo9yFBgMZ4tkJ2xnrakCnXBjErp83xPsaO3rHiXs7hzoWCaXxGKQY/O3C3
	mfU7k6AC1x7VjanyqDMMab7xK08fv8/s=
X-Gm-Gg: ASbGncvtmRtlilhHlMJcy85w7UWIJAy5lBGebwmsDCLydiMWItWXzWn/I2dLacacpd3
	wyDP1ScJF3CP2ILHPqEdtOmn+6tohYYDGCbWTPXphka32cRqLPkUGAzQNGWARu66Ayj/niJ+2ov
	IPqTkRudrVsOvcC+rxF0ZzBwh6TsFRdo3iY2T0ikOmxyN4i3xKslmwk2q65WzXd3TM4HAN08zc0
	+4kCSH5PEZPaPhTvV0eo9+mgJfDciZqxi74KvnqWmGpUxQNgiTpFWI42A2h
X-Google-Smtp-Source: AGHT+IEqZLl1+tHYHDR+Vslkfb/XS67Qsfc6fga33r3EGGbUMpBnhuclobjuFbTWHxyp3b5YV6T0ODw9wvMZYUfEEHI=
X-Received: by 2002:a05:6214:1305:b0:880:46b6:fe3b with SMTP id
 6a1803df08f44-88271a38db1mr114232936d6.53.1763053781547; Thu, 13 Nov 2025
 09:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113165757.366865-1-vincent.mc.li@gmail.com>
In-Reply-To: <20251113165757.366865-1-vincent.mc.li@gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 13 Nov 2025 09:09:29 -0800
X-Gm-Features: AWmQ_bl3mDPgzWRBGU3E-_JwY0REoBnCikIuNGa80Hpot6iK_81jaa7xJz_ZgGI
Message-ID: <CAK3+h2z-MUYO1rkFfXPPCp1cLDGREzFDAkLtBoGhjEpWx1xwzQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Disable bpf trampoline kernel module
 function trace
To: mchun.li@gmail.com
Cc: stable@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:57=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> The current LoongArch BPF trampoline implementation is incompatible
> with tracing functions in kernel modules. This causes several severe
> and user-visible problems:
>
> * Kernel lockups when a BPF program is attached to a module function [0].
> * The `bpf_selftests/module_attach` test fails consistently.
> * Critical kernel modules like WireGuard experience traffic disruption
>   when their functions are traced with fentry [1].
>
> Given the severity and the potential for other unknown side-effects,
> it is safest to disable the feature entirely for now. This patch
> prevents the BPF subsystem from allowing trampoline attachments to
> module functions on LoongArch.
>
> This is a temporary mitigation until the core issues in the trampoline
> code for module handling can be identified and fixed.
>
> [root@fedora bpf]# ./test_progs -a module_attach -v
> bpf_testmod.ko is already unloaded.
> Loading bpf_testmod.ko...
> Successfully loaded bpf_testmod.ko.
> test_module_attach:PASS:skel_open 0 nsec
> test_module_attach:PASS:set_attach_target 0 nsec
> test_module_attach:PASS:set_attach_target_explicit 0 nsec
> test_module_attach:PASS:skel_load 0 nsec
> libbpf: prog 'handle_fentry': failed to attach: -ENOTSUPP
> libbpf: prog 'handle_fentry': failed to auto-attach: -ENOTSUPP
> test_module_attach:FAIL:skel_attach skeleton attach failed: -524
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> Successfully unloaded bpf_testmod.ko.
>
> [0]: https://lore.kernel.org/loongarch/CAK3+h2wDmpC-hP4u4pJY8T-yfKyk4yRzp=
u2LMO+C13FMT58oqQ@mail.gmail.com/
> [1]: https://lore.kernel.org/loongarch/CAK3+h2wYcpc+OwdLDUBvg2rF9rvvyc5am=
fHT-KcFaK93uoELPg@mail.gmail.com/
>
> Cc: stable@vger.kernel.org
> Fixes: f9b6b41f0cf3 (=E2=80=9CLoongArch: BPF: Add basic bpf trampoline su=
pport=E2=80=9D)
> Closes: https://lore.kernel.org/loongarch/CAK3+h2wDmpC-hP4u4pJY8T-yfKyk4y=
Rzpu2LMO+C13FMT58oqQ@mail.gmail.com/
> Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
> Signed-off-by: Vincent Li <vincent.mc.li@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index cbe53d0b7fb0..49c1d4b95404 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1624,6 +1624,9 @@ static int __arch_prepare_bpf_trampoline(struct jit=
_ctx *ctx, struct bpf_tramp_i
>         /* Direct jump skips 5 NOP instructions */
>         else if (is_bpf_text_address((unsigned long)orig_call))
>                 orig_call +=3D LOONGARCH_BPF_FENTRY_NBYTES;
> +       /* Module tracing not supported - causes kernel lockups */
> +       else if (is_module_text_address((unsigned long)orig_call))
> +               return -ENOTSUPP;
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
>                 move_addr(ctx, LOONGARCH_GPR_A0, (const u64)im);
> --
> 2.38.1
>

Sorry for sending this by mistake, please ignore it.

