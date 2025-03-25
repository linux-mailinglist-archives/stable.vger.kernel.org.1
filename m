Return-Path: <stable+bounces-126589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72B5A70776
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 17:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51485167DBF
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6725332E;
	Tue, 25 Mar 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="loEPtfLf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A92036ED
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921877; cv=none; b=XS5xqIMaQyeSD1XIX/opKTWVbAtkXbCCt3qZFIW+Uumq4zfbHFOuFipqCajjChPxNUBoxHv6xGTPVNwS5o+mkJtb0V7BK5QU9Btyb+UWpSEYTe0xsf4iJ2rPCtj5ZcCC61LpNlOVFK2SNpY8SeLcrAUWj5MFdxoxILSJ0n5qiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921877; c=relaxed/simple;
	bh=hSo0IzBem6tTvhI21RgdgloEACTojt3ymhYBbJrlj/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/COzDq5cqRlC+kB+eDQgHVRjnSQlyLQSWvxAZhAqFDj6CTZxzyy5qijk/hgoF3Uvuacz+9BGgekUBr/pJHOmcu4IxlJHJeClY+d78mxXBhj7b2/2xIdmsJrAIo2wO2NYPehRuEH2jcnFtxs29FLx9t8ZdQwSWaCg/ZwAGS0DS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=loEPtfLf; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bef9b04adso62099911fa.1
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742921873; x=1743526673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTw8poJXscXq4T1N9RTVzFy8iPDV68AiEJFtNfKqVcE=;
        b=loEPtfLfNp0+Tod4RWvvEJywFGw9wFcKZQgT04B5PV1oUElA+wMMLiYefoRqfQ8tSc
         zdUvtyEJo1LpGT4ji7YawP0zfFm08XLpa+FfUY7cIiyF1RLLvoIQr8Tsn8j3lI0s1z2a
         phbsFcRYR3WUMduHIQEI/zqgfQdNqcs4Eor4f4wkkxItKqGd8ZTlwbCW9igQoYDQkR+D
         hvCiIIn9D+JaLCNiRI6KaDrSBOXadgVqp7LMYdOhc1Oy00eXRcw0iPY33nFDWVmaNjTC
         n2ft1EN8plNX0F8RZta5zDqkELeHQEi7lO8WyNvz9yPyArfgHQwMxdyuAQLV73Ei7uoc
         xkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921873; x=1743526673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTw8poJXscXq4T1N9RTVzFy8iPDV68AiEJFtNfKqVcE=;
        b=BE/hZD1jr2aVIy5yeCWAbd/Xaz4q3HMUU1E4CbjZ/ZhYAiqo4VjR3QaqDP6tuS6Bd+
         536r2U1ny9jnI1kYaEcu4GljdevmMiJ+r7GJAeWXleBgdm7wOPkCCjhiUHOBrv3iYvhF
         SJBeoyPqM38neWKViCiTciAbSGdwF8RgZoqdjhZmDBSik8J5EG+xHNdm+N5kGEem7BUh
         hTECNAUVjwIc8lmqkPbLO+miwAunRVMxjkOwdlzdGq6LaMBZy0l5jNMtq9xWKXiZsTuK
         QinrEcEEwO9lsOz6gg1zDjQSZ5F7P8pHRrhTkYJdF76k0cY/Ez6nJ/MuALhV7cpOaVJ+
         3uKw==
X-Forwarded-Encrypted: i=1; AJvYcCUeDQh7c+GvQVkzW129yv7XoHSmUseiZyYvSwlj1IXdeHvx99oeyC+NWNVhZGaIfOvvqVVsnGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBzdtA6OR5DeZIkYuYpvynJppWlT7YUG/uq3uQGgfVHx40pRe
	zcPwkZOzxxRVQKWPScAhnlgdN0fiWUamB1V5O8jyhJMJb72lgUZPYDpOfc1gp/5OgKAAMWWS4XR
	rDexz/crc5Ai0B8ZnOdReSOkUNRxVpluB3clt+w==
X-Gm-Gg: ASbGnctQvS2+KUNBV+MjAMDUeIRkSXlnKA9KALCO+FUy6Vg9UVnkvVQffLJw+TNqkD3
	RepizLmbaZ/lAjhrQIDXrEYk88R5ozYJgxTL9El1VVfJOJNyyjCt1U5mNIF1TMK/MIKtuynl1tS
	32dFeI78+RkUtKYn55D5h5pzC85uqJw9X4P/U1zQ==
