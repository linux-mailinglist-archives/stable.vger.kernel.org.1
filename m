Return-Path: <stable+bounces-214331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAR3Lx54g2mFmwMAu9opvQ
	(envelope-from <stable+bounces-214331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:47:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B36DEA77B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59D36300D4C7
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FA0338922;
	Wed,  4 Feb 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3tYiww6c"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004733890A
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223608; cv=pass; b=UUDVhdzvbYHhVQvlbFB9YOanDTCMplw9LWOYNB3g3wLc0eoDXKmKoxXPnW7eDvOMUOjsWtn47whZXbxoawvXUtM0c2/vx2gbxuNyyn0gaGA1wpcPSLMz772gVwshOA+MEhGL8qJGBTBJvSsyC08hcKKo2vsHqAk/UU8dzmJFRF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223608; c=relaxed/simple;
	bh=GuDdEDTx6jqo86jDKae5LLsjrHGR1rOWzeioqAUpz7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5M6XxY/kFIcU7OOq6FrQZBQmbgQWB5/8KwVgIMdCqSc6hO36oFluZ5vHOsunCslTRQF8AAsNNvLDogRJOgpQU9b9OK1tnthaGb/wP546ZXaPs0csll+6SqLtXJyjjpqlnJdppYM/+cteRRfD7ZKXQB9d5lPe7DsVtCQu1w6rG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3tYiww6c; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50299648ae9so572171cf.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 08:46:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770223607; cv=none;
        d=google.com; s=arc-20240605;
        b=c5KjpgdfBBC75HPi3tAcVVzhk6c75nNucPWn1LlcX0q5h02otoyKBEiHorbe/Tsnki
         ZLi1OHYObz0WC/yIn70Gvnvum6pPQWFvqE++OGz16UuejqojxThjx2kHZ1wwEr6GzTAL
         zpRXKS8nNbmaWYpdeoTlnvC2AQsPmR0UEKYjsmb4sTFZ0bHeoIDT8vE3mwBhY73cDCGS
         UbLX86T8cbebtyiDTQRsRaHm+enroTBINVi8P4f0dR8UDH2KiNHtnbBONBuY3w4Dieav
         aFFqLeqS4jIASV78lCnbPbJTMP1sqgNkuzBl+IQlBVXTgkgVwG3tFK1IJfwjnPNUtZRp
         RH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fxhu04OAvpDfoeT5InEkoDqVAH1C962dtOlYUArfHyE=;
        fh=XG5vVwEcZnIcIreul/JofQVcQ9rN0Y+ryIvw7JCrHJk=;
        b=BLMz80yJv2jChbD1GppnWJehaP44vPE4o/nhvPIeBzM8Fbdop/vPxA4QczUSMwFnEY
         YXC/YJo6AvdPFWOP0n16FkFqof6cNfboGDqYVClMFXlwBvGUSxzqWwBOEhwvTSaAGwsr
         8fwJuIxW3RWnk7ZrFFd7+bx1yn7kqe+DdyFOkKJN4ZulhAM7Fb5qh2mAMBr+byMmr9Hy
         oipj0uHm2vM8dg44RRiz+LPIAztW3+hMH04PWgoPD1nKn5yGYgZcrBCV9KKmZv3EP6G5
         PL+IkV/vPpcCkGB+YiXFa0MaV8XHQZoKyf5RZEhnhMHk9lddBZRHsM2EgdpVZwzTsKnY
         vUoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770223607; x=1770828407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxhu04OAvpDfoeT5InEkoDqVAH1C962dtOlYUArfHyE=;
        b=3tYiww6cIq+DIBwIjPwaMtjkvFwbzmYivNko/vjc5ToRLVdikZ0Otw3rdNHHagMP9T
         iCs7P9oxYZwlccjB5NN0rb3bEoLd/3CVQJ0CyTVWk7MyCISzeR66jinwc7MN8lDw3quv
         5YLcSZ/tKBupngd2wMc0fwQ7y79PvI478KXKwxTGaorr9dAGRE0dDsSg96QlFuIqvzGo
         lamUSYXZH0ZxbPojBlarLyDMq5rUeiFfeBOWMzpPcXEdNhYMcsHZqIcAJF3nF2BJBriv
         wWTffoIS+LacZHcrETcGRlguPQTFSiBIogWC+v/GwGg3+H5vbmOPMBBDmbxIxzZKypmA
         yaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223607; x=1770828407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxhu04OAvpDfoeT5InEkoDqVAH1C962dtOlYUArfHyE=;
        b=FcnGmYN0mg8FYcAxgkWvf+HJj6dmOHn4wJr4msAGkfw2N+YlOh68oWXqu+zWuX2OaF
         xzzshNqfeOMq0EKJxFxlSJSj1dC4+qQG7ASyke81R2rVNbbRDMQe+5HknMGORtipxfJU
         9Ty6TQnfvEC3iQD3or7pxp3xOvvLMA8Dt5lhaUv7bWU55ZZmH9Z5gdvfyazGifH+dKEF
         01FG/aQnD1VFF83zC1e3OMJYEi1X6vwud+0S/bVYeg7pz2CtJa8Gy+z5K8+JsUdWpDFL
         UuwzEXwG+S0PMx2YZFfMA1aXtuNwuV57ixSXEKZNuuD23vp8uhmOqKfMM2vaWS2Jgv8Q
         kPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDGYCrg77mEy7W0y11i+0UqYcHjQ45DHXN+0zEppIB1IEAIOM3Ct651LUCjRPRZ6RNTa2Bf2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0VEEO5giv0J7BRCAi24mQZl33w7fupwSn4Lupk30RZGmyaGw
	8tHrITznXIFsNvpmySS6UBVvAayilPqk4c1BSyhrSw6uA4kB76yc0wpxm9gJxNMiEqmlvFHEuCW
	j24aJaYyDSVIC9Tp/TtIWQDxGjv7MYucyaz25xct0
X-Gm-Gg: AZuq6aLTdnnlwKVtbFEqzHPlYdhYZF/lu5XHFthzAoW27iTCtVH+rhrFahuChTpno2h
	IKwBaP0wy27++cA09bfL6YE94gNqY8AT1kaFJ/g984Kjud6poI9HiP9roGKqSD4uVKn4G6cVXqm
	a6eEig+EMVFmpnKYunvR26TTtQqxHQRvXWrqM075GdnxCBpux4I/KPfkiCcZanIQCJaCoC3vvk7
	y0T7ihbG1EmQbgRy41AX7rTJO48KuXBxpb/NRwFYzb0HbqZji/l6UmaH3RBjEyff+yJJ2T2CKB0
	Rd9LWL/pUlp0d0H3JN2ZLZ2Q2Q==
X-Received: by 2002:ac8:5750:0:b0:4ed:a65c:88d0 with SMTP id
 d75a77b69052e-5061c3c6ed1mr14901671cf.6.1770223606526; Wed, 04 Feb 2026
 08:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026020303-drippy-appliance-a74c@gregkh> <20260204002654.1462558-1-sashal@kernel.org>
 <2026020419-extortion-swinging-6394@gregkh>
In-Reply-To: <2026020419-extortion-swinging-6394@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Feb 2026 08:46:35 -0800
X-Gm-Features: AZwV_QgktQI-U-2cz1KZyg814_EvzKKRB5FUYNdIaeW8UD1HDjUFn6kcQetyzPo
Message-ID: <CAJuCfpHGM0apXNe4nW_5vTNzEBLGvEHduoiHpHhs70+qmeFMLg@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] kho: init alloc tags when restoring pages from
 reserved memory
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Ran Xiaokai <ran.xiaokai@zte.com.cn>, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214331-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linux.dev:email,zte.com.cn:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 6B36DEA77B
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 1:59=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Feb 03, 2026 at 07:26:54PM -0500, Sasha Levin wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > [ Upstream commit e86436ad0ad2a9aaf88802d69b68f02cbd1f04a9 ]
> >
> > Memblock pages (including reserved memory) should have their allocation
> > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> > released to the page allocator.  When kho restores pages through
> > kho_restore_page(), missing this call causes mismatched
> > allocation/deallocation tracking and below warning message:
> >
> > alloc_tag was not set
> > WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU=
#1: swapper/0/1
> > RIP: 0010:___free_pages+0xb8/0x260
> >  kho_restore_vmalloc+0x187/0x2e0
> >  kho_test_init+0x3c4/0xa30
> >  do_one_initcall+0x62/0x2b0
> >  kernel_init_freeable+0x25b/0x480
> >  kernel_init+0x1a/0x1c0
> >  ret_from_fork+0x2d1/0x360
> >
> > Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> > fix this.
> >
> > Link: https://lkml.kernel.org/r/20260122132740.176468-1-ranxiaokai627@1=
63.com
> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation=
")
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  kernel/kexec_handover.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index 03d12e27189fc..db08c1a2e1f80 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -260,6 +260,14 @@ static struct page *kho_restore_page(phys_addr_t p=
hys)
> >       if (info.order > 0)
> >               prep_compound_page(page, info.order);
> >
> > +     /* Always mark headpage's codetag as empty to avoid accounting mi=
smatch */
> > +     clear_page_tag_ref(page);
> > +     if (!is_folio) {
> > +             /* Also do that for the non-compound tail pages */
> > +             for (unsigned int i =3D 1; i < nr_pages; i++)
> > +                     clear_page_tag_ref(page + i);
> > +     }
> > +
>
> Breaks the build :(

Which config? I built both defconfig and CONFIG_MEM_ALLOC_PROFILING=3Dy,
they didn't fail. Could you please send me your failing config?

>

