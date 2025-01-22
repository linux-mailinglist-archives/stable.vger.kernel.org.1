Return-Path: <stable+bounces-110147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92FA1906F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33023AE560
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA2C211A29;
	Wed, 22 Jan 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQnMBDCW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760A18AE2
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544348; cv=none; b=sPDz6c5HoRFiIwigVHjyIg6/VDzw+1erXU9YRQE6WX6edLQC3xgIDHttXGsb4Z0kOexfmnpp6I1j35+XX/MYWFjDGJR99Jd+Msy6L0KIBy7fx4BzREBnqJKuZpmJwnbdmtfYX9E8lb19E81RXUJrQN6zS2UkNHE/APnIn7cGdqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544348; c=relaxed/simple;
	bh=4fB9E+KmYyYbAg5lWiXyt35tPkvFepjgQsIxIDXs3qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQ416eF6rq6hJKxRKyLc+h6JSRwpK0U8YbwOWq7aTCrfQLuocAoKbL+bgjkjkksU3WDo7lLzs+WeVlIrfWQFYk03cyvN7WJWRTANuXEWhSlM6c1qgbwYzmHpy2ZY3VNPkGO/mwhfuRiZceVivWIw99xbqgI05JpSMRGzQ90DmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQnMBDCW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737544345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fB9E+KmYyYbAg5lWiXyt35tPkvFepjgQsIxIDXs3qg=;
	b=bQnMBDCWbMZKGzPYKxge3TP60pEQ6w3o2ZIZOIxBhLG8OMGTYQ44RXgNsUHrJ5sXmRyDf8
	U6aN/LhxQx5GJUqQ6sufnLf8EWZv7nmUi4rdo8hueszDcqwkc5771bK1UhVwG7Z7Pb3pJu
	CM+OQJ89GOQjvoJ5yUhxh68fRhVmqbA=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-wCzR80NpON6jjjguokcHrA-1; Wed, 22 Jan 2025 06:12:23 -0500
X-MC-Unique: wCzR80NpON6jjjguokcHrA-1
X-Mimecast-MFC-AGG-ID: wCzR80NpON6jjjguokcHrA
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e3988f71863so12935437276.0
        for <stable@vger.kernel.org>; Wed, 22 Jan 2025 03:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737544343; x=1738149143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fB9E+KmYyYbAg5lWiXyt35tPkvFepjgQsIxIDXs3qg=;
        b=pmIvp5ekuYFnE2H21+epGTDfmWrS3OagZY7G1dcZdgO3cNtfp2yKbHOmoY/H6JQl7V
         NTbaHtfBdSYWCIKn2CoFgf2MDOIEt21p3sJvIz2hEgWgiMZctdej7z/NYW1MglPzitSC
         iFWLtXXNhkAa1mEQJ9okHnTlaIZsMS9z5q2L+dAn/oF3+E0bBB5Rm+yxn/E+jrzcBPJ3
         MMWjr8HReAAsssFhKpJHX3i1T+P43TjK9E+HRLa04jijSAbyDvsQ2X8Mz++RyT/bgUbc
         is7ZHELXSh//XQOAh3HlJlptd8LIc/L0WC0Bi1t7HwOWZQawOExhBcRcRWXn8gd4YGeV
         kWlA==
X-Forwarded-Encrypted: i=1; AJvYcCUXBwe6Nkod5s+EzpuhpgOXymkCvrAkA8OH+PTJZbHco3swYIbflIu+5zVfSWYpwbuu1sBTjoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydL9wAObS5eYx1lVUGCNhQV0n5aKkF6e4iPKd4Vgi/f6oSa7aY
	V3DtwylV9b1QIOJEmfdbvPTX1liGVmfATveVRzC7ew5c+3aENSLrfB3Y7GiusHrukjhYd3sAc6f
	/eU1mIzaeS7pq90TBjmqdajO8mlRaRCfxaMdsVX4dwyP20KGbo6pBvuK9Usj8k2lwHT6ohZ/Wl9
	Zr+2qGqdPLWLDwYGN/lAchR1J62WXo
X-Gm-Gg: ASbGncs8wQHYzf5cIXvCGx/XbsBwzjLKl1E124W0MpmWRSnfE3TZ2GVCY30oosbLKmj
	PnZsgZHCf0+wuHN9O5YJu4t/yE+9qfievGF6t8WLxfmFm2RUPmo0=
