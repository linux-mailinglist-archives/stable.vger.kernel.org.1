Return-Path: <stable+bounces-166802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B3B1DDAC
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 21:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657CC58554F
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450121C9E5;
	Thu,  7 Aug 2025 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSaCC3rT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED51E51E1
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596134; cv=none; b=nYb9VMmnzR6Fzz+pIiTE7/+gMSHF7VX+jDk4uxiwXudZK8v4shsbLFe3KKiGt4jLbFq0N6UvEAO/0189B7dQS9F2yHHnoj/9oG3BdXAS5knESm0Tz26tjmw5urdd3lt+VXWiZg1rbPXe3g5fIMwbwKfi2MIB6mBXN312mwADjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596134; c=relaxed/simple;
	bh=RIo76mvyq5VwQpunHgBEWm/3E3MErf0Q3HmctD25xyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwuoq/yVgDyE144YeJT5OdzcwIrEcs1BpoQEiYn7JR85t6M+yFiRCOCd+vrIf7dBQ5XeSQKjYnzeF8h/AB+Quee3EnCB9tF3888XgyU56gb6pDUgI8WYf7t/64U8ASsIOHcdLjSbGw8nkEUP1vc97gUTJ9y30SMU0KxjVIO1J/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSaCC3rT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso56271cf.0
        for <stable@vger.kernel.org>; Thu, 07 Aug 2025 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754596132; x=1755200932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wFSxnKwuzrZsGAk9Mi7JG0vUdJDMSQzEw25HyCDeLo=;
        b=hSaCC3rT5H1hjeKDQqClPYl0p8l99VAzb0pPmGbf1AUIj3O91e2VQTB9+hmlSLiQ0q
         pvRH1Z8fRVweARUF5zaTIbAgTwyj7F74sHveWZ0Emq5J/0QT7sh8JMjYN4zfMoWf2Ykv
         XpG2QFFSR4j2IMg+q3Fd8A5iTj+FR6mjyl4/pqhegnSjrE039isEh1Bzgu9/JSiKAUKN
         6bfv2wvUoLqCKpNdzSt1GqaWJQPK19f9PSp4Ty7FFzGNcgfZhXsbnUFU6XHewOA8xa5l
         Rb5rjbVOgLtAcBnirlHP4YSxe0YC13CUwtLDq1gzRpaqq8tBxT0tdOr7mVdWZTmYHeAf
         patg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754596132; x=1755200932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wFSxnKwuzrZsGAk9Mi7JG0vUdJDMSQzEw25HyCDeLo=;
        b=SpXTDLh5NKE4LcPHw22D9uHmLtJki0CyTGVN1Ft0s2x00hn6RzFr3lcixM2u2mZi3B
         ACP3DkZRFnPO6h3Uy4Y38Gk0LczLqWsAT8Zz0vR/fhn34QXy9hVKkPq0abC6FZbkwvfb
         cp9uWxKEAFMqE1My07KKa+H0jwETxM5w7yEHdDUCk0me7ZNzFpnEvF4ODoJ9JTJUMYAx
         HgoBvkVDpzXOsW1Fx8QlUCgp5lo25FpAlr9YLj/NMMAO9X5NU5HSTxvL/S4mH1X/QKGB
         ctJa5NPqBMp5t/knKZkFZFgKzs7thAvQNDEniEb/1E81lCHSjrvFgtDtSTi0mE0ri+Fb
         xmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeXCy2Vc9ldo9oFyNugR3p3kIDSDfd+ycNBeT3uFnS0glp8XF07dnJWqVS38tj1/hLI1F4cwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwA54dSTCBKy7Bbw3AX/tZaoOy9ZODnrNsKDXchKFeb5OEKHZH
	cKegCVOfd20zLYaFCH6dYNTZoQOrVFLc3gmlxlWhW0t2ZDlp8ta6SaxE/fxqpTV4ACVgwe/tH02
	eE0gCC8+yMgmPxZ7Ptt8n0u+Z0YwBsKqxq/PuseOP
