Return-Path: <stable+bounces-93581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A29CF3C6
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099621F23E9E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BB1D47DC;
	Fri, 15 Nov 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="HjLm6roH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDF18FC89
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694770; cv=none; b=APYiz8ib1NKWVm6J73/E4bOmDo32IItq9T657RF24NsS3PK/BxZVwrQl997/NUNAG+g6+MALc48AFZRaG8v1JPxUV6l//bCwXiIme+7+5qawqYlLtQSF9n9O+CMY/kVLZ+j5sVlxGjUpcGOgq1w9EDT3foCcspqAKOQo7OcWoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694770; c=relaxed/simple;
	bh=8WF+IXOI/5KHH0almhkCtR9LN7cZH20aNAhAqFaHpxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYAb11e2pk1/T1rCgEAptu2SPkNwAuhA6Ia9zTklSvFceyMSCwIiD81JwU++HVYbWDr6z5cxUk4tmyPSBRnjkTtq0WyAPQr0sUx4Tsd+447wiaYyvY29IO1eqsOYaT4/VuMEhjkcElPshN1JkPVkSaywkHzTs15cPFp/FstOpRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=HjLm6roH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cafd36ed0so1331495ad.3
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 10:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731694768; x=1732299568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8EINp2KfOlgy1t9t+KySlnYW/+lvzTTAO/KkEajQ4yM=;
        b=HjLm6roHhlBvvJLmUYeAKVzUpWhneQtpDcTqaSYOj8X5z3uZ+m/RP5V7iuLQnnpwad
         loCDMid+rt42sZUIugxolZ4YNyIEs9RgdN3sys107mmo1tznv+Dul19fydiKGc4pAb8l
         dQPTRyFF76LHAuHHI67YxcTHKeJPRqNXVO7ntsaBHCI2/wjWYfIGu9zq6Ve9KqvRbeyL
         hJxT/hHjnsVsioTdHDZ+mpU5JjKwITK+rlpiHsXvN+zOcnFzjKJI1+/k5SbeMMFS4uI4
         jXANAjjncFqiph82xxlUE++hEq4ccz4uehNSYCR+6vNIS5qmgVVEWPgYaRRX1vgwcC7s
         lRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731694768; x=1732299568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EINp2KfOlgy1t9t+KySlnYW/+lvzTTAO/KkEajQ4yM=;
        b=jAd66UNeDe+b4NXy+dH03WoJsTYs7O8yU0sBD2Ue56CP+/frLBhJA4vdlQgDxuCy/b
         GdvaeWtn6zFteUtciqYYnCSS1BSKr+GxiuSEVNf9WuVq8CBZkkdQZunlwzF+JuIZYrsY
         F4ASyQGMsu9Dng9FmRoXm9ihERSaH3RyMlf1/jrw2sm/K0OrF4mLaixnrjEgWv4B4aZa
         nnvWSsmDDnDc+He06v1R5L7IlaysJoIPGq4yFgm2tf1h0d3Msqc22yzXy7jF8QChIdLd
         +GdYa4VbGKYgbYpmqECY/fKANLWgVz133pRdxDfwD3F9b85JN9COsP4+JOVEPkWd6nqm
         216A==
X-Forwarded-Encrypted: i=1; AJvYcCUGBqJVScbz9ZNMkDDTs+vh61IHXzgarfzb/o4fVW1Ch3SgR9IqQ7eIG7XQexY0E7EqqPTf4T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPKMXDUdfsMN4+lp5sFFXwsPHx5LtBro8yqwgRuhq4xOK/6e7
	c92k28Z0EB1AnwrAjbUd1pXdzGVPp9Q+elpFcbh+X0NKoETjMZIJnOE7G7qDZYc=
X-Gm-Gg: ASbGnctC2Ni/NwSAqHLumiIu2P2UEUm9AgmjyxsYUP3nftg87beEvx2lkZY+PxNzYih
	zS3v2z2xKrw0BHC91sOUznBxkFcXHl57/C4UZ7BPLypdi9ya8xl9XYI1eO7nGFyen3I2h1FnKLZ
	p9XBzV6qEhWHHs2GjCRNZz11lCXgtBB6UnDxlyG6EH4TzsRpO4+8qMS20te9ZeWiwwQXgOYZVLb
	q7Wmu83tfIR5zojZZ6nrZiFugjVaP2gtg==
X-Google-Smtp-Source: AGHT+IGx/2L8ZJlSqHsSFOYflEuyJXNV7qZw7rajp1+I37IhqsEhLDkOvbrmAvKWVgAckAVHJDGorA==
X-Received: by 2002:a17:902:db08:b0:20c:c482:1d6d with SMTP id d9443c01a7336-211d0d81c1cmr21369865ad.8.1731694767756;
        Fri, 15 Nov 2024 10:19:27 -0800 (PST)
