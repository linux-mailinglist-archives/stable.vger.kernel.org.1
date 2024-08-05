Return-Path: <stable+bounces-65399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6FA947E76
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095A01C21D3A
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768F159217;
	Mon,  5 Aug 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOxsqe3c"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59004D8AF
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872782; cv=none; b=EQEJ1+N8Pcx41arbC5prMqNBBXHLR7c4hHHAEnk+8Rtfw3ygiewvjuyXqQhQa34h7uZeh09ingpFzOiNyXIVd5I8X4Qapc8wkD20jVJPqjUS/budWnhTTjrkTEo8cL/VR8OAvD+Q+SF/8DSazc0kNUfcBZdYcqEte9btafAFgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872782; c=relaxed/simple;
	bh=5wjHU1wKHRRchFX2cqWEk5v6q0TdpGyDqI3gFeTqBiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clgomRp2zvHDmaX0U4F8sGd2eNAFppqSNMhWzixf+obpippuiSrO5XBuUY2+y74C9yFFAlfzNpWxrk1Kz3W/pkyStXRxuHqo6TCRaUd2FqfvtOF2PN7uMYGlambOuBj33YNdK/eEBR2MSZfTBd7vNTdWKncvziKTQGP1xS4l5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UOxsqe3c; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4519383592aso17769751cf.3
        for <stable@vger.kernel.org>; Mon, 05 Aug 2024 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722872779; x=1723477579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqOaptwxc12t3A/k1QIs7JMco9pX/hGJo5YaprxUknE=;
        b=UOxsqe3cbqludNtOBbYkk/wjzak5Sst16gQvEGUWEK3sclUoWL+DeodBNdSEBlouZK
         J1uEhdL01XbyWqbCSsZkMy850FTnvcS1oTC7rSFOML/hdXmFl2kkDxgZ1tZFaCMmWe7D
         RATHh4qapcb4ZPs9bJD9ZKCNAj0a7vS8oHCWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872779; x=1723477579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqOaptwxc12t3A/k1QIs7JMco9pX/hGJo5YaprxUknE=;
        b=TNLfnFlNHflBQwBM/C0f1dmQc9Bpg607nIjo5mXyMQQb8tPcUoeenTa99X8d5uQ0Yb
         /XL4iq8P1w/olBd1Zd6Ykpe8IRPCjZiJHzs/VSqQZl/pC9ABVlstLAEs+bueLfLHi1hw
         EutJ4UOEUSxgeeQsDO+zB9SYRtYSnf8aIRna11zpoO8WS3aEp+yNKDNZt/Z35japsAH+
         sNFuu6k1LroanJeQN1bbIHGdJZKBpXdeebU7Z/lmj7PQgs1Ha26CGpO6ZjFqzZmuIUfw
         wCSbNe13Sjc69mrRM1qpdzDLP7cXHAl5nnoTKzK1x9MaiHHT8Zdcy2+Z48gdxea2GqHv
         dl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDQ7yuAz2gcXWs/g+R9omm3c3GSrlURfLZX1T/9oK0uUb88YAuOVrR6dyXaKG7KQ7NLaOU2qgiMGHb0/qUW9x0dhMXjV/5
X-Gm-Message-State: AOJu0Ywo5xaJz2UKpMSgBrLooM6TKE5GiINF05x1QMVWkJnSR/ezc0IW
	RAd8ZZYs0WUmcXJP9/E1lReIUeVDdpfkinTITr+BW+uDiceBEd56TC3q011pmce/2Jx+X983oN8
	=
X-Google-Smtp-Source: AGHT+IEVYifPXnJi156vlAP5L6WU/vWfD51EWXAofK3X+D8Jv7YRclu04S2uSzGrWtqaZMbgLcy8Sw==
X-Received: by 2002:a05:622a:1920:b0:44f:f92b:6026 with SMTP id d75a77b69052e-45189206accmr165957601cf.3.1722872778746;
        Mon, 05 Aug 2024 08:46:18 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a577bd0sm30604701cf.0.2024.08.05.08.46.17
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:46:18 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fee2bfd28so463421cf.1
        for <stable@vger.kernel.org>; Mon, 05 Aug 2024 08:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9ZycW6uvmxxuqfZ3zEcddao/q2SdUWmUXG62j8KcBPJEwkCej9+5+DweXFK9b8PGx9iF3qSbikRWdthcSQhkwPLt3Zs4T
X-Received: by 2002:a05:622a:282:b0:447:e542:93a7 with SMTP id
 d75a77b69052e-4519ad00ecbmr5909431cf.12.1722872777503; Mon, 05 Aug 2024
 08:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-4-jirislaby@kernel.org>
 <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
In-Reply-To: <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 08:46:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
Message-ID: <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in uart_poll_init()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-serial <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 7:28=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 5 Aug 2024, Jiri Slaby (SUSE) wrote:
>
> > Coverity reports (as CID 1536978) that uart_poll_init() passes
> > uninitialized pm_state to uart_change_pm(). It is in case the first 'if=
'
> > takes the true branch (does "goto out;").
> >
> > Fix this and simplify the function by simple guard(mutex). The code
> > needs no labels after this at all. And it is pretty clear that the code
> > has not fiddled with pm_state at that point.
> >
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
> > Cc: stable@vger.kernel.org
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serial/serial_core.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 3afe77f05abf..d63e9b636e02 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2690,14 +2690,13 @@ static int uart_poll_init(struct tty_driver *dr=
iver, int line, char *options)
> >       int ret =3D 0;
> >
> >       tport =3D &state->port;
> > -     mutex_lock(&tport->mutex);
> > +
> > +     guard(mutex)(&tport->mutex);
> >
> >       port =3D uart_port_check(state);
> >       if (!port || port->type =3D=3D PORT_UNKNOWN ||
> > -         !(port->ops->poll_get_char && port->ops->poll_put_char)) {
> > -             ret =3D -1;
> > -             goto out;
> > -     }
> > +         !(port->ops->poll_get_char && port->ops->poll_put_char))
> > +             return -1;
> >
> >       pm_state =3D state->pm_state;
> >       uart_change_pm(state, UART_PM_STATE_ON);
> > @@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver *dr=
iver, int line, char *options)
> >               ret =3D uart_set_options(port, NULL, baud, parity, bits, =
flow);
> >               console_list_unlock();
> >       }
> > -out:
> > +
> >       if (ret)
> >               uart_change_pm(state, pm_state);
> > -     mutex_unlock(&tport->mutex);
> > +
> >       return ret;
> >  }
>
> This too needs #include.

Why? I see in "mutex.h" (which is already included by serial_core.c):

DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))

...so we're using the mutex guard and including the header file that
defines the mutex guard. Seems like it's all legit to me.

