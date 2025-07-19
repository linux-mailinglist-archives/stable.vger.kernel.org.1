Return-Path: <stable+bounces-163431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F35B0AFE0
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 14:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7631AA1A97
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077B2820DA;
	Sat, 19 Jul 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZbCmvEm"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAB2E3701;
	Sat, 19 Jul 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927979; cv=none; b=OkpFdKgxsBf1ZD4acg+mWqk359ab0cYtTokpicOBn9eFSZ0RzV0bE09mW3ZKHM11qFBw0Nd4rhZ9Sw0BFTuepd9AKf3klejk1dEszlXztx7aJy+HPIo5k+3qWcfJLjBSPcitGyA6D4e3+85brv+l/uSqvljA2q+NhVU0urqW5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927979; c=relaxed/simple;
	bh=krNqVLn8n4xKhjVwpkidSDuvS44saFLsxWfYVLb0zo0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RLPlDN17q6Zf0BvimyD0CHGyCEVdytn9lVQQ6y3xETY9f1b3AW1v4pBCYY159JcdnI4yHUvg+5QLY5sdWRcs/EXclyeOiaCzJkWOI8L6s3NiimHd5IzcTcvSCM2nueUOKroz3KgkV7rUCKWQsRQtOpHtpfVScWBQaE9a8d04W/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZbCmvEm; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b595891d2so22714931fa.2;
        Sat, 19 Jul 2025 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752927976; x=1753532776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVTmbpjrvgsqK+LXFLHUA+OLiijS8nQ9hRmjxh99LXk=;
        b=eZbCmvEmf4bpz4sBOWOh89q1tLXc7d/mm5F+ASdIGHbfkjD6aYT28NVSamD/FtMPQ8
         KE19r1u1FZj6gJQgFWmMXHC7kGcA+xXAU8OkubYs9TvzqTnhOcl0hPJ9gprFnQMIursl
         PMzRJu6aokw+eGyNyCo5fkzNnjTqKCVR7I5yGHcuQhI/NCgtpHhqfbQ7+no+c31BPir3
         wEkmKYBGrYplfUfY1bMqte0oaOChyOzpTckZQkKhN2p9FtjJS0/aUOpRYtfr/bvCaM5V
         0ZSRWhkcQGqQ6912QJP+ADo/kAyQCKN2tyCEPaXbBhs4Rdd6H58bJgjyfUtmv1IqwqnQ
         /ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752927976; x=1753532776;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVTmbpjrvgsqK+LXFLHUA+OLiijS8nQ9hRmjxh99LXk=;
        b=LA4m/f1ueXThU/PWuzWDoOZYfM33ue9nDsoWvxuX1L/Enb0t4wZd48oND4Vcr5yUTC
         NYN6MAUrXRM7GYvUl5qMK4dfd4HMjU9zI+mWNUY7bi1VaU8/0RSg8xh47c5BiUPH1Juu
         Xqts3FyZlaKF0Kh+jBxMmedvxT59l9Ls3mnO2ac17XNOUY2duztqMmQClj9Kg92gZMM+
         ptYRq5gTbyUe3NUu+rBmfD0nOc73zye46YPvrxhSQU1exJFlhAvp2SW92Ls48D7L83XU
         gVIjk1QavjaGWbjvWEM908+VN6gpPRP10x+pWHXryRZ5sqYETP+l13ciWGkrBlUo2blI
         pL8A==
X-Forwarded-Encrypted: i=1; AJvYcCVhRy14exSx+nDzweF82EKfzOFgHCoW4LnWSwLRum21JuVyTeBrju8EEG0c03q92nsr5NtC4AP715l1Ql8=@vger.kernel.org, AJvYcCXx3Lm+LuffHKHGANDwopWvNstvsOLaJgN1qY4jx1FoAdSjzMEVVhDfxpayvZi76gMJXNNNF8M0@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLIW4r8uQi9jY1lZNP1c5ZI1EhLKEi7GT1Q6V21pKqKUQunFi
	EdL19NABYEJYie4smpMoZi+j9WzQRTYfUKoEBM/u/DRUeI9Hz9iHU57j
