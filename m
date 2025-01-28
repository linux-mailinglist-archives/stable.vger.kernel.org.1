Return-Path: <stable+bounces-110941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99941A20729
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0333A4EFC
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF81DE8B5;
	Tue, 28 Jan 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea1lfMbQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02A1DF277
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738055972; cv=none; b=aXFHdpfcdGRt+5yIqL277JtDdGCVfzYVilKTVryNrCIp2j3J6TaqNqq1IhM0VRSeh4FbxiVzCLFVMMVZssFkUyrzECkxcLygnmZhjxr+q893PeenReRUJsEfbF1OuxxT6RCcYOAhwffxWDfACNmVUGvh5L3WD2UrRNssxLRW/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738055972; c=relaxed/simple;
	bh=i0ocaT+7VQsa6OXnwOQKMOaODLPfRH4rVhjVXTGGR8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNU/9SLvrNLfCIfebWx0/Syk+KjYGbYh59LUGAyN2neLMBwu6KoWfOTUhB48pJlIaKU2GIpCYRfJRCcUq8o8lzQZnWWqPuiiOohf8KPvySywelSclItfIOsgivre6lhNUVNswP+vLqCnTZese6KDmEYYbgr6JXM2PXYISZjDnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea1lfMbQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so5688161e87.2
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 01:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738055969; x=1738660769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFjC4ekOPBKsQNltwDCAOZHvn+tbsMOP3N4nSF5+7bM=;
        b=ea1lfMbQzV+mU6URwsSuJBRnUesgTxnfFG7GAVX/RMlvpep+yi+4IQwgqvpXlHGbz3
         E/MuCSMIAkjo0UCE94Ppc7fwRnn3Pem71IDxJOHryYoleJriYDsWgO18QojXJbAsNU2B
         71otWCiD4EZzBOvUBMPWej+6DTTFzeabV9yu2qyetfiO82onLPpITO5CK53NuKmjd2ro
         BQFNTkPhvQC7SH7svvQdqy70bCRbNfE0+kXIQyjPN5O6j0tHDqRit9QQylVK6Zw5zmzh
         mqiMHmtIh1PxhupIFbGntCSAeUMVcJiELFKbAJ/trBWgqA92xuaAPayH0R/cDdd2S+1u
         px+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738055969; x=1738660769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFjC4ekOPBKsQNltwDCAOZHvn+tbsMOP3N4nSF5+7bM=;
        b=FY3S9TDlgepPqPHbwHXtxfVpw+pfsiMBuUtfUIFwlKfg6aCn/kH+QN3IONau93vyFv
         7WDnwhDDJiIkvknBdkAGF6CkUN0r7IofuCN/84Rpr4MLCwZuJfKsDN7az7WC7foIBLbx
         ecvcq8VR4PQ8GwHYAVENLo0O+NY/h5xuhhHpOjP+Z0x61noG/hQ4Q6ScYUgFcuIAhmn3
         3/Odrd+Rae0tYLjrcB4t4JYPN9E89XUJ6fBYnwW3CLhOZPPVV3sLYxnpf7vj6B3AaojY
         ROGVHS+tJjlE/oRO3BeW1dGSYcBkN4n1fE7SmgpULGxbnvAG2T7i16rlLVCx1pBbcKcU
         BOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb47HSqZyyufYVF4xXcmVX5XJN50FuIKQ53cobmAzPU+iTjBxoaidhFtFjeDKaB7OZvFqmw6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyakZqScBgSzOkFUQ9LKMuCzaP98F2EGCv7hGXE0ZpZZE6nfZs6
	2DU7aUZmQ0MPpHGzdB8vLY3eB9JcvtHPki1RuIvIg0VKJKd7hxkZekb9/GtG9bqDkFiQbRLGjVK
	SH+TEx7P9wNOOQsTM58pktbwjANM=
X-Gm-Gg: ASbGncsixZ3FXeijHwepxneWM007UteKh9lZilJvQUWI2b94uCESq/TTJ+Vw7bI2QgR
	UuSjBmM7IDU8zAANMVFFwujWpEnmF0MIzeCZDwj0CVG69Hx5PWFIemu/azJre4zB2zaDPxCklh3
	s=
X-Google-Smtp-Source: AGHT+IFDKa3DNL/6O1/4S2XowhpQEtrSmZ1+vkazT27Rh7+ohbwEjdzPx9yGTQI9wWtVAyOI7KQmIC6nsrOmpj1SvGM=
X-Received: by 2002:a05:6512:b9a:b0:540:1fae:b355 with SMTP id
 2adb3069b0e04-5439c281128mr15510126e87.52.1738055968671; Tue, 28 Jan 2025
 01:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128174938.2638-1-42.hyeyoo@gmail.com> <2025012842-rebuilt-snugly-518f@gregkh>
In-Reply-To: <2025012842-rebuilt-snugly-518f@gregkh>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 29 Jan 2025 03:18:48 +0900
X-Gm-Features: AWEUYZmOVjgAj3DGOMZ3nh7fs_oFc92FmXoK_uzENk6K6OmiLOCxMsR9fxNeS6k
Message-ID: <CAB=+i9Q56PxJ_YpzdcJWWGfxMKKEhkSu0xszv4ne4Ep+KFs-Aw@mail.gmail.com>
Subject: Re: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 6:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jan 29, 2025 at 02:49:38AM +0900, Hyeonggon Yoo wrote:
> > Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()"=
)
> > mistakenly skipped charging any zswapped pages when a single call to
> > zswap_store_page() failed, even if some pages in the folio are
> > successfully stored in zswap.
> >
> > Making things worse, these not-charged pages are uncharged in
> > zswap_entry_free(), making zswap charging inconsistent.
> >
> > This inconsistency triggers two warnings when following these steps:
> >   # On a machine with 64GiB of RAM and 36GiB of zswap
> >   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
> >   $ sudo reboot
> >
> >   Two warnings are:
> >     in mm/memcontrol.c:163, function obj_cgroup_release():
> >       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> >
> >     in mm/page_counter.c:60, function page_counter_cancel():
> >       if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=3D%l=
u\n",
> >         new, nr_pages))
> >
> > Charge zswapped pages even if some pages of the folio are not zswapped.
> > After resolving the inconsistency, these warnings disappear.
> >
> > Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()"=
)
>
> This commit is in 6.13, not 6.12, so your subject line is a bit
> confusing :(

Oh, thanks for catching. Will fix it.
Also, I noticed I incorrectly described the problem.

Will send v2 (for v6.13!) after adjusting them.

Best,
Hyeonggon

