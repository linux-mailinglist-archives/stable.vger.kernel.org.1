Return-Path: <stable+bounces-126672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91098A71074
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 07:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A995188B3A1
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 06:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17ED17A2F3;
	Wed, 26 Mar 2025 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="A+76ePNQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9D33F9
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969672; cv=none; b=geTzVJOylSDXN1sl8ur5/IgYI4vRuUlcERH4heK2GW50GcWhmm2n1FOyamJt3c9Kr8GDDHwsGMzdlWx4LlAgQK7eVKYv5WJRQXBV/r7HY38eNOpXQiOTC4XfM6U6BimuGCcoFAe1/pmwqZFf1uHeRpCTsQ3S3WcUxatqvLPUEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969672; c=relaxed/simple;
	bh=dEqyY35keAEFTPvd1wn3tXQRPCKOteN9F6tBt5zb254=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5iZDZ1Ex9a76HAABUzuLX4cUgW3qoFm7KXKQoEUJz2x7s2zpb5EVNQseBjK1eprOmAPvAQzudyVUEgCqZjoRVQoFbHVBvKO2hQ3s2GPIbmiX1EN1O373KhZl7JxCMLSiO1wO7qHS4UQ3hj98vs5Ti8ML4+OiJnd82S/QZftGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=A+76ePNQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549644ae382so7983543e87.1
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742969669; x=1743574469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lug6QStK5gIrcz8qsBdfkDEK4mXQAgF8JIO50Ngtkug=;
        b=A+76ePNQkJSx51+iGiiM5zdeKcb3+XZJ8SVozxd8Rh6de5hFdRuIcYJIPrf7vhoJQN
         rdqI9KscRLYd1qM1XmnQfc47NWD0pCELHwAsUGUXiSN/kNPfh1V+9Cp3878+CJq4bGZy
         rglXsDFlGUxXkIuloip0kAqbFsFVh7FJRJPOMT6OPVh3eVXac9rCLvJadtFBjOhFsrH0
         oKJCAjNHmN4HeKzREa3+HoFt5hagr0Z6pU63hiTrzQ7yLsk1YPDRfQokDyLNFwr/IMOy
         gnbg/MBvn8JYDacbGvLq/0ZhVT17wxXZJIpcS1a428qo3pg64OurFOM20sTpF453El/g
         5OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742969669; x=1743574469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lug6QStK5gIrcz8qsBdfkDEK4mXQAgF8JIO50Ngtkug=;
        b=gIUJzIiGCgnzwkADLgl7xe3aGKKWEuNulCkfIbvfxS0ebUyKWLOjiLVAY4qf+0HI99
         Ur+QLM2elIjEwWjLNpFf7u67mksA92Jwdzf970+LEpHCtKEdPtTsMsUphtvlt7y5gWCV
         0dSoNuFr2AVkFuWo7vd6wWIw2ZIWfFImgPFX6PMjDXj/8RgB1qbBmiAHIjma8R6kiJei
         aFRkFsuuw2AkzceVxEibUCT2wM4Kv210mDA5LU+2pwG1+87Eg6PI05elTQvgB+pQ6qDn
         WNAsJwA76zvKJrj9lDrIqs1Qlv6sFhDgLaIDrTjvDEx1V8l0qUEQquzlhTYTqIoXDX6+
         pvCg==
X-Forwarded-Encrypted: i=1; AJvYcCUUQ9279QL9ZFlYGzJw+Q5h+1gbnBkXH3fRI3LWbcazOO0fYLC4u/B39hHbk9KLjQxIW0fp61M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX8fpPvmFw0q7WHuzDI8ljHEWfcwScgcryo26lndUNZHB4n1Ho
	dhdl9ILvdee7Sr2imsT3pvzu3BRYVDTh7JvMvRoZBOVHfaK0MK3ipZSGA0Izkm8IJz6ZdNqLg4r
	tkvMLIL1CDrZIwyrhvRQNWY701MKdsCQlROKztCZ3ONFmK/76