X-Gm-Gg: ASbGncv0JHNkfPbctaHzApqK7COxkpAzca6LwesZIYm1lvRPFynfCDqPrQSXfgogs2S
	6dg9Sw1tmNq6c54eU8/JDEGbhKlDrlOgJkzsjApUzPpyYeBDYK9UWS8u17oZxu6PoJAPmI4MLA8
	srjNqe+ufYW36og3IJ2/vw/5d3m6MmHYa/DBdmw7GFFqetT/bEaOT2OdKCyslQp6Qrut+H8eRdk
	xgbs2/zam7BzrFXZqLzlLYoCImZzNTGWGGurJb3Y7KlZg==
X-Google-Smtp-Source: AGHT+IGAnzFGc75ayYfRxWbh7uLxZSTdYzNMshPpWSpmNdU9XPko9zKPro5GAtATFgigXkkdyna/EGGm8ixjXrUw3W0=
X-Received: by 2002:a05:622a:5d0d:b0:4a9:e34a:58a1 with SMTP id
 d75a77b69052e-4b0af27f42fmr657231cf.21.1754596131723; Thu, 07 Aug 2025
 12:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806220022.926763-1-surenb@google.com> <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
 <CAJuCfpExxYOtsWZo6r0FncA0TMeuhpe3SdhLbF+udtbqQ+B_Qg@mail.gmail.com> <43f91e3e-84c5-4fd1-9b63-4e2cb28dab36@redhat.com>
In-Reply-To: <43f91e3e-84c5-4fd1-9b63-4e2cb28dab36@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Aug 2025 19:48:40 +0000
X-Gm-Features: Ac12FXwfQ6qiGrsCKNHq-ologii6PPu3d0YnpfdjkTe6XUo0_mB7-54uzVqhRMY
Message-ID: <CAJuCfpECC9w6RdfbH34Y906uV=egUDct=6H54Xn79okKK80cjw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD
 is a migration entry
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:42=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.08.25 17:27, Suren Baghdasaryan wrote:
> > On Thu, Aug 7, 2025 at 3:31=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 07.08.25 00:00, Suren Baghdasaryan wrote:
> >>> When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
> >>> obtaining a folio and accessing it even though the entry is swp_entry=
_t.
> >>> Add the missing check and let split_huge_pmd() handle migration entri=
es.
> >>>
> >>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> >>> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> >>> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@=
google.com/
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> Reviewed-by: Peter Xu <peterx@redhat.com>
> >>> Cc: stable@vger.kernel.org
> >>> ---
> >>> Changes since v3 [1]
> >>> - Updated the title and changelog, per Peter Xu
> >>> - Added Reviewed-by: per Peter Xu
> >>>
> >>> [1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@google=
.com/
> >>>
> >>>    mm/userfaultfd.c | 17 ++++++++++-------
> >>>    1 file changed, 10 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >>> index 5431c9dd7fd7..116481606be8 100644
> >>> --- a/mm/userfaultfd.c
> >>> +++ b/mm/userfaultfd.c
> >>> @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ct=
x, unsigned long dst_start,
> >>>                        /* Check if we can move the pmd without splitt=
ing it. */
> >>>                        if (move_splits_huge_pmd(dst_addr, src_addr, s=
rc_start + len) ||
> >>>                            !pmd_none(dst_pmdval)) {
> >>> -                             struct folio *folio =3D pmd_folio(*src_=
pmd);
> >>> -
> >>> -                             if (!folio || (!is_huge_zero_folio(foli=
o) &&
> >>> -                                            !PageAnonExclusive(&foli=
o->page))) {
> >>> -                                     spin_unlock(ptl);
> >>> -                                     err =3D -EBUSY;
> >>> -                                     break;
> >>> +                             /* Can be a migration entry */
> >>> +                             if (pmd_present(*src_pmd)) {
> >>> +                                     struct folio *folio =3D pmd_fol=
io(*src_pmd);
> >>> +
> >>> +                                     if (!folio
> >>
> >>
> >> How could you get !folio here? That only makes sense when calling
> >> vm_normal_folio_pmd(), no?
> >
> > Yes, I think you are right, this check is not needed. I can fold it
> > into this fix or post a separate cleanup patch. I'm guessing a
> > separate patch would be better?
>
> I think you can just post a fixup inline here and ask Andrew to squash
> it. He will shout if he wants a completely new version :)

I wouldn't do that to him! :)
Let me quickly send an updated version instead.

>
> --
> Cheers,
>
> David / dhildenb
>

