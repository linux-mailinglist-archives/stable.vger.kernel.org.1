Return-Path: <stable+bounces-195423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CDEC765B5
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 22:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 540C32A138
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F382D3EE5;
	Thu, 20 Nov 2025 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJX5NA3R"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726028B7D7
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673649; cv=none; b=iYV81iPR+jB9AyA0YIsegDHkamK1gTvxjO0aNbOCwGZiRlWKG0+Hlxk3fql6Knixh7VTLtwNZ9Ing+pX2tfRxe+7XrLev0Czg0dH/OwYmh1cmrIlS6B/bLBk+z0i5W4Z/rIsMFjB8k7Y+Zn4CAnMR7FzhP9wGzwzxwWIuUi5ZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673649; c=relaxed/simple;
	bh=8DdPqy7jdfUmtvBEUt3KyEUj0q4NS+9hPhMgPvU4BqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qf8NgxLyG4fYEFLX45W+ZLC0hwSXAfkXd5yvDJHuvhbt5oTIOII6fdbEB2KPbTurvGg25RHY0qaksi7jgpTZTC8+p5fqxUdQo2UNf4r7ti8FSUI2GEmz8UgPCkhnE2ku8Eowl8+Hr/xMdE1/A0tMQdrLaRnCbmBZW85bF1xe+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJX5NA3R; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed82e82f0fso12153701cf.1
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 13:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763673645; x=1764278445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MQ2GPBHW83S5fq1wRW7v7lPo7wmxf/AYTgBtJy0YmY=;
        b=TJX5NA3RKhbDNSqjHN7MiCBmt9F3BqDb0MC6AmtJ2cVkJMm7OmrUzhrnKegXtKaJuK
         GPLWbyEV16XjLBe7nAiW6JKhowiKMLhD6iCiJ+BE7p8jFl+YPnEXyfpigPpP2Ag5w0dj
         cv4qDXaC9icojPQ8yrWvrOuWG8InlFJA22WWH+g8xS8tAagtWAi5qPxn/apmKEeMy2+B
         EKzwXoVkTcclBuKInSK3S9QmCAVuPwQ0+ACPHL+pqbzwSGe0N1L3GWKI1vwjV3m6kmOg
         4CG9m7881KP6Qm96qza6ijbvHNtU+YjMDYGzCidsLYMr7xVNeEPPVEwoRk0h0htkQekn
         LlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673645; x=1764278445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8MQ2GPBHW83S5fq1wRW7v7lPo7wmxf/AYTgBtJy0YmY=;
        b=G4AsHJouKxvz6GwESZGRDGMlkuJAe/kMoVgkB9mW6/U5bduNxdvub9lLrRdiTxwedY
         xms/ATacAGNBFwkDtwGyRwzXdGZYAdn2jyd8lTFIA2nWVi+dKtJ8BOOIWIFZA1x0tQzm
         ieLebRLG/VpbvQQMOGYAuif9J4qWWiaMKIcwWkQ/ei4/Fio6lCB3wb53B/dveW9Gz7ct
         w3xS/lXbo/Li2yuGZ2B0gibZyfl6iDOG3wJ+V2DHiKZ+/X9cAjlSgbmthjhgtHmCbNxO
         yLu4HjHgeUsnkWiRA+IOavDR7LGa7vMT5FankFFzwERGcVho2zk6Y0LtXqfZ4FNj6KFo
         NpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK8os3V+jdaShqzrvfffjj4F/0gb0f8wgWTRMDktsEUGRQO+w6o/gqDDI0C04QxLozVWzpHCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4aa/NPuabXF9DjgXCSjqRWzJk4w9OakhpmhONRKLP0UY4DuF
	DJZq5PtxCBdXO2ZtiL7fy8Zdy0Csl9AJOES48QsF2pWyT5IHPi718aHsM8fIBfFzFeHv5Ls6jfK
	aihtMNKIPT3SlW2cUo2t6SW8JkS4//SM=
X-Gm-Gg: ASbGncswYf1R9a0dyEAn2GOl86pqyONDSQMHEabUan6V33OHlutwDCj5PZ3m2WI5uOE
	piww5Kpzh0ZkSvWKTkKpEgzyi3X7HGbOQ+x55WbFjHtfwmk4jft9lWetspH07uhb7odxoL6+rBp
	BUcQp9J4eBlygVdlkzRZnnrP7IudXoMUtzp7kIzjPlphD7I8fvqLlpJyu1O1OsOmYj+2/OgXIyx
	raPqROLYty/wr2ZPJ6l70KSRV9O5FMNR3Fcs7Qdzw3MbzE36z9b3cSjZPldr8WNLdYgaA==
X-Google-Smtp-Source: AGHT+IG+lg4eS5i0rptnxHqewOGmi9WIWtm3BkNS150hRV68edD3IKYERtGEqWDxSOmk7U8Kg75UXfI9iTTk7B7cmnk=
X-Received: by 2002:a05:622a:1aa3:b0:4eb:a0aa:28e with SMTP id
 d75a77b69052e-4ee58936cb6mr772331cf.64.1763673645433; Thu, 20 Nov 2025
 13:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com> <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
In-Reply-To: <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 20 Nov 2025 13:20:33 -0800
X-Gm-Features: AWmQ_bknxKe3HYjwzzfUFST-_e4QC_Zgx5EeYqCXoRNHcbarFlFOQ1yJzG1WvYc
Message-ID: <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	athul.krishna.kr@protonmail.com, miklos@szeredi.hu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 12:23=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 11/20/25 19:42, Joanne Koong wrote:
> > During superblock writeback waiting, skip inodes where writeback may
> > take an indefinite amount of time or hang, as denoted by the
> > AS_WRITEBACK_MAY_HANG mapping flag.
> >
> > Currently, fuse is the only filesystem with this flag set. For a
> > properly functioning fuse server, writeback requests are completed and
> > there is no issue. However, if there is a bug in the fuse server and it
> > hangs on writeback, then without this change, wait_sb_inodes() will wai=
t
> > forever.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and interna=
l rb tree")
> > Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> > ---
> >   fs/fs-writeback.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 2b35e80037fe..eb246e9fbf3d 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2733,6 +2733,9 @@ static void wait_sb_inodes(struct super_block *sb=
)
> >               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> >                       continue;
> >
> > +             if (mapping_writeback_may_hang(mapping))
> > +                     continue;
>
> I think I raised it in the past, but simply because it could happen, why
> would we unconditionally want to do that for all fuse mounts? That just
> seems wrong :(

I think it's considered a userspace regression if we don't revert the
program behavior back to its previous version, even if it is from the
program being incorrectly written, as per the conversation in [1].

[1] https://lore.kernel.org/regressions/CAJnrk1Yh4GtF-wxWo_2ffbr90R44u0WDmM=
AEn9vr9pFgU0Nc6w@mail.gmail.com/T/#m73cf4b4828d51553caad3209a5ac92bca78e15d=
2

>
> To phrase it in a different way, if any writeback could theoretically
> hang, why are we even waiting on writeback in the first place?
>

I think it's because on other filesystems, something has to go
seriously wrong for writeback to hang, but on fuse a server can easily
make writeback hang and as it turns out, there are already existing
userspace programs that do this accidentally.

Thanks,
Joanne

> --
> Cheers
>
> David

