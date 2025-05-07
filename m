Return-Path: <stable+bounces-141964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC30AAD457
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 06:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C85E1BC7A15
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 04:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116981D5170;
	Wed,  7 May 2025 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVlieqvV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B713DB9F
	for <stable@vger.kernel.org>; Wed,  7 May 2025 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746591109; cv=none; b=Ks2/4Vygtyo3JTXHtHRWKh/ds2W2B1hqmh0n/7FdsWzutcdvuUdr92UrnW1WfuuYeCUusCOAlwEqvBJ3078TRl3kInAR04g4XTYfUneNO0dMS2dxbdfVCOkcD1ZiGttkeDRN8ElD/0eIRIGa/4/2C1yj52AlhJvOqykPERlyiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746591109; c=relaxed/simple;
	bh=8PID+wi9yLs6Itz1N7GVcdzH699Be+tpw+C+FjNWjf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uc9sdxLeChvSRU/ZlfcFvDDc3Qks3fGjKFr7MYmGeX/R2J71YmMpKGDDk78iwIUyln9AB5j8QT9hkjcQeN0afv/m9fCV3B0m4mF7SFl2ohHrlSHe7edHkXkYLUyx4etar9tGnkeMNV1ZW4aA2kV3bFF6T+ZnZWiNKrP4TvHZoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVlieqvV; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-875b8807011so365809241.0
        for <stable@vger.kernel.org>; Tue, 06 May 2025 21:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746591107; x=1747195907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PID+wi9yLs6Itz1N7GVcdzH699Be+tpw+C+FjNWjf0=;
        b=lVlieqvVPiJMFBpwOkkeh+yrugQi/Try7yb+dDjjO/eUvja1sEY+3bffuMJ//Ohfgs
         nEvlJ3LpOTeXNV0LwnqcUHdQKpYwlPQyUKes/BtzHukS/DrtDy46mrzsCeVI+Qx9IwDe
         Oxorti90YR9X6xglZiBwJGH7tOSjfb7KIEu2eR/d4h/zHuklwFBPnIQIWYSEJZY1YJpx
         PGkv0A/g6jtu8uhfquMzvS3njnan0ri4rWNr+n8mBndMp2WvtjSgY/lDTApADBU2L58I
         4QPJHEZWp24MhciJJGGAK2gYdba5HQDC0BJNRGHcGxbg8me2z4VoPB/ERWGCfFt4J25v
         6XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746591107; x=1747195907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PID+wi9yLs6Itz1N7GVcdzH699Be+tpw+C+FjNWjf0=;
        b=HdK/oQs5A34vIdAjFxC0BHR4zywRCGZsNrv3vPaMt/qlt4B1EzL0xF7MCJmiG6grnF
         Q10gKCxiDgZZOUd0neZPhuglBqT9CllXXr38kqRhKkAXrVcSW5YNOESlbDo0+98XuhHX
         prLwg5vYnyvSdTvIBLnxVDPOweBtMOq1g90i3xVoc1IjtJWU6zsb9pJc5yOOat4YcANa
         pAFcWdca/OW/JgjPJwNWnmj+qbLA/2CqHLvxtnMoWKMU9RDS0lCq+wsoEdXmuyHEjp8b
         AyKn4pnlteLag8cwlGlh0sPSHOYRG1wFaGYKbTUPt3gaaY4WbL5lZLWzEZB3ZkIIjsNP
         FPjw==
X-Forwarded-Encrypted: i=1; AJvYcCV5KK9pLPxsQHOlmknt+uL9PprF9nlFgzfjDqFuqyLWAcw8v6h3bM3B8TU5XgPCjnHQI65+bqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnf9rYHgKtrx7lYMqJzLCwyFAn6L5xYURwGJoCHDekjwZ5icaK
	ReNrbSVI07vzaZUBznQKxHXqeEeXO6FFAcOAn3bF9gIVmQ11kRU23ZV7cGzG+mU/A0bMyUHTsGM
	UEhAmiQCJS9hEmD5flpJ2+9Ww/Fsv3+IvSaU=
