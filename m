Return-Path: <stable+bounces-181561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4BB98060
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 03:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208B62A09A6
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 01:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19011E9B31;
	Wed, 24 Sep 2025 01:47:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C278C9C
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678454; cv=none; b=l7ZAZLAlORSZR0161n0sT6zuS2DZmIRnqjFsXf5iUD/RtV7ibvZjuWGzeQlZiUkusfX96mSmezKezr+OXPxk9gfIxY6nMkEfv2vaWLb+aCII0QiuXjjXsqvTlGAQon884dQRhQbG79LDNpB8DYxvtlHScrp2tuk3NXwKGw3XSow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678454; c=relaxed/simple;
	bh=a78yOSPlJzqWA8H0Kkw+FyKGFUxbJvlfCgdJRUnIxsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=AjfJU/1KYZb42dyhQ+eIkBilddTihFYoatshVXqQuLq7vzcC49B3Eonc9g7+lD8jSH1Ct22VOEbNI1zPdefkffFoMTgCtUrNl2wrgbz5cQWj4/cnMw8XlEa69V0Q+834Qh1/+nH8CFS7pv/MfsKm3JLLPdycieoaUwE8rG/0yTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42570afa5d2so104922655ab.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 18:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678452; x=1759283252;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXqa8ZVUKHN/2pgYA2lXi0pwYaxmIHLyLmFVk0Bbclw=;
        b=N2ucggrjkLr2N/+40yUrzC23AS27bLnFoKk3Czk5wdqzKK9wemv97oEv5BzeRS3uw6
         +ki2FkRewO2Id4rj+hPqu0UqnYQdGkytVGHS8cy7whXLlj/oGO6jhnvonX2xO26LO24a
         A2HHccxk8VofcU1Qt6Pnf79JwsoB21JqfBhK23gPCuiowpC9n031iOrpN2TrPVpbSCRZ
         Kk9B1xKxrGln4LhcuWHhHewkJZNCXSRlDw/pSI0jrKlMtRpiH3jGVbWrAEpNiuoslU+g
         3VSoy/g34MD6DxGwyM2mpMSR9hG5kmM9DnixRDIFg0XYewBvQXsE4Y6HxtLusWkNqwR4
         AygQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyWOccqOV6LZvxOapv3js3ASQoZCdbzO3a7ej/DCmKmt6VcppEc4l/6tY2bw8TJqt7vEbWwZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrs5nG7wX453jM99JC1LBY1+MHlmcpRzwd5IIKnngg+iueLNW+
	W38jAjyXPEEXYXj54oDJd4lP4loEqqTfdIzRSHqxkn82bTLGRR/zhoYsByv+5hpBU9Sa0JaQhox
	rhAyYs7SK1Zp/6CN6ogfl+Jz3vEv6wZBhoiAW+lDt6iPYdS0VB7qC4c7GPM8=
X-Google-Smtp-Source: AGHT+IGOgaHNUpAopmgCGvJWfvbUXxy4mu5SH+S2Meqo+2nd5S+KrKKE0Eqj+YYf7O72l27Qm+TT+pWE0S8KgoOeqVi7WWzrGsVI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:425:7ae2:b8c1 with SMTP id
 e9e14a558f8ab-42581e10bfamr79342505ab.13.1758678452463; Tue, 23 Sep 2025
 18:47:32 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:47:32 -0700
In-Reply-To: <20250924014724.1097866-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d34db4.a70a0220.1b52b.02bc.GAE@google.com>
Subject: Re: [PATCH] comedi: fix divide-by-zero in comedi_buf_munge()
From: syzbot <syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com>
To: kartikey406@gmail.com
Cc: kartikey406@gmail.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
> The comedi_buf_munge() function performs a modulo operation
> `async->munge_chan %= async->cmd.chanlist_len` without first
> checking if chanlist_len is zero. If a user program submits
> a command with chanlist_len set to zero, this causes a
> divide-by-zero error when the device processes data in the
> interrupt handler path.
>
> Add a check for zero chanlist_len at the beginning of the
> function, similar to the existing checks for !map and
> CMDF_RAWDATA flag. When chanlist_len is zero, update
> munge_count and return early, indicating the data was
> handled without munging.
>
> This prevents potential kernel panics from malformed user commands.
>
> Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/comedi/comedi_buf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
> index 002c0e76baff..786f888299ce 100644
> --- a/drivers/comedi/comedi_buf.c
> +++ b/drivers/comedi/comedi_buf.c
> @@ -321,6 +321,11 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
>  		async->munge_count += num_bytes;
>  		return num_bytes;
>  	}
> +
> +	if (async->cmd.chanlist_len == 0) {
> +		async->munge_count += num_bytes;
> +		return num_bytes;
> +	}
>  
>  	/* don't munge partial samples */
>  	num_bytes -= num_bytes % num_sample_bytes;
> -- 
> 2.43.0
>

