Return-Path: <stable+bounces-80779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C181990A81
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AAF28229D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2581DAC81;
	Fri,  4 Oct 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsSv3mPm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6E1E3786
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064758; cv=none; b=pPnn24gki3DUac7eEmK0cbrk8Asq7miWm7RcjaJRshfvIpjuyPVBXGOsV+eZKD/gk6aEtBv67iKv1q44oXzhlcw7COWJAQ/pWkMD+eBW64V1vNYr/7PpsOSgL6JjMpOngVIWOsG09PRVCPokFEzBcMwXaG/n0adNYFceBz2DStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064758; c=relaxed/simple;
	bh=DRwOS9bMoOzqePm1SDrUAn8rG0Un516NdS4FyBLqf2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBPwForAYBHTyGjveGqZwHURzPwUfsstnuVHp4cxHUpRuM6kPHxi6SRn1tvF+5yWABc48x7X7YlN3KfW6fKAQDyHFHNiXsiMBZ1njL9Womt6ypUXkzOdyBLBVYLxUj49VPZJHGsDNkozQaDbVHWvklna9fo96bG8zP0UiTqK7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsSv3mPm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e255b5e0deso19800137b3.0
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728064756; x=1728669556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRwOS9bMoOzqePm1SDrUAn8rG0Un516NdS4FyBLqf2U=;
        b=bsSv3mPmCUvNQovTZWymHjSCet/nIfvDrKStjrmQ+I6qtGpioWos3SI2DdHo2rNqTq
         k9lytKPbhWhj66rJN2PgX1Ru6fqVFnV1A/Asme1TtwTArP5EYrClkz/Lo/IppYFzA5Xv
         RIGPnlPQH8M5lNd6yOyI35Udpj2MaxVz+csCW3KlqKYKION8gb6BTRinx6nrorwzxa78
         cVvGzv0MiocKG3cO9C7AGVkAciDOcG//V8webdTojyiISxMXNmPvefNB7eyV0Ush6nSu
         sO+c6jduBZH+PiXzNuqiR8pul3bGVxXgCMjAE79kdslwxjKFF5v13bKg2x9zVoljYYWV
         1UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728064756; x=1728669556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRwOS9bMoOzqePm1SDrUAn8rG0Un516NdS4FyBLqf2U=;
        b=DovE4HkNw5L0mhMh9iq/6eh8ud/szmb7BkTWPbRFO29NEztXe3vXFvT0EQT+RhebsN
         CG8ZWhEebCiefV9HX5LdhY6LKUeqAQXj/W36S0Ob1cShmBpbsCpFXLtnWJWtx2rrgVfG
         bKwdJZslPQh8D7OIWJpORdd3S1l0KGs/nwVWG7n5luDI/UbB+2h6iZ8c2IqCCo0Kqddz
         xR1BIRP0gMHqZCfJ8Yae8KHGBfgyK/H0GegyyIpB/BrRzrD9OlftppNSGN9OqlmoNwHY
         PN8PH85lFpAhMLw5UAePsYBNnkVe+E5FVlu8b2elAyXC6HESDQVj906Ykr7EorXVlmKo
         jhfw==
X-Forwarded-Encrypted: i=1; AJvYcCWMysZiXn0AsXjSIcVr6uUp9WmifdtnMeaRscAFrZiEzN/MuBQAUpY7y2rH6Zoo1dmfj/5yJYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9dZERUenVb4yWPqYRN3mp939/X0oh1olLw4JSl6oR8QlC1AB
	vgEiosBFzI37RaDJ6ftiaUseY7P+1e7hF2Y4O2RSxFC7238+urJMm5Xy9KP1HjmUqci4qmGXUAV
	tEKPYuydIvv9BHZTmdSyvr78wOoQ=
