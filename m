Return-Path: <stable+bounces-92901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4279C6C25
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 10:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2DB22B44
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B51F8191;
	Wed, 13 Nov 2024 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O47a+Oez"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748041885BB
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491694; cv=none; b=nsbViGA7YbyDMlNt35Z/NusgPAERaU7F+DVNmm0RFVFuCJ5XKv8alQTJqr2fIrbBfmD9uhRIspniaRbjxnijP0nBPHw/ZTh53fLOJPNCuLYwASKJd3CU5UFq9A9UbOQIUaI9zo40AWcsM+SSfNPmJWpglod3WFKdLfKLu8XwF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491694; c=relaxed/simple;
	bh=b3sjS5o/T4GT9VziYhr6nueRmxBl8KS4Ep+M6X17HbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrlfG7Yo+G44ghkEJMlpKwWWxmo2ZCw84GDZIfS/88oBqgY7cAyX2w+dD5JAYgZcooeSM1uf7fFqtlRnWNe3YXjCacVcsDK+DZeDYXk70wzBX5XgGIk2Ds7UO9IEefIiROD1Nz/sgOlr0QVUeAo1ojF5kBYmJY6RCqw4hVmGLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O47a+Oez; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b148919e82so446052885a.0
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 01:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731491691; x=1732096491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U1TtglPChqxh7IcjnLyAkelVEXzu6CDrucn0Vd4ODU=;
        b=O47a+OezpRyLT9z6tl3KGeSLOh8GhwPGP0qcivbCPZUKO22CtEXzgOLQpbs5ERJBr3
         TJ4CmOK1e5dxTOcUp1fcIvkq69bVeyjShWkIUAZUn8x1yig+X1Y5yHtTZyrETMu8CsPw
         bLZ/1ju3fU9makMOfPM6BNSqQnG/7M+3fZQBGnG+QMhcmrTF59HtK92EOWLQYveTo6Pw
         xGOQQ9fShf1EB6JXkJEbHRJxCMplf49+2vnB9GOwgSip090IRWi7n9wmp/qLjn3+mK5j
         irtjtmZnXaGO/VeL16S18AvfF25XGWZc8/tRAVCYoXhcX54VBb8w0fpaE+pRSGa4TgeI
         3luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731491691; x=1732096491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U1TtglPChqxh7IcjnLyAkelVEXzu6CDrucn0Vd4ODU=;
        b=UD+ZImRVhGjepPOtjb6Cr2vWfwLvTQr0fbs9z4e8TRCxOUHot8MIW56KvEk1AzA1/K
         W6zaG5ls1dqyDoJ7zWO6P37m942LhJ7ESoiWVs5ycGihoNE1oW8QsMkTxgunaIL7YkyU
         ysr1aT7yx0lX5IJDTtbkg2YLX4uNCJgvkJxhbGCKa5aCbTQGdA42NNVjXVjnkFh1co6y
         HI7KnI5Tv+Dy4qeosX3qtaAgg+6U79dyZ3J+FeKIU45H4ZIrtCHZhBWUrESeZnDd+nq/
         rE5nN3BxkJS/TZn/1oz16qOPxC4PI+vDraqJEv8CPv0G6K5YcMygWgBdgpKiWfc7+dTs
         t+xw==
X-Forwarded-Encrypted: i=1; AJvYcCWKNjs+t9BSJR1EFBHsnn3oOy73PvMZjpu4gitpCvHe9JIs3brqjqmOwuJBcU2qoe7Q/YKf1pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXt930s6/fqQtRixw0LJG6dOTcT5B+Y5KFU0wFagurwy4knQ8o
	mOq/eI7gwH33pGjLZPeL1yZ/fgVND7YnKpWlJNGm6busUiTLrrBNm1Y5M+fW1J8g5KxPkhLWJfD
	3HA05Q61xjCRymEmoJUXtv2Tcmpw=
X-Google-Smtp-Source: AGHT+IF5TGvGNmx7N7qk61VCAvERtj2ZAL2cxQR/6GcZQD29Mtuv6fIeoKuuXXpXlvJkM6z9HcM+wkB9J7Bh3IKiIe8=
X-Received: by 2002:a05:6214:540e:b0:6d3:9c7b:9384 with SMTP id
 6a1803df08f44-6d3dd07ebd6mr29570546d6.42.1731491691133; Wed, 13 Nov 2024
 01:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141710.9721-1-laoar.shao@gmail.com> <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com> <CALOAHbD6HsrMhY0S_d9XA0LRdMGr6wwxFYAnv6u-d7VRFt6aKg@mail.gmail.com>
 <cf446ada-ad3a-41a4-b775-6cb32f846f2a@redhat.com> <CALOAHbA=GuxdfQ8j-bnz=MT=0DTnrcNu5PcXvftfNh37WzRy1Q@mail.gmail.com>
 <a1fe53f7-a520-488c-9136-4e5e1421427e@redhat.com> <CALOAHbAohzxsG7Fq2kNDc5twbtpzJRCPbJ1C=oYB8fy8PsQzaQ@mail.gmail.com>
 <88211032-80e1-4067-a74c-c9dcea1abff8@redhat.com>
