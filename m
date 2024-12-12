Return-Path: <stable+bounces-101441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66E9EEC6B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0750A1661F7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A42153DF;
	Thu, 12 Dec 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGp7/OgQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F902135C1
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017561; cv=none; b=Lt2TcwUQs/T8UgvGZCHels1AG9VUotdBurnHcMWRNf00Oz44mvdKo5gDqmBHUBHpkvHrOMedoFHOxVlpxGGx+naJZTzZDYuOktNDyPVGLkXf84ZR1YxHDFj40UUg421xKxzg6qXdgR6kxZvKMPvKPkIIIvXWUALCvKi6v7V3dW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017561; c=relaxed/simple;
	bh=+g14PTZRgMS3BtzdlQ+ShYpyL9HTatlXBtuj4VcQsUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3Q6Hta5vpBn/UpxNsIEm/jpYzVB1vgsbQcMEzu4ScyObPN/x2fgB26a//UGopVToGF9/ALYKJyOswmM/bsaW3Qk9mteIlXGRsSLNCC1Y9KMSmqZmSYEhry6PdLBjzvlt+JmPjgEIF8NnXh8BdUcvn1X2bJSxV82HFqevKMFHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGp7/OgQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734017558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCMTlTRP/3e0GAeI9i2CqkJ+W5creB5kyxrrSSmkWB4=;
	b=XGp7/OgQIyDmwBZSiQxm776rpwZBvZgN5tvp4ggvqDHqDpv85wEcK3ed4WaQNy8YsaNNPv
	sEatKwmlf1doq0/WIKUHc76FJ1r3pwgIGz1rAOSkOpsZo2QRQmUKGny+hmsXzRRtMgHBDV
	48CXXGmay5aEbJ+IMHIrXi2F2xbo4QQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-E-wYx28HNLubOeHpjqjlgA-1; Thu, 12 Dec 2024 10:32:36 -0500
X-MC-Unique: E-wYx28HNLubOeHpjqjlgA-1
X-Mimecast-MFC-AGG-ID: E-wYx28HNLubOeHpjqjlgA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa69e84128aso60687866b.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 07:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734017555; x=1734622355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCMTlTRP/3e0GAeI9i2CqkJ+W5creB5kyxrrSSmkWB4=;
        b=rr/4lGAHKA7OL4vuG3QaiOW1HXeNr6WYUEPm0gI4fbTcix9+OvkjaxiOgOY2HmK4ue
         A6jZR7c+st1UeJBKvUVWGGRZ2e29sn7ie/E33OOtysLIJisxVRhXakBA+YNtBz6DykGu
         65B1T2tDl/dF8S/oV6XY4KakWUnrHJYkilz2mem+jNvpcfbMs/P0v8Ju4WhJPMKLRX1W
         KToYjzb8sdNM4sscFQFx0E+X9EnqtDWSFx9j9etVp+Es1TORo3/gMeuOwF9VwGbxuAuS
         WvcBmKG5bTfki2QYwOHDjxAPiz+dCzjjEWH/djO9dmQNarnD5kBs6NKYsiMNsME+4/JU
         J94w==
X-Gm-Message-State: AOJu0YzhcnVfOY8ICc0G1dCnUfF9sIezziB5Z2FjdTFzZt2LGTZ2Wr9e
	z3MFXlgfiuPxeMurcQt8FJ8Q29hyivikDycXE4XnMzNXK/wzzD0njuxIBC59lxEtLDU8F76WRr1
	sDOO6P65K/KzrRyR7dx/8ySzP5xYo9hM/qoVOooK5uKKXLpx23NfSYLSJLgJB+kT28emhgnFD/e
	5wyOy6Czl+qhNw+Lvjavg0mJ79TJkK9Cp4fhNXmcmSUw==
X-Gm-Gg: ASbGncvNoOfgngTEXoQ9/NN55Jc9k1r8q5nEDRFeYVOv+eXsUclXOzb6+gWEjxdk7n9
	pLHgzaBFGrP0DwkIV276kowwn5ZtfPZQ7v+igaQ==
X-Received: by 2002:a17:906:b3a8:b0:aa5:451c:ce1f with SMTP id a640c23a62f3a-aa6c1d06db0mr425782166b.59.1734017555272;
        Thu, 12 Dec 2024 07:32:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/gW4BUKjdoJSgHgllfJX4yx8ZmFQWajGB91Lnws5Ps6y+QnVfY7FV+ls9OVtjAQ6zk31wF/rCOoGbI+tFc78=
