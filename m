Return-Path: <stable+bounces-151406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A66ACDEC8
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BCC1776CF
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFB217F3D;
	Wed,  4 Jun 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7Tq8vM1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723043AA9
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042930; cv=none; b=jHibLga8p6owao6KwwRqMjJm8BOKv2C+5pxfNcg3PqieYvedbsjFSRLdqbYF9dXvpjoJMgqrs/Cvz/gSjiE5qKYRh1cqdBScFMfS7OvOPx2Eg2tLjr2WtAINiUic7XueReknz/EJzXyRR1ven6EEhZhccjaJ1Jrsh1D/+7H4i2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042930; c=relaxed/simple;
	bh=ScbPOmxLkhoZ1cDqil/IZy9KI3AulMrptp/FS9Jfjl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2I7Oo84y18F5UVqHPz4WmwkMimLXaJRyzWBIJpn99hIrBfNDylMKC39OlNNX9hHnHrxZKFwk5TWVBkPkKiHSQ13zSnpuVqx+qwr/1YnO0rhAMlyxtmtHM6l9Q3b/8/KdhRmCqBEW/l8ASkGveheuRohjPr5ZkD5F5vQ0/Ihix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7Tq8vM1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-308218fed40so840107a91.0
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749042928; x=1749647728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCYLMPKdnlJAYQpTMAISS2z8W8fxShU0rt9Uc0iK4rE=;
        b=N7Tq8vM1gFXAc07/Zg1FTgqiD5jr20IAVZ34+8wLwMtMtBKiYD8ukiZuYZUr7Ooq7U
         tZASqowNqMrdxVVBHzPVB0DZsMDtFyieb2s9gHi7mbLXCxgHne83mthD0LAS6eljQIsK
         4K9cgMKt3pYVitOmhrK/PDWjnHjfU+CoPhm5JiTDbudGYKonSqUdRkrIQ4I3DWDUMIBz
         ynVsF7rxqwK7RRSltfvjTdMd0g6+8kbgZC77SkZUNxuA5Wo6p4KoCAL1A0BfJIC+IsKy
         0xeylq8mCRwJzuFyLdLDTPP/OaSYXqeLfioEBwzbDBDCaNgMAMqu0u+3CvXdAKqU/oia
         6VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749042928; x=1749647728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCYLMPKdnlJAYQpTMAISS2z8W8fxShU0rt9Uc0iK4rE=;
        b=aQ7LT44ktt95v13QE3MMQ3WcxZQqKiVl9sHzfCSm8pCqxCK2kvipSwBQe/tRFKu6gp
         S28aiNWAt3MTq/HPYK1MWnq1ZMBeUJoR0xho5yFMSU2OAGFfqtYCl6fz1YeZ7bC2f6H7
         ICNnyOar/Mw5AtmpUWtcUyw5O1EvstgP9Ww2YFa+zcZFpBbN3g4mqT1GoN4BOy5jR9NI
         nTiEykz+uxb0NIbM7t1NZpFimZyJt6ETPvFsTDaJTazrYLg3UkNRVWGJjyHvB5Tb7P/J
         5euQDiJIbnP5XItgmm/lD08FslPtYvGCXDN6KjgAsNqi+zUw8niCnUtA3ZFhWjEc8kGv
         tomw==
X-Forwarded-Encrypted: i=1; AJvYcCXWrjx3slyKkpjLLTnaPoZPLRN9QT8lZeUT81grWMC2R43rsM9lgjEpACJ5pawyZCJ5GwoYi6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIyZJ3w3JdmFn00EEIULXkWo/wpCqqEN/f1Xx2ZRN5wyCWEGgz
	nh/5WkyKGrjZ+tmvCmJxke0lGCUT/m44fJ6DvA46W5RcSXjj9KgVmPjLoOdfFud8mMKE3G31klL
	66tsyLay7jctXRW5W8AqRO6ISnijQWpg=
