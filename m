Return-Path: <stable+bounces-158994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46640AEE75F
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 21:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CC9442527
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2BC1D79A5;
	Mon, 30 Jun 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udu3GcZ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2181FF1B5
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311110; cv=none; b=TVbg1OPHrgX6mEuUFgq+Feu7VMx37uOoAZQMtfch0+g4RcKFPjCKQXKdmXt73+T/kv5ejJHDruCYLvPXelTk578W3YrA9aFL4+rle4t6rU/ceHQ3zDTN+u0mzv6ZBSeQo5/tW/9SEHrrtjzFwawWil/aYZbLgJFismvJ5jqIXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311110; c=relaxed/simple;
	bh=ktEryih8VY5+ifM0aJwk7uE1X1N1qfRnzVACndRwNvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ga/cCdAXU/1UpPrsWMzSYf88ADBW4w5y+Xw6unoR742A+6HGg/T3DXL+NTtqc/c8Iq0N70QP1pPUoQFc+u22+rJK3suIkNM7kF6A3irblrdwQXmxA5VGFJqkjGomgCFr5cLb4MOgQV4q6YdBROmDpEXwbGKcRBwE2gUqdKIkZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udu3GcZ8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6098ef283f0so2352a12.0
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751311107; x=1751915907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tNFLYcYmuq0LkQjKHt7ObSCKck4x3ZAcVp6YK+ku9A=;
        b=udu3GcZ8Y4G/Atp62uHXi+vDmZ0tuhS+mQ+Sdn01zp60lHWLFXFubFA5qQD9lzMWKt
         RLALCCDYtOGkU0ms6xl8UU593IODyI7UvpfLQX/bw+3NTVD3r7HrB0F0+ZA6Yq3bTB9D
         hoViKK6VSqHNUVHR1SBtTnjCFuQWeAXsQ3geUNGU21DNbVke+pmV44Ip4U2V9uFgToXS
         MuSXm5sxFErpVs6ZqqcHve7uPKif9IHpFOWKI7gEE4UIudI8r2TeKG8n4eol1sKM8CFh
         Z3R2NGzrQ9fCJw5YguGz/TYuKDZZwie11SayZQCChHudbbxgyK3MMys2opw7SDzYV1oc
         e9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311107; x=1751915907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tNFLYcYmuq0LkQjKHt7ObSCKck4x3ZAcVp6YK+ku9A=;
        b=I6Fdri+qdzW2G/jVHgY684Rx0NmZ5IyWiKBoTJGfIb26WJF/tASetuqHN6+CD2p3vC
         yjOs558v+PwLXkHZ62Tk8sST0WX8+eBsaZqIvYKCWDfgxeWIHYq07UKHJw2WjfW8tPZT
         0g16YCvJoxllkssRh4OvvWgbW+kBW/gpu8ZCfL/1wLE/OsRJg18fMW0hxfs3t5KPhZwa
         yIhX5nkOwRJl8Era4fwPsjflYmOG52JC3slaNBvHaeuxAibhJUjT1wb5LXzE59N9WeUD
         UwpsBHw1H8penR1Hw9DwJqG9Ypd5HZxo83zyd0gbzyq3afKjhwvdVf68aAr6y6Zob3DW
         kCFw==
X-Forwarded-Encrypted: i=1; AJvYcCUS63a1scdzg2ZPR6SYILpQQ8MIr2UJuxnvjRcTP6CyriPFEf30k1Oq+kGp/48f2Y5oZ+BoFxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rc8i7T8QhNJv+vIbN3ROV00YI4WBsNIiHyffn+IEWqcX3iV+
	mjQadc0I0AIv4res5B7j2o5DBOBEMvdeL+DGLy1HIjn0toSGkmpdmwO7Qvtk25JK8strN10HAY2
	2eS8OgZzkjeGhdMWTUqROttN5Ek40dYTzjKtsQVNF
