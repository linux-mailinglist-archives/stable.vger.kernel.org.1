Return-Path: <stable+bounces-185675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F80BD9D84
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6C33BD5B0
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2930E313E25;
	Tue, 14 Oct 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnEsB/l1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B52FC025
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450539; cv=none; b=H8EJnINNPg28iEK478J7BHTD9fcU+QsQBo9zPrT4Git+0JJwh7fP6vTAMqvoa1NzHmcWo6RRQrGpMcsZ6ShrYkeFlkrHK38XRdCwDyTZNNo7DmKRPeMDddJHsnyXbno2XZX2HRBWlal5PdK9ntP1Q7raja7kpywttGYI/DLdpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450539; c=relaxed/simple;
	bh=X3Kj/9EsBuDj0C6iucnIK+fPSAPaDJhaBn0XMlaK8Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBXQ/+BX066Qu8d7p1HYyVV8A2H+dp4k9m7MMqNle6756ol08gqqTQWaxY7eguAPcMAA8BGyy8aJZhn9rE1aHvxHm9D0VxSaYtl6crcsvS3Ga50gYn2I3TZjdtMKzSJN90JzFL+AuinAd38vYxkw8nbbp/aJZ3a7m2ZQSzrARBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnEsB/l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7959EC4CEE7
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760450539;
	bh=X3Kj/9EsBuDj0C6iucnIK+fPSAPaDJhaBn0XMlaK8Q4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WnEsB/l1SKnpXKFXHdCaVVoboBxHsRTyLiVfQjj+gCtsqLNoQ6MOF0WfVATpStdif
	 LadV6c7ec6sVSk+8fzUWZZvsaFGWC+W1gFlvDpEdHzPB4iw/74Tro3eTyKDHN+MHL+
	 kd8jUYq53W1mlsdoydrMczYXvz7PNT+aZdqj1IQfoi/IOF9ReamHWz0rpbmAPDLPyB
	 E6+gURtPOp/R0jVEL7AHQbD/yyvGMYKe/iQ7ZO5PlWQ4cm1xqK6rAOpkfM3RjwMbHi
	 vrhrYjxFSL6dBbMmVKVVvjql2pA0wRiM5PhL1d7DVG0bIbO1K/dpNk8PYEQsPGscNG
	 OnkIcpqwaNaEA==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-43f696ebf8eso1282272b6e.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:02:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/fsIA3mjXShR77NxOEH9LLU+dUT1cpVxjyV9yY8vY6CKDi4EbDmNvUhvuXfXveoyARreCdMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvq4vbHJOdKhRlNzxuGzvUeaCPOEymV++NXuMO71Yyj0HB530
	heftx65ZpjVwiQIU0GZZrJn1gOa8tQ2rfFQWe8CR9OAddO/A7hIaZ2AE0798VILVh3GbbNNuFmH
	GwGvRGW0YHBvWn9FngtHGQulZHpYQQt8=
X-Google-Smtp-Source: AGHT+IGFjl6mqna9UBI551AIvWdiRTPoDPt8yqEi2IVIDmySqLss15l3WEoWQg5zQfl4GNQx1/9Oz4DcCuWdud+uht0=
X-Received: by 2002:a05:6808:1308:b0:43f:1338:7f5d with SMTP id
 5614622812f47-4417b36a238mr10540894b6e.13.1760450537276; Tue, 14 Oct 2025
 07:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
 <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7> <a9857ceb-bf3e-4229-9c2f-ecab6eb2e1b0@arm.com>
In-Reply-To: <a9857ceb-bf3e-4229-9c2f-ecab6eb2e1b0@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Oct 2025 16:02:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iF0NE07KcK4J2_Pko-1p2wuQXjLSD7iOTBr4QcDCX4vA@mail.gmail.com>
X-Gm-Features: AS18NWCDXS5AT6EoYutgX4W85Vm-NEEqEmK1wrey4luYZ0ANNj-JQFtyWJqNkrc
Message-ID: <CAJZ5v0iF0NE07KcK4J2_Pko-1p2wuQXjLSD7iOTBr4QcDCX4vA@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:59=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/14/25 14:56, Sergey Senozhatsky wrote:
> > On (25/10/14 15:47), Rafael J. Wysocki wrote:
> >> On Tue, Oct 14, 2025 at 12:23=E2=80=AFPM Sergey Senozhatsky
> >> <senozhatsky@chromium.org> wrote:
> >>>
> >>>> Any details would be much appreciated.
> >>>> How do the idle state usages differ with and without
> >>>> "cpuidle: menu: Avoid discarding useful information"?
> >>>> What do the idle states look like in your platform?
> >>>
> >>> Sure, I can run tests.
> >>
> >> Would it be possible to check if the mainline has this issue?  That
> >> is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
> >> with commit 85975daeaa4 reverted?
> >
> > I don't think mainline kernel can run on those devices (due to
> > a bunch of downstream patches).  Best bet is 6.12, I guess.
>
> Depending on what Rafael is expecting here you might just get
> away with copying menu.c from mainline, the interactions to other
> subsystems are limited fortunately.

Yeah, that'd be sufficiently close.

