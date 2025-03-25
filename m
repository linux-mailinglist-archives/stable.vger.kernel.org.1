Return-Path: <stable+bounces-126576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1AEA7050C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A461887C46
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843D25BACE;
	Tue, 25 Mar 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KpeE2Fvb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5282566FF
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916525; cv=none; b=hoe/H9/Rjyj6kN+rOO+xjPC+Kddra8gW/Fh9kA6Prp0HEDhJF44DIVB94ukEo19FhJylAVpDJGkGh1rezdD0b3AQWluJEk4F+4kCC09bYtEzIQwULmgSqFNb+01TMI3x+mBAa5+FdEuf8ix1tSQDfxk3XHXP2P9tJlvSKzZJuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916525; c=relaxed/simple;
	bh=kcQ404UfVtlFs133dTuevJrXrKYUFNafkLRf5b05Ot4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2srCNooDnxB3u0SPgyEvTj7obX7C5K8KSgTGltq/K1SbtAIio5/YbOtQCleq5btiTju4QMrZlvVrqnZE+MMdgA37AKOMFjuiNuFP1GkCxjKt+niEDAM4zUR9Xa4RPms/dEWqkxzEoDPEN8rLs+oKthaKBr1ct8SNPDno7JlfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KpeE2Fvb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54996d30bfbso5346015e87.2
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742916521; x=1743521321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpIowmBFf5Qy8Ae0zrn4Bcerv8Y1Y6Ys3FStleidhPI=;
        b=KpeE2Fvb07/zW4BSOqXo+SByI/KqbIVq9Efq28egkEOQV9s68a7iAThPLqT0rybuIe
         hlzEa6+KQIIQmO05sVflvBLs9ryP0SaDnLBDboyc5cQh72WQX4gQtpYZi9niVFuXHBdG
         XViFyYqYhqgj+7jWAYKAwe9jyg17ZfakdCd9NJi7wAYQvF6i4xFk5mAeUAIHixf+ONTR
         sjl5fnDBlmRCP43AMnvS/Yo48QZXYgS5VHwIwf4gu/IwVe2SRVNUbnG1m/b35+DG8Fln
         z5uv4c1pHCax0s+Ad5IMoXdaH/dZsY7Ue0805X++BbDL7eb7sT3whii+m7/nr4Xw+cOn
         WtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916521; x=1743521321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpIowmBFf5Qy8Ae0zrn4Bcerv8Y1Y6Ys3FStleidhPI=;
        b=aKrucqqZNOlfWw0zl8a5O8j9WfYwajA1RVD4UF8Uhg1B2j/uG8BAL1NsLdHWjfZ4KT
         gcAAzPYUrxQ5ESuPirHv1PlKdU60AiJNKowDvUYx0vbFTYKVMr56WRQgWOCP63JV+Pta
         ngYOCRQUzjjZaaVpf3b/cbbA9w9hF86NsbNFysWIfXQdnOKSuTRyZNA+oZU8GjYgFj8m
         OCSxYUw7DpM2ECtYEG+A4WtuBzPCUXqivku5PuZCRqZ78ZgPTrYcZQdOFq+Q8k6+SlqU
         4EjtAJeoEd2b1pCf7QbDN/VNXDo/y4B0dt8rN7vNDrtCTXpoB/BMZJ/5cZT1OCRnRacu
         JnRg==
X-Forwarded-Encrypted: i=1; AJvYcCXWIoHTPcpjlE+gxaWyfjYAnd/cGeWdEPa9Xaw3E7JDmwmfQnCIWup8xDHjPWxvHLGZ2ERRCBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYJAOKR+Dj412PQmvJ6gBtJTjUiUJiaF/2cNfrCrdwH24PmK6
	q/1gJ0eBnBW6JgdrUp7FO+hE03upEpRiuaLlflXaf63pDotPYz7n4XeRuKUViRx+3C+Vr1yFfI1
	tggWhUzDx13aaSaarVsUh6PftdtsHSrOOiB56Vg==