X-Gm-Gg: ASbGncv4z0qW+13PVQUyl/ZD+yLCXP+aCsNiVtAKvjoQURDX0ClsSscOQf3/wM/J7Ai
	8M/ODPLRSh1gBKEnGn/mQeZcJfM19hEJHqcz1o8R34xV1p+0/znLLSa41mJUOPmZBYoGd8HX+X7
	c1LEnG3BLP3lD06sfErZtlSnLgR86aLqgOFoRtg0AcITuoqYKjHyGvHg0=
X-Google-Smtp-Source: AGHT+IHoK/t0qRHJ5yM/hOBVyZvoaX1A0W9udJoXG+cRgaLh3QCyU3sjlJYfXKdomUH9Boz59AguWE9GpYEdpAi/0AE=
X-Received: by 2002:a67:f64e:0:b0:4c3:243:331a with SMTP id
 ada2fe7eead31-4dc71f555famr1971628137.6.1746591106989; Tue, 06 May 2025
 21:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHcdcOkW1D_zKh-HPsfjX-oGYhv-OwojPXVwcA=NYoO0hcCbZQ@mail.gmail.com>
 <2025050519-stem-fidelity-25b1@gregkh> <CAHcdcOkMt_Mpcm1AjxbU8MurGO5e--LPPJOrSTA+utDOzVHE3g@mail.gmail.com>
In-Reply-To: <CAHcdcOkMt_Mpcm1AjxbU8MurGO5e--LPPJOrSTA+utDOzVHE3g@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 6 May 2025 21:11:34 -0700
X-Gm-Features: ATxdqUG9dkblt4V27qOpHvU3W8xLOFXG2ZqD-fIWGWgiz-WZgF_XlHMyWmIiywI
Message-ID: <CAM_iQpVHg+6WJB7On-+1uoeRHR=HRH6pOZvi++CRktU818DLyg@mail.gmail.com>
Subject: Re: net/sched: codel: Inclusion of patchset
To: "Tai, Gerrard" <gerrard.tai@starlabs.sg>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 8:00=E2=80=AFPM Tai, Gerrard <gerrard.tai@starlabs.s=
g> wrote:
> Here's the list of commits. The order should be the sequence as listed
> below.
>
> 6.14, 6.13, 6.12, 6.6, 6.1: (all 6.* branches)
> 5ba8b837b522d7051ef81bacf3d95383ff8edce5 ("sch_htb: make
> htb_qlen_notify() idempotent")
> df008598b3a00be02a8051fde89ca0fbc416bd55 ("sch_drr: make
> drr_qlen_notify() idempotent")
> 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb ("sch_hfsc: make
> hfsc_qlen_notify() idempotent")
> 55f9eca4bfe30a15d8656f915922e8c98b7f0728 ("sch_qfq: make
> qfq_qlen_notify() idempotent")
> a7a15f39c682ac4268624da2abdb9114bdde96d5 ("sch_ets: make
> est_qlen_notify() idempotent")

Plus:
376947861013 ("sch_htb: make htb_deactivate() idempotent")

>
> 5.15, 5.10, 5.4: (all 5.* branches)
> 5ba8b837b522d7051ef81bacf3d95383ff8edce5 ("sch_htb: make
> htb_qlen_notify() idempotent")
> df008598b3a00be02a8051fde89ca0fbc416bd55 ("sch_drr: make
> drr_qlen_notify() idempotent")
> 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb ("sch_hfsc: make
> hfsc_qlen_notify() idempotent")
> 55f9eca4bfe30a15d8656f915922e8c98b7f0728 ("sch_qfq: make
> qfq_qlen_notify() idempotent")
> a7a15f39c682ac4268624da2abdb9114bdde96d5 ("sch_ets: make
> est_qlen_notify() idempotent")
> 342debc12183b51773b3345ba267e9263bdfaaef ("codel: remove
> sch->q.qlen check before qdisc_tree_reduce_backlog()")

Ditto.

Thanks!

