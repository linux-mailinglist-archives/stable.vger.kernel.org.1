Return-Path: <stable+bounces-210230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24FD39898
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57D793004CC3
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B332F547D;
	Sun, 18 Jan 2026 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3HWkvEK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B332F25F4
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768757718; cv=none; b=RZWkw9APKlUV4djKNSj8NABj/NDSCuA8Le1W41Z2LivYMPbo1bFuL080eKGf3++jBQjDo3OF3X+wZpBbzF5yRzUcoCZa+WCgv8eNH3KeaGCMDxOL1FwwEWlEyxnYFcxNZZ4ywaetn4E9mCP3SzzUtiI1CwgZX2qZ619OG3MB4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768757718; c=relaxed/simple;
	bh=1XjJMml5OQHthHhA3ZJ+DGh77+QauGSNKbPL+AXXDOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q74uP3M06vwqdKq4lysN5BIajYMjanypw7NVMBHfLkbMe2bEA3gvggngozJTDoOIYp31fM8USBbNQ9znv33FmUiXJ+YN//MBnsOUqMWPRe3975Zh4U8foA3haup8izSHDrXOo7Qh9VYhj+qeSLm2MYg0a2/lmoQXI6KM1r+jTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3HWkvEK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b872b588774so533681066b.1
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768757715; x=1769362515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGZEHCPvQHmUu6ZZAHCVz+kl9sfR9JLyuBUpjMnyHL8=;
        b=h3HWkvEKKGJzTpxkwG9bvkRXr5RPqRabGvsoGSv304WVI1dyZqMCsqAObaJ1SDhCF/
         WtbWaujJHUaHqoTWFpvthfeHIUJwusghfpSIAUzOE3kCInyrUjhGkACgD7oshWWBDG/A
         XyQfnrB9u2TDPzA+42vVKD453juaeh7QQ3nB335Yh8HO6cLJO8ypUjwO38EtzMXyq4/Y
         YkdKN8mhfpOVy/xKeNfPbAHUMngf9ZYplSjtup5qpi7jVO19BEFErHktTqK2meWtnTVK
         vFGAfew8p0QbiiBAId6QlOPzGVB0Fk64cVc1V4Q2WkGjQ+lTaKy8uDnFCEgV+3HRsoau
         rmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768757715; x=1769362515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGZEHCPvQHmUu6ZZAHCVz+kl9sfR9JLyuBUpjMnyHL8=;
        b=YPKHyWoi3DeewuwRwm3RJC88ne24I2zLP/07vJ2MbQ2wKEP6iz5O15Nqm/uKnALS0D
         c7GzHZ4xrnA7k9WDUtJVHsqBR9GLrrd8BdEMOSmLoCZNDFr60BLuqZiBgsSDFa9uZQ62
         ymBh9wZzbMwtiAFVtJhx1b37dWg4yD1mi56C4CHPaQe3H3g3vIwyEB17ZXD9cGf3OPjZ
         +9fySFQPyfuafD/afWXHSERkoh99FhBATQtZD6vrAxcywQOCi0hAwImJEIceiwpEvHIn
         J/yfCWu6hdUqQkrfA5XPxV2javmM+2npWsT0LPAyQqlkaNu889uQSUNe3e2zMAcMtcdC
         D+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUcSPCPE1n8gBnYO5zCCi88te4bo3LB5yVVSIhWVAl9X1iTpJBniXfbeuB6+ENEXt7IaVttdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98JQLxooiSPHT7xwfSY+pxZ39JcZskAttLvQ92svCMT7pt5ch
	A0No/ossaCFxmtPyZWIIF8m9/kNHlZzMqFp/b7TqIIo19XjTRE49f7by
X-Gm-Gg: AY/fxX5SGvV2HvgZlddXCppTz6AKkGDj+do9yX3XC3xC+zoP+3w1sVacHFesJCiNyOS
	oEoRRiYUDWR8NYz6N6PTyilFV+UMuuavh67nmjBHp9lUEbT1wY8c0p9vM1sPTROqZmzxMmufePT
	/e1aVxhZnUOao8O7cN14w+NSrtVrm8pCRqc6ytx8Alak76waDUV/eCHmToVTa+ljYwp58zjWChE
	Sal68f2ezd71ln8eyC2Mutr0gMfzwf4clSkHA7horiYpQdT+/ONnhVXxNsFJMAS/klsM5iT4IWo
	nrR/qChzzf/STOQWflHsgO7SO4rZX0LyAHeyNmtz/f0UjhRKmvYiPlcp+aKf5KyJ693OyAclZsr
	joeTkBbPEm94PtLHuxLr+5Wv8b/0B/gNuYY1UJavDJN2E3rI4IX3JOXFvNVvYHYNE86LC2Mz0UF
	gcT+J2begu6kI=
X-Received: by 2002:a17:907:1c02:b0:b80:a31:eb08 with SMTP id a640c23a62f3a-b879302426amr752483166b.55.1768757714447;
        Sun, 18 Jan 2026 09:35:14 -0800 (PST)
Received: from osama ([2a02:908:1b4:dac0:5466:5c6:1ae0:13b7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654533cc4b9sm8173672a12.18.2026.01.18.09.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:35:13 -0800 (PST)
Date: Sun, 18 Jan 2026 18:35:11 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: caif: fix memory leak in ldisc_receive
Message-ID: <aW0Zz9SNbxJRxghp@osama>
References: <20260118144800.18747-1-osama.abdelkader@gmail.com>
 <2026011805-bamboo-disband-926a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026011805-bamboo-disband-926a@gregkh>

On Sun, Jan 18, 2026 at 04:02:44PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Jan 18, 2026 at 03:47:54PM +0100, Osama Abdelkader wrote:
> > Add NULL pointer checks for ser and ser->dev in ldisc_receive() to
> > prevent memory leaks when the function is called during device close
> > or in race conditions where tty->disc_data or ser->dev may be NULL.
> > 
> > The memory leak occurred because netdev_alloc_skb() would allocate an
> > skb, but if ser or ser->dev was NULL, the function would return early
> > without freeing the allocated skb. Additionally, ser->dev was accessed
> > before checking if it was NULL, which could cause a NULL pointer
> > dereference.
> > 
> > Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
> 
> Please do not wrap this line.

OK.

> 
> > Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/net/caif/caif_serial.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> > index c398ac42eae9..0ec9670bd35c 100644
> > --- a/drivers/net/caif/caif_serial.c
> > +++ b/drivers/net/caif/caif_serial.c
> > @@ -152,12 +152,16 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
> >  	int ret;
> >  
> >  	ser = tty->disc_data;
> > +	if (!ser)
> > +		return;
> 
> Can this ever be true?

Yes, when the line discipline is changed, tty_set_termios_ldisc() sets tty->disc_data = NULL
> 
> >  	/*
> >  	 * NOTE: flags may contain information about break or overrun.
> >  	 * This is not yet handled.
> >  	 */
> >  
> > +	if (!ser->dev)
> > +		return;
> 
> Why is this check here and not just merged together with the one you
> added above?  And how can ->dev be NULL?

I'm going to combine them in v2.
If ser exists, ser->dev should be non-NULL (they're created together), but the check is defensive.

> 
> And where is the locking to prevent this from changing right after you
> check it?
> 

I'm going to address that in v2.

> thanks,
> 
> greg k-h

Thanks,
Osama

