Return-Path: <stable+bounces-112259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2EA2803F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 01:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417043A71D1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 00:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCA227B9C;
	Wed,  5 Feb 2025 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9qkbwZy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1301FE479;
	Wed,  5 Feb 2025 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716287; cv=none; b=bxxgeBBW2J4uNAhANEDMCR+/+JtiES6ack1eabMewLHsqokDeL5/pRfI6fd8FrOJEHrqj9VRxjs+izyerVO+s0HSbA8lBqUTm3LOuDKI+g8kafzbxOZVDskqnFogeoiLmcxIqHmA1M7b2WjazEJ0kvWNmQNKrHlwO87C9d3ldgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716287; c=relaxed/simple;
	bh=5AMLP6KqAfauKZIR8cxwZPY0XZUqNH03YuIp3tW4LXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WddyEEd+TaL4KblVZHwBoK2GX2prq3PUhHw9KEg9AgF2qkAnZfhE4WbtHX5QunYX4EkBdxJ3sHlou3BjfgwgtsmneGoDtUQhcFWOuo/qEGcfindiCdjoR6J53MlTCpeceucHdqYxiJIgOG2Wc9xa2oSLxS784HODivWS+lKftvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9qkbwZy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46fee2b9c7aso39284731cf.2;
        Tue, 04 Feb 2025 16:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738716283; x=1739321083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1AuBJ1tnUY57DN3YH+p2Y6np4rZoHmi5I7qiWXzVRE=;
        b=C9qkbwZywCgF99Cj/61jYVjDPEc1h+9rjrmLPTmdJXVnVX1SwdZHIUQwuFDGZf1/Dd
         zPgjDb5SHut4d6urdgWt92TmRqHfjh9RmNKcnkBCYvbmrCcsSpot+uON6ZzWebB/q+vj
         GC0ny+0nBeY817eB/nx0B84ET7CeB47B3a7FoqK/J1IXh1G+6+8VUfJkFH4oTBOMbmBp
         mXfzpN7RUtsc2krxWwyyj/NimkCLCbhyt1sdbAnfFZnvX1P/Hh2lP33UUfn6HqMZixa1
         zV4q4eeUtAUZu1P35V+11BK6McA81TvZO8x+id5K9Oq64ev8i8H1WXhemtkAl80rDF4l
         kHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716283; x=1739321083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1AuBJ1tnUY57DN3YH+p2Y6np4rZoHmi5I7qiWXzVRE=;
        b=V3otSvKINRE51wNf4bSj93FM4rm7UaY04X3+W/QWbudYsXa3fJZlcnzlHIZMiaLmx6
         tLuzzwbYgnTstU5yHsGU/XD76Lc3v2oYpTr6UsDgyV1D1gn8CUwcoY82RDVRoONbmMnQ
         9svnUw0oAbSaPd8bdswdsSh8De713lYsgGueHM9KnFWbjeJ/T11hpl/cDH5SsCOLebi5
         D8DHQpO6XNvoE/1c79UHIk0NHotDLHetNtcfYVAGFvDoPKIqOngzzvUyU5AqvaBnH3cE
         Y3+1I8PCAVB54HOjl4GH3jYrt6LhFUulOxcvi15HhZlfKHhZP4mXXw9Jl0u8WK0JmXuD
         2SWA==
X-Forwarded-Encrypted: i=1; AJvYcCVt1vtdUduBWbmz93OhACfh4q1Kv7+JRJsnGi5IffWQ0JPBYfEjc4EmgyVOBQGFbLvWOeaUlOsp@vger.kernel.org, AJvYcCX+7Qjh0lkeYPmK4U8jDaasDl6rNxxKoQeiXCuR/xm11vMdMXcGx/gndSmxtGywOp0oa75cDUBNjhdu/88=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy08yhc+jl/UkKi9AfLIfC2rbypcnVAgwyRo/03PvbrWaylkyx
	dihoCyzX4zaok1PK3Dk0hlsdpMlFQ+lNXqaPN2cIavtBS/fcp4sv3N0abaGICB/k6AFQWhOep5a
	+xpSEKqFRAkguYXOOdSiZg4wSZSmJDg==
X-Gm-Gg: ASbGncvNmovyJZMS6rMswMAN8spZjM6jFW3E7SzcJWipJLPrvCtiqwW8g/J/IMe0FlP
	+C6hWy4PXvxD+2tAapGEqD7hokfvXZNhU/pGixfK+HDMpYF7cGTseYafLvT0V6FhiiCXsPLns
X-Google-Smtp-Source: AGHT+IHX2Hyv44me1JJDVahmyiUtOiSCZF6Zck33fnL7TPzyBHPQxSxRY4YtswKcI8k3oD6Fa47PP0Nf/Y3yiNzEJ3E=
X-Received: by 2002:a05:622a:4a06:b0:467:5462:4a10 with SMTP id
 d75a77b69052e-47028028bd7mr12819011cf.0.1738716283097; Tue, 04 Feb 2025
 16:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202200512.24490-1-jiashengjiangcool@gmail.com> <27dd749e-712f-46eb-9630-660a8f8f490d@gmail.com>
In-Reply-To: <27dd749e-712f-46eb-9630-660a8f8f490d@gmail.com>
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Tue, 4 Feb 2025 19:44:31 -0500
X-Gm-Features: AWEUYZl7DViKm1Tt4vAH1-yB1kdaAGclsFPcNPZBXOOVWsCVJa0cuMngN7Jrewk
Message-ID: <CANeGvZUneWgQYAciHhx9yu--vQ88xOvH+Zhyw2LKQMjiwHNwng@mail.gmail.com>
Subject: Re: [PATCH] regmap-irq: Add missing kfree()
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On Tue, Feb 4, 2025 at 3:34=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
>
> Thanks Jiang!
>
> On 02/02/2025 22:05, Jiasheng Jiang wrote:
> > Add kfree() for "d->main_status_buf" in the error-handling path to prev=
ent
> > a memory leak.
> >
> > Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register supp=
ort")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>
> This looks valid to me.
>
> I still wonder if you could fix also the missing freeing from the
> regmap_del_irq_chip()? (AFAICS, the freeing is missing from that as well)=
.

Thanks for your help.
I have submitted a v2 to fix it.

-Jiasheng

>
> > ---
> >   drivers/base/regmap/regmap-irq.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/reg=
map-irq.c
> > index 0bcd81389a29..b73ab3cda781 100644
> > --- a/drivers/base/regmap/regmap-irq.c
> > +++ b/drivers/base/regmap/regmap-irq.c
> > @@ -906,6 +906,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle=
 *fwnode,
> >       kfree(d->wake_buf);
> >       kfree(d->mask_buf_def);
> >       kfree(d->mask_buf);
> > +     kfree(d->main_status_buf);
> >       kfree(d->status_buf);
> >       kfree(d->status_reg_buf);
> >       if (d->config_buf) {
>

