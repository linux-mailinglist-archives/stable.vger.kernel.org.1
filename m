Return-Path: <stable+bounces-163127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FE6B074FB
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EE11AA71A3
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36435288C02;
	Wed, 16 Jul 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9v9Ybns"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2920110B;
	Wed, 16 Jul 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666372; cv=none; b=DfrfEZBps0DEqT3WcknVMQRUHEJcwUZ7rYHzI8nYkTv0g5HERBcKYH0jMZNTSlb4kT7KLVQEz2xNbMJ8IZmeMeUBULLYhZtItaOtr36tMdq8oKw00ooG2BOeQfcbuSnRPolSTJ1nfkTbDkKawm6qaN8mcE8pKjskP3IgNBFNn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666372; c=relaxed/simple;
	bh=NXanfPZpH2ceGudSk2SUYSm9HbVf2NruYNTN6drDoyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJ13waeDax78FqcYr84IIkvVYmMMrwDTuahLH3SOLZg+4u36TyB+PdgNQrPH2AaajZKj3Z9kIGAEzmlUmWGyGDukq3uf49fjvg4fc9GZ6i9Hf2VLnoHguHjXDtf+q8tAGv2eeHHBWihoIxy84JR8OWqnSYkiNLT1tOjwjbEqNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9v9Ybns; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-454ac069223so5752005e9.1;
        Wed, 16 Jul 2025 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752666369; x=1753271169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRK0uTRJWMXudiGrHPLDeir9C8aaiiInPobNXttZUgA=;
        b=Q9v9Ybnsh5pwDLyXr6+8URc/Cpn7f/FwoByU+hjXXm3CGlLJ4W15XHUSJ3Tt4paYP4
         sY3kajQFRDnOYJ3kGFVwoy6q8Kylb+hd+zSb+58MaGIm/M3iper+9dE49tKaI7skh9xe
         8N5ivx0PT87HUYOHthlRXgDzQ/A/kASeT3uPZ4/V8VTwab1vk1zfCxwt/PZdCgEfY56T
         kxCZtTWnOyTOs4WrbjimmKpLM84nCQ7YES5dEbaT6ufnvvTjUPi0Hl6CydEpzQsBLTue
         vU3ZilugujblXXclZHlme2aiHOfT/v8UmV3hvwy4iqRAAoN0IDu8C/Rqkl1bDDTcysRW
         odqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666369; x=1753271169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRK0uTRJWMXudiGrHPLDeir9C8aaiiInPobNXttZUgA=;
        b=h0TuDSkrui9RmfciqlwlboBK901By9VHtiVCbWNwXSGTKU77ZaFpAHZ4z87akrJhFb
         KqzlbdEe6fI7mVWoQCy/cunhI0ZJapHMC45w4WzYHTiOq2JHELoXIAEmzVgAC2FYwbCL
         htWV8KybyqfRQ8BCeWTgJktAqbMHh5y1q/MaaMBipQ59tVG770UtqUFjQgAR/S7vnUuz
         lWCJm8joYxyA6TEeoQ8BiFWEoVPvvgYCqywn0Eb/9lxBePCQex0vbwDt+6IZ/shdFggh
         n5CFmrv0geV/YfolRWFBuDj/MZPldLstnrDbrE9cJRLeFnk4lALdOn++IIFQaxc5WKoJ
         YiSA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Viy3eaK74nDDv4y8DCUWyvA9+f8wPdg6hjb4hAiLyXVoEACncn3Hnzj600FXEUMoIG0oq7xu@vger.kernel.org, AJvYcCX8vsYKzMJ8HCLibaZgwpC23H3sW99ExlL9NZE3RckJX0puTpannckQyBRZ6/78AxFI5t+DHOVEz31zU/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hLnObNL4s5kTYGH5V2W7V/Dqy6pqnWp045txuEg6ato9CGJp
	fwAHRk9zsFNUGFp8SMLS+N7WbhFuw8hzh59QGHhRIXblu59a/TQvCNN9
X-Gm-Gg: ASbGncu0qI7zkvQpbgQC+4jyY2PjZUE2hvhzl7TzdRzBxCEMi/opcwafZyTT9v21RX7
	Sl2Vu7ycPqHJbUdjDAY9+ft89MnTcFQrAtdQs3qqrTsM41r6hkmX4MLhU/s/CkTwhvG0DbSoUT1
	AmLYVVmMauPfH6f7nc0FBTl1tINsEQh9GcOqiB68zmZf8UrdO0dj7djh865+MWvE22JeE0z+Mu+
	ZTsMrSm21Mj7wA9odnlpsw4tLva4hbAnsob0MRy58hyl6aRjetALShkTf/jgJLv5WTNk3Ga0XAP
	4A8Yl3nFBgGc1FUXQN0b76aUUjgKF1iHtvFX5XxKUliyImU+yZyDdidKr/hl0D/6ReI+YuwJ7xn
	nQOdP8mvWdCLLsDvd07qEIQZVZIMBJYt36enaCVIm9Bj/No9xXvvm1TV70rzl
X-Google-Smtp-Source: AGHT+IGe9mrawVK8DME5xTxzobrY4snOPO/udcok/amD5IGmZSO+Gh8mRnJF9n9m5I8NmSps33RJrQ==
X-Received: by 2002:a05:6000:144a:b0:3b5:e077:af52 with SMTP id ffacd0b85a97d-3b60dd7a1efmr2532215f8f.25.1752666368419;
        Wed, 16 Jul 2025 04:46:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26938sm17491288f8f.89.2025.07.16.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:46:08 -0700 (PDT)
Date: Wed, 16 Jul 2025 12:46:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: sashal@kernel.org, linux-kernel@vger.kernel.org, frederic@kernel.org,
 david@redhat.com, viro@zeniv.linux.org.uk, paulmck@kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH] kernel/fork: Increase minimum number of allowed threads
Message-ID: <20250716124607.50fc5e34@pumpkin>
In-Reply-To: <0e855c4f-2ff9-4007-854a-20955dec052b@hauke-m.de>
References: <20250711230348.213841-1-hauke@hauke-m.de>
	<0e855c4f-2ff9-4007-854a-20955dec052b@hauke-m.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 01:06:07 +0200
Hauke Mehrtens <hauke@hauke-m.de> wrote:

> On 7/12/25 01:03, Hauke Mehrtens wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>  
> 
> Sorry this has the wrong from tag, will send a new patch.
> 
> Hauke>
> > A modern Linux system creates much more than 20 threads at bootup.
> > When I booted up OpenWrt in qemu the system sometimes failed to boot up
> > when it wanted to create the 419th thread. The VM had 128MB RAM and the
> > calculation in set_max_threads() calculated that max_threads should be
> > set to 419. When the system booted up it tried to notify the user space
> > about every device it created because CONFIG_UEVENT_HELPER was set and
> > used. I counted 1299 calles to call_usermodehelper_setup(), all of
> > them try to create a new thread and call the userspace hotplug script in
> > it.
> > 
> > This fixes bootup of Linux on systems with low memory.

I bet it doesn't - it is likely to fail somewhere else instead.
While 20 is probably too low, the real issue seems to be that
the hotplug notifications need rate limiting.

	David

> > 
> > I saw the problem with qemu 10.0.2 using these commands:
> > qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> > ---
> >   kernel/fork.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 7966c9a1c163..388299525f3c 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -115,7 +115,7 @@
> >   /*
> >    * Minimum number of threads to boot the kernel
> >    */
> > -#define MIN_THREADS 20
> > +#define MIN_THREADS 600
> >   
> >   /*
> >    * Maximum number of threads  
> 
> 


