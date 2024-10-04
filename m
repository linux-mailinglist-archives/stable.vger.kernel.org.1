Return-Path: <stable+bounces-80729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE3990120
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA06C282085
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F49156F4C;
	Fri,  4 Oct 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Gwkobuia"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886A156F30
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037530; cv=none; b=H/K7V9PtMpLIOOeiGmvIfJynAZ1uF9wtZtnSuBGkYy7eyOEtvexGqTizVhqwn552Hj3pXfQr30AuZnDqwXDFZiig+W2CI7r90UKTQiLh8DzDVrP2DL0C4Mq2UUERrvUKwcuXSzvwKOG82ON0N6Nb6q2D3SNDWpyYR6Pkw9W+SC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037530; c=relaxed/simple;
	bh=IgqML/A0RI8EV0Mka9xfk/zX4S8CY878POOjVe4o6IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoGeTnWtgYc8CYqszk+j8inGN0JZfEg/gCqw19nHRpA2QsZA5Bg0wIiURtrLL1YpRQ1LUSFjjJainyRkpa9J6FdCvD+uMM0zQsInRLt1JC7AMHVGNYacy0NtcmnFv4aBGTYb3EchIXp4OsOV070tcKBve0OZZbqo6JLE6rXtMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Gwkobuia; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo1235447a12.1
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728037528; x=1728642328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtzZwDcCBRIJWjG1SeILMCRqnIAOjaXwt0dR2Z/fZRk=;
        b=GwkobuiaHhhmofWljIeGUiMWNCZlFqZhtquwRcQHBHxoyPBZQtVagU9MIHLGX/euQA
         sm+/3m2PSQ/DEaRi6F0OFuMsfsjtga9W1uHlsTqVcVJB15OYoBJClCBQCGs+Y5WFnOY6
         Z2NsW3a7Nz1GJEr8QfZKGs0hRZtJn5I6VBfsXlSPdFMgIZw6AFvR2826y7L1SE/Enxx1
         Hl36ZjZata69dXdg5diReAsZlWRV5m/a0XaSNPDtPDuK6w7SmGuB8ZVzo6r0QRkVGMJ8
         8ykNkO0/9uvyJua2eV4uhjp2ISbAK59x/0LXhfNHIAY2SDcO0seXmbRBWJ7kF2A2Mxu9
         D7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037528; x=1728642328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtzZwDcCBRIJWjG1SeILMCRqnIAOjaXwt0dR2Z/fZRk=;
        b=A73w+aR7keN96vGgvX9P65U4n04X+FHWWSFxLJQoLd2qz4Nnzef/tALWCafZIcJUeU
         JrcMiOeJXKelCotMFnUFeyVwpfp5xiMtl524TbpHp0X/pcSOAcDYFrwWLlpS7Grk3fiA
         1nO4LMfXjDFYwDlMt0WhQrq8viBLjVn8JBqsRPFd0nD5ag+2wc3LNDaw7OFcD/AAlZ9l
         TuIeRbwFjTObIINi9SfFpdVSxcdHddxhBrcnb+7QJXSKBVU7rPj0GW4UUiIuqWgn5RrB
         e1hsCFA8xrRRyCqab1xB5ShF05pBgM6sjLeFAerB3usUu3TVjA1Kg8QBKY+A4+lT5K14
         PFjw==
X-Forwarded-Encrypted: i=1; AJvYcCUfYUAk8OgDf0tPw4ECC1QG2awRrXLYPydgj6KSXJdjug0p26KJDeA63WXmDu1TQUsvoopaIM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYr/2LwfzucGmQ86uYcAC2YPw0Hg7C09/DxtLAUd00hLJo5CLH
	2cL9U4PTf+p2CVvMKIiObmIImbSc/UeENx9I3xjusHPOme/iUy5Wplk1+2L/rA0sIuewPZPNLeX
	mc2PbqDhO+ii9ZHQj2aKqus5Wb8nKhLYoUb6kzQ==
