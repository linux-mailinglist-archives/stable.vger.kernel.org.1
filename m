Return-Path: <stable+bounces-103686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5AD9EF919
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78FA18998A1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA72153EC;
	Thu, 12 Dec 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H88hyPxq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242E6F2FE
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025304; cv=none; b=jsJXSAkGuF22/0cWWRFfc6htMxyBO93enFXnrimFf6dYzJJAbScJGEio7JDxT/su/2GyFHHmNXgvc+roWEnpqqX8dXaiHj4oMBumZ/8ro5Ugg2bjZW4yoBr/g8sdcMrc9FZw+W7OzuOrQIkHsCTiH9svnPgRQYssQAWk41dl1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025304; c=relaxed/simple;
	bh=v6WIqyhhl0Zr5vLxR46O1ZEdTswWNqigsAv5x4xb7aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPrho2qwqJoJz/nksTTeAoqmpgRbmb3vvzBc7J9n3Onms630uB1iFZOr7q1BhsvGolGiR3GLjSwvWYFpIzGeBsXGxlh2iCPrEOHdPbcNTUsPzWZg09+3vv96+czHd2qHSMeaMjgE2ZodzxXVwUMgb4EFtvk8U86pXqH6JFDXPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H88hyPxq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4678c9310afso309711cf.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 09:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734025300; x=1734630100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbhcdDXDREjgn9eplzkHshNSc2l/7sNrQ8gJKXb8n4E=;
        b=H88hyPxqk9gRktsCpcogWHly91iEc6lrohAyWaMjz/mls3HA+uDazhAvAsif5qPiMS
         dNJ5HmXWIeKYyJfBF6TD2vCRF2e+BJdF4MDHdFoRolNSowJS18Cd7z5Zc/7ONlXE4N9u
         SbneQK+FQvMwAnhHBtoskk3o6N9wGwIbphZftJzmEgA08C57iPFjROfnDAnZ2JVCI19R
         ux5OOD+VEVKZokWqD128BuKvY5xCsQfg8aC+biwweI/JU/P0xJsGDAhBmA88V9JAJ6vh
         v9sUFNjB4lrflIS+8hbUxSh2IdW7+lcD4FAh44VvpjDMEqGlNC9G6FSutjMXjtpQrXyI
         Gjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025300; x=1734630100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbhcdDXDREjgn9eplzkHshNSc2l/7sNrQ8gJKXb8n4E=;
        b=mmx1pXveA2uJSs5JC0wrUlQ6ZuC1FI+TAJMXvhkQAi0oRHu73Kjb3qZl3UJZiIH+Uq
         BR0Hypk8chfOUUNMMA+zm1GQ/UnSXdh5nDnfjdk5JhO3spkPw5ObuYk0vcer8MOMH2FI
         xUgDtUWcKQGylzLyzSAE5pl/TcW9yICqV768zXtHx8iqrpQ1XbeVddE8V3dFsFJZKt9E
         pSBnns2dHup3gCWG6R5l5MQOoKvbdLjZrxvSSg4ZlVzVgnV1vtzxz3dsBLUnFiiZGQJA
         BcIdx6k6sL57cTwm4Sbj/J5V0I7LlKyk2dQxIOdG7myqwDKq0egkPgDj/VA9yjLatzB4
         /JWg==
X-Gm-Message-State: AOJu0YwMmdnRI44UglxRzaAfE4V5rV3Nqld4s2Xb6VhinQBSoYgNIx2F
	05tLtuiTWbDPfQ8dLfwBAb33AsSbY8KRFDWZTic8VBb5h8Y59ZK7rUO8EUJL7BUUpHR0DeV2C71
	SRK13O/m0ysPYmw743ZPePWO78BD2ZU6itQhb
X-Gm-Gg: ASbGnctxlB64AVqW/S2m9QBAZ0VEdHVl3T7e5L7zR2cqJ7x2pCqvVkWuAxKeTPnqdOc
	9iX4tU7560n/jND2sG12S9rf5Fjr5VfOJ43OZ2A==
X-Google-Smtp-Source: AGHT+IGyL3hD6AVdp/DmP7j9kHC1HsUTSXZjHF0q05nNxAJPoCobagh5aKucd0Xms6/hkoHpH81IHgBGSU9hEQvhKQU=
X-Received: by 2002:a05:622a:40c7:b0:465:bc11:c481 with SMTP id
 d75a77b69052e-467a0eefdbdmr1460311cf.1.1734025299632; Thu, 12 Dec 2024
 09:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024120223-stunner-letter-9d09@gregkh> <20241203190236.2711302-1-rananta@google.com>
 <2024121209-dreaded-champion-4cae@gregkh>
In-Reply-To: <2024121209-dreaded-champion-4cae@gregkh>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 12 Dec 2024 09:41:28 -0800
Message-ID: <CAJHc60zMcf7VZKwc61Z3iGaWHe_HayhViOv=rdFxwoRB=AyH6w@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for
 overflow status
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

This is an adjustment of the original upstream patch aimed towards the
4.19.y stable branch.

Thank you.
Raghavendra

On Thu, Dec 12, 2024 at 12:27=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Dec 03, 2024 at 07:02:36PM +0000, Raghavendra Rao Ananta wrote:
> > commit 54bbee190d42166209185d89070c58a343bf514b upstream.
> >
> > DDI0487K.a D13.3.1 describes the PMU overflow condition, which evaluate=
s
> > to true if any counter's global enable (PMCR_EL0.E), overflow flag
> > (PMOVSSET_EL0[n]), and interrupt enable (PMINTENSET_EL1[n]) are all 1.
> > Of note, this does not require a counter to be enabled
> > (i.e. PMCNTENSET_EL0[n] =3D 1) to generate an overflow.
> >
> > Align kvm_pmu_overflow_status() with the reality of the architecture
> > and stop using PMCNTENSET_EL0 as part of the overflow condition. The
> > bug was discovered while running an SBSA PMU test [*], which only sets
> > PMCR.E, PMOVSSET<0>, PMINTENSET<0>, and expects an overflow interrupt.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 76d883c4e640 ("arm64: KVM: Add access handler for PMOVSSET and P=
MOVSCLR register")
> > Link: https://github.com/ARM-software/sbsa-acs/blob/master/test_pool/pm=
u/operating_system/test_pmu001.c
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > [ oliver: massaged changelog ]
> > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > Link: https://lore.kernel.org/r/20241120005230.2335682-2-oliver.upton@l=
inux.dev
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >  virt/kvm/arm/pmu.c | 1 -
> >  1 file changed, 1 deletion(-)
>
> What kernel branch(es) is this backport for?

