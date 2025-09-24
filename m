Return-Path: <stable+bounces-181563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1244B98075
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 03:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3781B4A8189
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 01:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B220296E;
	Wed, 24 Sep 2025 01:49:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E391FDE39
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678579; cv=none; b=NiYgJH55ae3qmvDVoiiMx9Irag0hrKcaqbPSNe2ZLWT/WtVFMGffGIqxSkY5Qy9fL/wc5Zy5e5aGq9ABTb6DfPoVpomCSsEv58PUlcvKACyM6ZnWQHiWd3eybV/biKcOD0rsNFWH/X22BwpFsvZQGCd6VGan2h2VBWbqpDH9ePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678579; c=relaxed/simple;
	bh=a78yOSPlJzqWA8H0Kkw+FyKGFUxbJvlfCgdJRUnIxsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hh3vEFf9p1124wh8n8XrDKE9+tM1th5QvrPTlsIoF3Utiz6O/hMuj9DdXXJQquDLWn18+QllhQKY1N7c56tM+QQpK6eCvFL4R3mlbSN7auMGyM1QUMeeJxPx4N9JaFCOBENOhi1MrUq6tCXu3gEra0Jfm47eJ1MuN2pKVC0J1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-893658a9aceso716942939f.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 18:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678577; x=1759283377;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXqa8ZVUKHN/2pgYA2lXi0pwYaxmIHLyLmFVk0Bbclw=;
        b=fhoQSAd8JDG2zvYp10oCsVG78rS52C0568P+Z9sB/x+oK0udhXOdqc5t6UKkRA7xCV
         BL6z7vdW12UX50Mq6ErxDG1vTSsEUQC9SG7nJCVThgmKOGkI17PYyrGvV16+v/rThUtZ
         PvvNqck66FQVO8JVR+n2GXGyEbPSQVwjpp72ZRUH0FbYPDKGeK4sm500g9HQjodmbgj1
         dHRUEOTzVCm+uZZT4CMCPgsEhMxCnpuCW25TN8dOm5+nUw70MJyWJVPdscLfXKJWa0ja
         BI4cs4nGOaQj5b6pRlZr6NR+aPL2LYvbbeW7mPAOKCxT5TfVoxow4lkMCZgjQdpPP8WM
         wjfw==
X-Forwarded-Encrypted: i=1; AJvYcCXCC9e7GZ9NgYBUMg+omV4nHVt9hMT2MzxaRyGp/8OLHMqjHa71B2A7jDZkWl1i6Fa02fSowWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxF7inQO+w4yiGo9lYtDmOqeN/YxAVhZlpdQCqT8NY+6ytE9uz
	DS5+jEqv927PtlPZN/2E3RXegJ/NKQgX+A90nMfa42+Fb0Q+J8WQuK//SmhgZ64opnDCSuPgQ3T
	IrLhYEaRJ0VQ+tGof0UjtVx0571VAkQc1XO9vqdg1c4KlUoSJxHuQv/YDj8U=
X-Google-Smtp-Source: AGHT+IErBKB2pIbdmGNVR8AR4U0hYMeSxtxw4hyHrsOw/lklznaPY96fkm/z7eIS8VTf9QqaCcltWUn3zmEkBCYyXHtqlnWZfzg8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:424:553b:f2f5 with SMTP id
 e9e14a558f8ab-42581e17756mr68269305ab.10.1758678576916; Tue, 23 Sep 2025
 18:49:36 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:49:36 -0700
In-Reply-To: <20250924014929.1097959-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d34e30.a70a0220.4f78.0016.GAE@google.com>
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

