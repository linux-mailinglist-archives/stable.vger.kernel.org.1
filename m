Return-Path: <stable+bounces-166791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27FCB1DAC5
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 17:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF52C563462
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB4264A9D;
	Thu,  7 Aug 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHmbndFI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B7267B89
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580443; cv=none; b=BZbXQs7H5Kvye6v/aZKC40pt8hVmw00tI8H1rOxEfEV84jMKwYAOqJyZmzme32p40bKhTG5Hph6hwdsKSv45tbnOvlxo8xDhPlgVirREtN2K2mAS66bbljc9d6E4aNWxUrLf/uU0lK1BFUsJhznjC8R1Nf9P6xJKuEkxnPHJtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580443; c=relaxed/simple;
	bh=mL1pBirMJzEme72kKHRF2wr+5TBxmQNWIHDsAk3E3ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iu+n50EbZ0YwfptgEipVwycLlQTkwTM8jaRcpBGR0E/7O3CoVqb1Tc+X7gIOkTRF/uCCipHWoVo5jHoIoE4dKzJ3dpRUHIWuyweUCn9+rtGLNRzO7Ogl7wgsapps/Jn42reKVNktMTcb0IBiS6gEgiIQ5A+ZuyUZXSLUUVxK9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHmbndFI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b0673b0a7cso342601cf.0
        for <stable@vger.kernel.org>; Thu, 07 Aug 2025 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754580440; x=1755185240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xioyC2IWw8hko9lVkldYv22q6OUtLq1NUecRh4m4n4o=;
        b=PHmbndFIDSUTUf4WhUbdxhBmexysSjqB8/Z5jnubC+HbH09kJYe5yhENPI9XvvtIEd
         D/rv1OyTXi/9FQ8mHlt+RWGgwa8c1tsTKhu8VbK+k+DOF9wbEw1TlFKNcd7fS0VwJiQg
         rvNA2OpL9s3NyUOAc43xqZoU/QygIiqT5SNcSUssKBlV4u61tNJ0t1ytxdZ/Nt7u6F4H
         bP4yP7U8zyXO2nxQiqM22an/+sDb1UwG9Xs4b2dOYJy/qZcL3MQkYrwIt7tr32iQXEQF
         saytPcvWSqv03P6unxcjGK7dKsp8FhLYBuIeQ/87l+d/VRtD5BwS7gr4KlMtNLlI1hTR
         hYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580440; x=1755185240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xioyC2IWw8hko9lVkldYv22q6OUtLq1NUecRh4m4n4o=;
        b=siKmZ8VGB5gdrjRe9YywTCRKi2uM65BTXPiQ3tG9TbLGfWxFwLlBeox1dRtAGR+sy/
         WD/tfOMy7E5/RVmIpl8lGrGY/gOYws7YvYTb/CbU1j3csSjk/AQ8AlKdbZ3jviodmUuN
         YrV432ZE0HcBnx7xuCFs09tO2Sg3AKHEhPvVcD/IsV1u9TzRAijGWtGw5uGiOatLjvrI
         qYjgr/8OF1sf96FMmwMHOXl097giNjhniAB6vCsADPiIB0LJafHTU0XlqbizuPN3Du3q
         labNI7ZB01NhyxyfIrQRNEOir8EnOKsTF/S1N7Vl9cWdTrYCDyV67DyowlP7cjxvP1Ca
         kkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTvQJ3StZhrOSv8bHR23WjEYTHOOHfhgnUJ0s60lNOLUZPUgdasQiByCH19NQQZZZKHstqNC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXSMF12xAxjZw9urTQ5Rfu/Ku11NiSkkw4J9TXgtHU7YEf98KJ
	7Yv13Rae3Wf4kmH+cjM2kF8/PQd1LqVNBbBf2LBrknaa/PyPkrOqpXEnuLLInygVrm6XLOZVXo2
	CnDHXeuP0H8Y2i3kWhfwLjsktGHT8HZzGra6cH0X1BA1OsDdhQwhopQb8
X-Gm-Gg: ASbGncsaWOEwHbhYAPxjVt+lHo84BjfpVwEWiUn/tUMDr10fhDBu9uyaDDnWnboM3bi
	DM8phS9oOEZ/GVgmBb5rbeLpqMG9Lz5WHs2UyAHCIv4vwGccrByVNvpSL8EZl/X08Q+hDBR5M5o
	cr9Aof2La2lyunEAbo9EMthkZueDLIAXGIxnijcT+Kzz31zwWNsLoDVFiOuAtAjEt2bzLJ/ZlfZ
	wsPROV7qU/JHVE7jK96u+qAznOMI5+sJ8k1YAWQNQWq7xPR
X-Google-Smtp-Source: AGHT+IGqSzXAmTUh3Qi2CUJgK4pgM8gORIxm8uH+FHAhS4VzwkyY6xnxbuHT0p3P7PQwzevNQcRG65DrMC35ALNZ2Dk=
X-Received: by 2002:a05:622a:41:b0:4a9:a4ef:35d3 with SMTP id
 d75a77b69052e-4b0a6dd90f8mr4013581cf.7.1754580439612; Thu, 07 Aug 2025
 08:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806220022.926763-1-surenb@google.com> <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
In-Reply-To: <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Aug 2025 08:27:07 -0700
X-Gm-Features: Ac12FXw0D7Y6MNnLaNuzRlNa7wyKoBPDReSLik-x4NPnGAkXfZmI9tMKxVv_LLY
Message-ID: <CAJuCfpExxYOtsWZo6r0FncA0TMeuhpe3SdhLbF+udtbqQ+B_Qg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD
 is a migration entry
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 3:31=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.08.25 00:00, Suren Baghdasaryan wrote:
> > When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
> > obtaining a folio and accessing it even though the entry is swp_entry_t=
.
> > Add the missing check and let split_huge_pmd() handle migration entries=
.
> >
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@go=
ogle.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes since v3 [1]
> > - Updated the title and changelog, per Peter Xu
> > - Added Reviewed-by: per Peter Xu
> >
> > [1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@google.c=
om/
> >
> >   mm/userfaultfd.c | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 5431c9dd7fd7..116481606be8 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >                       /* Check if we can move the pmd without splitting=
 it. */
> >                       if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> >                           !pmd_none(dst_pmdval)) {
> > -                             struct folio *folio =3D pmd_folio(*src_pm=
d);
> > -
> > -                             if (!folio || (!is_huge_zero_folio(folio)=
 &&
> > -                                            !PageAnonExclusive(&folio-=
>page))) {
> > -                                     spin_unlock(ptl);
> > -                                     err =3D -EBUSY;
> > -                                     break;
> > +                             /* Can be a migration entry */
> > +                             if (pmd_present(*src_pmd)) {
> > +                                     struct folio *folio =3D pmd_folio=
(*src_pmd);
> > +
> > +                                     if (!folio
>
>
> How could you get !folio here? That only makes sense when calling
> vm_normal_folio_pmd(), no?

Yes, I think you are right, this check is not needed. I can fold it
into this fix or post a separate cleanup patch. I'm guessing a
separate patch would be better?

>
>
> --
> Cheers,
>
> David / dhildenb
>

