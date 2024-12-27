Return-Path: <stable+bounces-106182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC4D9FCF5A
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 01:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025953A048C
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 00:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD911798F;
	Fri, 27 Dec 2024 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhUzeWmf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4B79C4
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735260975; cv=none; b=SG3wxSSJBbDJOEYBf4sEtQ/J9o64T/PyR1MCmmNrooxwdviqYpms0YzoF2IEMS2Tp4d5WG73O6mWDkQQdyt3RYDSr07BFua+qLhoyEaULNNulW62VXePbMYQPPcTANfkl8oBsidORx5jeMn3o8EiTRSy8cGjzXpgx7YXoht+y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735260975; c=relaxed/simple;
	bh=egFk9cIF0QKdDzYedgHl0oYP2QYTFjz+4RZCBfu+4D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGGEYaRlUXt9Yh77OQSGpgdSXaO0t2ZZRZg5fkxaBth2YlQ9ittwivxZu8KcqDRJsOjZ/prVb8kKk9mOv/az+6Q1uVY84nQ15ZRtoBAds0iPRTMWjt4qfBz9xkfizxYNLU7+ny0JcR/xUsWclnqK7UhlRzFyM68t5xds9iLH4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HhUzeWmf; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467abce2ef9so1776801cf.0
        for <stable@vger.kernel.org>; Thu, 26 Dec 2024 16:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735260972; x=1735865772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmg9031oBU+yNDO8om8qf1pVDLfYewKveF6+MqKOFzE=;
        b=HhUzeWmfBV9bDV/OeO7Z/wZhIsHbbR44AK2+i/F2WHbHPfNlGO5NKmTWYfVsfV+zVf
         Px62utE3ydQoMKTYrfZtwkUW2s57oDS0S3MLkauVUrCWl+x7xgHLLABzHxiPvrgvLbAW
         Ry/7x7D4N/1l5kiS2NXGe9iRj+TqN7JC4/pq7YwbsC33rQRSDQISyl0bbg3y/rw4rldv
         vvBHxA3mU8FUAjuboVm5+T4YhVdZjd14USCJSjJtiq40UZpO3zBHabeUrypmnxpZOCBN
         P7iDN4dnr9iwhyFIyuYxuUZrvCxsIDJX9AoR3MSdsgfzPlfBYmDrmgERGKUzGzSpM7AB
         GX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735260972; x=1735865772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmg9031oBU+yNDO8om8qf1pVDLfYewKveF6+MqKOFzE=;
        b=VmMjx8+uUuL78FxMhACSJdwr0K8grz1YVj58O67VnSRLIWTlngFxI7MplgTB7I7eVt
         ERhm+KSZ0B/58y/EJ/cY/B6vbnG2Eq2ejV5krJHluuKOCVgRZpfdPuGH4QsxtyRBLcFI
         zn5YKJri36LX7kMaeR4KiJPemD9Mh6HHKVLB9KSW8se2nr1bu6CHMjeD7fmhXbdOSS4/
         9+vFKlqow0rMhtQ6uiEVTktqcBdBRfPeo1O+VnjWuVExBwU3cjihpLf4iCW+L0PTP6RC
         7DGkVAISRt7ZVJ4tSiotj3+NTSn84QqJPFiVNz9TkPcK/a8tnSInXjSQ5y2EBCvF0x1A
         rasA==
X-Forwarded-Encrypted: i=1; AJvYcCUWmiu7iA36xPJwoPYxeQamwc5hW9jos/1I+zEhdc59oAdH0h/XV8qwugOJqkR3g8Ouadn4B8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiCsDoBBzv6BNz3sVHgYvmWZ0RvRQsabXj5piXLNHhBr659wKV
	oTMclmgJYFPE4ep4FppzhWWiNJy5UKm56SPvsYfQJ32XxecUJa4tnmUL3fW/zfAdy9ptx2qFN++
	EdMEDlKAgeAcleL42qFV8kCngfGSQuWwoMm5r
X-Gm-Gg: ASbGnctSC5PFvZPyAAe+c+aqWJWR/t5maCgIw0ydrg40zlayPn2zG/QcDD6ACC9v2Yh
	tWEVCTNxw/nlDqiIUV06XsTTMDg0ukfAsnzPeGg==
X-Google-Smtp-Source: AGHT+IE4iBoGsKtdMKjCFLQm891+4egmnOR4DRE2hqUqWLpwgabRAeOBJZAwWAV6byblgHFXNdDL7AWbg7J8AKXniIs=
X-Received: by 2002:ac8:5f4f:0:b0:467:462e:a51b with SMTP id
 d75a77b69052e-46a4a8efe30mr17834661cf.14.1735260971638; Thu, 26 Dec 2024
 16:56:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226211639.1357704-1-surenb@google.com> <20241226211639.1357704-2-surenb@google.com>
 <20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
 <CAJuCfpFSYqQ1LN0OZQT+jU=vLXZa5-L2Agdk1gzMdk9J0Zb-vg@mail.gmail.com> <20241226162315.cbf088cb28fe897bfe1b075b@linux-foundation.org>
In-Reply-To: <20241226162315.cbf088cb28fe897bfe1b075b@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Dec 2024 16:56:00 -0800
Message-ID: <CAJuCfpG_cbwFSdL5mt0_M_t0Ejc_P3TA+QGxZvHMAK1P+z7_BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is disabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 4:23=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 26 Dec 2024 15:07:39 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > On Thu, Dec 26, 2024 at 3:01=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Thu, 26 Dec 2024 13:16:39 -0800 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > When memory allocation profiling is disabled, there is no need to s=
wap
> > > > allocation tags during migration. Skip it to avoid unnecessary over=
head.
> > > >
> > > > Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: stable@vger.kernel.org
> > >
> > > Are these changes worth backporting?  Some indication of how much
> > > difference the patches make would help people understand why we're
> > > proposing a backport.
> >
> > The first patch ("alloc_tag: avoid current->alloc_tag manipulations
> > when profiling is disabled") I think is worth backporting. It
> > eliminates about half of the regression for slab allocations when
> > profiling is disabled.
>
> um, what regression?  The changelog makes no mention of this.  Please
> send along a suitable Reported-by: and Closes: and a summary of the
> benefits so that people can actually see what this patch does, and why.

Sorry, I should have used "overhead" instead of "regression".
When one sets CONFIG_MEM_ALLOC_PROFILING=3Dy, the code gets instrumented
and even if profiling is turned off, it still has a small performance
cost minimized by the use of mem_alloc_profiling_key static key. I
found a couple of places which were not protected with
mem_alloc_profiling_key, which means that even when profiling is
turned off, the code is still executed. Once I added these checks, the
overhead of the mode when memory profiling is enabled but turned off
went down by about 50%.

