Return-Path: <stable+bounces-8233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C481B250
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 10:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A363A1C21FFC
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069C39858;
	Thu, 21 Dec 2023 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="aaaqOUWg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85944B5B3
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2041e117abaso363473fac.0
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 01:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1703150681; x=1703755481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrFYVKMKAls73y7tPJ/0eD7g7DzKwCrOBW20HJX//Lk=;
        b=aaaqOUWgquzhDNerPKun3uJ6K6SBNcVh4rgw25Yz6vkv3Rvl4JcfMSUYEJ4vHclqAU
         jp0z9Vp01B7ck3imhGJdoDpnV7eiW8+t8hVp2SJfXCzukODYuSsd+thD13ZiJmQ7H+Fg
         wXro0Ir7ZO8uAEEwx/FcptkSZAhWHy5HyV7xj3/w7uuqRXsEcvOZHEFb2qg1wd1NJ03a
         TT4hjKNDY8e/CE2r3cB6jrs0+49mKY1txJRA6IwyyUzGjQsjQrKGtTd+1fzmX/0oPhvS
         KRRmIjiyOxOchdSE48/Dx800Lsmx9l6Xguw21vDT201yIlZAwEKBhbIRzJS45xCgxTk1
         Qe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150681; x=1703755481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrFYVKMKAls73y7tPJ/0eD7g7DzKwCrOBW20HJX//Lk=;
        b=B/57kzhyX0YNhDe1gnoddi6vf1PoeULI6drRnqbi3ibwqBe66ieJKjrncPLjT7f89O
         2Gzw5iv2YLTVAQNeAm//owp+ateENE8B86IsewrKp7SEpPea4XzpXtp8v3cAxcbez8X3
         0T91O/Oxla9MmRrrVcZy2pFXfRXDHc6hYU53XzhTnUyf3TwIpCUX+E4y8h8D3uhOpNR7
         6kNoYfbLKfPTNOV+evKKtmJ8wE+RWZRox/SXDucczHW7BCrOG2eiuQ2sxVDj6Xg1SvQj
         4VBONPfhY30YWnXNNc5gfEpNb7esLkSOL1NmiydVTVfZjTugmK73EChCFqjEGkeTPfez
         rbsw==
X-Gm-Message-State: AOJu0Yx2XadtAwMU4j+v7p1Jgym4r6ZuhGMvkCUVIbutvRAnRKUzkJCE
	JlRx00MwbY0kxDwqfIF1ySgz3A==
X-Google-Smtp-Source: AGHT+IG/e7v/4yjyw7iqrmWPlhi6xdNZWnDQpy4LNKo26D8VVfTnVvifn6J0+295mAbJcFvWyBA5sQ==
X-Received: by 2002:a05:6870:55cb:b0:204:bd5:4b26 with SMTP id qk11-20020a05687055cb00b002040bd54b26mr956962oac.112.1703150680677;
        Thu, 21 Dec 2023 01:24:40 -0800 (PST)
Received: from ?IPV6:2607:fb90:e600:87e2:3ea9:f4ff:fe4b:aee8? ([2607:fb90:e600:87e2:3ea9:f4ff:fe4b:aee8])
        by smtp.gmail.com with ESMTPSA id hi27-20020a056870c99b00b001fa39dfef88sm376079oab.37.2023.12.21.01.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 01:24:39 -0800 (PST)
Message-ID: <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
Date: Thu, 21 Dec 2023 03:30:37 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
Content-Language: en-US
To: Askar Safin <safinaskar@gmail.com>, stefanb@linux.ibm.com
Cc: gregkh@linuxfoundation.org, initramfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, zohar@linux.ibm.com
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/23 20:19, Askar Safin wrote:
> On Sun, Nov 19, 2023 at 08:12:48PM -0500, Stefan Berger wrote:
>> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
>>
>>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>>   line.

I wrote that around 2005.

>> This currently does not work when root= is provided since then
>> saved_root_name contains a string and rootfstype= is ignored.

I wrote the code to populate a tmpfs from initramfs in 2013 (8 years later),
because nobody else had bothered to, and I've had a patch to fix the rootfstype=
issue for years, but I long ago lost my touch with linux-kernel proctology:

https://lkml.iu.edu/hypermail/linux/kernel/2302.2/05601.html

Last I heard it was going upstream via somebody else (who tripled the size of
the fix for no obvious reason, but that's modern linux-kernel for you), but I
lost track after the guy who'd said to send it to him instead did multiple
automated bounces from a bot that said "to save this one special guy's time,
we're going to spam linux-kernel with autogenerated content delivered to tens of
thousands of plebian mailboxes":

https://lkml.iu.edu/hypermail/linux/kernel/2311.1/05544.html
https://lkml.iu.edu/hypermail/linux/kernel/2311.1/06448.html

Last I saw the rewrite of the fix had been resubmitted to the Special Guy a
fourth time:

https://lkml.iu.edu/hypermail/linux/kernel/2311.2/02938.html

Maybe it'll show up in a git pull someday? Who knows...

> Therefore,
>> ramfs is currently always chosen when root= is provided.
> 
> Maybe it is a good idea to just fully remove ramfs?

"Let's delete a 20 year old filesystem that's been built into every system that
whole time, this can't POSSIBLY have any side effects."

We've already discussed this, more than once:

https://lkml.iu.edu/hypermail/linux/kernel/2311.0/00435.html

Can you build tmpfs on a nommu system? Last I checked the plumbing expects swap,
but it's been a while...

> initramfs will
> always be tmpfs. And tmpfs will always be enabled.
> 
> As well as I understand, ramfs was originally introduced, because
> tmpfs seemed too big.

No, ramfs came first, tmpfs was created later. Not just what initramfs uses, but
the order in which the filesystems were written.

I believe modern ramfs more or less dates to Al Viro factoring out "libfs":

https://lwn.net/Articles/57369/

Although the memory grows a bit hazy. (I vaguely remember what happened, but
exactly when it was, and what came before what... git log in my unified history
tree is showing fs/ramfs originating from 2.3.99pre4 in 2000 but it may be
confused by a rename. I remember somebody, I thought Linus, saying that ramfs
was an example user of the libfs code...)

> Here are my configs (x86_64). Just enough to run busybox in "qemu -serial stdio"

Back when I maintained busybox there were people in that space who cared about
14k, and that's not measuring runtime overhead.

There was a lovely ELC talk in 2015 about booting Linux in 256 kilobytes of SRAM
(everything else being XIP out of ROM-alikes), but alas the entire year's videos
got wiped by the Linux Foundation. The PDF is still online though:

https://elinux.org/images/9/90/Linux_for_Microcontrollers-_From_Marginal_to_Mainstream.pdf

Alas, XIP got replaced with DAX which I've never managed to get to work...

Rob

