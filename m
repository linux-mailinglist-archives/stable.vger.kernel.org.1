Return-Path: <stable+bounces-249580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJY5KVNbDGodfwUAu9opvQ
	(envelope-from <stable+bounces-249580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:45:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6F57EF22
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E261F3061971
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C324A340B;
	Tue, 19 May 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctDSdFNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D774A340C
	for <stable@vger.kernel.org>; Tue, 19 May 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194530; cv=none; b=ufe4uJQp230od7+1Fa9yg0xrE40HjrFyOBHBz9e754SdUGXq3n+H+DK6ABoj/cxHAqx+k8rdWR+QmqjOJ0lnaYdSsegCcZXWO9acX8nlm2ZMd7ZbGYmlub+86blXMj/i4o3LWF2ZeQ8hOzslmsmp4S1hw5NrfYIgsTuOD4JMr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194530; c=relaxed/simple;
	bh=DXoDL5wbX+53q/PO+mVk1bAErki3tsddN3QF3kPdHCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKKSVp49e1mswUnsZuPFvZD9T+qW5PggP/Mf+hIYu5RD9N2aBX5EuidCk1UmxAzIGa1DmWfDE3anj/A5PNqDFuCrV7hBs/Mfq8INdf7W7vDYV2do0GvOujky+MIhZHzfR6PttrtfNgL+FMG2mbrmFwKh7CRSCi5Q7RNgzFB18L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctDSdFNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD0BC2BCB8
	for <stable@vger.kernel.org>; Tue, 19 May 2026 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779194530;
	bh=DXoDL5wbX+53q/PO+mVk1bAErki3tsddN3QF3kPdHCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ctDSdFNyBOHqz6CAcgo9qhEP778cxGNNTgEMvl19T62JurnnLSI9g57UDJnrjqqiE
	 /30JtgjILFNxj5eqC6hxZA6XjSMkF1u7abXrxTZcles4TG7bxxBKY8uRwqE6x9CYLm
	 ZZkUGqDW2uCIYfQb3xTMGCxQQHAnWjMHEdERf7fIPd4HHLGZQ03tmjxXGWznpWqvvX
	 y0/J+dkNtg8zp9NpYjkuO6sQbS5E5YT8+5qq+FxBKK0vFBB3K9yPZtRIxQHGJDJLtm
	 5OqeUOwDQf19fd/ZjKRd5GjPEbGpmhtp91GbX6rIC+x7G4nbhKPSXxQOilfazDlaen
	 Fva94Ni9CGpVg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bccd251d622so598544066b.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 05:42:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8+gqpzuBzniwc6QSI9wQOeXQt8iA9l/vI7D4VhbpVbSbkzXiJRKM1NaFt0zogTox82SHJ8O8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2abE5mtcpshizXkL2Jd3EEgkg/Eurd2UenuBxrCHVRG3uREg2
	kOqPZfJqXCsUz1BVP6Uy/DmpJDgcDHjpuOrxegGflRQr1MLdfFt/XOcihlrCU70r45/SPqxLa1o
	Cb9L3nCxszxsCPCHbFuEXMmY6Djp2cPE=
X-Received: by 2002:a17:907:97cb:b0:bd6:6f5e:ea6f with SMTP id
 a640c23a62f3a-bd66f5efe1cmr680395766b.19.1779194528935; Tue, 19 May 2026
 05:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517092432.1025008-1-chenhuacai@loongson.cn>
 <CAJF2gTSn-44So=SdVYxvF5ihJjWs9R7vFAyuPNpeLBwBpJrY9Q@mail.gmail.com>
 <CAAhV-H4Zvqvb_Crx-cpunZV8tGcFu=2T6x0aG9iV31BPcO5xng@mail.gmail.com> <CAJF2gTSAWP4X19t10f8kgd3xdufDEdyc_z4aiaLCmOieMd2ipQ@mail.gmail.com>
In-Reply-To: <CAJF2gTSAWP4X19t10f8kgd3xdufDEdyc_z4aiaLCmOieMd2ipQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 19 May 2026 20:42:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6jKR-i3w3u9CJMLmzteZURQnazuBEtp9k2UkKRxUrOmQ@mail.gmail.com>
X-Gm-Features: AVHnY4IV41hqOor1MsAuVKl_i-pFwmthCfjFjC_j4Q1cDdRW_i6CJ0nLrPoP7zU
Message-ID: <CAAhV-H6jKR-i3w3u9CJMLmzteZURQnazuBEtp9k2UkKRxUrOmQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Remove unused code to avoid build warning
To: Guo Ren <guoren@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Xuefeng Li <lixuefeng@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249580-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,loongson.cn:email]
X-Rspamd-Queue-Id: 24C6F57EF22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 7:29=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, May 18, 2026 at 10:58=E2=80=AFAM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >
> > On Mon, May 18, 2026 at 9:42=E2=80=AFAM Guo Ren <guoren@kernel.org> wro=
te:
> > >
> > >
> > >
> > > On Sun, May 17, 2026 at 5:25=E2=80=AFPM Huacai Chen <chenhuacai@loong=
son.cn> wrote:
> > > >
> > > > After commit feee6b2989165631b1 ("mm/memory_hotplug: shrink zones w=
hen
> > > > offlining memory"), __remove_pages() doesn't need the "zone" parame=
ter
> > > > so the "page" variable is also unused. Remove the unused code to av=
oid
> > > > such build warning:
> > > >
> > > > arch/loongarch/mm/init.c: In function 'arch_remove_memory':
> > > > arch/loongarch/mm/init.c:134:22: warning: variable 'page' set but n=
ot used [-Wunused-but-set-variable=3D]
> > > >   134 |         struct page *page =3D pfn_to_page(start_pfn);
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  arch/loongarch/mm/init.c | 4 ----
> > > >  1 file changed, 4 deletions(-)
> > > >
> > > > diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> > > > index 3f9ab54114c5..031b39eb081c 100644
> > > > --- a/arch/loongarch/mm/init.c
> > > > +++ b/arch/loongarch/mm/init.c
> > > > @@ -123,11 +123,7 @@ void arch_remove_memory(u64 start, u64 size, s=
truct vmem_altmap *altmap)
> > > >  {
> > > >         unsigned long start_pfn =3D start >> PAGE_SHIFT;
> > > >         unsigned long nr_pages =3D size >> PAGE_SHIFT;
> > > > -       struct page *page =3D pfn_to_page(start_pfn);
> > > >
> > > > -       /* With altmap the first mapped page is offset from @start =
*/
> > > > -       if (altmap)
> > > > -               page +=3D vmem_altmap_offset(altmap);
> > > >         __remove_pages(start_pfn, nr_pages, altmap);
> > >
> > > Good cleanup, but does LoongArch forget to remove the linear mapping?=
 If the memory is unplugged, the mapping is still there. How does the core =
fetch data from there?
> > LoongArch's linear mapping is based on DMW rather than TLB, so
> > removing linear mapping is unnecessary.
> Do you mean SSEG tech? mips & csky also have that. But my question is:
> how does the core fetch data/instructions from an unplugged memory
> region, given that the mapping is established by DMW?
Access unplugged memory region will cause ADE exception.

Huacai
>
> >
> >
> > Huacai
> > >
> > > --
> > >
> > > Best Regards
> > >
> > >   GUO Ren
>
>
>
> --
> Best Regards
>  Guo Ren