X-Google-Smtp-Source: AGHT+IFMpmv5D2TzWt+YxjbR3nR1TrszC2sHNKVoX9BUFluVoE/fgvkxbJ/d3y2ym+HI1YO+RODl+Oa/5iMyup+U5dM=
X-Received: by 2002:a05:651c:2220:b0:309:26e8:cb1a with SMTP id
 38308e7fff4ca-30d7e2aabf8mr69622361fa.30.1742921872855; Tue, 25 Mar 2025
 09:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324182626.540964-5-rkrcmar@ventanamicro.com> <CAK9=C2WFQxKYnKeteeS94CqfwWkOgMWG69y5WWiun8129z6wsg@mail.gmail.com>
In-Reply-To: <CAK9=C2WFQxKYnKeteeS94CqfwWkOgMWG69y5WWiun8129z6wsg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 25 Mar 2025 22:27:41 +0530
X-Gm-Features: AQ5f1JoJL2mzyvlIsRLaIHrvn3mU2mR1sndLmetBlVazABYwF9hMTbVZII6rtms
Message-ID: <CAK9=C2V90_GX6u_M2hOh62J1xxVx-ioenSqz316BNWPt3Lr0dw@mail.gmail.com>
Subject: Re: [PATCH] KVM: RISC-V: reset smstateen CSRs
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: ventana-sw-patches@ventanamicro.com, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 8:58=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Tue, Mar 25, 2025 at 12:01=E2=80=AFAM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkr=
cmar@ventanamicro.com> wrote:
> >
> > Hi, I'm sending this early to ventana-sw as we hit the issue in today's
> > slack discussion.  I only compile-tested it so far and it will take me =
a
> > while to trigger a bug and verify the solution.
> >
> > ---8<--
> > The smstateen CSRs control which stateful features are enabled in
> > VU-mode.  SU-mode must properly context switch the state of all enabled
> > features.
> >
> > Reset the smstateen CSRs, because SU-mode might not know that it must
> > context switch the state.  Reset unconditionally as it is shorter and
> > safer, and not that much slower.
> >
> > Fixes: 81f0f314fec9 ("RISCV: KVM: Add sstateen0 context save/restore")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>
>
> How about moving "struct kvm_vcpu_smstateen_csr smstateen" from
> "struct kvm_vcpu_arch" to "struct kvm_vcpu_csr". This way we will not
> need an extra "struct kvm_vcpu_smstateen_csr reset_smstateen_csr"
> in "struct kvm_vcpu_csr".

Other than my comment, this looks good for upstreaming.

Thanks,
Anup

>
> Regards,
> Anup
>
> > ---
> >  arch/riscv/include/asm/kvm_host.h | 3 +++
> >  arch/riscv/kvm/vcpu.c             | 4 ++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm=
/kvm_host.h
> > index cc33e35cd628..1e9fe3cbecd3 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -234,6 +234,9 @@ struct kvm_vcpu_arch {
> >         /* CPU CSR context upon Guest VCPU reset */
> >         struct kvm_vcpu_csr guest_reset_csr;
> >
> > +       /* CPU smstateen CSR context upon Guest VCPU reset */
> > +       struct kvm_vcpu_smstateen_csr reset_smstateen_csr;
> > +
> >         /*
> >          * VCPU interrupts
> >          *
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index 60d684c76c58..b11b4027a859 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -57,6 +57,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcp=
u)
> >         struct kvm_vcpu_csr *reset_csr =3D &vcpu->arch.guest_reset_csr;
> >         struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
> >         struct kvm_cpu_context *reset_cntx =3D &vcpu->arch.guest_reset_=
context;
> > +       struct kvm_vcpu_smstateen_csr *smstateen_csr =3D &vcpu->arch.sm=
stateen_csr;
> > +       struct kvm_vcpu_smstateen_csr *reset_smstateen_csr =3D &vcpu->a=
rch.reset_smstateen_csr;
> >         bool loaded;
> >
> >         /**
> > @@ -73,6 +75,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcp=
u)
> >
> >         memcpy(csr, reset_csr, sizeof(*csr));
> >
> > +       memcpy(smstateen_csr, reset_smstateen_csr, sizeof(*smstateen_cs=
r));
> > +
> >         spin_lock(&vcpu->arch.reset_cntx_lock);
> >         memcpy(cntx, reset_cntx, sizeof(*cntx));
> >         spin_unlock(&vcpu->arch.reset_cntx_lock);
> > --
> > 2.48.1
> >

