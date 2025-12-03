Return-Path: <stable+bounces-198182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40097C9E78C
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 10:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7659B3A91DE
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83542DCF4C;
	Wed,  3 Dec 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZC8APadj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489BF2DCF4E
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754097; cv=none; b=tFNpzNK/TNQB0d704QpHJDfSI8EVoMFdtGuZFo6VQbF+bTKr/dgL6e89R00zKdtB8xil5nSTHBhd5iss1E6MYypzEf4jp+gn6Hu8K5XkUaBiMJ7oWbQv17gWMrTdLZ62Az/qGE2ugKYXjjLsISe1qEVHg91TmZK3wsrl13c2/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754097; c=relaxed/simple;
	bh=ns2TzdrZVTfQ2mVS+gF3kQw0VyYvREhCt2c0Yr6Y9zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icyM9nlkuGKTIHfzNL32W77c4vT1DBdbF1lFvaUcrILuE+2JzR5lUdrDwaXkUFWsQWb4al8VDlJ5UV5XJ0k67+YA3ZAfncIlcf7QD+Hf4eHNBxqaQhO7jmO/T6xaEuhJ1hNJbis0zysoXl8XiJP1YiuQ2BvhIPFoDULxE2/r/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZC8APadj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2148ca40eso775209485a.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1764754093; x=1765358893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns2TzdrZVTfQ2mVS+gF3kQw0VyYvREhCt2c0Yr6Y9zg=;
        b=ZC8APadjeAHlLFij1YgDUWZkNqowc4sUQsEVBq0EBE/+BPP8l1W2k8fXVL920ytYtu
         zb4sI7hRZP7N3+7fOA8UbDhiiCJXLh4m8aTh5dHIWnXyousEna+SnDlsrxEwbR26kfLK
         2ctiUxKbNwwVnDfZ+5VY4//RYO4ixO9Bn/lS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764754093; x=1765358893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ns2TzdrZVTfQ2mVS+gF3kQw0VyYvREhCt2c0Yr6Y9zg=;
        b=Nbb1fMSDHPETBXX80GRJmU321WAh4tPbSaRyY71/SCdj8P++LOlipqkcwVkm8Y6MwE
         cZMCmNloKYt8vPuTTI7wZub6VNLtHX9BT+K/unMCcw+vRqKReU1Aocn8e78eLmIHfHdy
         TJKBRWDlU2JHcrU+KwvdsNOnsVnxiruXAHEtoKRgmj/qCCW94h2P/W+uwCbI74eiaKvh
         EZG94+ohaRP4yQXGbey3B+FXpHuAQ27L/WLKReIaxQacvTSRg/JNp9yLyOU98FUKlCgM
         h6ii+Coz/6hqaRQb0CwCUH2dgcByS4oHBt+/YB6/fG0ec8zXZuUr9yiwHOOU3+YvTCNm
         qFvw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Sza9zsoUo5p91cr7r9O8WM8b0WWrior/TDMH3hhulr4RQEiihMPNqHwcKZwTpWeuIiMERyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Nf5C6j8eb2Q6PggjEdz5Ka0LHf7QV+74sBx3fvIbvov+ipPf
	5me5/G4DsFoOgAmbxBHXjqEbUyvekyjhl/kBUn08fsZiJYhKzW2VihYVsXTf+zVQt0Rf97PAx4m
	c4/BTUJg+0Fms+BCjWcHxsTSxBdy0wmg/3jF46REuFFZKHjKyKATGgY8=
X-Gm-Gg: ASbGncvmVXxnWKeMk49hU1bfekKrJ7DrsdkEihQ/b/U1D8jJrq5z29rZIM62OdHK8Rn
	0GSF45d/yENuCACZhi6Qjz06RxpCv9t1ey4zJ8Og+2wqrivfT1wXicbf0aD+1q9SUcDU9bwXwCs
	YAxC+em2WjkCMZbbM8kkwNVwSEl1OkxPz20G36zaK29x679zs/LpGTq/c3TOep+68fQ2dX+Xsjr
	3oPs+Rah6Ycn+ygPHdCO4E9R16+B5+TUOVcr4Isrxb5PcOTQkNe3Pk0YBfjzXNk5qUf/sA=
X-Google-Smtp-Source: AGHT+IGH4y6G7l0uWAM7MVs0ZUDjiX64KDLpg17aJDNSM/roeQAWJbNS+KY5jVjRbd5lpner64LysoyLNATeT3izA2o=
X-Received: by 2002:ac8:7e86:0:b0:4ee:1dd0:5a4f with SMTP id
 d75a77b69052e-4f0176da1c4mr19930841cf.61.1764754092958; Wed, 03 Dec 2025
 01:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com> <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
 <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com>
 <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org> <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
 <504d100d-b8f3-475b-b575-3adfd17627b5@kernel.org> <CAJnrk1a1XsA9u1W-b4GLcyFXvZP41z7kWbJsdnEh7khcoco==A@mail.gmail.com>
In-Reply-To: <CAJnrk1a1XsA9u1W-b4GLcyFXvZP41z7kWbJsdnEh7khcoco==A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Dec 2025 10:28:01 +0100
X-Gm-Features: AWmQ_blcA_e4kaMi5shA7dS-lb9KIG0yD8t2lL60ZmfQjrXgcrRpZu3lHj-XY4c
Message-ID: <CAJfpegv7_UyTht-W9pimE-G6tZQ0nKU6fYo1K2hcoNSHYC3tpw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	shakeel.butt@linux.dev, athul.krishna.kr@protonmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 18:58, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Wed, Nov 26, 2025 at 2:55=E2=80=AFAM David Hildenbrand (Red Hat)
> <david@kernel.org> wrote:
> > >
> > >> having a flag that states something like that that
> > >> "AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC" would probable be what we would =
want
> > >> to add to avoid waiting for writeback with clear semantics why it is=
 ok
> > >> in that specific scenario.
> > >
> > > Having a separate AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC mapping flag
> > > sounds reasonable to me and I agree is more clearer semantically.
> >
> > Good. Then it's clear that we are not waiting because writeback is
> > shaky, but because even if it would be working, because we don't have t=
o
> > because there are no such guarantees.
> >
> > Maybe
> >
> > AS_NO_DATA_INTEGRITY
> >
> > or similar would be cleaner, I'll have to leave that to you and Miklos
> > to decide what exactly the semantics are that fuse currently doesn't
> > provide.
>
> After reading Miklos's reply, I must have misunderstood this then - my
> understanding was that the reason we couldn't guarantee data integrity
> in fuse was because of the temp pages design where checking the
> writeback flag on the real folio doesn't reflect writeback state, but
> that removing the temp pages and using the real folio now does
> guarantee this. But it seems like it's not as simple as that and
> there's no data integrity guarantees for other reasons.
>
> Changing this to AS_NO_DATA_INTEGRITY sounds good to me, if that
> sounds good to Miklos as well. Or do you have another preference,
> Miklos?

Sure, sounds good.

(Sorry about the delay, missed this.)

Thanks,
Miklos