X-Google-Smtp-Source: AGHT+IFQmp/uoREOZGCDkiFRh/G647ifTQRZp8Ru0lVVF+cqOU1Q+I3rZsb+Yb41N45SjjCiX7atyhctfo6wH9YIlmw=
X-Received: by 2002:a05:6a20:1e45:b0:1d6:e22e:1571 with SMTP id
 adf61e73a8af0-1d6e22e15d7mr1225656637.1.1728037527803; Fri, 04 Oct 2024
 03:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003170151.69445-1-ignat@cloudflare.com> <20241003215038.11611-1-kuniyu@amazon.com>
 <CANn89iKtKOx47OW90f-uUWcuF-kcEZ-WBvuPszc5eoU-aC6Z0w@mail.gmail.com>
 <CALrw=nEV5KXwU6yyPgHBouF1pDxXBVZA0hMEGY3S6bOE_5U_dg@mail.gmail.com> <CANn89i+BNfpKY_qCRLFyGSgtzNeVGuPKudw2nWTF7=r0+P9jUg@mail.gmail.com>
In-Reply-To: <CANn89i+BNfpKY_qCRLFyGSgtzNeVGuPKudw2nWTF7=r0+P9jUg@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Fri, 4 Oct 2024 11:25:15 +0100
Message-ID: <CALrw=nEZ=0bP7FPqmT9-cE_ZeT9Wz4-19xrFfE=6BK4nSHuUeg@mail.gmail.com>
Subject: Re: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alibuda@linux.alibaba.com, davem@davemloft.net, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 11:19=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Oct 4, 2024 at 12:05=E2=80=AFPM Ignat Korchagin <ignat@cloudflare=
.com> wrote:
> >
> > On Fri, Oct 4, 2024 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Thu, Oct 3, 2024 at 11:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@ama=
zon.com> wrote:
> > > >
> > > > From: Ignat Korchagin <ignat@cloudflare.com>
> > > > Date: Thu,  3 Oct 2024 18:01:51 +0100
> > > > > We have recently noticed the exact same KASAN splat as in commit
> > > > > 6cd4a78d962b ("net: do not leave a dangling sk pointer, when sock=
et
> > > > > creation fails"). The problem is that commit did not fully addres=
s the
> > > > > problem, as some pf->create implementations do not use sk_common_=
release
> > > > > in their error paths.
> > > > >
> > > > > For example, we can use the same reproducer as in the above commi=
t, but
> > > > > changing ping to arping. arping uses AF_PACKET socket and if pack=
et_create
> > > > > fails, it will just sk_free the allocated sk object.
> > > > >
> > > > > While we could chase all the pf->create implementations and make =
sure they
> > > > > NULL the freed sk object on error from the socket, we can't guara=
ntee
> > > > > future protocols will not make the same mistake.
> > > > >
> > > > > So it is easier to just explicitly NULL the sk pointer upon retur=
n from
> > > > > pf->create in __sock_create. We do know that pf->create always re=
leases the
> > > > > allocated sk object on error, so if the pointer is not NULL, it i=
s
> > > > > definitely dangling.
> > > >
> > > > Sounds good to me.
> > > >
> > > > Let's remove the change by 6cd4a78d962b that should be unnecessary
> > > > with this patch.
> > > >
> > >
> > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > >
> > > Even if not strictly needed we also could fix af_packet to avoid a
> > > dangling pointer.
> >
> > af_packet was just one example - I reviewed every pf->create function
> > and there are others. It would not be fair to fix this, but not the
> > others, right?
>
> I have not said your patch was not correct, I gave a +2 on it.
>
> In general, leaving pointers to a freed piece of memory (and possibly reu=
sed)
> can confuse things like kmemleak.

That's a good point actually.

> I have not said _you_ had to review all pf->create() functions.

Ah, NP. I reviewed them before your comment, before submitting the
patch - basically to decide whether I should go with the current
approach or just go and fix them.