X-Received: by 2002:a05:690c:6e03:b0:6ef:8dd0:fff9 with SMTP id 00721157ae682-6f6eb658933mr154474917b3.8.1737544343102;
        Wed, 22 Jan 2025 03:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGivNJoBau9Ozv+j4BLL8zIkIWqyaCieeW/hTHYpqiyzk9GAipA8Dm6H1I6pMdN4JZDkGTQorzWf3a9mxHQw3w=
X-Received: by 2002:a05:690c:6e03:b0:6ef:8dd0:fff9 with SMTP id
 00721157ae682-6f6eb658933mr154474787b3.8.1737544342764; Wed, 22 Jan 2025
 03:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACW2H-7QEMKA+LUAzFJ+srmRCzSuLk2G7shWt0SGR9SfmxwOjA@mail.gmail.com>
 <CAGxU2F4_59X-Fj7vRCoDqM394699uxqLQZ5yCuH+jXUYcYO81g@mail.gmail.com>
 <CAGxU2F40eWaLxS8tsQaFeQ_ndjwdQXMj7VghH3VidcbkcVPrgw@mail.gmail.com>
 <CACW2H-4UivUO+aVt-Bb7GGwxLWite7hKSBzJ5WhSXyvWCkh8bg@mail.gmail.com> <CAGxU2F57EgVGbPifRuCvrUVjx06mrOXNdLcPdqhV9bdM0VqGvg@mail.gmail.com>
In-Reply-To: <CAGxU2F57EgVGbPifRuCvrUVjx06mrOXNdLcPdqhV9bdM0VqGvg@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 22 Jan 2025 12:12:11 +0100
X-Gm-Features: AWEUYZm4I96U--kvnleoCVg9EscJc162Swo5mHUXkxNMgLxL8V4-FdeLmULkThY
Message-ID: <CAGxU2F4F2jETc9+NFi=9xNkthAbRDOKCVa4-UeOpyfzHjtLdeg@mail.gmail.com>
Subject: Re: [REGRESSION] vsocket timeout with kata containers agent 3.10.1
 and kernel 6.6.70
To: Simon Kaegi <simon.kaegi@gmail.com>, heruoqing@iscas.ac.cn
Cc: Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Martin KaFai Lau <kafai@fb.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jan 2025 at 10:23, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> CCing Ruoqing He
>
> On Wed, 22 Jan 2025 at 04:48, Simon Kaegi <simon.kaegi@gmail.com> wrote:
> >
> > Thanks Stefano,
> >
> > The feedback about vsock expectations was exactly what I was hoping
> > you could provide.
>
> You're welcome ;-)
>
> >
> > In the Kata agent we're not directly setting SO_REUSEPORT as a socket
> > option so I think what you suggest where SO_REUSEORT is being set
> > indiscriminately is happening a layer down perhaps in the tokio or nix
> > crates we use. I unfortunately do not have an easy way to reproduce
> > the problem without setting up kata containers and what's more you
> > need to then rebuild a recent kata flavoured minimal kernel to see the
> > issue.
>
> I talked with Ruoqing He yesterday about this issue since he knows
> Kata better than me :-)
>
> He pointed out that Kata is using ttrpc-rust and he shared with me this code:
> https://github.com/containerd/ttrpc-rust/blob/0610015a92c340c6d88f81c0d6f9f449dfd0ecba/src/common.rs#L175
>
> The change (setting SO_REUSEPORT) was introduced more than 4 years
> ago, but I honestly don't think it solved the problem mentioned in the
> commit:
> https://github.com/containerd/ttrpc-rust/commit/9ac87828ee870ecf5fb5feaa45cc0c9e3d34e236
> So far it didn't give any problems because it was allowed on every
> socket, but effectively it was a NOP for AF_VSOCK.
>
> IIUC that code, it supports 2 address families: AF_VSOCK and AF_UNIX.
> For AF_VSOCK we've made it clear that SO_REUSEPORT is useless, but for
> AF_UNIX it's even more useless since there's no concept of a port, so
> in my opinion `setsockopt(fd, sockopt::ReusePort, &true)?;` can be
> removed completely.
> Or at least not fail the entire function if it's unsupported, whereas
> now it fails and the next bind is not done.
>
> I don't know where this code is called, but removing that line is
> likely to make everything work correctly.

It looks like they already released a new version of ttrpc to fix it:
https://github.com/containerd/ttrpc-rust/pull/281

And Kata is updating its dependency:
https://github.com/kata-containers/kata-containers/pull/10775

I hope it will fix your issue!

Stefano


