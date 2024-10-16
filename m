Return-Path: <stable+bounces-86474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11339A0738
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16A81C223A3
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2466206970;
	Wed, 16 Oct 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xiuc74sn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7C20695C;
	Wed, 16 Oct 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074206; cv=none; b=WcP/oA+p2d7/dS6xpxx1QELPfgUTGZVAaBybEUPZfSc3anCDGSv1NOpYSN+pCXjrp3eS1DEwXIvFvz8QgUbdrd8wWsb21ruRK8ZEps1HkR6QrVRysbhNDzsrIzKTAa1BKZ2KdYFri4QbnQzBU3Z1g/PfI0aNjIVZyzK0+K3SS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074206; c=relaxed/simple;
	bh=q/4Xnfo2QoXLnMrsQKtONWcJi0JMSdcZjjDyjdhf5aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIFWgZirZLs7hGNsXB4Ltvh55Z8K/96wnXG8Y6qSFhrwGS+0HWoNM9k6Kbh0bU/jX5CNN5YDLhx1VbdgxvQgdU/skMwXpVb/xVbi/lBAQYkf/lKmR47BJ/6dT4zs0FJs+MBF9IEqQGpSX4SQFdL1+9LB39ftsUyIAsfzrk6Qf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xiuc74sn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e1543ab8so7973097e87.2;
        Wed, 16 Oct 2024 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729074203; x=1729679003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/4Xnfo2QoXLnMrsQKtONWcJi0JMSdcZjjDyjdhf5aQ=;
        b=Xiuc74snO0c3vlAdKJIF5lswKqCH/Z8NrsqFGOwA+/iPxQTM63te+fuOE/pHJ/Z5lO
         mbpPAt4D3zellMOGOsEEB7xfdZT+XIq6DZgYZKJON1MXrtaTDNwMRXWlWXABS0MeMKO2
         gQxKd2Hcv294mTUff3JQK2F0kesD0UvzQyth7lyCohrz3qHcFBwseYfabbWZ7jDJ59r6
         7Ocn435wNP5HpfKyS0x8zAvpgqYFqOPtbu2HGHha6fZ1Wfh4WNJEwQJt7Ifu4wQ7Je92
         JKcNrqkYwB3s6QkWfYbIur92zqjKVJMCqyaFp1kxmQu7OGK7mm3g+RjFAB41fp1M5yjT
         gC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074203; x=1729679003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/4Xnfo2QoXLnMrsQKtONWcJi0JMSdcZjjDyjdhf5aQ=;
        b=w0vW3K0A11OVCITp73paCicsbiFRShmWDvDEcdJrQHJY/fA7/2HJkm3rw3iY72FSW3
         sFX/4TASg0cMZHihEbQTOSkBMsn39/k3v1peUJYQPruf0Ak3WLrnrRipGbwsgQpyxTq9
         KGo84THduHBiHSGzCp4lx1cCs69TgrzFztqisCvGtyEbyeIc2Lv3zs0n/q7bup8vkcHO
         NHpm0fkblQCP4dcWd2WfiEPsRq6N+ao78cHcDv4O0bfgkBO/GaHJ49XPbLBAm+A4HC49
         R3FNwspjphsg4zoGEo/4CJlrx3P65FNtF5chAJy4+C2jAi6TVg1/xNjTRRzznMqEiKpL
         rg9w==
X-Forwarded-Encrypted: i=1; AJvYcCUTehgTrfTAQmd3gB8cMpZDkljIyzBOG4R1f3d+rrToEn6PGz/i8trTQD6ns2X0LurmsXLIV0Jh@vger.kernel.org, AJvYcCXFSpJUd+3upIiU6rlnknJAHPyv2KyWfnV8QLFYeZzy9jxTv0wLIpSiMebW0puj8ZH0DKQ/WK7RMzsmaYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJT2QqDXFER9Abh3taWW50Jms7ph7cSm1Hvb4D35aEXYtS3KV
	YznkhFvi0Wi2pcNvQsLkSS9Aq2iyGXC+yUoJ85tGnC6hiuxQ5adzi/IRZlptPGSlEKGnTdm98Xn
	Ge3wqgiN8gWqzO3Zk6RjhD8WdHU4=
X-Google-Smtp-Source: AGHT+IHecL3xyZYXLTNm5iA6rs/KvXKjLMOFmfwx3AdAWDJHF6WIEmSzNsGABI2L/R0hEVHbIIgQ2Q6LGf7wWO/MM7E=
X-Received: by 2002:a05:6512:10d1:b0:536:a695:9414 with SMTP id
 2adb3069b0e04-539e54d7907mr9596702e87.6.1729074202511; Wed, 16 Oct 2024
 03:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016072553.8891-2-pstanner@redhat.com> <Zw-CqayFcWzOwci_@smile.fi.intel.com>
 <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
In-Reply-To: <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Oct 2024 13:22:44 +0300
Message-ID: <CAHp75VcO5g1UerroLaiUa4n7Aj8TPQ594tPGdG-T-xkh4uqyCA@mail.gmail.com>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 12:22=E2=80=AFPM Philipp Stanner <pstanner@redhat.c=
om> wrote:
> On Wed, 2024-10-16 at 12:08 +0300, Andy Shevchenko wrote:
> > On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:

...

> > > ---
> >
> > I haven't found the reason for resending. Can you elaborate here?
>
> Impatience ;p
>
> This is not a v2.

It doesn't matter, the reviewers and maintainers should get a clue
which version is to be used (even if it's a simple resend) and why it
has been sent.

> I mean, it's a bug, easy to fix and merge [and it's blocking my other
> PCI work, *cough*]. Should contributors wait longer than 8 days until
> resending in your opinion?

Usually we may ping for that. And yeah, depending on the maintainers
it takes a while to get it to the point. In some (quite rare I
believe) cases we may escalate up to Linus about this. I probably has
only one case like that in my full period of working on the Linux
kernel project (several years).

--=20
With Best Regards,
Andy Shevchenko