X-Gm-Gg: ASbGncvRDN92BU1+FObYSjElsHCJsaH4/6k62aH9nCve0hO/od4Xr6HltnnsfZbts5C
	B9FYTMiaA85ImbItVrYdLGrLYn3Or8KaT5OGOlcpRJ+DAHBUYhk8Uwdtb7Dist4VaOAjbO3S7Eg
	SCOXEc2VtYSnLElCLMHANyy4l5555emQZf++SCZg1kPjpQilac28Ai9MD3O4BkqlBEJnxBHiwVr
	pOAc1oZTo8=
X-Google-Smtp-Source: AGHT+IEAj1zqpjuM7UlhxZycs5/VVtcZm5W51dZaMAG/kHQVzfNT6TD6MZvE5QVt44ZCJeBAgTSC9ZxL2NFCAmkQPqY=
X-Received: by 2002:a50:ccc7:0:b0:60c:9b28:350 with SMTP id
 4fb4d7f45d1cf-60e3344d499mr11050a12.6.1751311106379; Mon, 30 Jun 2025
 12:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025062041-uplifted-cahoots-6c42@gregkh> <20250620213334.158850-1-jannh@google.com>
 <20250620213334.158850-2-jannh@google.com> <srhpjxlqfna67blvma5frmy3aa@altlinux.org>
 <CAG48ez26QWvqPoL-B0p934P9U6hDyGTUDjE6srGdUhBeCR2Z=w@mail.gmail.com>
In-Reply-To: <CAG48ez26QWvqPoL-B0p934P9U6hDyGTUDjE6srGdUhBeCR2Z=w@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 30 Jun 2025 21:17:49 +0200
X-Gm-Features: Ac12FXx22E442tjOx_8u750cqqoSYvckeUpo0UbyTVndVgyGXOg51PKWaTgpf5s
Message-ID: <CAG48ez35o7RsinJxLv=fuce2=B2wguSpHMXB8DGN3tbMr1X82w@mail.gmail.com>
Subject: Re: [PATCH 6.1.y 2/3] mm: hugetlb: independent PMD page table shared count
To: Vitaly Chikunov <vt@altlinux.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org, 
	Jane Chu <jane.chu@oracle.com>, Nanyong Sun <sunnanyong@huawei.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Liu Shixin <liushixin2@huawei.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:12=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> tl;dr: 32-bit x86 without PAE opts into hugetlb page table sharing
> despite only having 2-level paging, which means the "sharable" page
> tables are PGDs, and then stuff breaks
>
> On Sun, Jun 29, 2025 at 3:00=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org>=
 wrote:
> > LTP tests failure with the following commit described below:
>
> Uuugh... thanks for letting me know.
>
> > On Fri, Jun 20, 2025 at 11:33:32PM +0200, Jann Horn wrote:
> > > From: Liu Shixin <liushixin2@huawei.com>
> > >
> > > [ Upstream commit 59d9094df3d79443937add8700b2ef1a866b1081 ]
> > >
> > > The folio refcount may be increased unexpectly through try_get_folio(=
) by
> > > caller such as split_huge_pages.  In huge_pmd_unshare(), we use refco=
unt
> > > to check whether a pmd page table is shared.  The check is incorrect =
if
> > > the refcount is increased by the above caller, and this can cause the=
 page
> > > table leaked:
> [...]
> > The commit causes LTP test memfd_create03 to fail on i586 architecture
> > on v6.1.142 stable release, the test was passing on v6.1.141. Found the
> > commit with git bisect.
>
> Ah, yes, I can reproduce this; specifically it reproduces on a 32-bit
> X86 builds without X86_PAE. If I enable X86_PAE, the tests pass.
[...]
> I guess I'll send a patch later to disable page table sharing in
> non-PAE 32-bit x86... or maybe we should disable it entirely for
> 32-bit x86...

This follow-up patch should address that:
<https://lore.kernel.org/r/20250630-x86-2level-hugetlb-v1-1-077cd53d8255@go=
ogle.com>

