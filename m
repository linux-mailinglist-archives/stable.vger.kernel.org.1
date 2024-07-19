Return-Path: <stable+bounces-60589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1BC9372D8
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 05:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F011C2118C
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 03:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8141CA9C;
	Fri, 19 Jul 2024 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5i/y1Lr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF12C1BA;
	Fri, 19 Jul 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721360827; cv=none; b=cPm6Q5hCA4IO3kR8LGjRyoDmdlY9OsGXQOAQY0M+Ex1vk4weTclZ7WWK2gLhUKrr4ixEzU6WWKI3Uc0oR+EmBUXfocWkbbDrHj+Ja1bkmbtjSbO7QIRnHMwh7akGrq9GHfeidSyoo7BZI6YPfJSIzMS0jW8NzjUa5ucspwLiP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721360827; c=relaxed/simple;
	bh=Pmihlnn/dQptJI+Hq2xL/tv7JYrWqbhgus0F/Tlyerc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb5OZyLmiHezBG5fsTYn92m/1A9r55DjOLOmiitwSCXoNRz149OS2QSkeAycFACPEkLcEc+QuiKNVBTi6Q7A4hCzVCJfOEyDHXZwW3/aHRIlTiu40ISXldelxFPmPEGwJ0Wpdk17tPNaGuKxmYYG4IUuoqlGN3Jar43DZGEyv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5i/y1Lr; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-81f91171316so1113840241.0;
        Thu, 18 Jul 2024 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721360825; x=1721965625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp6drrNzfbzSqsVZ8Tan+TwIGIyIdS/jLO+8J7vaOrw=;
        b=N5i/y1LrmDd7qCSKYLe2RbqVvs7Df5DSYPUoNMjgotvMCrAC8SI9hBNYpqzjeUQV+v
         jSfo9897Pr2pdqKf44nYwt/eXcyhSGsFToNG4N8aiukfSv34PLsA6EoVjXVHm5W7vN0f
         MMye7Y/DdfrlmyHdopL08T6Hb1VaaHjb0n9e8x3rbhw7YaW40iA7NmcchuH2VdAiNmJd
         Uy7ID+8BnPH5wSfy60gyNDyMlwtTl6+r5B6yRtg4QjHezXbURIjrNbygY6wMHkUiXiLc
         LE5iU6C1Ol9SRVGYFDTZwT4ld0Arf9v5KYK5KG2izE7039IUVlFr4d3MM7CNeBnTGN0m
         VEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721360825; x=1721965625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp6drrNzfbzSqsVZ8Tan+TwIGIyIdS/jLO+8J7vaOrw=;
        b=H8cQ7zvWDk3Rdd9AT72HF9JZ5F6ppZj0QdouJNM9RM93erjLGtZb8LycUjzMl1XlBe
         pkA+vVCnh/q6IxxWi+14Fv6PvFnQ0GEuAMdbAMxtmD8c6whE+rB3/tvcCova1e75lW8l
         2urBiqKPoDanQ1S0yAs4RS47tAHbjpBZ5a1S1tUUyg0AZJNHjONbD7aMJ2jcvt5mYm1q
         Ta/USZ6BiI8G6qx87WtHbefUAp3iP7/asZ0a5pK1EFSTWrSf4D77rojFpShbmcALjZ0i
         iKzpz9oqXqjPiKWoYJh5CMu514Dba+gFLfecqL0HhIeG7gSBIJeX3OSZEbp3XFrOrq4b
         KtCA==
X-Forwarded-Encrypted: i=1; AJvYcCW8HAju9YfUbz/8raR15Q2/pslKy1jjydKsvaX8zriHf3yhQ7+w8i0IZ0jwz5OEjFO9Y6T6g9IobFlpBgfRBXf3W5wzzFip
X-Gm-Message-State: AOJu0Yy8KfNAovQBJUUgCSanMXgOL39d17InK17+SuwaCbRKr9GAmNyI
	Kc/e4UqJ/OY18IgIdT0DPqbiBXY0OmhbpktLr3DHRCGbI8oB1TR3IDI2ZHPt63NBGMaWBZilfbd
	kUQjGHk78bU0fuJdvejMT0QlO3Ks=
X-Google-Smtp-Source: AGHT+IGDQGxGl5bxypB9sF1D7jmfnImAmSa4egh61YyG9pvEkcyF0IT+0CSzxg7mNf7Y4pQbFwx+6U3JNMUlcuMDEwc=
X-Received: by 2002:a05:6102:3f92:b0:491:36b0:33a4 with SMTP id
 ada2fe7eead31-4925c25d1dfmr5232683137.14.1721360825186; Thu, 18 Jul 2024
 20:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718190221.2219835-1-pkaligineedi@google.com>
 <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch> <CA+f9V1PsjukhgLDjWQvbTyhHkOWt7JDY0zPWc_G322oKmasixA@mail.gmail.com>
In-Reply-To: <CA+f9V1PsjukhgLDjWQvbTyhHkOWt7JDY0zPWc_G322oKmasixA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 18 Jul 2024 23:46:28 -0400
Message-ID: <CAF=yD-L67uvVOrmEFz=LOPP9pr7NByx9DhbS8oWMkkNCjRWqLg@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, shailend@google.com, 
	hramamurthy@google.com, csully@google.com, jfraker@google.com, 
	stable@vger.kernel.org, Bailey Forrest <bcf@google.com>, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 9:52=E2=80=AFPM Praveen Kaligineedi
<pkaligineedi@google.com> wrote:
>
> On Thu, Jul 18, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>
> > > +                      * segment, then it will count as two descripto=
rs.
> > > +                      */
> > > +                     if (last_frag_size > GVE_TX_MAX_BUF_SIZE_DQO) {
> > > +                             int last_frag_remain =3D last_frag_size=
 %
> > > +                                     GVE_TX_MAX_BUF_SIZE_DQO;
> > > +
> > > +                             /* If the last frag was evenly divisibl=
e by
> > > +                              * GVE_TX_MAX_BUF_SIZE_DQO, then it wil=
l not be
> > > +                              * split in the current segment.
> >
> > Is this true even if the segment did not start at the start of the frag=
?
> The comment probably is a bit confusing here. The current segment
> we are tracking could have a portion in the previous frag. The code
> assumed that the portion on the previous frag (if present) mapped to only
> one descriptor. However, that portion could have been split across two
> descriptors due to the restriction that each descriptor cannot exceed 16K=
B.

>>> /* If the last frag was evenly divisible by
>>> +                                * GVE_TX_MAX_BUF_SIZE_DQO, then it wil=
l not be
>>>  +                              * split in the current segment.

This is true because the smallest multiple of 16KB is 32KB, and the
largest gso_size at least for Ethernet will be 9K. But I don't think
that that is what is used here as the basis for this statement?

> That's the case this fix is trying to address.
> I will work on simplifying the logic based on your suggestion below so
> that the fix is easier to follow

