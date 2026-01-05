Return-Path: <stable+bounces-204907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C9BCF5705
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 20:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8393094A57
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F492BD597;
	Mon,  5 Jan 2026 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctkWunSJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89D10FD
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642958; cv=none; b=U0piQN9Scc+sDGJSDTfJ8eGXJhZRVm4WqiEpvm1SZ8MxOP2wMtf/drpKMfUs0zPgESRjgLkJ5/MOOh22Ye+/qOzTIZR8ZXtEk3O2E/uvuRm5mixMkWJawf4Hh87v+BxQ73WYNMLBJZbf906VWeK0vd6fenenaF9Qt0Xl16FXrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642958; c=relaxed/simple;
	bh=B/KCutNmTXc3sPl8xG1vSOW3KcxjghTl22c98nbAzLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk8A9YPscC+TrLuleDTTuyHFpV+g3Z9TAsJxijbzBU5AD6uBWeiovaubVuE842ur52BpFe+xn6+RwZiOkEEQjFtc/qAJ2D1PwhWDHhTY3uvc04h+mpUvuj4C9CTErNAZLqwAej08MojOH9D6Gl36oUs84txvnL8QD3akJmBs2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctkWunSJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee1879e6d9so2694611cf.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767642956; x=1768247756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iog+hYgLiZRC3g3lYFmRjl8SBSTmMSwxCWcvManxv3I=;
        b=ctkWunSJttS/uY2z77W3YgS1SoXFgjaGRw4R+iTuIn/377xURXpYseqRkC4hGQ/ean
         wGKSc205PXyouI+kIdFrt6DAtmqu4dUoh+9v0QolmJcwpGFQuV2FBWwGXSVA7SiycSkQ
         90OAC5lWxO0pVxS604dUiTObqgbaWbek3yWCbgl8lzjIMFu9sOfvR53ZWRYSxy6ytpgs
         PlJoSYt5Y7tuByVhIRCTRiafdZynoODg9T9ov3ecjA5zg3kvM2N5ozWgn9V2ArWZi01d
         7wsSqXw7beFWUkoYGrgTrh/YyankYCX5ZHaJEiEet6lo8gnU4AkA37BW+6m7FURfvbk/
         lp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767642956; x=1768247756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iog+hYgLiZRC3g3lYFmRjl8SBSTmMSwxCWcvManxv3I=;
        b=DMOhDl66gPtPfflRUWabBrp6ldTMVptSsmxgRHhGreWDcb0jTGvARqXXYFPKk/zvzw
         b+wX8NiR+OOlg5D7DN36azjfC6WlLQsnB6p+K5odPxifnKI8KBoCZxg+Dn5IyrLG6hsa
         uSa0eqa8s9TpO1p/h5bUkFf101oLS/JPEHwDUoTVU9B5i+LugTRB0XNDrpYcfAsKRkR7
         DmmGyqnF7pKchAx7TNG/IWrB9SG3Emt0hxf04w5dEBMUjHhcoK1zlEV5ZbIrGyG6aSjM
         WD3yA3T9y2lwf6yYciKK2GA5yqrzqIyywg/nJO5ZCPXmXkU5+iBVhF9c+0Cxby5ooe/B
         hUXg==
X-Forwarded-Encrypted: i=1; AJvYcCW4pmHg+84xnvDIwW2bOeMRsgnNRZwouVZ3sfmYe0AO4m17NV3RNite4Ka+OC+8fIn6lTVG+60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/k8/JpwljRwPYmXQbmWVhjDbbbzV7EhrdOyq/L1sEhNUJU8Q3
	CSVd2jmjVED8kXBD5DQKLB4rkOLUdwIld+PgtndgudLCr5Ig++39qcXnWEueDk26IMdGZ5NzYSs
	qUtIHsqtw7O6irsCEqtx0mK7cDAtyrJo=
X-Gm-Gg: AY/fxX5D+eTN0Alk0hqbf4d74Ho3EiirQio73zI7k4UN2bPB8NU4x8x7d7c3Hos+X9D
	T/Num8/YTDihjApbjjQ4OXoKRD0hTKejfJMzLlqfGIRBASpyYVmUB+4kO1LBUVhIgZ4leI40+C/
	d+yTdTlY5NDnopU9sH3+5INcLvNFZVQOGIPDFvjswueaQT+1YBXntsTRFvkHiuYosdWmaXXN0d9
	fcFxj66ROrkREHBG/S28yKOd4HXpkU8zQJIV41y2LGtjzj4xZO3/Vp1ZEIXkReQ0zuEZw==
X-Google-Smtp-Source: AGHT+IEcXiL8f+s52fan8QBIB8gC3RmFY4+fpmlXK2z6PXVY35c7s9hfXufUtxNhmOF/muXn/qtrDW/8Z7clxD7o+HI=
X-Received: by 2002:a05:622a:198f:b0:4f1:e99f:7d74 with SMTP id
 d75a77b69052e-4ffa76d7eb2mr10837171cf.12.1767642956158; Mon, 05 Jan 2026
 11:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <20260103100310.7181968cda53b14def0455b3@linux-foundation.org>
 <9f9343f6-c714-4d2f-985b-e832c6960360@kernel.org>
In-Reply-To: <9f9343f6-c714-4d2f-985b-e832c6960360@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 Jan 2026 11:55:45 -0800
X-Gm-Features: AQt7F2qxuG4z8c8Qm515xNGzMMbs8p-UQIVayICF-AA8ax8cqWJEnRx16FYQQIw
Message-ID: <CAJnrk1YhqsoNGFocqbDhbU00c1ZZCqGrDVDf1ZCFqubPLQH4qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, miklos@szeredi.hu, linux-mm@kvack.org, 
	athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, carnil@debian.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 10:54=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 1/3/26 19:03, Andrew Morton wrote:
> > On Sun, 14 Dec 2025 19:00:43 -0800 Joanne Koong <joannelkoong@gmail.com=
> wrote:
> >
> >> Skip waiting on writeback for inodes that belong to mappings that do n=
ot
> >> have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> >> mapping flag).
> >>
> >> This restores fuse back to prior behavior where syncs are no-ops. This
> >> is needed because otherwise, if a system is running a faulty fuse
> >> server that does not reply to issued write requests, this will cause
> >> wait_sb_inodes() to wait forever.
> >>
> >> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and intern=
al rb tree")
> >> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> >> Reported-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>
> >> ..
> >>
> >> --- a/fs/fs-writeback.c
> >> +++ b/fs/fs-writeback.c
> >> @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *s=
b)
> >>               * do not have the mapping lock. Skip it here, wb complet=
ion
> >>               * will remove it.
> >>               */
> >> -            if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> >> +            if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> >> +                mapping_no_data_integrity(mapping))
> >>                      continue;
> >
> > It's not obvious why a no-data-integrity mapping would want to skip
> > writeback - what do these things have to do with each other?
> >
> > So can we please have a v2 which has a comment here explaining this to =
the
> > reader?
>
> Sorry for not replying earlier, I missed a couple of mails sent to my
> @redhat address due to @gmail being force-unsubscribed from linux-mm ...
>
> Probably sufficient to add at the beginning of the commit:
>
> "Above the while() loop in wait_sb_inodes(), we document that we must
> wait for all pages under writeback for data integrity. Consequently, if
> a mapping, like fuse, traditionally does not have data integrity
> semantics, there is no need to wait at all; we can simply skip these inod=
es.
>
> So skip ..."

Sounds good, I'll send out v3 with these changes. Thanks for the
feedback, Andrew and David.

>
> --
> Cheers
>
> David

