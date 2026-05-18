Return-Path: <stable+bounces-249252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCNZHTn6CmpF+wQAu9opvQ
	(envelope-from <stable+bounces-249252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:38:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE056BB22
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E17C305817D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A03EC2E0;
	Mon, 18 May 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlK7TH9Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA33EDE51
	for <stable@vger.kernel.org>; Mon, 18 May 2026 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103752; cv=none; b=ja9aV0G7NSLFVaL+swrf7wkZJ5VArPwJVW9ox9rjss84o5Wk9VV2rSt4ioq9gCGHp0uUiB9t0ACMWknRiEg46qbKwwov493uk9IfpmBLlqJFgOVMF020LOXdW2c4Abxhrs9XFORx6Mz9XPlRUxVx5/e/ir5pwcugjKTQ4lwptE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103752; c=relaxed/simple;
	bh=KbabBor54xBK33nwMtrMqpUI7sK9R/iILVn+vEiaIFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iq9c7YWEPTd2iAAs+0cp05jl07iNu8Rsk9+PU0K1YtWO6wYz40DgRb4f7ucX+BaYIc/il/FQ//yqTYewsbjY2CvC8Nnd8o0jqDAv7lEVV6QR1AthhJWziZs4vwG6InKcYdiywhre7yE1lUF1cY3g0pe+fbH8Z/UA0ICgRr11+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlK7TH9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85127C2BCF6
	for <stable@vger.kernel.org>; Mon, 18 May 2026 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779103752;
	bh=KbabBor54xBK33nwMtrMqpUI7sK9R/iILVn+vEiaIFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WlK7TH9QHxRAYFQsczwkbhsr3fu+Q3vBmWcGhHj6YhXFM4kt7I72A7OpHSEhORvmj
	 n05FUAsMY2Xf8DN3z77DZf4te57v/EXINNOPSJPOqZkHA4YsFpI4u4VPKXbr9ZnB9V
	 hSZm/KQ7gJy/JyPne2iJJzvpXZEHj8Koy7XK3aj5laTmrHmQRuoFITRUhDp9TmjKDL
	 TIVA9sXS3nm8hsaMJn9OqL5UPb+46tFZFF5Z8nLYyUJrw/btv9kdQTGQOAWjW8ZaxD
	 99KO8Truf+m8Rn15NlB2uLeIMlHg9qLjPJidSi50vvutVa9aq+KRipostTCUJKq86i
	 V7GmMZ+MYf51g==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4585a116a4aso1718785f8f.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 04:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ83UdBbimOlfUmPoty8Q8ZAZAwH0eXeihbPAjrQI9qFZz2ERZmpITYSBtIXr5i/H103LGTbfbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQHSn8n/6ve6aHDtWeM3ASZbgSmnufatcumroG4nMgCGS6vjj/
	4bLUc2psWQdf4RUTvdiWc8cTQT7kDF5cWpeK6ocV4VJiSZkOKOflbSnfjhufjot/pweub+x/q39
	DDPcAyLVzCeKmCrZ8XgCE2Nz0pHWtbyc=
X-Received: by 2002:a05:6000:2383:b0:449:9aee:4575 with SMTP id
 ffacd0b85a97d-45e5c5ccbf6mr23525653f8f.30.1779103751090; Mon, 18 May 2026
 04:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517092432.1025008-1-chenhuacai@loongson.cn>
 <CAJF2gTSn-44So=SdVYxvF5ihJjWs9R7vFAyuPNpeLBwBpJrY9Q@mail.gmail.com> <CAAhV-H4Zvqvb_Crx-cpunZV8tGcFu=2T6x0aG9iV31BPcO5xng@mail.gmail.com>
In-Reply-To: <CAAhV-H4Zvqvb_Crx-cpunZV8tGcFu=2T6x0aG9iV31BPcO5xng@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 18 May 2026 19:28:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSAWP4X19t10f8kgd3xdufDEdyc_z4aiaLCmOieMd2ipQ@mail.gmail.com>
X-Gm-Features: AVHnY4I8JVtIkj6eFcO1hPldyVb7fH2I0uNTYz-q65m2QrRT3MN7DuJpfsss4TA
Message-ID: <CAJF2gTSAWP4X19t10f8kgd3xdufDEdyc_z4aiaLCmOieMd2ipQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Remove unused code to avoid build warning
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Xuefeng Li <lixuefeng@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 07AE056BB22
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
	TAGGED_FROM(0.00)[bounces-249252-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoren@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 10:58=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> On Mon, May 18, 2026 at 9:42=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> >
> >
> > On Sun, May 17, 2026 at 5:25=E2=80=AFPM Huacai Chen <chenhuacai@loongso=
n.cn> wrote:
> > >
> > > After commit feee6b2989165631b1 ("mm/memory_hotplug: shrink zones whe=
n
> > > offlining memory"), __remove_pages() doesn't need the "zone" paramete=
r
> > > so the "page" variable is also unused. Remove the unused code to avoi=
d
> > > such build warning:
> > >
> > > arch/loongarch/mm/init.c: In function 'arch_remove_memory':
> > > arch/loongarch/mm/init.c:134:22: warning: variable 'page' set but not=
 used [-Wunused-but-set-variable=3D]
> > >   134 |         struct page *page =3D pfn_to_page(start_pfn);
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/loongarch/mm/init.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> > > index 3f9ab54114c5..031b39eb081c 100644
> > > --- a/arch/loongarch/mm/init.c
> > > +++ b/arch/loongarch/mm/init.c
> > > @@ -123,11 +123,7 @@ void arch_remove_memory(u64 start, u64 size, str=
uct vmem_altmap *altmap)
> > >  {
> > >         unsigned long start_pfn =3D start >> PAGE_SHIFT;
> > >         unsigned long nr_pages =3D size >> PAGE_SHIFT;
> > > -       struct page *page =3D pfn_to_page(start_pfn);
> > >
> > > -       /* With altmap the first mapped page is offset from @start */
> > > -       if (altmap)
> > > -               page +=3D vmem_altmap_offset(altmap);
> > >         __remove_pages(start_pfn, nr_pages, altmap);
> >
> > Good cleanup, but does LoongArch forget to remove the linear mapping? I=
f the memory is unplugged, the mapping is still there. How does the core fe=
tch data from there?
> LoongArch's linear mapping is based on DMW rather than TLB, so
> removing linear mapping is unnecessary.
Do you mean SSEG tech? mips & csky also have that. But my question is:
how does the core fetch data/instructions from an unplugged memory
region, given that the mapping is established by DMW?

>
>
> Huacai
> >
> > --
> >
> > Best Regards
> >
> >   GUO Ren



--=20
Best Regards
 Guo Ren

