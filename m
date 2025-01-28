Return-Path: <stable+bounces-110951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A07A2083A
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 11:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF203A1D56
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3880918FDD2;
	Tue, 28 Jan 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB+9CnnU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490A198A37
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058786; cv=none; b=QJAXrUaWUT2TY5RPHe41yxXvYym8muGtAytO+gpQzVsFbu8ITnbSGUu2i3zFvckiKBpMknYclL+Yhhjj4oI8ooxyIHi+EtBCVvicmtXggtYU6Semn82QMqeQLXjCaWOOfLJEihV1xrQMOjhgTdW6bws/d+0NYID4ovtTA3XhRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058786; c=relaxed/simple;
	bh=DBddvKNBU/ifywhhW38xvDGwWY72lRzeZCeEQyax8Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDpFp4VnIeHYCx58NoDopdOnyOYcQiVYnSdCCqljI4bO//l7Dpi9DJmW2HAVd6gS/JSpkB8UTcBTtTbisRHzoIh1wR+9ttsuUySNq/UNgSIGQ1HgZWWGGt2cba/FMBXT9ny1xVLvuyZdlolBvayhzqB60XIZ4GhpczctttjYpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB+9CnnU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54025432becso6105250e87.1
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 02:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738058782; x=1738663582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deNH7HDb2c23QYFP12vV+EaWCfGxY8DKG8orZ6rjvro=;
        b=MB+9CnnUUFr8jllwauoIRSHF6kQJBs2wigkOYY7WTQhFc4jvMdi8/euCwbH0LVgAoO
         wjUlyDDIEbFsYu1s78TJG50dR7aSkRNLphHsYwkRcELKy3eqHQf1mq0FTaE11XWwtvYJ
         kYe3NAeoooPH7e3l70C6egqsDF3dZDDMolaxNoJISmZNY6AsM8mbz1if7B6HXhaaVms6
         eAbTfhfGeOs2KQriwrN4xwl7qHoM06udXYm8eno+NW7Ml2fd9S1105fMJBkHoG2kr5za
         y981WfFelpDl8aWZSnUhkGs4OjqQBraWLBVuywg9NKDvOBGjd/F7ibqHEbGIuyS5AnkI
         oEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738058782; x=1738663582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deNH7HDb2c23QYFP12vV+EaWCfGxY8DKG8orZ6rjvro=;
        b=XN8Fq3xgg6Hp7WRRyavyQvMdTDzL+3fxBGXDy0UMtWvtRzZXwYC/qzhDcbGTu9ALsE
         DkAO3KLkjOhnQTDoAqRyt1pv5Ts8t20YByjKrIZaum15odfnwRYvybHQ7sEOWsjhkMwg
         lnUFteGWxA7LNWtO71SDV1vlO3lY11GLQ2+tgeffZoRVAU/60j38r8ScDfR5RUDnT/ML
         lyhxkDGweslkZ2A247NDwnBMpLv1puoNvl37AlJiTFK356beg4sOnIfcJnM1s5h2QKNg
         j6B3m3kkDSYnTqMYRMhqS8rE0jDLU8ZZnyce4sZC/PCjGvpUsPCzO6DKOomxwc/s65D7
         HIMw==
X-Forwarded-Encrypted: i=1; AJvYcCVTRcRAJIkOq0LWKmjEmSLAcYZ1bMR97YA+Ox1KH86TBJVWpmGp/XEVl86Efcrc+P0Ye68gUWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmC0f8eDf3lEQHZgYqfxw88/YtogYZ3xfh8/VGtw4JKyLYS5iF
	ImjnrwqelXjFMZx6Owb61bOtcs31Nw290wGpGI1ddFdlFv6q7vfN4+7qshRFx8MfaWOpGCaJAy9
	0Dphn+Yy4y0wvZArC2BoD92hdKlk=
X-Gm-Gg: ASbGnctIl5HgzszKUo0QdbWVEfYi0SANSgBgTjM4lQJFtgwixP6pKp7QfJyGXPQSn7Y
	LAtM6S40jhhGw+5mrtyC46jI7IIOftq3BZCFVzdpK0w3eYt66cNTt9M3irUVRqLYEyamNjWANWh
	M=
X-Google-Smtp-Source: AGHT+IHebYpTwUQr8RGD7/MeVarMse5DiKG7XYBEfSptDjyaMVtYTx7Ovm+Aie72mDrmBPsSroxJWDw90c8rMmLBOo0=
X-Received: by 2002:ac2:54b1:0:b0:542:9a0a:131c with SMTP id
 2adb3069b0e04-5439c22a908mr13474863e87.11.1738058781916; Tue, 28 Jan 2025
 02:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128174938.2638-1-42.hyeyoo@gmail.com> <2025012842-rebuilt-snugly-518f@gregkh>
 <CAB=+i9Q56PxJ_YpzdcJWWGfxMKKEhkSu0xszv4ne4Ep+KFs-Aw@mail.gmail.com> <ecbc496b-aee5-402c-add1-0ab9d8eef8a9@suse.cz>
In-Reply-To: <ecbc496b-aee5-402c-add1-0ab9d8eef8a9@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 29 Jan 2025 04:05:41 +0900
X-Gm-Features: AWEUYZmteZMv6duj9lrhKyOa-oFh6mLuefhD7_V-yrbIZ9XSECEb-2DYhVhMcEQ
Message-ID: <CAB=+i9SjU3vwj_A9BgJ-YyFCvvM_Ogyw0S-8M2nu8OdGPiw1DQ@mail.gmail.com>
Subject: Re: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 6:42=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/28/25 19:18, Hyeonggon Yoo wrote:
> > On Tue, Jan 28, 2025 at 6:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> >>
> >> On Wed, Jan 29, 2025 at 02:49:38AM +0900, Hyeonggon Yoo wrote:
> >> > Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store=
()")
> >> > mistakenly skipped charging any zswapped pages when a single call to
> >> > zswap_store_page() failed, even if some pages in the folio are
> >> > successfully stored in zswap.
> >> >
> >> > Making things worse, these not-charged pages are uncharged in
> >> > zswap_entry_free(), making zswap charging inconsistent.
> >> >
> >> > This inconsistency triggers two warnings when following these steps:
> >> >   # On a machine with 64GiB of RAM and 36GiB of zswap
> >> >   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-n=
g
> >> >   $ sudo reboot
> >> >
> >> >   Two warnings are:
> >> >     in mm/memcontrol.c:163, function obj_cgroup_release():
> >> >       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> >> >
> >> >     in mm/page_counter.c:60, function page_counter_cancel():
> >> >       if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=
=3D%lu\n",
> >> >         new, nr_pages))
> >> >
> >> > Charge zswapped pages even if some pages of the folio are not zswapp=
ed.
> >> > After resolving the inconsistency, these warnings disappear.
> >> >
> >> > Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store=
()")
> >>
> >> This commit is in 6.13, not 6.12, so your subject line is a bit
> >> confusing :(
> >
> > Oh, thanks for catching. Will fix it.
> > Also, I noticed I incorrectly described the problem.
> >
> > Will send v2 (for v6.13!) after adjusting them.
>
> I think we use e.g. "v6.13 hotfix" only while the stabilization of 6.13 i=
s
> ongoing, to indicate the urgency.

Yes.

> Now it's too late so it would only confuse stable maintainers
> while the patch is not directly aimed at stable
> but through mm to mainline and then stable backport as usual.

Right, that's what I'm trying to do.

> So I think you can just use [PATCH mm-hotfixes] at this point.

Adjusted the subject and sent v2.
Thanks for the explanation, that makes sense to me!

Best,
Hyeonggon

