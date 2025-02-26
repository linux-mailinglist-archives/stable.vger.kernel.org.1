Return-Path: <stable+bounces-119759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D28A46D7B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 22:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91177A38D4
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54E25C6F0;
	Wed, 26 Feb 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFCNng3P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859E1E1DE8;
	Wed, 26 Feb 2025 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605450; cv=none; b=u/8Jooiw7tdgz3vxB42TmicCpanWWvMDonGlF0WwaxC0FCdzkhTXe0s7Ed5bTpiCIgIoLtqv0DHTdX0SAw85aoAeSNduYXWLMQHBGw1p5Iej5/KORyVb83JGmRubRauM1zMFeSjeI/nBxriESrW4QAGaqXiZtFy+n3vRMpfJto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605450; c=relaxed/simple;
	bh=Fa+SeEJeFDsoKrxwGND4hBVmD0Q2qWhMtMhE4PIUYJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njV/GpFo++miLlwAr5I3uhJrLegJc7LyQ4tJ3JT0qru45D47getIP1xvW8Pama/mjGjkjLoIuES57xvjikzvU0LP07fkTaRrnQA6VlYBIx+E1yuyEkQsou68aglX66Ko3Pyclw8a2TWK0/Za36z0gytGH4Y32f/hpqiGSZlzNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFCNng3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A833FC4CEE7;
	Wed, 26 Feb 2025 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605449;
	bh=Fa+SeEJeFDsoKrxwGND4hBVmD0Q2qWhMtMhE4PIUYJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bFCNng3PjzrdqJ3i6uwG8OTTGJ9NDho7HkEeLKPfYsNqSnUbhoN9F9g4I267mEsmd
	 9SwmdZEN45dZwdPZBMB4Px1Mq8+jyKSuwv5uwwIe1lwxkyJga3hed0p2v9sChKscvl
	 VnFPcQ5ZVLS8ItwKDwLruqllgsb4LTHismU1pIf9iGKRnRt0o6fm93JJ2FLAhj3zu5
	 Nccz9W4FX1OU6N1pSGq6vPtLCcKfu+/8a39ZDQ5nvtozYIJf05Yj9zfHrFqHJiY7vY
	 wr/V5VTRHsW4SlL+d0XV4FqDhD1d8O7XTiD47othuqZgFvguBvVJDBYBbiAymEBtyQ
	 pjCT/OKsNOn2A==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so2490132a12.1;
        Wed, 26 Feb 2025 13:30:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYD5bKqfgEN5BeZ7IPB4uJywmNvovxaXNqHBCrsHQfREJI1ciPPLBoJWbHc911rPlq9QEXqJLQd74I@vger.kernel.org, AJvYcCUkQFr0dOueZ8xo0dfocWbgesk0sinMnvx+lmytdo421KIrgMwTbgwm1xEq4zC5hI5Xb9CzrV8nFYUg56gf@vger.kernel.org, AJvYcCVBCEcNiUJa8YKpElK/CAFtmN4pWhqxwQutESqbYeTRmiI+A9YaMRJ5OTWwoAQMQZOa0K5DJr0K@vger.kernel.org
X-Gm-Message-State: AOJu0Yymp+ODjnKBq8zGoXZGbHfjY3+HO3iqqqQbENlQmWHJ9Y1sch5v
	bi5cOgROKnnni8/uonaCxbiImyAfXrYJwLE2pOrua6Unr31LK1PxD75/pnkMaqTxE+ZTFyKRgO3
	2gG5RceFRPmdXoQbCp6Vj9lD1WQ==
X-Google-Smtp-Source: AGHT+IHlCJ+Xi+JTkFIYA5G/1VXTRL3VRHAkWieMIv5z0HohGMqAAYdNDks5N9f1LpXkXE9M9XJfxNjXEHZGQO/HrLQ=
X-Received: by 2002:a05:6402:27ce:b0:5e0:6332:9af0 with SMTP id
 4fb4d7f45d1cf-5e4bfba9566mr1293250a12.14.1740605448294; Wed, 26 Feb 2025
 13:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com> <20250113232551.GB1983895-robh@kernel.org>
 <Z70aTw45KMqTUpBm@google.com> <97ac58b1-e37c-4106-b32b-74e041d7db44@quicinc.com>
 <Z74CDp6FNm9ih3Nf@google.com> <20250226194505.GA3407277-robh@kernel.org> <f81e6906-499c-4be3-a922-bcd6378768c4@icloud.com>
In-Reply-To: <f81e6906-499c-4be3-a922-bcd6378768c4@icloud.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Feb 2025 15:30:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+P=sZu6Wnqq7uEnGMnAQGNEDf_B+VgO8E8ob4RX8b=QA@mail.gmail.com>
X-Gm-Features: AQ5f1JqOKeTnW33IInftxXZnL7Y77FEoU1DLo5L9sHUHjSG2OYc_YVgyXt2Rr7M
Message-ID: <CAL_Jsq+P=sZu6Wnqq7uEnGMnAQGNEDf_B+VgO8E8ob4RX8b=QA@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
To: Zijun Hu <zijun_hu@icloud.com>
Cc: William McVicker <willmcvicker@google.com>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Saravana Kannan <saravanak@google.com>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	Marc Zyngier <maz@kernel.org>, Andreas Herrmann <andreas.herrmann@calxeda.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mike Rapoport <rppt@kernel.org>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:31=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> On 2025/2/27 03:45, Rob Herring wrote:
> >> Right, I think it's already backported to the LTS kernels, but if it b=
reaks any
> >> in-tree users then we'd have to revert it. I just like Rob's idea to i=
nstead
> >> change the spec for obvious reasons =F0=9F=99=82
> > While if it is downstream, it doesn't exist, I'm reverting this for now=
.
>
> perhaps, it is better for us to slow down here.
>
> 1) This change does not break any upstream code.
>    is there downstream code which is publicly visible and is broken by
>    this change ?

We don't know that unless you tested every dts file. We only know that
no one has reported an issue yet.

Even if we did test everything, there are DT's that aren't in the
kernel tree. It's not like this downstream DT is using some
undocumented binding or questionable things. It's a standard binding.

Every time this code is touched, it breaks. This is not even the only
breakage right now[1].

> 2) IMO, the spec may be right.
>    The type of size is enough to express any alignment wanted.
>    For several kernel allocators. type of 'alignment' should be the type
>    of 'size', NOT the type of 'address'

As I said previously, it can be argued either way.

Rob

[1] https://lore.kernel.org/all/20250226115044.zw44p5dxlhy5eoni@pengutronix=
.de/

