Return-Path: <stable+bounces-172235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232AB308E7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 00:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5291892F4D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 22:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ACE2EA734;
	Thu, 21 Aug 2025 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMqeI6ve"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393BF2EA165
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813932; cv=none; b=KXHSs2vLn5q79U9vEQ03Sc/f/1ODAhqReVm9ZCy1+O+qkoj7deDnPrIpuR4qL64LhbRVWcbo+F/0DDsH+xo+C6FYgeYteN8YM6IvZtI4Pn1Ia9kBD8PRZBK+G9Rkp6U6KN+JkCBnlSFcYbnGgeVNp8aueLvCjpJ5eW6tTW0uXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813932; c=relaxed/simple;
	bh=P5+PojnbPQTrtRF9Wl9yX8jlXFvLA4BAuQTi+TBvbvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsLFQBxnsnKxEf5vDSMLEWIBsWBs0Y5fUEkFYKmxEbnjeuRYu7kShV6DXCaepvYfKzG1AuocLqzkzdT+cIVhlDXLghHP1gGagXX5s2cgp29dSK1pb0XBGepXU+N0QZfodJbh4y40KNYf8vyCY8yIL3nvvPIme0+uozApuKt5isU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMqeI6ve; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3364e92c1f4so3386781fa.1
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755813929; x=1756418729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEoIGgjzTubRPR28lvO2YuhgPwi8mIAHDjAhzXLrRpI=;
        b=KMqeI6veBBSeUt4WTF5AZfXmnBmmrDjnwl5GCE59G0pkt5+n/zrhBawyq0siA3DvHT
         CWjqFuCO9vBE/fX8KxI/3a6G9Kbsj6FYOdl+M+fYEU/7aChAg2F7vyt2MqGbW5RxrALd
         +N3AjXJ0VjkNjRVIW4r2FCACSWqHouSxdf6h43B8oh0KkzpWgbwxDgYo68/iGHEHsIfz
         X58cSUCEYUV8nGufqf+DaSlrQGu8scZCDgbw4k8jfQbHvjA4FUkObex0nPtBU/HtJek3
         YBFS2a3dxwYzqeHQnGeY01UqwLGN2/e0QjEcNk1/OwzfztAN3PkeJFk6rhCpg/0KVwaY
         NRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755813929; x=1756418729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEoIGgjzTubRPR28lvO2YuhgPwi8mIAHDjAhzXLrRpI=;
        b=UIcBsN2Q2HUc2nGSn+0GhwLk4dTwno5I1imySf5gh+l8aDsnc+2R8eowPClvt0i2L1
         Q3CRFLZ1ndgmoSi9dWnW5ora7S0t2BbSRQrLRPuMAcB+x8B2cry4SMxVxhpZs6Atg5XO
         ZZQFF9AibAIJ/OTS5jlyT1gHpE4eymxB+WMfSD+Nre3dNSQJbOFa7j8WVk7ytG11el1y
         SYGvJcbmGdoIwSaQx+HWWnmx+Lbp13+PKZgH6J5nBF51KRDhShHHyAf2E5Y9+vDWY91k
         hHAo7DM5I+00q8Hi9MNQ5WzZHhXF5A0Yjtf6XNlo7J9sBV0UUEwouFwdfS8KoDYW+f+X
         0XwA==
X-Forwarded-Encrypted: i=1; AJvYcCU+TBsDAc98lMUINL9cXAs2qee/Qy5fJ5hDctACLjn5mz6S+rS5OS1EQNpuVkpH12OT+Tx3oRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyaS8WRao/4I3uAGwSJRyWQgIcfL+jbl8uo6Ji8t8bYy1rbY10
	LurDRkTxT+6eICA42E3dvofMJTzOC0vC7w6Z/Xza6cvJFLMUSpUVjLgtKrpXROmTF90J4SF5NFQ
	QqS8bOlco3UJXUKPYql7Kw4KIustn5xNvHvWhZzw=
X-Gm-Gg: ASbGncsise7uUXG5aSxWPGHKoS3sg4mBGS/CjZt8s0KROlgr19h2gQS2KTzPW+OsFcB
	+uyKqEV0FPED5MKlhezJVCSBa6NP+3T35fkjfevlZA2lJKqnH1DINFeliG5+5ZGjjj5l3xcPWr6
	dllmYPNhXxLt3GB3I07ybK3fvHURxYm8Dxi/jBaE1dUz+HkIVLpIKEMiIo8RB0Op1YGhs0U1kAV
	+k/eIz1TGYYB0OsJ4GWdXnIF6awJOJx3N2tasYPmpw=
X-Google-Smtp-Source: AGHT+IEAgnsRZZTBeBDPDig80smarcOxEH06giqqNuoKXrA13XjQ7OiwRrBiWUUoigKNiHoqJl/qovcWZd5Rdn8lJJs=
X-Received: by 2002:a2e:b524:0:b0:335:4125:1e2c with SMTP id
 38308e7fff4ca-33650fde1ccmr1426251fa.38.1755813929028; Thu, 21 Aug 2025
 15:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCr3E3nUjwYqFq1aC9P-EkX6iPs-X857wwN+a_QK9q7u4g@mail.gmail.com>
 <20250821210208.1724231-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250821210208.1724231-1-sumanth.gavini@yahoo.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Aug 2025 15:05:16 -0700
X-Gm-Features: Ac12FXzzr54zcQyksnxtUQGLgWxtveKK_3R-oS6cSdkpVMWWdDoG4arzM3gPIiI
Message-ID: <CANDhNCoao7P8RWbugxY70K-+HRPSy=NypgNXM3DjheHRmznmjw@mail.gmail.com>
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: boqun.feng@gmail.com, clingutla@codeaurora.org, elavila@google.com, 
	gregkh@linuxfoundation.org, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@kernel.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, sashal@kernel.org, 
	stable@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:02=E2=80=AFPM Sumanth Gavini <sumanth.gavini@yaho=
o.com> wrote:
> >>
> >> Just following up on my patch submitted with subject "Subject: [PATCH =
6.1] softirq: Add trace points for tasklet entry/exit".
> >>
> >> Original message: https://lore.kernel.org/all/20250812161755.609600-1-=
sumanth.gavini@yahoo.com/
> >>
> >> Would you have any feedback on this change? I'd be happy to address an=
y comments or concerns.
> >>
> >> This patch fixes this three bugs
> >> 1. https://syzkaller.appspot.com/bug?extid=3D5284a86a0b0a31ab266a
> >> 2. https://syzkaller.appspot.com/bug?extid=3D296695c8ae3c7da3d511
> >> 3. https://syzkaller.appspot.com/bug?extid=3D97f2ac670e5e7a3b48e4
>
> > How does a patch adding a tracepoint fix the bugs highlighted here?
> > It seems maybe it would help in debugging those issues, but I'm not
> > sure I see how it would fix them.
>
> This patch is related to linux 6.1/backports, the backports(https://syzka=
ller.appspot.com/linux-6.1/backports)
> I see this patch would fix these bugs. Let me know if my understand is wr=
ong.

But that doesn't explain why or how it fixes the bugs.  I'm not
opposed to stable taking this, but the reasoning should be clear, if
that is the motivation for including this change.
I fret there is something incidental in this patch that avoids the
problem, and that those issues may need a deeper fix rather then to
hide them with this change.

thanks
-john

