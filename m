Return-Path: <stable+bounces-181795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBC8BA50A5
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 22:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151591BC6953
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4249028467C;
	Fri, 26 Sep 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNTn0KyV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF701DF75D
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917289; cv=none; b=Do/a2SSYM/4ePAeHGWB5zuoy9M5guUfoYNJw7/iGkjYu20DVO6jIjQgVvEBmb4FLbn8x+iT/HSsWHwmKSkpwlWjYyUCCf70sJw2lvFxOct8oHsaa0nDzAYTQrjywb4UcJ8Hb1tTr8YAwb8Omxhq50Je0VS9iKupVqgeIOLIQiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917289; c=relaxed/simple;
	bh=K9CI2XREIIFjhmSjVkb/YP87oVQqlW9glL6hrNBmQgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsJ6GzfxS0lJSGn2Yir6V4qpVzSOMLkq9kM39/Y11lZBHnCm0ef/EH8GUGWJ8U05Idfm3I/lbnNlugh4LF5QYlvHL/AtFR/nM55JG9i4CmA5B7UcKHvmcDemv7SGGXNKIiS2EFgghBCw2Eo9VkjjPVDBxveakSq2J5Jq1HA65UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNTn0KyV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57dda094f6cso1780e87.0
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758917285; x=1759522085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9CI2XREIIFjhmSjVkb/YP87oVQqlW9glL6hrNBmQgU=;
        b=BNTn0KyVHrEuIgcrgvuTq9cAuBBwnCT8qIRHq8gb5hplOwRyv+xAC2SeOlaMDvFH40
         2HfxWB2YBOcdyO4qHAX+V1D17W+35xTRhRh9ySS95/eNBkKYLslBWa3GNHPmyWrVp/vc
         Bkzg9sni+zyWpa8kk+hX2GDFR4z2XORhBmEQ2M0wPeZ9r5MhBZL2ksEytF7mfBhy9fGJ
         PgahMD6BZQ9taby4wvmO/ZlpSJOVFkRY30l0WuAWnehwlzhNJlzpd/0djTarpBpOv33A
         0R6XaPPO85bfLssDfYTt5ZaxqTJ6lkMrZkGmu756/Y8HZ6h1ghGhTg1JhAMsL2s2ogIK
         d9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917285; x=1759522085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9CI2XREIIFjhmSjVkb/YP87oVQqlW9glL6hrNBmQgU=;
        b=vEiHWAE6JMDa5qi8X/0wWUdGQnHGVsiAgWl/VOoGyZEkr/7VjGO2orGITdvZFVZp7+
         D5dAA4KeFM6jT4zu6JnnkSOUzbhEJqq0kF49x4cFrUxLklHlFkIeVoMrDcUrIn1J0y8g
         24sTq6jOh/xn9e793KZAbHMfSx8SDpcnXswHWN0RXTYKGDB6tILMRLf2wUYpsJU9hZxt
         WHhGcqHHsBq+wDKBYiAA2A0Bjuc8MnIHGnTlS9fsSLWVuzeeu9zjocU0U3TvUr/5q32J
         pclD7Ig5jvZEfctPzBxrwWTYaK1i/O7pZ/zM7vc50bSV9lngCpVSpJr3BEf7ztC5znNd
         0A3A==
X-Gm-Message-State: AOJu0YwbW+WWJhV2/sQEW/LjPZVCm4VN/uZ3PPgI7WdzYy7eEs6HMjM/
	Mi2z8GR+mfx9uZV1nHnRGoAfu+mJw5pq7ARyLpq3YJdntr9AyRo+CMhsLLqaASmC5HhK7D25rrg
	0NDz7kt8OwjWivIQ8kIY6bZFO2Nerk/kenmFeWzM+
X-Gm-Gg: ASbGncv6Gcx94JoKSdAMfgAvDQYX9sDHelguagYy+LosOVVahyUjQe3OciRKBl9DhPB
	sn0SpHebQuSeJA4LUIk96dmugYev2xD+14q+oCOI6na7mAa/oBaCW8Ln9O+BnrAhkwF/VwPUGhx
	YM2wdJk7HVjixib4FdUsZTuyyGPV7t9i73OM1HXPMvMfjsgDuPA97/eWI2On9EyGINvN1fddxA+
	hgMpeLTl4pmowiTLYDMYJysJdR+EZf7Q2M=
X-Google-Smtp-Source: AGHT+IHh/8s5lDW6PrIkGVFJaJJdDZIo4CtrqP31BIJcj1gV4FXK0xxTL1eISgB5E3n7tXhFhgbr2pjeJVV/JUTIXYs=
X-Received: by 2002:ac2:48b0:0:b0:579:bc95:cd25 with SMTP id
 2adb3069b0e04-5856d00983cmr99849e87.5.1758917285153; Fri, 26 Sep 2025
 13:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTYQye1Rtp-sG48Re+_ihD637NDXTG_V_uLkerg=m1Nbtw@mail.gmail.com>
 <CAOdxtTYKrMhjW9JiOCDBia+s=2tob1HF6yfAytYnajYsSoX5Kg@mail.gmail.com> <aNbwuc_Efg-Bj2Yu@slm.duckdns.org>
In-Reply-To: <aNbwuc_Efg-Bj2Yu@slm.duckdns.org>
From: Chenglong Tang <chenglongtang@google.com>
Date: Fri, 26 Sep 2025 13:07:53 -0700
X-Gm-Features: AS18NWCZIXmLqkVpjrQEp5xtsSwnAPUB3hSpbrnmkPOnsnT8YMG5tAtXTkLnx1M
Message-ID: <CAOdxtTYadTmVt7N6SLkQG63Nxxc-a5M=df=4f0qEXwm1LcrNAg@mail.gmail.com>
Subject: Re: [REGRESSION] workqueue/writeback: Severe CPU hang due to kworker
 proliferation during I/O flush and cgroup cleanup
To: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, lakitu-dev@google.com, 
	Jan Kara <jack@suse.cz>, Shedrack Okpara <sokpara@google.com>, "Calvin D'Mello" <cdmello@google.com>, 
	Jeff Schnurr <jeffschnurr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cc'ing GKE folks

On Fri, Sep 26, 2025 at 12:59=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> cc'ing Jan.
>
> On Fri, Sep 26, 2025 at 12:54:29PM -0700, Chenglong Tang wrote:
> > Just did more testing here. Confirmed that the system hang's still
> > there but less frequently(6/40) with the patches
> > http://lkml.kernel.org/r/20250912103522.2935-1-jack@suse.cz appied to
> > v6.17-rc7. In the bad instances, the kworker count climbed to over
> > 600+ and caused the hang over 80+ seconds.
> >
> > So I think the patches didn't fully solve the issue.
>
> I wonder how the number of workers still exploded to 600+. Are there that
> many cgroups being shut down? Does clamping down @max_active resolve the
> problem? There's no reason to have really high concurrency for this.
>
> Thanks.
>
> --
> tejun

