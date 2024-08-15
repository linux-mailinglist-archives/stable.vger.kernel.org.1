Return-Path: <stable+bounces-69243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B0953AE1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E0D28271D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B083771747;
	Thu, 15 Aug 2024 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+NxNSxC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16244AEEA
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750357; cv=none; b=r3QCBJfZTTqhBwwQwInXr9CXvGLB1v50XQ8gpn0/M6RWxeYrIVLj9eldFyVuX2Qjxly1OOITtPMNtw9qNOrez5RC4U/5i5dzY2d2W5ungPoeStnu6XPjmetiZq3KRV83h4zhg4GmMnR27mTtrkL+wrlN8Uvb0WVYbaaLQ2tJTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750357; c=relaxed/simple;
	bh=hlL28argICLuWvwcogXRPeun1O8bK02suZxF8cP+Ffs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Spi/uqgki8mb3fonv5rFf7YXbZYIaP4zEVlWbYWDp8weNvlMr3Gj6YimDJYG0ObzsNF3ZH1LqxVAzvv3kDqzJznLrp/cihnX5C6x66ayB4H0XJSHYUNmadvj6nOd3rBwb44o9oHgRye6dH/SlKc6vyuEjykHl77PedwFlE5kV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+NxNSxC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso15549131fa.2
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723750354; x=1724355154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VMWtIVUQceYpVvLsBLbPk3iyKD7Br7JtsGxqPKKxK4=;
        b=b+NxNSxCX20RYDYzPvRaPdpGUhQPCjr2xYzuoOMpLqoEHwfH8yW6kOQeAQaP0rqWRs
         36EusCwxEivvqr8XPR/TKOxPAWTbBXCZETtISlc0ZSst9GzU6mdW/u2JofdvmBPj/ydG
         dC1qRVcJfanQMgOd8oOXxiTck3Jyhl6Ysdq+8pLeV1i6vdwORhFgRL286TnQWZZ1cjyR
         9DgqItKb5TzcC88B2Nch+tOU+Fgr1BgmCxCswIi8ROuzfWX6EmYfOC98IsvRyWd9E4Wq
         32zDSeYPJA1hqIu47V+V9xdaBDpwFGf3ac//ov1Nh0ASLNOObzKCWu8Y7tQuEtBpKQiA
         GobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750354; x=1724355154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VMWtIVUQceYpVvLsBLbPk3iyKD7Br7JtsGxqPKKxK4=;
        b=pMZHgwaCnUFfBVZv1yx0YEDT45FFN5639m1Zrsjl/kVv+N+EGB8jGiapAJBakiWWG2
         yISdUoJMNAFXrkj63GVHY2fsE/WN+FyiBp2xWvfXDWq0a6VBtjyDHHf/7GTsQ0GnN9cV
         Om8M2D2jnti0v7/NL7D2AC6L0wXq7PGSCCGg+CIsDDE6KczVzmfTQqUSpVsm+Hpulxa9
         fxnsXfhZY2H5nKOG39nRBjgh5FLKMnXmgaXWePimENrawFMsmorEyhEf5XBBhanNJvlA
         B79ZzIbP8kaz+N1MiicIbIUyGMwfH64rRsrQZzo8NWxZhaTL2jIowWLXLmBRzY6WY+A7
         /hgA==
X-Gm-Message-State: AOJu0Yy4jyPRy3+5YbcV+HaffWShtZpr7ZRSbnWCvbziinFGfZq48mze
	CVwqBF9G5Ake3tRRgkaB6951IYPTsatl3U/1vo529kPdtI/FZ+rbe7d2KJaHdtK0KviMznQWtO5
	ZgV1Jj3sPw92yo884RZCJ+uZD8Pg=
X-Google-Smtp-Source: AGHT+IFh2pRw1WXxjD533NOYR3CmzviYIbHdMSsqG1lW5W3Hf0Oh1ro001FUh4FCsYoILC2D9KjC+2LRp4j4b7/Mno8=
X-Received: by 2002:a2e:be23:0:b0:2ef:22ed:3824 with SMTP id
 38308e7fff4ca-2f3be57e68amr5908661fa.5.1723750353365; Thu, 15 Aug 2024
 12:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730201315.19917-1-sergio.collado@gmail.com> <2024081227-habitat-cough-dfb0@gregkh>
In-Reply-To: <2024081227-habitat-cough-dfb0@gregkh>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Thu, 15 Aug 2024 21:31:57 +0200
Message-ID: <CAA76j92XEdBJzMVuK1w2bk=Or07NtMpsZ3B-K_DWXLSkWj7iCw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] jfs: define xtree root and page independently
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	Dave Kleikamp <dave.kleikamp@oracle.com>, Manas Ghandat <ghandatmanas@gmail.com>, 
	syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

 The original patch is already in linux-6.8.y, so I submitted the
patch for the previous branches:

 -  linux-6.2.y:
https://lore.kernel.org/stable/20240815183641.7875-1-sergio.collado@gmail.c=
om/T/#u
 -  linux-6.4.y:
https://lore.kernel.org/stable/20240815185026.8573-1-sergio.collado@gmail.c=
om/T/#u
 -  linux-6.5.y:
https://lore.kernel.org/stable/20240815190146.9213-1-sergio.collado@gmail.c=
om/T/#u
 -  linux-6.6.y:
https://lore.kernel.org/stable/20240815191047.9737-1-sergio.collado@gmail.c=
om/T/#u

I have not addressed the branches linux-6.3.y and linux-6.7.y as those are =
EOL:
  - https://lore.kernel.org/all/20230709111451.101012554@linuxfoundation.or=
g/
  - https://lore.kernel.org/all/20240401152553.125349965@linuxfoundation.or=
g/

Please let me know if something is off.

Sergio

On Mon, 12 Aug 2024 at 16:37, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 30, 2024 at 10:13:15PM +0200, Sergio Gonz=C3=A1lez Collado wr=
ote:
> > From: Dave Kleikamp <dave.kleikamp@oracle.com>
> >
> > [ Upstream commit a779ed754e52d582b8c0e17959df063108bd0656 ]
> >
> > In order to make array bounds checking sane, provide a separate
> > definition of the in-inode xtree root and the external xtree page.
> >
> > Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> > Tested-by: Manas Ghandat <ghandatmanas@gmail.com>
> > (cherry picked from commit a779ed754e52d582b8c0e17959df063108bd0656)
> > Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> > Reported-by: syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
> > ---
>
> What about 6.6.y?  We can't take commits only to older kernels, that
> would mean you would have a regression.
>
> Please resubmit for all relevant branches.
>
> greg k-h

