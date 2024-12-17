Return-Path: <stable+bounces-105038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050019F55F4
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B1F162A68
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA81F9A97;
	Tue, 17 Dec 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gwZpeegf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0491F9A8C
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459606; cv=none; b=Hbp4Rsyu3aUqWSyPXNQL5hV4bOU94Q4s0QHHqP0yKB+c4T4PPE6glP+cB5ULaDe0Gn5suDmJaMvvTwqJjiSxiVFhEWkJq+dZOwKvr+/HU56eJPkMiYZuUT0bFu/75T5WGOiTaShUPj8LS21taIjOryju78DUuCywV0xhpzO1Wf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459606; c=relaxed/simple;
	bh=l2yRZ36y2wW9dvgVix4csSbmNDAJNiwmbO6uhLXvPm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qz1/iRMMK3hy4AJPu+AW9dqMTI1FhXq9CiYCoFvJGBYE1vNJ46bu0EYwfQvouukWiZej/SDb9wDLJ5JZqzaldPBRsA3y62Bbct+y4GCE5ziZ0HzljKnnDNJd9fBVGmyNSKf93VdTDHqzb50pc4n14Xd7lCQgHMSnq38lwKhiCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gwZpeegf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so12063151a12.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734459603; x=1735064403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucYQz3pug45wlWkI5/rqDm7d8VUZXMh7k+KyEWxY/qg=;
        b=gwZpeegftA6CLxCNKk6lELmJnEBdX7H0jBk3hTlM/xKpnJoPjRh8yXN8EJVfSkoTJe
         XEYSi5lpQATtNFixduQzjm0OEYIoi/uL6+yyoian5p1se7HwSMNKhXLUSs8b7yGx3d/l
         m2Ol7orgx6b3jqjdJ6mTRoniwGd03rCPRthMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459603; x=1735064403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucYQz3pug45wlWkI5/rqDm7d8VUZXMh7k+KyEWxY/qg=;
        b=MEd02+qckabHmaRsiy1FbBq0vSDQxEbEK3a30khlzzoGx1bBTRMbwF9fIGLJiCMUMF
         EbseySKIVHgMV6MEwlGEbuD8vBKWbvrgIikLsvvqd4vJC2e+9HqYLDaTewhe57tdntUL
         jJbJdoIcUJFKFcgCVeatXdCmTZ8RBiy8fDHY8mHljUMOmBnc8eUytFm8AzWvJGOSCHF4
         9PoE+jd1Nc8aUnnlbNMCrrdUqVJLj9cDBbnV+T13+KglzbyiQ5zVB9Kf5rreTO7BGCiV
         xmLijYkjqoKFT10qPzKvmoMQnvbMT5e2vvCFV7AgUOJrJgLYFNLe1hoq0HpbiqNCokJa
         nUWw==
X-Forwarded-Encrypted: i=1; AJvYcCUisR4aHzX4IZtqCeyS7q0cvGWxRUTK8f6yu/DQL17mce846vWkSoUmUUzK3B1fzOW2t8Gv+iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKZPg0lNJ/Zwqw0S0+9ti7mzCZELLufvlGZOsS1JD4e+DziGD
	iwofx4JDsh9ZnPZC8W4pQucgrzsI03klofD5iyX6pw2xT7yWSgwljSZYWIzmH4GHWxo4d6aPiWu
	FI4U=
X-Gm-Gg: ASbGncvj+k/H5xp29YiLMqVTTj/UAgET3Z0zfGtWuzPZdUfDoYv7Z9GP+g9Rhi2VGex
	+y5Git2OGNHSv8rb2lEu5oku0UvzqJfM6O2Xw1dMiGwD+qqqyy4ORfYaPfpxlbzAnfmPVR5W8Pu
	elwF3GNzBT31r/ibBPBb4GlpL925a5BdN1sRyDVwqQMcPFiexrnzuWcLY05ZxYO/8tV8zGogpOX
	D0PLjTxukjLTQYtw1gTBNjeE8lN2hPFO8+X7GoF2PktGbsFSgeNFTS4ybayWDDC2ZAGV9hdHNuR
	YOlGuPTPjR7kMCI9aTqZzHNUlrXAwBI=
X-Google-Smtp-Source: AGHT+IF3wLxZaNv+CsH65XEoElfUGS9KjvDTahLPh4qRRaKWFfemLukzXMdQiiiuQ7BBHaNo8623yA==
X-Received: by 2002:a17:907:76f1:b0:aa6:a9fe:46de with SMTP id a640c23a62f3a-aabdc8f7b5dmr329594166b.19.1734459602839;
        Tue, 17 Dec 2024 10:20:02 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963cdfa5sm470390366b.199.2024.12.17.10.20.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:20:02 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa662795ca3so1271569466b.1
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 10:20:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUce5u74vDSh9MqJYkz5w0xLgXvX5BN6EzBGbC9wOq3Cb5K0TX/bFktoEVz57QHl+MvesJNpBg=@vger.kernel.org
X-Received: by 2002:a17:907:d1c:b0:aa6:7ff9:d248 with SMTP id
 a640c23a62f3a-aabdc88c2bcmr443639066b.8.1734459601680; Tue, 17 Dec 2024
 10:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com> <20241217130454.5bb593e8@gandalf.local.home>
In-Reply-To: <20241217130454.5bb593e8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:19:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
Message-ID: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm not sure what you mean. If the kernels are the same, then the pointers
> should also be the same, as KASLR just shifts them. This no longer uses
> module code. It only traces core kernel code which should always have the
> same offsets.

 (a) the shifting is what caused problems with you having to hack
round the format string and %pS.

 (b) the data addresses are more than shifted, so that "data_delta" is
*completely* bogus

 (c) neither of them are AT ALL valid for modules regardless

Stop using the delta fields. They are broken. Even for the same
kernel. It's literally a "I made sh*t up and it sometimes works"
situation.

That "sometimes works" is not how we do kernel development. Stop it.

What *woiuld* have been an acceptable model is to actually modify the
boot-time buffers in place, using actual real heuristics that look at
whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
of the previous boot.

But you never did that. All this delta code has always been complete
and utter garbage, and complete hacks.

Remove it.

Then, if at some point you can do it *right* (see above), maybe you
can try to re-introduce it. But the current delta code is pure and
utter garbage and needs to die. No more of this "hacking shit up to
make it sometimes work".

             Linus

