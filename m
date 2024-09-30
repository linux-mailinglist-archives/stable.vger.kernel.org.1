Return-Path: <stable+bounces-78260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6D898A491
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA2F286685
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEA018FDC6;
	Mon, 30 Sep 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkaHHwUt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE118E36E;
	Mon, 30 Sep 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702320; cv=none; b=M3ylJ8YS9nZ8wE0U3l204ELyj62/bNBo1o3+cIBRJB+reMMv0c+vJKJSoDZInDUhhb3FmNhKTRBkuykRnPX7ZrNdQXl3y0TqnuJcCtitotMvdCuuSnLjxYOoWKlleMna0ruKfMW8GK8UuY67hP+t6tN5EGsSIZwAtBEu5fO9Ka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702320; c=relaxed/simple;
	bh=R/DAKeRK1OrB3Ld3fbwvFPlwIXzPnBdJ3N3gEjoOEhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxSefaG7eDMHuW029asKBhafC0lpAuJO7/Scon+/+FM281TdLWM5ViLVsKp5N3BnY62Fg31zUVX8up2PkciEDRRHzBqr4TzpXDvVe158chdAXRVVka3XTy2I3U0j0cMizslDlhwcSDRd0rS8jkbLMW3AbqUhcM7krSA8/BGhtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkaHHwUt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7ac83a98e5eso376837485a.0;
        Mon, 30 Sep 2024 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727702318; x=1728307118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqb3JtNhWWkOUOy2ElpxqXyhTNuktovVBAPwTw1UTzs=;
        b=NkaHHwUtvgWfmZQnaQKhyjys0uBRsiIbtDusuJBlJ0PSiTjNPw24EJ1rf9cevZZpif
         0KhK5UBmhk+OboufoZrI4a3uPZzOkd+Wki55meXsPfe2ShUk52/2Fpul57RdPwScF5I1
         tQMFJK2BvirBZtn+EqHt4K2DF2WkNPj3o1Dm347rMkvqwnLA23o1+U20DPVkE2c1Nxf+
         FV8dqZB7bXV5moJtEPm93wszKZd37WfK3fUkDlCivqYHioyfPtVjYfN9AGnXKaUziDc2
         6C4b4D8PRe3B5l1XhPOI+YVPSU32CNFdAAiO0kdsUXdD3tVgWfhSKm4LtBgfiCd66QE6
         /oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727702318; x=1728307118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqb3JtNhWWkOUOy2ElpxqXyhTNuktovVBAPwTw1UTzs=;
        b=VYDFSOk6ZzqTFW1GWGKAA+qieIAE0AIF1fDEZRXDw2p3LzKrs93+bz9/DVT7klLHhN
         NKw+E/r1osYLf+pWbgY0KhvtO+H3jjxjK+1/1n7tbLkyFBi6lR31t8iHlkBDLmQjlt1D
         ZhLFwINW+B120lP19SDs8jl0ZnipTm1OuM2si2uifBv62mYYR2HWVh+oz4ygsst0ARKN
         r1rBxcd0CQAXk2iQQiMqDCAYYAKVXHWxC5CfKTui//h8zpswuTqYyYj2acTBaQHJirMF
         l3ql484OXkzb+qkxcSN2QHdVQWu7lwEi4J2DtKvdbpP3WpInJ4xLThA1O9m0+JsNKtjx
         DTIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCqj23n6y1j1CDbL+0oNjXh7SOCeuTbDwDsPOMfNqW4r398n9HAXFEPqXsQBCdLg+JlHaXemoGCqdlzk8=@vger.kernel.org, AJvYcCXrmGdAFLmHa+j2k0RZgvPwjzDw1evbadyeBAi3ACW7ReVp4pud2NZr13ZJ0nyjl4fdSsfxvlp3@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmb+HiDCe7w/0hZstvMl4do0MDtzXP6mjo+li4QlmE7xeBY6N
	7a5mKsw2mnd3LR8Ml/RJF+swKVIC/eADPvh+iBxxG9JVpE2QkT3ry/qiyiwjkJHFGsL/FJQXQsC
	WviNS7+q6wR+1k2xRGPLnjtpz+76QnWhpWKY=
X-Google-Smtp-Source: AGHT+IF7AXYLFHtLUQIv/Ye2qZCxqhQBuqosJSPFYmJoZ4RLhHt8UrvV495lBQjxZG0qIu5MgMyrS1zc1EeuZTKBLEU=
X-Received: by 2002:a05:6122:a1c:b0:50a:c52d:6ba6 with SMTP id
 71dfb90a1353d-50ac52d8005mr853284e0c.7.1727702306292; Mon, 30 Sep 2024
 06:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926211936.75373-1-21cnbao@gmail.com> <871q13qj2t.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q13qj2t.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 1 Oct 2024 02:18:13 +1300
Message-ID: <CAGsJ_4w2PjN+4DKWM6qvaEUAX=FQW0rp+6Wjx1Qrq=jaAz7wsw@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kairui Song <kasong@tencent.com>, Yu Zhao <yuzhao@google.com>, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	SeongJae Park <sj@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Oven Liyang <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, Barry,
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> > introduced an unconditional one-tick sleep when `swapcache_prepare()`
> > fails, which has led to reports of UI stuttering on latency-sensitive
> > Android devices. To address this, we can use a waitqueue to wake up
> > tasks that fail `swapcache_prepare()` sooner, instead of always
> > sleeping for a full tick. While tasks may occasionally be woken by an
> > unrelated `do_swap_page()`, this method is preferable to two scenarios:
> > rapid re-entry into page faults, which can cause livelocks, and
> > multiple millisecond sleeps, which visibly degrade user experience.
>
> In general, I think that this works.  Why not extend the solution to
> cover schedule_timeout_uninterruptible() in __read_swap_cache_async()
> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avoid

Hi Ying,
Thanks for your comments.
I feel extending the solution to __read_swap_cache_async() should be done
in a separate patch. On phones, I've never encountered any issues reported
on that path, so it might be better suited for an optimization rather than =
a
hotfix?

> overhead to call wake_up() when there's no task waiting, we can use an
> atomic to count waiting tasks.

I'm not sure it's worth adding the complexity, as wake_up() on an empty
waitqueue should have a very low cost on its own?

>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

