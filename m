Return-Path: <stable+bounces-9712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE13824649
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 17:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDACF1C20EBD
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DE250E9;
	Thu,  4 Jan 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="FGndA+ao"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA624B27
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7ba9c26e14aso20360439f.0
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 08:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704385946; x=1704990746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZozTrRnGVXzy31zBAY9Io4KyrsVmk5XpdKMFCKbp5Q=;
        b=FGndA+aoe6WDkgaivOKRHwydkzkusJ8CuvZXYuM5KMprCew/0HZKAHsTxfP7JXLYRM
         FfCvbWbi3xXR5BqM3gdc6WZGBISwuoAip158x+ftCkm64Z9NCbKT6MqCPMSwCzYej+EG
         2RzZ0bHZOqOmBudyeTCWgnD/RkDHyGNdZP0Rpwm+TEfDvCs9p+El9xGlUiitquXlNtvy
         HQ/yTlNnFdo5pRpvoIG1sRBqSFnQRYwc2HwzIwO7KaChSCqaKtxkaoWcaFd0D+LHhccx
         dWpLZ+W5pLuVlaUShb9dcUYge5KF1U7bxcJhG0lETalKMntPslu3WRryXCRdi5A21oG7
         rncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385946; x=1704990746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZozTrRnGVXzy31zBAY9Io4KyrsVmk5XpdKMFCKbp5Q=;
        b=uZbOHIITx8u//IA6VEItp65EpCfFPXXx4YFW4lHjMdGWR/oBzNJ6Bq3GFK8Rd4Q5/g
         t+j5HeRRIc1bC+KmlSwDVDp6z7tvLmtKk2GMSZkb12P4aVEp4npa/C6zii4JZ6CqICOA
         nuA7ftyk3IqbpgsIV5WODQu2S+C2Askrx7GXTd1S+pwBJIX6r0yV32MOiEnkMFaXMLCG
         f5B2JbAX/SoT2+2Dl54osCkCF9smCScGIKDfC9lio1ExVj9S+FYOzFMx5z8qtlIlwhwk
         WWaEDmiZufYjkqaqDGIZ6yIrLedtEBka/LHIxJtQhDkLL4o2Ljpo+X6QVzPvlN5r46B4
         n0ag==
X-Gm-Message-State: AOJu0Yx8xUyxUckZ/1Yfh2DbyGfktgiSPc7ylCnbq7rufIJHn2+TAjMD
	fYBFmDP8GYbaQy6OMtMSBEaH/c7nUlNMRA==
X-Google-Smtp-Source: AGHT+IGfv7ALW3+Jd+SE55tGh732azgppxaH8IixXrfYqjh5vvjsIK9HlVCx+k8e0bLSIH6hQ0rZAQ==
X-Received: by 2002:a6b:e511:0:b0:7ba:7d6a:652c with SMTP id y17-20020a6be511000000b007ba7d6a652cmr543650ioc.3.1704385946492;
        Thu, 04 Jan 2024 08:32:26 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id n21-20020a02a915000000b0046df6a4574dsm212304jam.161.2024.01.04.08.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:32:26 -0800 (PST)
Message-ID: <c7b8d248-fb59-0476-dea8-89d40207460f@landley.net>
Date: Thu, 4 Jan 2024 10:38:53 -0600
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
To: Askar Safin <safinaskar@gmail.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, gregkh@linuxfoundation.org,
 initramfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zohar@linux.ibm.com
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
 <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com>
 <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com>
 <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
 <CAPnZJGAr8BfTHmn3QZnJ6dnVCQsUnUASmdH4tzz0-QMwHmZZLQ@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAPnZJGAr8BfTHmn3QZnJ6dnVCQsUnUASmdH4tzz0-QMwHmZZLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/4/24 00:06, Askar Safin wrote:
> On Sat, Dec 30, 2023 at 8:01 PM Rob Landley <rob@landley.net> wrote:
>> I've been following the initramfs xattr support threads forever:
> 
> Here is my proposal: add to the kernel support for catar (
> https://0pointer.net/blog/casync-a-tool-for-distributing-file-system-images.html
> ) in addition to cpio. catar has the following advantages:

Didn't we just have a thread about the inadvisability of adding more ways to do
the same thing, with each existing codepath still having to be supported forever?

And your solution is a link to the website of Lenart Pottering, author and
maintainer of systemd. You want to put systemd code into the kernel.

> - catar is simple and reproducible. For the same directory tree the
> same bit-precise catar file is generated, which is good for
> cryptographic signatures.

I can trivially reproduce the same cpio each time from the same tree, the trick
is just fetching the whole directory and sorting it before processing (to
squelch hash-impacted readdir() return order from the filesystem).

> As opposed to tar's monstrosity (
> https://www.cyphar.com/blog/post/20190121-ociv2-images-i-tar )
> - catar has support for xattr.

Adding xattr support to my toybox cpio implementation is maybe 10 lines of C, I
assume the other implementations aren't that much more tangled. The question was
always a largely aesthetic issue of file format.

Tar is NOT well-defined. I say this as someone who has IMPLEMENTED tar and has a
pending TODO item to patch up YET ANOTHER funky corner case du jour somebody hit:

https://github.com/landley/toybox/issues/469

Inventing a NEW file format... there are multiple dozens already: zip, arj,
lharc, zoo... You could theoretically extract squashfs into initramfs because
technically it's an archive format.

Good grief, there's an xkcd on that:

https://xkcd.com/927/

> It has support for nearly all types of

"nearly"

Please no.

> metainformation Linux offers (32 bit UIDs, nanosecond timestamps,
> "disable CoW" flag and various other flags, selinux file labels, file
> capabilities, etc). All this metainformation can be disabled if
> needed. So, next time we will want to add some new type of
> metainformation, there will be no need for lengthy discussions about
> how it should be stored.

There's no real need NOW. "We did not come to an agreement in email" does not
mean "let's add a new unrelated format". It means let's carve out an hour to
actually speak to each other, by voice and maybe video, using this thing called
the internet. (Without covid we'd have had a BOF at some conference by now.)

Rob

