Return-Path: <stable+bounces-249735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK2QMKAnDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:16:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D01A7587205
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 444BE30262C6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F003264EF;
	Wed, 20 May 2026 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izY0XCev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283F2F5A36
	for <stable@vger.kernel.org>; Wed, 20 May 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247001; cv=none; b=WDM+ZicZwSb5szcUDhc7S7evDvN3edpOJW336+5oW5NwhKNCQn+9QixV+ioJChrCyiy1XLSWGHySmCh6OXONXrmCOAQUah+WnYp8+Rszwsk5F6hODqMUW923S6MWXWKn78kOlZyuRNEoZxj6mUnDlhbCJ/tjrPdBD31U67hC54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247001; c=relaxed/simple;
	bh=xthBu8gxp0UE5mwNzRPmM8wXltMSpnPvtDh3L1NwPho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuBF00o31wHbfyqGhOpwKNjFiJK1AXYIgrgPB6sZSyyWp+9dzouYBUShh/d5I3M6P36lZ537jGgH3kc/uskGFu9CgzGksP6R7xK/Z/VW4cm8NNQdrk3YSrijPPNNbx0ZSvAToNSLoz+xiOiPrw9AuHFz+owOw8DXBH7m3NF2DiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izY0XCev; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41651F00898
	for <stable@vger.kernel.org>; Wed, 20 May 2026 03:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779246998;
	bh=hFi454T6jkN3Y3X6t2PdAB5T9v4vTCofDs0Mti0/+5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=izY0XCevpqb3o1cDMk+j/bkKXotSj9MSBwRWBgIorE29ztklO6skZCdSJ0W0j5CN9
	 OxenjITQmNokKxFBG3hKEBV7NlW6ntOHzbFznXtL1FIV+AIvafj88IyGoEkZL8IjCK
	 IcEh0gkBCqnjoXnhGwxh8XUyl4gTpu4GCnPVI34kMfMRyTyVTx4sPlGqjq1OAF0i7H
	 LQkZ4lAjfUNhy8uB2pj8uvyqL807krgiiLl+grhns2R5KXLSdgJ9DNC6XKo/Epxbrb
	 vrw5I5X6X6tmQMNxLII4RG3at2eRXF/qgSFc6+VFjNxHs2Lk1/YbopopX8VC8UUrNu
	 Thi/yubAk3/IA==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44509921fbcso2666578f8f.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 20:16:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ//TA+iRKulB1T0+5tUnVyyDsXY98DMDi2bTJTaCn1j6T1hC+3gFi8XUY4dL/4hDwJnEjDN0DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYgqEN0fHw+tkL+zmP2KoMT9m1mgDFSf/P1kWoKF1xeb0WtgQ
	4oUqKHNyEZ3jgdhERyZU0aTXdjPesLzMiUchsO/ZFY7PxRcxsGyRmYEXMD5mz+/3QaHIOyWlDC5
	919Q0BjPZvQKomFpHuBogDEU7Q11ILOM=
X-Received: by 2002:a05:6000:2209:b0:45e:7418:a3f2 with SMTP id
 ffacd0b85a97d-45e7418a468mr22920987f8f.26.1779246997603; Tue, 19 May 2026
 20:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517092432.1025008-1-chenhuacai@loongson.cn>
 <CAJF2gTSn-44So=SdVYxvF5ihJjWs9R7vFAyuPNpeLBwBpJrY9Q@mail.gmail.com>
 <CAAhV-H4Zvqvb_Crx-cpunZV8tGcFu=2T6x0aG9iV31BPcO5xng@mail.gmail.com>
 <CAJF2gTSAWP4X19t10f8kgd3xdufDEdyc_z4aiaLCmOieMd2ipQ@mail.gmail.com> <CAAhV-H6jKR-i3w3u9CJMLmzteZURQnazuBEtp9k2UkKRxUrOmQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6jKR-i3w3u9CJMLmzteZURQnazuBEtp9k2UkKRxUrOmQ@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 20 May 2026 11:16:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSivSs-3Bd7xCU4mXtVd=8wtuYP+RyF=1jcLpa1CtvF8Q@mail.gmail.com>
X-Gm-Features: AVHnY4IpF_1uRly8kew-C2OgcM9u7PrRTY5U8N38_QM1DmMMob4lNmJxwtn1kxQ
Message-ID: <CAJF2gTSivSs-3Bd7xCU4mXtVd=8wtuYP+RyF=1jcLpa1CtvF8Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Remove unused code to avoid build warning
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Xuefeng Li <lixuefeng@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249735-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoren@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D01A7587205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 8:42=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Mon, May 18, 2026 at 7:29=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Mon, May 18, 2026 at 10:58=E2=80=AFAM Huacai Chen <chenhuacai@kernel=
.org> wrote:
> > >
> > > On Mon, May 18, 2026 at 9:42=E2=80=AFAM Guo Ren <guoren@kernel.org> w=
rote:
> > > >
> > > >
> > > >
> > > > On Sun, May 17, 2026 at 5:25=E2=80=AFPM Huacai Chen <chenhuacai@loo=
ngson.cn> wrote:
> > > > >
> > > > > After commit feee6b2989165631b1 ("mm/memory_hotplug: shrink zones=
 when
> > > > > offlining memory"), __remove_pages() doesn't need the "zone" para=
meter
> > > > > so the "page" variable is also unused. Remove the unused code to =
avoid
> > > > > such build warning:
> > > > >
> > > > > arch/loongarch/mm/init.c: In function 'arch_remove_memory':
> > > > > arch/loongarch/mm/init.c:134:22: warning: variable 'page' set but=
 not used [-Wunused-but-set-variable=3D]
> > > > >   134 |         struct page *page =3D pfn_to_page(start_pfn);
> > > > >
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >  arch/loongarch/mm/init.c | 4 ----
> > > > >  1 file changed, 4 deletions(-)
> > > > >
> > > > > diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> > > > > index 3f9ab54114c5..031b39eb081c 100644
> > > > > --- a/arch/loongarch/mm/init.c
> > > > > +++ b/arch/loongarch/mm/init.c
> > > > > @@ -123,11 +123,7 @@ void arch_remove_memory(u64 start, u64 size,=
 struct vmem_altmap *altmap)
> > > > >  {
> > > > >         unsigned long start_pfn =3D start >> PAGE_SHIFT;
> > > > >         unsigned long nr_pages =3D size >> PAGE_SHIFT;
> > > > > -       struct page *page =3D pfn_to_page(start_pfn);
> > > > >
> > > > > -       /* With altmap the first mapped page is offset from @star=
t */
> > > > > -       if (altmap)
> > > > > -               page +=3D vmem_altmap_offset(altmap);
> > > > >         __remove_pages(start_pfn, nr_pages, altmap);
> > > >
> > > > Good cleanup, but does LoongArch forget to remove the linear mappin=
g? If the memory is unplugged, the mapping is still there. How does the cor=
e fetch data from there?
> > > LoongArch's linear mapping is based on DMW rather than TLB, so
> > > removing linear mapping is unnecessary.
> > Do you mean SSEG tech? mips & csky also have that. But my question is:
> > how does the core fetch data/instructions from an unplugged memory
> > region, given that the mapping is established by DMW?
> Access unplugged memory region will cause ADE exception.
Thx for the answer.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Huacai
> >
> > >
> > >
> > > Huacai
> > > >
> > > > --
> > > >
> > > > Best Regards
> > > >
> > > >   GUO Ren
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren

