Return-Path: <stable+bounces-216688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFyAG7fykmlA0QEAu9opvQ
	(envelope-from <stable+bounces-216688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:34:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E369B142638
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 721323012E93
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4E2FFF9B;
	Mon, 16 Feb 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZmr5E8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8C2EC553
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771238063; cv=none; b=EsjGIQA4RHQwe4on7em8nopyMYxqX0d891X5ZONXbqGvhPjAoeZm4zghp9sDgcDpjyPzldKC898IVhVc2xWET+7t/TswheqGWKaioFReizTkHE283kbndnSWFcaFHLdjUCBgw4XRR0qWhoW8bwLlP27XX1mEpfxhD3WPIc7dt7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771238063; c=relaxed/simple;
	bh=Q2+hdYFmtAqtMLq5tkMs+y+f+ZfaEJRBdIpsjZu0z9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4IJ9ewKVAra2gkx/aI0CEx8dV3jQ+LKqfMN7JpZjcPdTi2LHwl7o5aw9tRrZkSicpGi7u6c+vG1wknXerwT7mO99GLqxCQBXbxN7oSQbb0m4fWrHybbbxkoBCX1un/AZENDfe4KiElN93BfM8RFetqXkscXgFEyFxikDWrnz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZmr5E8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73D7C2BCB2
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771238062;
	bh=Q2+hdYFmtAqtMLq5tkMs+y+f+ZfaEJRBdIpsjZu0z9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HZmr5E8Yxr2sSwM2NhDYJO4EcvdjbLjxsyzGZFJgjJenrLc5BjbcRfn4Hz3pBiqeD
	 CbqyvquORxWmOngSD+c75j0MHWotUbv30t9eVLe3nf18JEjdrEourXDZSGM0PcxlO/
	 QXtQoiLczDOGTzrQ9yllzfUB1i5+b0r/Lcc5286PL/rniAQwEyOn/WrX5/1vYBbXX4
	 9mqdYxcAKHjFCxULE437ojze3bVUQMlTcSoREqPacxWGzxiQOr6Ny8yQij4uIbYB71
	 P2M1G1RVcuWLXZTzTCIrzbMejMp220z4nHeDcWoGUmw6TNlSA0t9GaGhsRglUep68E
	 3OI5Lp0ARIgSQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f7a30515aso386255166b.0
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 02:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvxfxUZCqMO7U20SwTNI2VTh/0eDh6ZdTfTS37rajkNs1PZ8YSWYK750qoGMwEDtYaaxzVefM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEHEBxTE+ngGpfUuAkNyqITRIinN5OkUE83VOyWFQPC6U4xbM
	ihW7XbbxgGZu+X8nZInyDTuLw6PQ58FgNIjMdYq5GnoeHDF9F6WL5Xk4x2MgPZLAejHBoRKLiq5
	s/YQXzwjxHJ9u1+A+MHHmjmfQ9PB+QUY=
X-Received: by 2002:a17:907:3d9f:b0:b88:7431:3942 with SMTP id
 a640c23a62f3a-b8fc3ca80f2mr390011766b.33.1771238061395; Mon, 16 Feb 2026
 02:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215140953.1224579-1-chenhuacai@loongson.cn>
 <2026021631-sabbath-wrangle-3496@gregkh> <CAAhV-H42+WuWpKqFc6MMv8cZ_U8Ve15qtb4DkOd9Yj6Z4ZFE_w@mail.gmail.com>
 <2026021602-unsalted-straining-edfb@gregkh>
In-Reply-To: <2026021602-unsalted-straining-edfb@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 16 Feb 2026 18:34:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4x_739RjgJYmWOXVrfFkAwCf+ArzQHK6i42kUVqTvLMA@mail.gmail.com>
X-Gm-Features: AaiRm50VTFo3OX3Hse0aNUdm3jS1-phvYT_ZMWjuDkhf5xbRCVOepju_XRZEFvg
Message-ID: <CAAhV-H4x_739RjgJYmWOXVrfFkAwCf+ArzQHK6i42kUVqTvLMA@mail.gmail.com>
Subject: Re: [PATCH for 6.6 & 6.12] LoongArch: Rework KASAN initialization for
 PTW-enabled systems
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216688-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E369B142638
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 6:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 16, 2026 at 06:09:31PM +0800, Huacai Chen wrote:
> > Hi, Greg,
> >
> > On Mon, Feb 16, 2026 at 5:52=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Feb 15, 2026 at 10:09:53PM +0800, Huacai Chen wrote:
> > > > From: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > >
> > > > commit 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 upstream.
> > > >
> > > > "kasan_early_stage =3D false" indicates that kasan is fully initial=
ized,
> > > > so it should be put at end of kasan_init().
> > > >
> > > > Otherwise bringing up the primary CPU failed when CONFIG_KASAN is s=
et
> > > > on PTW-enabled systems, here are the call chains:
> > > >
> > > >     kernel_entry()
> > > >       start_kernel()
> > > >         setup_arch()
> > > >           kasan_init()
> > > >             kasan_early_stage =3D false
> > > >
> > > > The reason is PTW-enabled systems have speculative accesses which m=
eans
> > > > memory accesses to the shadow memory after kasan_init() may be exec=
uted
> > > > by hardware before. However, accessing shadow memory is safe only a=
fter
> > > > kasan fully initialized because kasan_init() uses a temporary PGD t=
able
> > > > until we have populated all levels of shadow page tables and writen=
 the
> > > > PGD register. Moving "kasan_early_stage =3D false" later can defer =
the
> > > > occasion of kasan_arch_is_ready(), so as to avoid speculative acces=
ses
> > > > on shadow pages.
> > > >
> > > > After moving "kasan_early_stage =3D false" to the end, kasan_init()=
 can no
> > > > longer call kasan_mem_to_shadow() for shadow address conversion bec=
ause
> > > > it will always return kasan_early_shadow_page. On the other hand, w=
e
> > > > should keep the current logic of kasan_mem_to_shadow() for both the=
 early
> > > > and final stage because there may be instrumentation before kasan_i=
nit().
> > > >
> > > > To solve this, we factor out a new mem_to_shadow() function from cu=
rrent
> > > > kasan_mem_to_shadow() for the shadow address conversion in kasan_in=
it().
> > >
> > > The subject line AND the commit text here do not match the upstream
> > > commit AND the diff is different and you did not explain what changed=
 or
> > > why :(
> > The subject line is exactly the same as the upstream commit (no differe=
nce).
> >
> > The changes in the commit message is because the text of the patch has
> > changed (this is why the upstream commit cannot be applied), and I
> > think the commit message should exactly reflect the text.
>
> No, the commit message should match exactly what is merged in Linus's
> tree and then the comments before your new signed-off-by should describe
> what is different here from what is in Linus's tree.  Don't rework
> changelog text for stable backports, that only confuses everyone
> involved and it makes it look like you are doing different things than
> expected (i.e. attempting to get stuff that is NOT upstream merged.)
OK, let me try a V2.

Huacai

>
> thanks,
>
> greg k-h

