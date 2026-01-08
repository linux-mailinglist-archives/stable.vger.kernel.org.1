Return-Path: <stable+bounces-206308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59572D04045
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 941F73081816
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759313A35DA;
	Thu,  8 Jan 2026 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYI109jR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20E3A961F
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868348; cv=none; b=C/V8GhyE9IkqplNcIeHbqp6XHglKOMo6EJdivYMeeRPa/gle0N1q23T+zoKGxAV+6joHNwOll+inhZjJn9jcJbLtAY569d2O2CuYIBN+OU7nqiOzxKX8kn0XkjHHMGcw68291fNMNRL1HtpKADsG07DKA/OxJg8Xf8cIhU5yhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868348; c=relaxed/simple;
	bh=R2K+i1sRQKmSf8yyiZ0axORAp9DYHsv+qjGYYzdkAi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6HW9UaRGBx3hd5rSyF64IMoLkDFUvxaGZZk7Pe8u06ETlEIc/ew6OcnobCvA3W5dGuXqAXYZP+243cesL7FL9eHjxu3TJnjnzrMv2Re7JbMOJGhGc+foOuP9TohTff1RkkJw+I43+QJzDRwaFLnAsn2XUCyZull/3//cI/0n0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYI109jR; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so29640621cf.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767868337; x=1768473137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok3n6452CCn2akqoUJ4qnpNLPbUKwpWUXAR9kiMAF0c=;
        b=WYI109jRM4F/eCVbKIWmEp7Ozmw8Qmb+0LULE++Sn16pPCOjjoE3k+59AXapKEsYiZ
         2wPf4Mlaipiodl3TjRwi8Ti+Etwooye5O6Yq0VucV1mZw9QLpJUbcQKVV/gEflWSv71U
         9aKEVt0N4jf1tRfcMjQjY4tnVj5PYzrx3vh+hIr9K3kqRqvJDjjBru8T0GgffVtEFmvx
         hPFOcxT4m4DnYD66aqP+mIZaiFjH8HVF0684vvFuZU9iWgjkc9FzuUUi5XQT165yKu4G
         KJ//tuwWIGV4hp4AMeiit73tXFIxfHZ82m4XgYYclPdetGuXbSsylP+zmo1dQ5kF4Aik
         bpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868337; x=1768473137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok3n6452CCn2akqoUJ4qnpNLPbUKwpWUXAR9kiMAF0c=;
        b=CiR8J/rpAGNu2fr1axV1ll7NzBRc92BgXBAURMyyZMEq8T63VPJeB+lysNgg9XZNdO
         so8QT/9VFXHl0jnT+pm9hwujfIx6OtmG1OXT8NS/Sr1h2q25i932bX/JZonTOu/L6z+x
         zveanuiOzhk6moyiUulp4mOwMQgzLDB9b7DtlFTTNt3MP1QnawP0DStuQed8Iq0tuPwA
         iUvardXvEaVGmdZpnNnstRBbcRecbcUW//vZQDR7Sy9Lv4HRyjVkYl6cpFy75+F3+Klz
         JDoR826YqkLnBt+dOGygjM5075xcQtRfucaa7XAjIVHNqrG0hKI6FOyMYk61YUkF+c/C
         fsdA==
X-Forwarded-Encrypted: i=1; AJvYcCXfLsQVu3pnMuXSGnc6mj6G7PclJnsRz5ay06hOzC4hwoOd/lI0+0TTKLcG6nzPzK7a6RKQauI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0N0eH+qj/BWt/R0gO62sFx6YNaJeiT3yRXGNg6CJiiUONGzy7
	nfArEOAW+b/I4gjFhDZiej4s+b9Gs0gEAjqPM+HhsZO1JbCFzWWcpn2AE3xanq+AV7eluDoSftd
	Aey+MLemxE6po+qdrv2+B4H1uQ/+GPU+RTBR5M/32
X-Gm-Gg: AY/fxX7ixmaNbt8xCjVBRTo+eNTl/KBVV0H9BSIP9k/ntJbxhJjhb7g1CcmkzeOMi8O
	P7dzqOBKpfnz/WpSgwZdREVlulX5DmOc5HTBYGp7STBP5Z81Ua+hM/djaEDXwODqduJspX1S63N
	Czn/Z4GRyO84NnPk1Zlc1K0OWyBCxua4itsvgaeu6WCJkbPcegp4S9COPZ1IAE/l4uZQS4mghcG
	LqJHWYb8I2ZM+Xs5ZQ75JJJdJZR4ndErtWhHhgfChoZggnwpxgqPWvT/9vqTatA2q4bew==
X-Google-Smtp-Source: AGHT+IFY03QOD+rpaee6JMJz5V1Q+LtZHzyW9QYCkUaj/PQGgBqN8ctNNUwKRAG43fFXIBU1U0KMnEepQ85YQps45bM=
X-Received: by 2002:a05:622a:248d:b0:4f1:b1f5:277b with SMTP id
 d75a77b69052e-4ffb48a8654mr78118021cf.23.1767868336738; Thu, 08 Jan 2026
 02:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101927.857582-1-edumazet@google.com> <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
In-Reply-To: <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 11:32:04 +0100
X-Gm-Features: AQt7F2p-y5UbYRv-TWHGNGwam1_iRtt3bbPJlg6n-RcD7sW7wTP_mSOnZxUlj-8
Message-ID: <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:29=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
> > struct iw_point has a 32bit hole on 64bit arches.
> >
> > struct iw_point {
> >   void __user   *pointer;       /* Pointer to the data  (in user space)=
 */
> >   __u16         length;         /* number of fields or size in bytes */
> >   __u16         flags;          /* Optional params */
> > };
> >
> > Make sure to zero the structure to avoid dislosing 32bits of kernel dat=
a
> > to user space.
>
> Heh, wow. Talk about old code.
>
> > Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com
> > https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@google=
.com/T/#u
>
> Was that intentionally without Link: or some other tag?

Somehow the Closes: prefix has been lost when I cooked the patch.

Closes: https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@go=
ogle.com/T/#u

Let me know if you want a V2, thanks.

>
> johannes

