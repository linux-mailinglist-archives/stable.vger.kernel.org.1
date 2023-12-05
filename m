Return-Path: <stable+bounces-4669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8988053A6
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 12:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EF2281760
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B444859E4F;
	Tue,  5 Dec 2023 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op6XujnI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27769A8;
	Tue,  5 Dec 2023 03:57:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-33330a5617fso3536822f8f.2;
        Tue, 05 Dec 2023 03:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701777463; x=1702382263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juHNWQkjsGClIEG2iYdwYJ3MncD2wvBN8yrVUxA8Tfc=;
        b=Op6XujnIAolRZugFIlEgSo5vO2TpN3kiJ1u/vIkHK2t1zkdIMMC+o2+hp6cRP/09aG
         BbDFDBJcZ1wacCgR5y+ST2XmOaf7RmcQpOhpNSEp5R5iVEnyLYzmZbsG1DcGiphSwBCQ
         iGFneFS6zRN9Ha2UeEa6GhGFKgr/epVauLCnxtGLJXlPRUpuwMbALImzz5asSZ77H3D0
         7pq5EcO98BUe83JVIHrd5PJWbgx4K9r0clhGc2QcLUXBV3vIKaNbSCO3XkJhTLaIHz8q
         lQSTJm3+clLOkZzSzlflkrvof5U49s7b0MvUNLsokSWTI9lAiPHFrkqd1imDfiJK5rLo
         LI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777463; x=1702382263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juHNWQkjsGClIEG2iYdwYJ3MncD2wvBN8yrVUxA8Tfc=;
        b=JOpqkC3sAeseWSAc5prL8YtMsPTdtn1t8sFMPG6Tz6kt+Mp2tVXfUUCI9LV0szkjjJ
         6SkzAixN/7L9OWQfkko3Jces8osj0tve+L07FbMHGK1yXDUJOKbPD/r7CeBlbOaXN+wZ
         hhgFsgVcho3NhYkmnS+dcf+/rYm+mKOBd601Fqf9kBQjZZwgL7MrUE68/8dCrbJkZi+7
         YtQQdx4y3oD9iNreXfqcynJRzr4VC0SZR53dcKN0ssYhLIWCyVNcc43Pbf5QQCyW0/Sl
         6tXyG5J34S3OYbhrXXlytM0TzDPoI6EgwRkv2Aiparopjwjp0eXmABbb/Nts04Qkvm5R
         De+g==
X-Gm-Message-State: AOJu0Yx8/d+/yVNrPL56dmGf+OJ0/u5n7ARpg6zeozMgqdzslhBd38yx
	A+IAXmvD4k9o9dXfnzJt2Y73CT3zOy6qrkHa3Kc=
X-Google-Smtp-Source: AGHT+IF504eiqyRwC18dGlZ0WyusZeV5rKYbClTfcBwRLfk7NZtSodduOTWf3HgANvG6zFMGSqFDGO1uCc+8agAEIOY=
X-Received: by 2002:adf:f706:0:b0:333:2fd2:5d3d with SMTP id
 r6-20020adff706000000b003332fd25d3dmr3898006wrp.111.1701777463315; Tue, 05
 Dec 2023 03:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOOPZo5oFZAs3sMcEgmTEZy3ef4jg630xL3mUBx3bvV6tQcdQg@mail.gmail.com>
 <20231129103233.GD30650@noisy.programming.kicks-ass.net>
In-Reply-To: <20231129103233.GD30650@noisy.programming.kicks-ass.net>
From: Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date: Tue, 5 Dec 2023 19:57:28 +0800
Message-ID: <CAOOPZo6wV9yrBvHN9uHiQXxG=LxsWjz5K10AZGdHrV9oESbORw@mail.gmail.com>
Subject: Re: Question about perf sibling_list race problem
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-perf-users@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?6IOh5rW3?= <huhai@kylinos.cn>, =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>, 
	huangjinhui@kylinos.cn, Zhengyuan Liu <liuzhengyuan@kylinos.cn>, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:32=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Nov 29, 2023 at 05:33:33PM +0800, Zhengyuan Liu wrote:
> > Hi, all
> >
> > We are encountering a perf related soft lockup as shown below:
> >
> > [25023823.265138] watchdog: BUG: soft lockup - CPU#29 stuck for 45s!
> > [YD:3284696]
> > [25023823.275772]  net_failover virtio_scsi failover
> > [25023823.276750] CPU: 29 PID: 3284696 Comm: YD Kdump: loaded Not
> > tainted 4.19.90-23.18.v2101.ky10.aarch64 #1
>           ^^^^^^^^^^^^^^^^^^^
>
> That is some unholy ancient kernel. Please see if you can reproduce on
> something recent.

Sorry for the late reply since my company mail server has some trouble.

I don't have a reproducer,  It's an online server and happens once
every few months.
From our analysis, the recent kernel shouldn't have this problem after comm=
it
bd27568117664=EF=BC=88=E2=80=9Cperf: Rewrite core context handling=E2=80=9D=
).  But LTS  branches such as
v4.19 and v5.4 will be used for a long time, so I think it's worth
fixing this problem.

Thanks,