X-Received: by 2002:a17:906:b3a8:b0:aa5:451c:ce1f with SMTP id
 a640c23a62f3a-aa6c1d06db0mr425767366b.59.1734017553303; Thu, 12 Dec 2024
 07:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210210407.3588978-1-sashal@kernel.org>
In-Reply-To: <20241210210407.3588978-1-sashal@kernel.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 12 Dec 2024 16:32:22 +0100
Message-ID: <CAP4=nvSewMCgCYg1jBbHoUkNOknR5Nc5T+0EZZKRG_2RVUfsDw@mail.gmail.com>
Subject: Re: Patch "rtla/timerlat: Make timerlat_top_cpu->*_count unsigned
 long long" has been added to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 10. 12. 2024 v 22:04 odes=C3=ADlatel Sasha Levin <sashal@kernel.org=
> napsal:
>
> This is a note to let you know that I've just added the patch titled
>
>     rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rtla-timerlat-make-timerlat_top_cpu-_count-unsigned-.patch
> and it can be found in the queue-6.6 subdirectory.
>

Could you also add "rtla/timerlat: Make timerlat_hist_cpu->*_count
unsigned long long", too (76b3102148135945b013797fac9b20), just like
we already have in-queue for 6.12? It makes no sense to do one fix but
not the other (clearly autosel AI won't take over the world yet).

> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 0b8030ad5be8c39c4ad0f27fa740b3140a31023b
> Author: Tomas Glozar <tglozar@redhat.com>
> Date:   Fri Oct 11 14:10:14 2024 +0200
>
>     rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
>
>     [ Upstream commit 4eba4723c5254ba8251ecb7094a5078d5c300646 ]
>
>     Most fields of struct timerlat_top_cpu are unsigned long long, but th=
e
>     fields {irq,thread,user}_count are int (32-bit signed).
>
>     This leads to overflow when tracing on a large number of CPUs for a l=
ong
>     enough time:
>     $ rtla timerlat top -a20 -c 1-127 -d 12h
>     ...
>       0 12:00:00   |          IRQ Timer Latency (us)        |         Thr=
ead Timer Latency (us)
>     CPU COUNT      |      cur       min       avg       max |      cur   =
    min       avg       max
>      1 #43200096  |        0         0         1         2 |        3    =
     2         6        12
>     ...
>     127 #43200096  |        0         0         1         2 |        3   =
      2         5        11
>     ALL #119144 e4 |                  0         5         4 |            =
      2        28        16
>
>     The average latency should be 0-1 for IRQ and 5-6 for thread, but is
>     reported as 5 and 28, about 4 to 5 times more, due to the count
>     overflowing when summed over all CPUs: 43200096 * 127 =3D 5486412192,
>     however, 1191444898 (=3D 5486412192 mod MAX_INT) is reported instead,=
 as
>     seen on the last line of the output, and the averages are thus ~4.6
>     times higher than they should be (5486412192 / 1191444898 =3D ~4.6).
>
>     Fix the issue by changing {irq,thread,user}_count fields to unsigned
>     long long, similarly to other fields in struct timerlat_top_cpu and t=
o
>     the count variable in timerlat_top_print_sum.
>
>     Link: https://lore.kernel.org/20241011121015.2868751-1-tglozar@redhat=
.com
>     Reported-by: Attila Fazekas <afazekas@redhat.com>
>     Signed-off-by: Tomas Glozar <tglozar@redhat.com>
>     Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/s=
rc/timerlat_top.c
> index a84f43857de14..0915092057f85 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -49,9 +49,9 @@ struct timerlat_top_params {
>  };
>
>  struct timerlat_top_cpu {
> -       int                     irq_count;
> -       int                     thread_count;
> -       int                     user_count;
> +       unsigned long long      irq_count;
> +       unsigned long long      thread_count;
> +       unsigned long long      user_count;
>
>         unsigned long long      cur_irq;
>         unsigned long long      min_irq;
> @@ -237,7 +237,7 @@ static void timerlat_top_print(struct osnoise_tool *t=
op, int cpu)
>         /*
>          * Unless trace is being lost, IRQ counter is always the max.
>          */
> -       trace_seq_printf(s, "%3d #%-9d |", cpu, cpu_data->irq_count);
> +       trace_seq_printf(s, "%3d #%-9llu |", cpu, cpu_data->irq_count);
>
>         if (!cpu_data->irq_count) {
>                 trace_seq_printf(s, "%s %s %s %s |", no_value, no_value, =
no_value, no_value);
>

Thanks,
Tomas


