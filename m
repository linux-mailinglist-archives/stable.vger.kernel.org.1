Return-Path: <stable+bounces-61284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BFB93B1F6
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F51C2345C
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92266158DA7;
	Wed, 24 Jul 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AYTu7kIy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814B2D030;
	Wed, 24 Jul 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829047; cv=none; b=YOy7eG11sYBypAT1PQz0WcxDrfiuYuEYkYB6lF/nOB0oENc+Aesaq0ZB2nBS7mUUrmhtI1KT9X7VYl9YEUz2ap9dYiUkk6HSOUUZ2eZXhLVP0pgN542MSSTFh6bClOylh92tu5OSDfAzSpbYZ2ykaeIHGtfOPNUYOfCisw1TeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829047; c=relaxed/simple;
	bh=5tYaunI9mHj7AJQXknuwa1odhAFPbxz97YpU4VGHqo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQwiwDyy8P+csZdsOCE5EYDyMDkX5QPuDyZBcChQDYegpsjFG4kFRxkOeMaSQUxBkkMKoYw9/WLpHFbuEgVVQnQFhTViDn1ApmcVpATCpdXCRnd18Iy3Q9AABL12fC7ESZ+DMvaRXFAYWtcP1bpA8HeqTAn7cFtLpFShVYBa9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AYTu7kIy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so6119555a12.3;
        Wed, 24 Jul 2024 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721829044; x=1722433844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1tb/0vlo04/6oUmqi9MW3/tdDuhFSKMBGaNrhUjbNNQ=;
        b=AYTu7kIyjXvaC96HGEsSPhAQ0v3uVzwx+D5kJBVq2SXbxDpkGlc8eg9cNRjVMRelE5
         32pZ02xuibmGNM2IMgNeZJLMs7o4BrJSk7DEyALKYJ/OgOPaFKAyZxRVfnfCVnHehIg9
         pDN4y3pbBOp5MYo+bfhn5tyVUVfMWJIrA6WSH9qIejPgz8cM6eJDFwZn8Xt45XSqY1Ac
         6IdB21qnGLxWSfnFbkC4Yj5Y6srD/XF1iZdYr4Ypxqj5yUwnhrYheFDufpGmgRh6srb6
         7giRFdfUHENxF6CW9Lea3gDdXeiGcBqq1HU4BRzIyeCqC7cxes0oSek3skI733hre+9K
         huVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829044; x=1722433844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tb/0vlo04/6oUmqi9MW3/tdDuhFSKMBGaNrhUjbNNQ=;
        b=f7TNIurz51GOGfY4UAwrLjpnxYEEtDqzdFRsk2DsrUhcfvtUhvjYQ/W68NzG3JNwMV
         qNjhyxoe2gu9LtQN6D2MMq9FYqgZPVnWjA3L5jj2c02ZiOzF2xsc55EmCJL/LmXftKyD
         KasrBWusOqYVUIuDLjEWp4ztZSPIsG8tzYZFgwM1n3kakJSY3Js6laHnrV7zqpqqPT9m
         3FuGSptxr3TVD0655DpML7zOFmZVwyNoQIwNt2AOR+XFI1rtsyIlTwdKMpIFZddeKiFq
         ZPb2tbiZW4zHtdqSVMbqGoRvjh70rLbHm/8i5Ab1wO5cOnCnW2NcYBxO/EPlRzgh0IvZ
         pQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWKVBH/o2ZX9O/azgw/gNjRjXmOdcKmvHwZL1Omug//JhUa0zIeiRPJGQy4wcnfOnRxiqGDneQeR+iTLaLsjI5dem1ZxRXR88wTyEX+eyMuDJ2F/jiwIxmvkAblE2wtwp1zBpLB
X-Gm-Message-State: AOJu0YyL78aEVJ7yzQX65gz4quDAi8k7Ws5XbJY/eYZ4mFzXFY7p6rOb
	ZrK7xhePNMUHMYSDwBBZIm6mHbUTPYJz3mFgEipnNWi9rzUgb3c=
X-Google-Smtp-Source: AGHT+IFF1t3XbbSMwoDx6IknkN6dSpsDw3xplReMpBPmOq6tt+lyAKbMk4Fl1g+1mSBg6rxdmMa8CA==
X-Received: by 2002:a17:907:3fa4:b0:a7a:b3ff:7da7 with SMTP id a640c23a62f3a-a7ab3ff9247mr147136266b.26.1721829043889;
        Wed, 24 Jul 2024 06:50:43 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b1e.dip0.t-ipconnect.de. [91.5.123.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c95200fsm643476166b.225.2024.07.24.06.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 06:50:43 -0700 (PDT)
Message-ID: <08c24d4a-eaf3-48d7-ade1-004a97be982c@googlemail.com>
Date: Wed, 24 Jul 2024 15:50:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 000/163] 6.9.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180143.461739294@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.07.2024 um 20:22 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.11 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