X-Gm-Gg: ASbGncud6pHm1zlN0XN73YbNA69gP6g8BaMNN8BAZnu+mR8USridQzczO7BqgBsRccF
	p/3dxTyi3PQJvToPNqFFcq/MirskDWLVkSDOBDc6CTS4jzlzvTaz1ZgQqLL0p0U+LHq/X1nu8Wi
	elT9lfvRLjLhnS2QUetIgfpvBQZwS6WmFD8VYFiNpEl7d4SU4loYg+UEW6n2sI0ygaB2Lt2d5oZ
	XrmrwvtbLg+9v2pPgqdaphLpNYgyyl6U33I6gqITnfmzZtToDjEs2FdJkscTIyQR5GYD51/tW5u
	WtpMGmIjkiKPExhDRO/jghycqFkLMNcNGmUupsI7y9+EXszfbbpk+jh1Sc5pyWIRJMVll0C8EVr
	CYs1nYt9sRbn0Wzb5sC/01NTrpaqy9m/hDVrOpl+snKxK0IK2+/zyFk460A==
X-Google-Smtp-Source: AGHT+IEveyhVrEcB+rlD0yOS3BUrqKa0DUT00e6nskBX9SpCXdPppmQZsC1ZsDAW3ghC2R+AOs31Lw==
X-Received: by 2002:a05:651c:b0e:b0:32c:bc69:e921 with SMTP id 38308e7fff4ca-330a7b12523mr19069211fa.9.1752927976152;
        Sat, 19 Jul 2025 05:26:16 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-54-30.bbcust.telenor.se. [85.228.54.30])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91f0607sm6288581fa.92.2025.07.19.05.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 05:26:15 -0700 (PDT)
Message-ID: <fae36efb-be09-8b60-ff84-db6cb38fc18e@outbound.gmail.com>
Date: Sat, 19 Jul 2025 14:26:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH v3] char: xillybus: Fix error handling in
 xillybus_init_chrdev()
To: Ma Ke <make24@iscas.ac.cn>, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250718100815.3404437-1-make24@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <20250718100815.3404437-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2025 12:08, Ma Ke wrote:
> Use cdev_del() instead of direct kobject_put() when cdev_add() fails.
> This aligns with standard kernel practice and maintains consistency
> within the driver's own error paths.
> 

Could you please point at how and why this is "standard kernel 
practice"? In my reply to PATCH v2, I pointed out that indeed, in 
fs/fuse/cuse.c a failure of cdev_add() leads to a call to cdev_del(), 
like you suggested. However, in uio/uio.c the same scenario is handled 
by a call to kobject_put(), exactly as in my driver. So which way is 
"standard"?

There are indeed kernel-global efforts to align code with a certain 
coding style every now and then. Is there any such in relation to this 
issue?

Otherwise, please leave this alone. Playing around with error handling 
flows is a dangerous business, and can lead to vulnerabilities. One 
needs a good reason to do that on code that has been out there for a 
while (four years, in this case).

And now, to the patch itself:

> @@ -157,8 +156,6 @@ int xillybus_init_chrdev(struct device *dev,
>   		device_destroy(&xillybus_class, MKDEV(unit->major,
>   						     i + unit->lowest_minor));
>   
> -	cdev_del(unit->cdev);
> -
>   unregister_chrdev:
>   	unregister_chrdev_region(MKDEV(unit->major, unit->lowest_minor),
>   				 unit->num_nodes);

Why did you do this? It just adds a memory leak, and it's out of the way 
of even trying to fix anything: The only effect this has is that 
cdev_del() isn't called on error situations that occur after cdev_add() 
has been successful. It has nothing to do with the kobject_put() / 
cdev_add() thing, because that case jumps to unregister_chrdev, which is 
after this removal.

I have to say, both the language of the patch description as well as the 
weird removal of cdev_del() remind me of nonsense ChatGPT does when it's 
given tasks related to programming. If you're using AI to suggest 
patches, please stop.

Regards,
    Eli