In-Reply-To: <88211032-80e1-4067-a74c-c9dcea1abff8@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 13 Nov 2024 17:54:15 +0800
Message-ID: <CALOAHbCY94=YDZcuLk5wS1jg1ycAD9Cx9=3CgxE9VOAsnj87vQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async readahead
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:28=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.11.24 03:16, Yafang Shao wrote:
> > On Tue, Nov 12, 2024 at 11:19=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >>>> Sorry, but this code is getting quite confusing, especially with suc=
h
> >>>> misleading "large folio" comments.
> >>>>
> >>>> Even without MADV_HUGEPAGE we will be allocating large folios, as
> >>>> emphasized by Willy [1]. So the only thing MADV_HUGEPAGE controls is
> >>>> *which* large folios we allocate. .. as Willy says [2]: "We were onl=
y
> >>>> intending to breach the 'max' for the MADV_HUGE case, not for all ca=
ses."
> >>>>
> >>>> I have no idea how *anybody* should derive from the code here that w=
e
> >>>> treat MADV_HUGEPAGE in a special way.
> >>>>
> >>>> Simply completely confusing.
> >>>>
> >>>> My interpretation of "I don't know if we should try to defend a stup=
id
> >>>> sysadmin against the consequences of their misconfiguration like thi=
s"
> >>>> means" would be "drop this patch and don't change anything".
> >>>
> >>> Without this change, large folios won=E2=80=99t function as expected.
> >>> Currently, to support MADV_HUGEPAGE, you=E2=80=99d need to set readah=
ead_kb to
> >>> 2MB, 4MB, or more. However, many applications run without
> >>   > MADV_HUGEPAGE, and a larger readahead_kb might not be optimal for>=
 them.
> >>
> >> Someone configured: "Don't readahead more than 128KiB"
> >>
> >> And then we complain why we "don't readahead more than 128KiB".
> >
> > That is just bikeshielding.
>
> It's called "reading the documentation and trying to make sense of a
> patch". ;)
>
> >
> > So, what=E2=80=99s your suggestion? Simply setting readahead_kb to 2MB?=
 That
> > would almost certainly cause issues elsewhere.
>
> I'm not 100% sure. I'm trying to make sense of it all.
>
> And I assume there is a relevant difference now between "readahead 2M
> using all 4k pages" and "readahead 2M using a single large folio".
>
> I agree that likely readahead using many 4k pages is a worse idea than
> just using a single large folio ... if we manage to allocate one. And
> it's all not that clear in the code ...
>
> FWIW, I looked at "read_ahead_kb" values on my Fedora40 notebook and
> they are all set to 128KiB. I'm not so sure if they really should be
> that small ...

It depends on the use case. For our hardop servers, we set it to 4MB,
as they prioritize throughput over latency. However, for our
Kubernetes servers, we keep it at 128KB since those services are more
latency-sensitive, and increasing it could lead to more frequent
latency spikes.

> or if large folio readahead code should just be able to
> exceed it.
>
> >> "mm/filemap: Support VM_HUGEPAGE for file mappings" talks about "even =
if
> >> we have no history of readahead being successful".
> >>
> >> So not about exceeding the configured limit, but exceeding the
> >> "readahead history".
> >>
> >> So I consider VM_HUGEPAGE the sign here to "ignore readahead history"
> >> and not to "violate the config".
> >
> > MADV_HUGEPAGE is definitely a new addition to readahead, and its
> > behavior isn=E2=80=99t yet defined in the documentation. All we need to=
 do is
> > clarify its behavior there. The documentation isn=E2=80=99t set in ston=
e=E2=80=94we
> > can update it as long as it doesn=E2=80=99t disrupt existing applicatio=
ns.
>
> If Willy thinks this is the way to go, then we should document that
> MADV_HUGEPAGE may ignore the parameter, agreed.

I'll submit an additional patch to update the documentation for MADV_HUGEPA=
GE.

>
> I still don't understand your one comment:
>
> "It's worth noting that if read_ahead_kb is set to a larger value that
> isn't aligned with huge page sizes (e.g., 4MB + 128KB), it may still
> fail to map to hugepages."
>
> Do you mean that MADV_HUGEPAGE+read_ahead_kb<=3D4M will give you 2M pages=
,
> but MADV_HUGEPAGE+read_ahead_kb>4M won't? Or is this the case without
> MADV_HUGEPAGE?

Typically, users set read_ahead_kb to aligned sizes, such as 128KB,
256KB, 512KB, 1MB, 2MB, 4MB, or 8MB. With this patch, MADV_HUGEPAGE
functions well for all these settings. However, if read_ahead_kb is
set to a non-hugepage-aligned size (e.g., 4MB + 128KB), MADV_HUGEPAGE
won=E2=80=99t work. This is because the initial readahead size for
MADV_HUGEPAGE is set to 4MB, as established in commit 4687fdbb805a:

   ra->size =3D HPAGE_PMD_NR;
   if (!(vmf->vma->vm_flags & VM_RAND_READ))
       ra->size *=3D 2;

However, as Willy noted, non-aligned settings are quite stupid, so we
should disregard them.

>
> If MADV_HUGEPAGE ignores read_ahead_kb completely, it's easy to document.

Perhaps, but documenting the behavior of every unusual setting doesn=E2=80=
=99t
seem practical.

>
> >
> >>
> >> But that's just my opinion.
> >>
> >>>
> >>>>
> >>>> No changes to API, no confusing code.
> >>>
> >>> New features like large folios can often create confusion with
> >>> existing rules or APIs, correct?
> >>
> >> We should not try making it even more confusing, if possible.
> >
> > A quick tip for you: the readahead size already exceeds readahead_kb
> > even without MADV_HUGEPAGE. You might want to spend some time tracing
> > that behavior.
>
> Care to save me some time and point me at what you mean?

I reached this conclusion by tracing ra->size in each
page_cache_ra_order() call, but I=E2=80=99m not fully equipped to provide a=
ll
the details ;=EF=BC=89

--
Regards

Yafang

