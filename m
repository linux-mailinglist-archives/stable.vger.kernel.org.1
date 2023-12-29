Return-Path: <stable+bounces-8685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D481FF9E
	for <lists+stable@lfdr.de>; Fri, 29 Dec 2023 14:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AE21F21E74
	for <lists+stable@lfdr.de>; Fri, 29 Dec 2023 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140B111A1;
	Fri, 29 Dec 2023 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOOlctru"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D9111B1
	for <stable@vger.kernel.org>; Fri, 29 Dec 2023 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703855752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfPmhWh5N07csZQbCyEOyFqOu16Nwjy09GLJLCEkO2c=;
	b=JOOlctruYXV72fmhtBTyPYAd629rX8OW/hxiMo3eDibMiTuVyQjrqSTgCVZzNMQ3pnubyx
	+KsE/UGxb6z/1YRO9QyeJ1B01DlD0VuyMmkfFJLaS55zDSMmmrdvUvHHWzcdlh/arZ6LzE
	SOvf40proLHI7aaz1fgQY5Sd2iB01HI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-hAIYKzJEOKGJSUrU963Mog-1; Fri, 29 Dec 2023 08:15:50 -0500
X-MC-Unique: hAIYKzJEOKGJSUrU963Mog-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-427b10db31fso76149911cf.0
        for <stable@vger.kernel.org>; Fri, 29 Dec 2023 05:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703855750; x=1704460550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfPmhWh5N07csZQbCyEOyFqOu16Nwjy09GLJLCEkO2c=;
        b=ZRSQvMKjRmSxPyXhTi+bs09y1Uv7tI2etJqMToDYRJKpAApS3z7Du/bH01E4d/7yMr
         xNnGkYXaACqOlMwzjhSOnccZ5ts4xDPhew7sYnHVKMnxxMQ2w0JSiid8w/sIEuQrJVpj
         AIe32nPdUEOaxXo29WFyiJnItngqS0qOkf2GQHxhtUoLwOpb594BGkGvJkBydiucpqG9
         pPTGnTqFplwDIweAcdJGZ/ybRf3bKV/B6k3MuFhs442EHRX49aTKjPfycQ7Ko2OFLMHR
         PjN7OjEwOew23ta0CmjL3V7jppUZ5o9lOc8/DNaRC0XThqHi0vArD/ySRHmY92kXifzV
         XX6Q==
X-Gm-Message-State: AOJu0YzoxrDCdWtHG0eVi31XYPzDmk1D5ZJ6+Xn230ma3X+3qZl9klZ6
	lguMN3aQPGkQAjAjhpjwDTh4fnNpBR6a+kg4ZKZqYZsNtZ6itQbEIwH+MqIr70zovbaiAmPDcUs
	GU4M/Ooz6FzEdmq0BaqEeIol58zbx2k0SNJE2YodK
X-Received: by 2002:a05:622a:191f:b0:427:eab9:9066 with SMTP id w31-20020a05622a191f00b00427eab99066mr5338492qtc.18.1703855750116;
        Fri, 29 Dec 2023 05:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfBDDAmt/X1fcwAziQNaFqEOeKl3wNTh1KeafT9WlILnoleEYbHi8kmd4ctu+RfMRi43nxUnehQ2Fqztiafmg=
X-Received: by 2002:a05:622a:191f:b0:427:eab9:9066 with SMTP id
 w31-20020a05622a191f00b00427eab99066mr5338476qtc.18.1703855749909; Fri, 29
 Dec 2023 05:15:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228143737.17712-1-wander@redhat.com> <CAHk-=wg1VJR4WFT4VhEqXgE14dogJe9kbpYGBZdtai3ORomfOw@mail.gmail.com>
 <20231228220045.GA598@breakpoint.cc>
In-Reply-To: <20231228220045.GA598@breakpoint.cc>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 29 Dec 2023 10:15:38 -0300
Message-ID: <CAAq0SUmgoYEWEkp1YhZcEeaSZTA7FsOhu=Ltwu93-ibfFd3dPw@mail.gmail.com>
Subject: Re: [PATCH] netfilter/nf_tables: fix UAF in catchall element removal
To: Florian Westphal <fw@strlen.de>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, security@kernel.org, 
	Kevin Rich <kevinrich1337@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 7:00=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Linus Torvalds <torvalds@linuxfoundation.org> wrote:
> > On Thu, 28 Dec 2023 at 06:38, Wander Lairson Costa <wander@redhat.com> =
wrote:
> > >
> > > If the catchall element is gc'd when the pipapo set is removed, the e=
lement
> > > can be deactivated twice.
> > >
> > > When a set is deleted, the nft_map_deactivate() is called to deactiva=
te the
> > > data of the set elements [1].
> >
> > Please send this to the netdev list and netfilter-devel, it's already
> > on a public list thanks to the stable cc.
> >
> > Pablo & al - see
> >
> >     https://lore.kernel.org/all/20231228143737.17712-1-wander@redhat.co=
m/
> >
> > for the original full email.
>
> Thanks.  I suspect the correct fix is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?=
id=3D7315dc1e122c85ffdfc8defffbb8f8b616c2eb1a
>
> which missed the last pre-holiday-shutdown net pull request and
> is thus still only in nf.git.
>

Indeed, it fixes the issue. Thanks!


