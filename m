Return-Path: <stable+bounces-3155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DB7FD8F5
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D5282DDF
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D54225DE;
	Wed, 29 Nov 2023 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHRR0UUc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E6AF
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 06:08:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-33319741ba0so428102f8f.1
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 06:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701266906; x=1701871706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opy02tZrBJGXUhxgamyTNZots4pCFp3IvdIOLkf9vzk=;
        b=WHRR0UUcUv0n58mi0IcE9eQ152l6rncI2KIAd/RWVpYvU8EoTA8vpku8t9A5lXrxNC
         Jo4lhRxLwA2gFG+qA8lcbsPj128BKEnT7TwdHvfDS3wI2vpwfgiqOnejr8gEr0hJnuZI
         zC5bPPa5RQumC2xWPfs19OyIrWJ/zEDAj1FPif45WH+hPWiUnvCLMz/CmS73TKKM4Xl5
         i5+CodJlIyOfwXRKfH1PwFtg9Hiu13p5RFOnOK2WDYq9J3j28UdNBi4RXyGM0QqCg5L+
         RpBtMZUkcG3tcRqQ5oIe9sB8IjAcsHWh+e144CyjjLJmDjRZBqBTDzvlLIj9msLaAK3a
         PR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266906; x=1701871706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Opy02tZrBJGXUhxgamyTNZots4pCFp3IvdIOLkf9vzk=;
        b=LQBgr9hwjRlKgJJ2Ri1Oof+lYHyIHZ6FwihOlAKuYlt3Rvpd3BiU9+VKYKFZBJeY43
         Pwt0KxIRmInDVRM/Ne5dCwmjTMKUovF67y7FURB9z+X7W3dixFje7yFPHkJX++bG8u+h
         BrwbM5NQBnPIe6Jb21IlMARRKV7XugY3YJNdOnVBRRi8Q5katDsKPn2zTwB8DDfcK+2J
         iwpbw3AHAxmJyjCFxUxpnuDyX4zZuctHccLS1PqKrWPBmrnVKhqYEXL7DDoexjsm76Xg
         YYHtVXE8+iS8nTaqnLMtMcjKsLloPK9XeK6FdWtWXUNsblZ3QNs0XhhUtDQf0fZ52v7v
         qjVg==
X-Gm-Message-State: AOJu0YyPtTCmq5N+VW5S6xuPGoJx7hp7Jtia8xyMLfG+v0diJ/o8xx/F
	37JclHgCK0Dm6am3552gWYPCYsq4b8Os9+p6EsRNSFuQkpg=
X-Google-Smtp-Source: AGHT+IFjpDODj3tox0Pdt0YL/Ignxx1mdcIG2/YXNYCFctWTknVTsverAPsmFHkXHv3wTqHudo/YIHeouIk7Hp4ve7A=
X-Received: by 2002:a5d:58c9:0:b0:333:eeb:e5fd with SMTP id
 o9-20020a5d58c9000000b003330eebe5fdmr3843208wrf.3.1701266906415; Wed, 29 Nov
 2023 06:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALk6Uxo5ymxu_P_7=LnLZwTgjYbrdE7gzwyeQVxeR431SPuxyw@mail.gmail.com>
 <2023112431-matching-imperfect-1b76@gregkh>
In-Reply-To: <2023112431-matching-imperfect-1b76@gregkh>
From: Ronald Monthero <debug.penguin32@gmail.com>
Date: Thu, 30 Nov 2023 00:08:15 +1000
Message-ID: <CALk6UxqZtm_MR9cYyN2UvTF_7xPH0D-zQ_uUjZKjNGfU-JOX-A@mail.gmail.com>
Subject: Re: Backport submission - rcu: Avoid tracing a few functions executed
 in stop machine
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:10=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Nov 21, 2023 at 12:09:38AM +1000, Ronald Monthero wrote:
> > Dear stable maintainers,
> > I like to indicate the oops encountered and request the below patch to
> > be backported to v 5.15. The fix is important to avoid recurring oops
> > in context of rcu detected stalls.
> >
> > subject: rcu: Avoid tracing a few functions executed in stop machine
> > commit  48f8070f5dd8
> > Target kernel version   v 5.15
> > Reason for Application: To avoid oops due to rcu_prempt detect stalls
> > on cpus/tasks
> >
> > Environment and oops context: Issue was observed in my environment on
> > 5.15.193 kernel (arm platform). The patch is helpful to avoid the
> > below oops indicated in [1] and [2]
>
> As the patch does not apply cleanly, we need a working and tested
> backport so we know to apply the correct version.
>
> Can you please provide that as you've obviously already done this?

Hi Greg,
Sorry I notice my typo error 193 instead of 93. I have tested on the
5.15.93-rt58  kernel.

BR,
Ronald