X-Google-Smtp-Source: AGHT+IFIOBo8QxrlSc3g6B70PgpHtfKVajoreTZbg9Pk/0PJQDfMjjagFzFHQKaJiS/RgZ+55j35mDaSxCD+x2fkZts=
X-Received: by 2002:a05:690c:610d:b0:6e2:a250:a1bc with SMTP id
 00721157ae682-6e2b540695amr57442297b3.22.1728064755895; Fri, 04 Oct 2024
 10:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125822.467776898@linuxfoundation.org> <20241002125838.303136061@linuxfoundation.org>
 <CADpNCvbW+ntip0fWis6zYvQ0btiP6RqQBLFZeKrAwdS8U2N=rw@mail.gmail.com>
 <2024100330-drew-clothing-79c1@gregkh> <A8D6C21F-ACAD-4083-900F-528EB3EB5410@oracle.com>
 <CADpNCvbKGAVcD9=m_YxA6qOF6e0kohOfVsKOqJeVmrYaq0Sd8w@mail.gmail.com>
 <2024100420-aflutter-setback-2482@gregkh> <CADpNCvYn9ACkumaMmq7xAj6EQuF6eYs174J+z81wv5WqzdWynA@mail.gmail.com>
 <2024100430-finalist-brutishly-a192@gregkh> <2024100416-dodgy-theme-ae43@gregkh>
 <8AC0ACC8-6A77-487E-B610-6A0777AFC08E@oracle.com>
In-Reply-To: <8AC0ACC8-6A77-487E-B610-6A0777AFC08E@oracle.com>
From: Youzhong Yang <youzhong@gmail.com>
Date: Fri, 4 Oct 2024 13:59:05 -0400
Message-ID: <CADpNCvZXyw25A3+DvMpECFoffWmcrFQ0Do5hhwbqftxTVr-+Mw@mail.gmail.com>
Subject: Re: [PATCH 6.11 397/695] nfsd: fix refcount leak when file is
 unhashed after being found
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-stable <stable@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Jeff Layton <jlayton@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The explanation of how it can happen is in the commit message. Using
list_head 'nf_lru' for two purposes (the LRU list and dispose list) is
problematic. I also mentioned my reproducer in one of the e-mail
threads, here it is if it still matters:

https://github.com/youzhongyang/nfsd-file-leaks

Thank you.

On Fri, Oct 4, 2024 at 1:23=E2=80=AFPM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Oct 4, 2024, at 10:35=E2=80=AFAM, Greg Kroah-Hartman <gregkh@linuxfo=
undation.org> wrote:
> >
> > On Fri, Oct 04, 2024 at 04:26:39PM +0200, Greg Kroah-Hartman wrote:
> >> On Fri, Oct 04, 2024 at 10:17:34AM -0400, Youzhong Yang wrote:
> >>> Here is 1/4 in the context of Chuck's e-mail reply:
> >>>
> >>> nfsd: add list_head nf_gc to struct nfsd_file
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D8e6e2ffa6569a205f1805cbaeca143b556581da6
> >>
> >> Sorry, again, I don't know what to do here :(
>
> When we tested 1/4 on upstream, it was neither sufficient
> nor necessary to address the leak, IIRC. And I don't recall
> ever seeing a clear explanation about why that change is
> necessary. That's why we consider it a defensive change,
> not a bug fix.
>
> But it shouldn't be harmful to backport it to LTS kernels.
> I don't object to a backport. To me, though, it seems to
> be lacking a complete rationale.
>
>
> > Ok, in digging through the thread, do you feel this one should also be
> > backported to the 6.11.y tree?
>
> It's not clear that it is needed in v6.11 without testing.
> Neither Jeff nor I have a reproducer for that leak, though.
>
> 4/4 seems like an ABI change, and again, testing is needed
> to see whether its backport is truly needed. So far we know
> only that when all 4 are backported, the leak goes away.
> That is not proof that 4/4 by itself is required.
>
>
> > If so, how far back?
>
> LTS kernels all the way back to v5.10.y are likely to have
> this leak, since they have all the NFSD filecache backports
> already. 5.4.y is generally too old to be reparable.
>
> I would prefer more testing of this backport on the stable
> kernels, but I understand if that isn't practical.
>
>
> --
> Chuck Lever
>
>

