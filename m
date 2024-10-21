Return-Path: <stable+bounces-87590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DA9A6EB0
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B83F1F2298B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117C71CB51B;
	Mon, 21 Oct 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRSilMVy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F01922D6;
	Mon, 21 Oct 2024 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525755; cv=none; b=i4yQPiyk75eYwRetGb2Bbk0y28PUhqKwInnG9fxR3MKzWys9+kaIlRhAbz5JWqtknFt6yIujgBM1mjepc1aEnOGrkS96k12L7qaC8EoxDkjLpQh+vpyVd0CbPlVMaY4rU7jRtHTtuwui3/+3uKaooI1AloEP8PO+hqSBkpZcO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525755; c=relaxed/simple;
	bh=H6Ns5vHK2HiU2VSwpxuXrmH1JhXPcpiGuL6AgHNjnEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPngREP37kQHQybSfq5Tar8McuPC7U8McrcpRPxbuJVryvRr9Sm2zsB3MmKLFH/+NRGPbPenR5PKxVgfy8US1MjjZMZv/QrhzRohfUPBE5VVWkwuPSMbXkNBu0ek5dXMt0qYk0Sg2RoTaRO1fesV/vKnPboat1lfRkChCU8EZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRSilMVy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1507c42faso306131485a.0;
        Mon, 21 Oct 2024 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525753; x=1730130553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuDwGcL6XFvfW5v+H1Ut14rr/uCtFeoQ3IsS9Q3KUp0=;
        b=aRSilMVynXGkKrZSTjSPSxX9lgISEblqX6lnfrlDv8wu4iN6nulBOfLtOMyjyN1KNM
         2b9bxq9lfZ5IGlVZ6rcMTp1VLBumoRl63Y/acv0v4Ye+l6A22hfilRdD8y6G8QeGwdW1
         CFPyKJcF1Uzkk7tYOHJ2bjlwUXMZfPbvBylJYzzw5JHCLLkRGT+qffbddDvHFktdAGT9
         3683wuDFb4mB69BOusB1PK1/qOYFf/J4rbNQruHKhWpT7QaD+xQlSmrlYYy5e1jIiKPz
         nHXzBjGE+7A61ovsvQAcZngXzhW0C7pra2MsqYAHnv4VN9Hi3jKyaHVyicmZm2iIQdmT
         ta3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525753; x=1730130553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuDwGcL6XFvfW5v+H1Ut14rr/uCtFeoQ3IsS9Q3KUp0=;
        b=tkPrk37r1ZbUaXuJzrk3cRZHBzaP9wKMExNY7btjjnlhbTF/7w5E4X+deV702Zk5Gb
         S2+65scGDlz7R7azX6xeaA0fPxTt/J79VZ1WhFy5PeLsCPXlyImSSQTICLE1nUgQ9bS4
         xhFWAZN4RwwpoZfq8ffEblLTKge8yv0NI8BTIq2nD6pEiFdHUvc4359hUNKWt4f1nfz2
         aXegLc7XUeHRzUNnD89KJuId6S0PahXa04bgDb0L8FrHUkAEKshWcSLRavVom7IPXhGJ
         QoU3tly5K+pdAMurooQwGWVYCCxp4+RW8fVseTSig2llNL8A6g7+8gxEn/VRtg1wg6vM
         qQGg==
X-Forwarded-Encrypted: i=1; AJvYcCVYxuoV7FlzkuLvycG3UbBNbte2g0WtIdKxuJbK2rnChMsRRjmajab1gIZ/rQ8T8yRNIPEjKJV1@vger.kernel.org, AJvYcCWtJa3vPiYgMCpWD4T7bi/XOsnBhDEL0CvNkmjfzhGXBQeyp7qofq1rWhT/1IeCVUecACIPRRtA9aIb2jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjfBtKfLllbHIpI5JeJ8wG70lR2H8EawtKXQZDeKx3agrIOcD
	XUb4JBpXUyHri++2KZEkpXzOzXv5RADs0nfb3VXxb5eiL92DS7nMW+9rwMaejxSfjwpDb0WNiKd
	btVXhfvCl2WRxlabIlQ8xtl6RvzM=
X-Google-Smtp-Source: AGHT+IFJG3Qq5sCVTXOTqxB6sF68E9Bvo+Aw9xw00VQxkyOIE8zeh+i7+DmduDJUdV4A7b6v8MAJ0HqlBxRyPMZvEYk=
X-Received: by 2002:a05:6214:528b:b0:6cb:55e4:54d5 with SMTP id
 6a1803df08f44-6ce21a01f29mr942216d6.10.1729525752811; Mon, 21 Oct 2024
 08:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015123157.2337026-1-alexander.usyskin@intel.com>
 <2024101509-refined-posh-c50d@gregkh> <CADyq12xj8VckfYO7W5XNf4MSssBTsCSi8gcE5_RmeD+dO5Cg8g@mail.gmail.com>
In-Reply-To: <CADyq12xj8VckfYO7W5XNf4MSssBTsCSi8gcE5_RmeD+dO5Cg8g@mail.gmail.com>
From: Tomas Winkler <tomasw@gmail.com>
Date: Mon, 21 Oct 2024 18:49:02 +0300
Message-ID: <CA+i0qc7JgJucJeQ=oagCu932JmuTZ1-LBUhgCukzn7XPaCMfxw@mail.gmail.com>
Subject: Re: [char-misc-next v3] mei: use kvmalloc for read buffer
To: Brian Geffon <bgeffon@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Usyskin <alexander.usyskin@intel.com>, Oren Weil <oren.jer.weil@intel.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rohit Agarwal <rohiagar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:53=E2=80=AFPM Brian Geffon <bgeffon@google.com> w=
rote:
>
> On Tue, Oct 15, 2024 at 8:48=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Oct 15, 2024 at 03:31:57PM +0300, Alexander Usyskin wrote:
> > > Read buffer is allocated according to max message size, reported by
> > > the firmware and may reach 64K in systems with pxp client.
> > > Contiguous 64k allocation may fail under memory pressure.
> > > Read buffer is used as in-driver message storage and not required
> > > to be contiguous.
> > > Use kvmalloc to allow kernel to allocate non-contiguous memory.
> > >
> > > Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands."=
)
> > > Reported-by: Rohit Agarwal <rohiagar@chromium.org>
> > > Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar=
@chromium.org/
> > > Tested-by: Brian Geffon <bgeffon@google.com>
> > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Cc: stable@vger.kernel.org
>
> > > ---
> >
> > Why is this on the -next branch?  You want this merged now, right?
> >
> > Again, I asked "why hasn't this been reviewed by others at Intel", and
> > so I'm just going to delete this series until it has followed the
> > correct Intel-internal review process.
>
> This is a significant crash for us, any chance we can get another
> reviewer from Intel?
>
>
> reviewer from Intel?

(second attempt, forgot to remove html formatting)
I'm no longer with Intel but I'm aware of this fix, so as the former
driver maintainer:
Acked-by: Tomas Winkler <tomasw@gmail.com>