X-Gm-Gg: ASbGnctmeA+jPw5aFXMQz5wSX0TDgNzdLWfxDw5jgIuclbGFTQ/+YTuSOOR2t7aysuW
	5NgKKuFH3xSA7I+duULjcmuKeWRx1RqbxMt6VM4EzzCj5hbIM9Be1MEVeU1MB6cdlcDlisZu+1j
	h7vJpDq3VYZp/FT3rYwsyojnOs
X-Google-Smtp-Source: AGHT+IF/4MbBeOg6xuWXY9zxIVY5Pq5wo31nlZNsl/g3Jvkai8f2HSkmEjuWuYrta5J3CLzZ1xWowlHP+LUvrio7GiY=
X-Received: by 2002:a05:6512:130c:b0:545:b28:2fa2 with SMTP id
 2adb3069b0e04-54ad6476fd4mr6243908e87.7.1742969668552; Tue, 25 Mar 2025
 23:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324182626.540964-5-rkrcmar@ventanamicro.com>
 <CAK9=C2WFQxKYnKeteeS94CqfwWkOgMWG69y5WWiun8129z6wsg@mail.gmail.com>
 <CAK9=C2V90_GX6u_M2hOh62J1xxVx-ioenSqz316BNWPt3Lr0dw@mail.gmail.com> <D8PIGUPV6622.4Z9G0C5FRLRK@ventanamicro.com>
In-Reply-To: <D8PIGUPV6622.4Z9G0C5FRLRK@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 26 Mar 2025 11:44:16 +0530
X-Gm-Features: AQ5f1JpBqAu2v4aL-V0BwHRfXC36GAzl4kDe43P9DEt27RgPdzY6RTF8JFjM6us
Message-ID: <CAK9=C2Wze-O0ozpdg5SZ8QMnx60ezVrwsWx5SZO-cW-cwGYVKw@mail.gmail.com>
Subject: Re: [PATCH] KVM: RISC-V: reset smstateen CSRs
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: ventana-sw-patches@ventanamicro.com, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:38=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcm=
ar@ventanamicro.com> wrote:
>
> 2025-03-25T22:27:41+05:30, Anup Patel <apatel@ventanamicro.com>:
> > On Tue, Mar 25, 2025 at 8:58=E2=80=AFPM Anup Patel <apatel@ventanamicro=
.com> wrote:
> >>
> >> On Tue, Mar 25, 2025 at 12:01=E2=80=AFAM Radim Kr=C4=8Dm=C3=A1=C5=99 <=
rkrcmar@ventanamicro.com> wrote:
> >> >
> >> > Hi, I'm sending this early to ventana-sw as we hit the issue in toda=
y's
> >> > slack discussion.  I only compile-tested it so far and it will take =
me a
> >> > while to trigger a bug and verify the solution.
> >> >
> >> > ---8<--
> >> > The smstateen CSRs control which stateful features are enabled in
> >> > VU-mode.  SU-mode must properly context switch the state of all enab=
led
> >> > features.
> >> >
> >> > Reset the smstateen CSRs, because SU-mode might not know that it mus=
t
> >> > context switch the state.  Reset unconditionally as it is shorter an=
d
> >> > safer, and not that much slower.
> >> >
> >> > Fixes: 81f0f314fec9 ("RISCV: KVM: Add sstateen0 context save/restore=
")
> >> > Cc: stable@vger.kernel.org
> >> > Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com=
>
> >>
> >> How about moving "struct kvm_vcpu_smstateen_csr smstateen" from
> >> "struct kvm_vcpu_arch" to "struct kvm_vcpu_csr". This way we will not
> >> need an extra "struct kvm_vcpu_smstateen_csr reset_smstateen_csr"
> >> in "struct kvm_vcpu_csr".
>
> It is tricky, because kvm_riscv_vcpu_general_set_csr calculates the
> amount of registers accessible to userspace based the on size of
> kvm_vcpu_csr.
>
> We'd have to make changes to logic before expanding kvm_vcpu_csr with
> kvm_vcpu_smstateen_csr.  At that point, I think it be much easier to
> just put all csrs to kvm_vcpu_csr directly, which would also simplify
> future extensions.
>
> > Other than my comment, this looks good for upstreaming.
>
> I think the current version is more appropriate for stable, and we can
> implement your suggestion afterwards.

Sounds good.

Regards,
Anup

