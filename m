Return-Path: <stable+bounces-50156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C033903CFD
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 15:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86C81F23D3E
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6217C7D7;
	Tue, 11 Jun 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQesdpJe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B41E49E;
	Tue, 11 Jun 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112003; cv=none; b=iRf/sPFH7NVaAJyHGKrExZuffYIjgeXHSl5MvrhIKdM6CXb2lnhfHuGIJ8ihBihqhxZngTLlBNBQbQoTrWq/nzrXnioqfzTSUPn6GckOVkEhWTherhX6a+DpRDL4CQWXsm9TjT4MY+R1o/SYgcqFT90od/OZWQ32gtbuc4Vv6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112003; c=relaxed/simple;
	bh=sdPLfiowNbYg6TIhZYX/HLOnceUJA2pderFfCXtAaeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8VNcoHgE4qBAzxMY7V86Vtam6UhR/tO/iM3nota30C8v/pZDv2TqH9eMpg9VSNSJaCKQ376XWzBXxkQYsAJpDod2o98TbXAyVmjxKB+WxK6GIqYrke3+OR4J1d4xTwJI9YdA3FIEJnmBIWsllO4NeEwPoxlpZtU/bVLn15v9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQesdpJe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c327a0d4c9so880910a91.1;
        Tue, 11 Jun 2024 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718112001; x=1718716801; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0DqNIZ2fkLo6z8QESOonTasJoXWxjg6TNbDof5tmJA=;
        b=SQesdpJe9KRKeRITSrcNLSevjGAlNZ8pV5KsdkmnMpUJj6DoBwGET78wQVyDSt+rTF
         MwxAwG5z1io1U9GWq5ZPb83/Rmq4ZoYNlIAYWSKq7KsgBRvTbBf8gP6X+Nxyiqvwrtco
         8f4yxi0zxxECVBU6YziSlsq3ikLX1faot8wnvyYvnDm2O68nU1vmkaKloT6dSaEok/X6
         IedNnCB1vXlkv7XmZI0ZM7aPinT4gjxpjJeYheGG0RyoETfxJYalOoWdA0SHFn47CWu4
         umqGvgqIKvtryl1/dEGTAmO/IfmLtxohVptQWnz3m//gU6GVTmF/SvsNL+d17XjsUBkq
         iHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112001; x=1718716801;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0DqNIZ2fkLo6z8QESOonTasJoXWxjg6TNbDof5tmJA=;
        b=UWEDezV8VyEUgx2SaiNhEW2Y1um3EYQz3msIn9/gc3jSWfSFZv6kVisy2kNGllp6ee
         ktVX5jInkjO6mnX0eYzcGK1Vp5wRNAhTZrU8zD2diOA4MVR1BnkaV0jF6bJhMb12zURI
         3RBUmxmoGBZTkDUzFnU8ukR7ICgk4a0rO8l0yF0khWM7DjykepEpp9dKCHshWkVq1IgU
         /T3b5LEsmsBCqOxM37I7BJMnXGzN7zWuNMW1d1/H0dDJAF55jpw52YrLpfZzY81McuTO
         c7+YAD+TBrfTpxMHUwbKeU7ZllJ05JIupkrL/4cd4bz7y7lR0il6JgAY27il1vwtHXV6
         ootw==
X-Forwarded-Encrypted: i=1; AJvYcCWmp2gLJBbAiHWI6MQ3l7Ripx029pLXo3UCb/T76+NGYP7CiUKgGN3IBPDxNOjqO8hwA4vBgc0oqfliImrJ/9JbSGhJ8lrwnq2hIcoYPtjLpNxiA/jzFUasgyJ2jVWFddvLPofb
X-Gm-Message-State: AOJu0Yy7FDils2HuYOwd9f4QW2lHwKppKTN7/eI5o9uDKgz0JXv3xnyH
	/ovWmNmXll872exiRnNlMUVyam5APZddmgNZ7iZeoo24zo5QFw6X
X-Google-Smtp-Source: AGHT+IGxAyGrqEkm1Bhw5VMCLG2lCoQAaYzBkoR1AFtPozvd93R9xhFHzL0rANhkNtT7vnbJfUSN0A==
X-Received: by 2002:a17:90b:19d2:b0:2c3:2f5a:17d4 with SMTP id 98e67ed59e1d1-2c32f5a2ae7mr2962806a91.4.1718112001471;
        Tue, 11 Jun 2024 06:20:01 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c304fe9622sm4536521a91.18.2024.06.11.06.19.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2024 06:20:00 -0700 (PDT)
Date: Tue, 11 Jun 2024 21:19:57 +0800
From: Peng Liu <iwtbavbm@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, maz@kernel.org, iwtbavbm@gmail.com
Subject: Re: [PATCH] genirq: Keep handle_nested_irq() from touching desc->threads_active
Message-ID: <20240611131957.GA16967@iZj6chx1xj0e0buvshuecpZ>
References: <20240609183046.GA14050@iZj6chx1xj0e0buvshuecpZ>
 <877cewwtbm.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cewwtbm.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jun 10, 2024 at 08:23:09PM +0200, Thomas Gleixner wrote:
> On Mon, Jun 10 2024 at 02:30, Peng Liu wrote:
> > handle_nested_irq() is supposed to be running inside the parent thread
> > handler context. It per se has no dedicated kernel thread, thus shouldn't
> > touch desc->threads_active. The parent kernel thread has already taken
> > care of this.
> 
> No it has not. The parent thread has marked itself in the parent threads
> interrupt descriptor.
> 
> How does that help synchronizing the nested interrupt, which has a
> separate interrupt descriptor?

Right, I never thought there would be more than one interrupt
descriptors involved which is quite common.

> 
> > Fixes: e2c12739ccf7 ("genirq: Prevent nested thread vs synchronize_hardirq() deadlock")
> > Cc: stable@vger.kernel.org
> 
> There is nothing to fix.
> 
> > Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> > ---
> >
> > Despite of its correctness, I'm afraid the testing on my only PC can't
> > cover the affected code path. So the patch may be totally -UNTESTED-.
> 
> Which correctness?
> 
> The change log of the commit you want to "fix" says:
> 
>     Remove the incorrect usage in the nested threaded interrupt case and
>     instead re-use the threads_active / wait_for_threads mechanism to
>     wait for nested threaded interrupts to complete.
> 
> It's very clearly spelled out, no?

Indeed, due to my ignorance, I never thought there might be more
descriptors involved. Now think about it, I never really understood
the meaning of the above change log.

Thanks for your time and concise explanation.

Peng

>
> Thanks,
> 
>         tglx

