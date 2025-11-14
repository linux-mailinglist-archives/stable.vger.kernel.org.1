Return-Path: <stable+bounces-194762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F96C5B577
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 05:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93FAC34A609
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 04:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E72C1581;
	Fri, 14 Nov 2025 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO/LGYuP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCD27F005
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763095404; cv=none; b=Jh7nJm0Bpnk45MVq08RYAZFasjV3f41t2vp9VroSDvxR2iywBNGPhwCnita3jzPLf1qzDhp/doZ9tiRVVVsmuo+0eUWWzn2AvKgvCC4SXcQOt43ahH1AX+6OVFZGDusNzekPTjKRGDs2rvM6Y+uvJfyKvqg2MgEe6XmKwmoKp/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763095404; c=relaxed/simple;
	bh=+03OWhWsCvHzUD3ujcRTYP+YuL6pz1A99+XVZIy6Juo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc6jwUAzjuCSpPHEU6bli0Yizxkj6Ct6mugBQcOvsIp1zL063dgF62zpKakfBMNGWEs+q6gO/5Byfin6KT9aqb8RRr4b6z7oVR2YNbu0jE2rc0WdF/wvfjuY5ky9WJWeObhrR+jupnlDINKFbAW9QJSLCiQMrTe4Er8pO6Igjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO/LGYuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F66C19422
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 04:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763095404;
	bh=+03OWhWsCvHzUD3ujcRTYP+YuL6pz1A99+XVZIy6Juo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pO/LGYuPW7kxS8NnHFWpPpSKKsxLgNYceZyPnKmT6v+j2IZnq5uAtz/BtGnjyb8ed
	 V+X4+nXvpR9BjCOd1rc/VbV/TCpCvC5Vdg2iHzyrFi6ItUzN8UANVt/Y0pzNwR3BHm
	 aZ8BNtflvVgUlm/v5yPKsbYl6JLPZZnXfhiECxs9wqkjuTdRoGchx6najjGY/5QOm/
	 ffHjaxioQLONc6QJ9N+vLnEWqgkNIB6Cjqb619TFYmbauwNO3876WiqIpPh72SHvww
	 PswcRwxdoT7kP1Je77MinAw4iytbFpK1DCPUf5ktZSKeZClOCckghwMQ8A2gOQPue2
	 IynME3Fn1Pmyw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so2544461a12.2
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 20:43:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9VUCYsc1K4IhW8YSKNav6aISr+RCT7ryMgndD0hcckLtZHrMVFSgbPZWA+f2odOLFUG/h5fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHli2SgDjAFiAH7Ddv4fX7fvDLloS+yK0A5RJFh+nu6ak3qB3A
	6+dno/kGJqgPjIyidYcZx1RMAaqlMk4awxamzBHpFt8jh4O2KIXK5eercKjrSSvZ8EoUUJZZX1c
	RNIqtVe9k+BHPKrALYpODkZ/avEvrM5E=
X-Google-Smtp-Source: AGHT+IGq/umpnn8/eAmEEcMc8Ns51UhVdQNa6hO5Gi8p4v2IFeBEKMGs2H6kwjwevwsFnsYaIdyNz5Qr8lBWm2rFsIM=
X-Received: by 2002:a17:907:3c93:b0:b70:c190:62e1 with SMTP id
 a640c23a62f3a-b736793d2eamr150090866b.35.1763095402925; Thu, 13 Nov 2025
 20:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113170651.367092-1-vincent.mc.li@gmail.com>
In-Reply-To: <20251113170651.367092-1-vincent.mc.li@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 14 Nov 2025 12:43:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6-TxBj18hiTU_E_x2BPnQ5G6gfwmkCquu+-bb7TZR_Fw@mail.gmail.com>
X-Gm-Features: AWmQ_bmQIJNIoVh4tO6f2OiLc8IS63LkXrfJ-KBQ6TJPopb2qi43god49fzZ1Nk
Message-ID: <CAAhV-H6-TxBj18hiTU_E_x2BPnQ5G6gfwmkCquu+-bb7TZR_Fw@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: BPF: Disable bpf trampoline kernel module
 function trace
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: Chenghao Duan <duanchenghao@kylinos.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Fri, Nov 14, 2025 at 1:07=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com=
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

