Return-Path: <stable+bounces-216683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GKkJOTskmml0AEAu9opvQ
	(envelope-from <stable+bounces-216683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:09:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE731423C4
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFAA8300EF86
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5A2F6922;
	Mon, 16 Feb 2026 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMICYFBm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08282F744A
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236575; cv=none; b=YlbyF8PmbdDavmr6FaR0Ra1uKsgShnbIltcoA1Cvy+314tQXUY+8FuJxkJbISFFvn/1ys/VHird5OPKlcn+ahnPnrSaL2iZTo0pKTuSZYUNfrjPf+R43dZV2ST9wbVZEbEBJGWuarNIwa/+ytH13sWxiJQk0V2ltcMbMh1jHruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236575; c=relaxed/simple;
	bh=qBExBGT1EG48SF428uTWG1DV7WLLwl2Q0J8FpvAshs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr4vZtLmCbnpucXR5wycc9mQbOcQ6T0s8p1yLAKYRDglZt1QcnM6IpBfnzwq4YPe5FFeJ0TXNHztdthYF9JX0AteAsfyaF6YdiiVrGBtb2smAn5keCipvh69lh5zmb2ROc0ZG2qXMrGQgmxXQ2AcidHQSqDoQ2zSX6QBCwjLzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMICYFBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB07C2BC86
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771236575;
	bh=qBExBGT1EG48SF428uTWG1DV7WLLwl2Q0J8FpvAshs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oMICYFBmvOvGW9EEZh28ZlpdeiHg5cDFiGV7o8537fTO8Ki4rnTGxBUAqL2UFFh/q
	 nCBindk6ZxoR3TKzyI/vkUAgAmlZYYYQRDaqxXBBOUS5gfWgZST85NIkY/R2/LIOt8
	 dg5R6tvWDNHdu98C1HaZVWhuMpnVH5hRk1hh8aCLUzprUviXh9FV7zlbXFzzmI05gE
	 FyZQt6wIOV95jZNXFw+ggJg268OSdzCoFMewFlV8OkkSsRaKbvPF8vptqqncAOtJ4G
	 MLH2vjZEcoRMCN524yDP4HAUbR3Qh2oPRSCbgWdc1+SSzcjZEit6TQAgjazUuYk3vj
	 57pbFkr4mKvEg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65bfe9c585cso1360018a12.0
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 02:09:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUID/LtbiAYhGJhBrmcCNvjDqxq5sVNM0ROa6QxF/6sTG/HX3HFz47R6SLQVQTtCTCKhXm842c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBrjZd4e5Jh+MhQ9xGh3I1xC0wsJ2l3iymRPaa8ffn+4VNhqU
	SM6kOOm5TV/Yc3bPE7E44DZvg9hqMLhG/h9aq4NxI8d8S7wkrm9nWmuNKsdmjMg1RjzcBqFVojU
	NnyV65ik34upgopLAF1gqRMUm+6WyFrg=
X-Received: by 2002:a05:6402:520d:b0:65a:390a:205d with SMTP id
 4fb4d7f45d1cf-65bc7a70774mr3297588a12.24.1771236574077; Mon, 16 Feb 2026
 02:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215140953.1224579-1-chenhuacai@loongson.cn> <2026021631-sabbath-wrangle-3496@gregkh>
In-Reply-To: <2026021631-sabbath-wrangle-3496@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 16 Feb 2026 18:09:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H42+WuWpKqFc6MMv8cZ_U8Ve15qtb4DkOd9Yj6Z4ZFE_w@mail.gmail.com>
X-Gm-Features: AaiRm51YipyZEoWSnk97F2pgSJm5zm7gXCz2pXNmDpBDeQkfx3eZt7kf_J8eAXA
Message-ID: <CAAhV-H42+WuWpKqFc6MMv8cZ_U8Ve15qtb4DkOd9Yj6Z4ZFE_w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216683-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: DCE731423C4
X-Rspamd-Action: no action

Hi, Greg,

On Mon, Feb 16, 2026 at 5:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Feb 15, 2026 at 10:09:53PM +0800, Huacai Chen wrote:
> > From: Tiezhu Yang <yangtiezhu@loongson.cn>
> >
> > commit 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 upstream.
> >
> > "kasan_early_stage =3D false" indicates that kasan is fully initialized=
,
> > so it should be put at end of kasan_init().
> >
> > Otherwise bringing up the primary CPU failed when CONFIG_KASAN is set
> > on PTW-enabled systems, here are the call chains:
> >
> >     kernel_entry()
> >       start_kernel()
> >         setup_arch()
> >           kasan_init()
> >             kasan_early_stage =3D false
> >
> > The reason is PTW-enabled systems have speculative accesses which means
> > memory accesses to the shadow memory after kasan_init() may be executed
> > by hardware before. However, accessing shadow memory is safe only after
> > kasan fully initialized because kasan_init() uses a temporary PGD table
> > until we have populated all levels of shadow page tables and writen the
> > PGD register. Moving "kasan_early_stage =3D false" later can defer the
> > occasion of kasan_arch_is_ready(), so as to avoid speculative accesses
> > on shadow pages.
> >
> > After moving "kasan_early_stage =3D false" to the end, kasan_init() can=
 no
> > longer call kasan_mem_to_shadow() for shadow address conversion because
> > it will always return kasan_early_shadow_page. On the other hand, we
> > should keep the current logic of kasan_mem_to_shadow() for both the ear=
ly
> > and final stage because there may be instrumentation before kasan_init(=
).
> >
> > To solve this, we factor out a new mem_to_shadow() function from curren=
t
> > kasan_mem_to_shadow() for the shadow address conversion in kasan_init()=
.
>
> The subject line AND the commit text here do not match the upstream
> commit AND the diff is different and you did not explain what changed or
> why :(
The subject line is exactly the same as the upstream commit (no difference)=
.

The changes in the commit message is because the text of the patch has
changed (this is why the upstream commit cannot be applied), and I
think the commit message should exactly reflect the text.

Huacai

>
> So as-is, I can't take this, sorry.
>
> thanks,
>
> greg k-h