X-Gm-Gg: ASbGncsreDve6K5f2QTaLsPacjr6yWVbpeuAT5XAAfPU/fySR4YYXUqsgzuYXFYfg4N
	eqtCHVUA1hsO4AJ2BdYC/z6I0MvI0r2v4W283/lIolNwMvtdAjK2S0e4SLlUErxiHh21PSDKDet
	uVg4PINjLEIjZYpoWcHtgyT7HNV4Y=
X-Google-Smtp-Source: AGHT+IHHuzvgaGoi3IYfKaD9IljljqpdE7O/p9f3pM7tTuy391dihltaKnTTXwkhhLEWnvuCX+b/asXh+4RCn9Cyesk=
X-Received: by 2002:a05:6512:130e:b0:545:d7d:ac53 with SMTP id
 2adb3069b0e04-54ad64f593fmr6441718e87.34.1742916521114; Tue, 25 Mar 2025
 08:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324182626.540964-5-rkrcmar@ventanamicro.com>
In-Reply-To: <20250324182626.540964-5-rkrcmar@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 25 Mar 2025 20:58:29 +0530
X-Gm-Features: AQ5f1JpSw5TKi_Y1c8mh-PB4ndnV-kqI2GuUqctnrTpScevLhXlYrgKcZl6LIbI
Message-ID: <CAK9=C2WFQxKYnKeteeS94CqfwWkOgMWG69y5WWiun8129z6wsg@mail.gmail.com>
Subject: Re: [PATCH] KVM: RISC-V: reset smstateen CSRs
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: ventana-sw-patches@ventanamicro.com, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:01=E2=80=AFAM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcm=
ar@ventanamicro.com> wrote:
>
> Hi, I'm sending this early to ventana-sw as we hit the issue in today's
> slack discussion.  I only compile-tested it so far and it will take me a
> while to trigger a bug and verify the solution.
>
> ---8<--
> The smstateen CSRs control which stateful features are enabled in
> VU-mode.  SU-mode must properly context switch the state of all enabled
> features.
>
> Reset the smstateen CSRs, because SU-mode might not know that it must
> context switch the state.  Reset unconditionally as it is shorter and
> safer, and not that much slower.
>
> Fixes: 81f0f314fec9 ("RISCV: KVM: Add sstateen0 context save/restore")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

How about moving "struct kvm_vcpu_smstateen_csr smstateen" from
"struct kvm_vcpu_arch" to "struct kvm_vcpu_csr". This way we will not
need an extra "struct kvm_vcpu_smstateen_csr reset_smstateen_csr"
in "struct kvm_vcpu_csr".

Regards,
Anup

> ---
>  arch/riscv/include/asm/kvm_host.h | 3 +++
>  arch/riscv/kvm/vcpu.c             | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index cc33e35cd628..1e9fe3cbecd3 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -234,6 +234,9 @@ struct kvm_vcpu_arch {
>         /* CPU CSR context upon Guest VCPU reset */
>         struct kvm_vcpu_csr guest_reset_csr;
>
> +       /* CPU smstateen CSR context upon Guest VCPU reset */
> +       struct kvm_vcpu_smstateen_csr reset_smstateen_csr;
> +
>         /*
>          * VCPU interrupts
>          *
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 60d684c76c58..b11b4027a859 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -57,6 +57,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
>         struct kvm_vcpu_csr *reset_csr =3D &vcpu->arch.guest_reset_csr;
>         struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
>         struct kvm_cpu_context *reset_cntx =3D &vcpu->arch.guest_reset_co=
ntext;
> +       struct kvm_vcpu_smstateen_csr *smstateen_csr =3D &vcpu->arch.smst=
ateen_csr;
> +       struct kvm_vcpu_smstateen_csr *reset_smstateen_csr =3D &vcpu->arc=
h.reset_smstateen_csr;
>         bool loaded;
>
>         /**
> @@ -73,6 +75,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
>
>         memcpy(csr, reset_csr, sizeof(*csr));
>
> +       memcpy(smstateen_csr, reset_smstateen_csr, sizeof(*smstateen_csr)=
);
> +
>         spin_lock(&vcpu->arch.reset_cntx_lock);
>         memcpy(cntx, reset_cntx, sizeof(*cntx));
>         spin_unlock(&vcpu->arch.reset_cntx_lock);
> --
> 2.48.1
>