X-Gm-Gg: ASbGnctOJIgry64e4B1B8ucmD1gF7fvEx1okOMbUSaCgdHvQehWs5THNCmEy+C0bxcS
	SbZMosnkBdCuCi2sGnOl2HH2C1bCYLEX3s0XdmtQ1OvKqVLCAg7MHbLFlWNsX1EVo3sD9KhrQeW
	0YIcqP+Ip/SyAByzEkU/IhHyObhpsCSnkiYRDOzAE0Ukg5
X-Google-Smtp-Source: AGHT+IGRHI4o8ybBMUjDV6E0tY5UJVBxXL9jqEzcy9tCSWUQBQmpNBLSLxj/yZy+6XAHVSmlV5mVgJkFbvSw+wtCLvI=
X-Received: by 2002:a17:90b:5287:b0:312:1d2d:18f8 with SMTP id
 98e67ed59e1d1-3130ce4c202mr1598982a91.7.1749042927752; Wed, 04 Jun 2025
 06:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530200918.391912-1-aurabindo.pillai@amd.com>
 <CADnq5_P1Wf+QmV7Xivk7j-0uSsZHD3VcoROUoSoRa2oYmcO2jw@mail.gmail.com> <jn3rvqffhemwjltd6z5ssa2lfpszsw4w7c4kjmkqqbum6zqvmi@pv6x2rkbeys6>
In-Reply-To: <jn3rvqffhemwjltd6z5ssa2lfpszsw4w7c4kjmkqqbum6zqvmi@pv6x2rkbeys6>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Jun 2025 09:15:14 -0400
X-Gm-Features: AX0GCFuEm4P-A96ElLoHLpKmMRORb3VPwCvqqXCZ8vKe0FEZcQbZ3Cs2mXrc2wY
Message-ID: <CADnq5_PHv+yxYqH8QxjMorn=PBpLekmLkW4XNNYaCN0iMLjZQw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>, stable@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 5:40=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Alex,
>
> On Fri, May 30, 2025 at 04:14:09PM -0400, Alex Deucher wrote:
> > On Fri, May 30, 2025 at 4:09=E2=80=AFPM Aurabindo Pillai
> > <aurabindo.pillai@amd.com> wrote:
> > >
> > > This reverts commit 219898d29c438d8ec34a5560fac4ea8f6b8d4f20 since it
> > > causes regressions on certain configs. Revert until the issue can be
> > > isolated and debugged.
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4238
> > > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Already included in my -fixes PR for this week:
> > https://lists.freedesktop.org/archives/amd-gfx/2025-May/125350.html
>
> Note the way this was done isn't maximally friendly to our stable
> maintainers though.
>
> The commit in your tree (1b824eef269db44d068bbc0de74c94a8e8f9ce02) is a
> tad better than the patch that Aurabindo sent as it has:
>
>         This reverts commit cfb2d41831ee5647a4ae0ea7c24971a92d5dfa0d ...
>
> which at least is a known commit and has Cc: stable.
>
> However this is still a bit confusing as commit cfb2d41831ee has no Cc:
> stable, but a duplicate in mainline: f1c6be3999d2 that has Cc: stable.
>
> So f1c6be3999d2 was backported to 6.14.7 (commit
> 4ec308a4104bc71a431c75cc9babf49303645617), 6.12.29 (commit
> 468034a06a6e8043c5b50f9cd0cac730a6e497b5) and 6.6.91 (commit
> c8a91debb020298c74bba0b9b6ed720fa98dc4a9). But it might not be obvious
> that 1b824eef269db44d068bbc0de74c94a8e8f9ce02 needs backporting to trees
> that don't contain cfb2d41831ee (or a backport of it).
>
> Please keep an eye on that change that it gets properly backported.

DRM patches land in -next first since that is where the developers
work and then bug fixes get cherry-picked to -fixes.  When a patch is
cherry-picked to -fixes, we use cherry-pick -x to keep the reference
to the original commit and then add stable CC's as needed.  See this
thread for background:
https://lore.kernel.org/dri-devel/871px5iwbx.fsf@intel.com/T/#t

Alex

>
> Best regards
> Uwe