Received: from telecaster ([2620:10d:c090:500::7:3740])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f4535csm15203175ad.178.2024.11.15.10.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:19:27 -0800 (PST)
Date: Fri, 15 Nov 2024 10:19:25 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <ZzeQrYy-6I3NK4gX@telecaster>
References: <20241104175256.2327164-1-jolsa@kernel.org>
 <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava>
 <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava>
 <Zy0dNahbYlHISjkU@telecaster>
 <Zy3NVkewYPO9ZSDx@krava>
 <Zy6eJdwR3LWOlrQg@krava>
 <CAEf4Bza3PFp53nkBxupn1Z6jYw-FyXJcZp7kJh8aeGhe1cc6CA@mail.gmail.com>
 <ZzUWRyDmndTpZU3Y@krava>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzUWRyDmndTpZU3Y@krava>

On Wed, Nov 13, 2024 at 10:12:39PM +0100, Jiri Olsa wrote:
> On Wed, Nov 13, 2024 at 12:07:39PM -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 8, 2024 at 3:26 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 09:35:34AM +0100, Jiri Olsa wrote:
> > > > On Thu, Nov 07, 2024 at 12:04:05PM -0800, Omar Sandoval wrote:
> > > > > On Wed, Nov 06, 2024 at 12:57:34PM +0100, Jiri Olsa wrote:
> > > > > > On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> > > > > > > On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > > > > > > > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > > > > > > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > > > > > > > hi,
> > > > > > > > > > sending fix for buildid parsing that affects only stable trees
> > > > > > > > > > after merging upstream fix [1].
> > > > > > > > > >
> > > > > > > > > > Upstream then factored out the whole buildid parsing code, so it
> > > > > > > > > > does not have the problem.
> > > > > > > > >
> > > > > > > > > Why not just take those patches instead?
> > > > > > > >
> > > > > > > > I guess we could, but I thought it's too big for stable
> > > > > > > >
> > > > > > > > we'd need following 2 changes to fix the issue:
> > > > > > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > > > > > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > > > > > >
> > > > > > > > and there's also few other follow ups:
> > > > > > > >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
> > > > > > > >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
> > > > > > > >   ad41251c290d lib/buildid: implement sleepable build_id_parse() API
> > > > > > > >   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> > > > > > > >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search
> > > > > > > >
> > > > > > > > which I guess are not strictly needed
> > > > > > >
> > > > > > > Can you verify what exact ones are needed here?  We'll be glad to take
> > > > > > > them if you can verify that they work properly.
> > > > > >
> > > > > > ok, will check
> > > > >
> > > > > Hello,
> > > > >
> > > > > I noticed that the BUILD-ID field in vmcoreinfo is broken on
> > > > > stable/longterm kernels and found this thread. Can we please get this
> > > > > fixed soon?
> > > > >
> > > > > I tried cherry-picking the patches mentioned above ("lib/buildid: add
> > > > > single folio-based file reader abstraction" and "lib/buildid: take into
> > > > > account e_phoff when fetching program headers"), but they don't apply
> > > > > cleanly before 6.11, and they'd need to be reworked for 5.15, which was
> > > > > before folios were introduced. Jiri's minimal fix works for me and seems
> > > > > like a much safer option.
> > > >
> > > > hi,
> > > > thanks for testing
> > > >
> > > > I think for 6.11 we could go with backport of:
> > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > >
> > > > and with the small fix for the rest
> > > >
> > > > but I still need to figure out why also 60c845b4896b is needed
> > > > to fix the issue on 6.11.. hopefully today
> > >
> > > ok, so the fix the issue in 6.11 with upstream backports we'd need both:
> > >
> > >   1) de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > >   2) 60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > >
> > > 2) is needed because 1) seems to omit ehdr->e_phoff addition (patch below)
> > > which is added back in 2)
> > >
> > > IMO 6.11 is close to upstream and by taking above upstream fixes it will be
> > > easier to backport other possible fixes in the future, for other trees I'd
> > > take the original one line fix I posted
> > 
> > I still maintain that very minimal is the way to go instead of risking
> > bringing new potential regressions by partially backporting folio
> > rework patchset.
> > 
> > Jiri, there is no point in risking this, best to fix this quickly and
> > minimally. If we ever need to backport further fixes, *then* we can
> > think about folio-based implementation backport.
> 
> ok, make sense, the original plan works for me as well
> 
> jirka

Greg, could you please queue up Jiri's one line fixes for 5.15, 6.1,
6.6, and 6.11?

Thanks,
Omar

