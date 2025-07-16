Return-Path: <stable+bounces-163186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7692B07B9B
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721F64A7545
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB712F5499;
	Wed, 16 Jul 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M145wDwD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A72F5C20;
	Wed, 16 Jul 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685160; cv=none; b=Nm9eyhPvH0oJME/WJSlpKVUBRy5inXafdPhXs7D/yakoFpwkIhb2ZGCzycyu+UiqCD7GvdAFRZxUn2SiwwMKM1zBjz6UQRhm9dgMZA8vSRHBN+D28ElABT+ZpscVMnjleT++fgWmsWAO3GQg/ah7K1Vpcdnkg6wqoP68D4iru3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685160; c=relaxed/simple;
	bh=bgGIt5uwKo+8SRhGnRNrziln2a/zjnugSuIhacb/y3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4OSVrTwBvMD2bTkeTZP+wuRlXzHGh1feXQuq3nNqkcNz0Ziungbeh3duqrXh2ltnxtMAH4alOoWB0RSzgZWL7xyhYvLgzpCbS6Y7Cwt326g6d2Stwa/p8jyTErmNf0iCgEBY0hYV5VBbOVQ0orziykCinUfgvzVlviENRNNp70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M145wDwD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561607166aso449695e9.2;
        Wed, 16 Jul 2025 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752685153; x=1753289953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCi+0zlUCZ4Yn1DhG0pTHwDWnxFzOiBeKQ3YUvqQbIo=;
        b=M145wDwD7BU1nFDMevRRTpIR41TNWBVd/4FtD8bZDqB9jqaiV+VWfcwxDmcAO23Znu
         aAL3Zu3GrjDg/Ei6RCzXjdolqFgD7uNdfZAsnCQgkPiY42mzi4V3D9Zj50nV309b2mrY
         TxCAaEgQHV7ctCuoPoEMmG69vm0fG49EMfN+50O0RnGkJ2+OfehYK+dPnQvdu/oTfI5k
         XBLHMjKJz8x7kGXkAoX0BOPqYWWH8oM+JJqcYLysbWtDc/hQZUoq8CDvGzlUl2OjZ+I3
         cxRuZ63joJ/d+D0un1yUqjfEb8hdXoDdZJHcPudHwDvVy9XWiSPvRyQTLSQsBDqlKlEH
         H8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752685153; x=1753289953;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCi+0zlUCZ4Yn1DhG0pTHwDWnxFzOiBeKQ3YUvqQbIo=;
        b=YIsKwbEjcsxJotmXUbw0nCEg37wWXOHPBUZiRHwfgbIUNnXj67YgPw3isNbSv6zDFL
         3QnF88+RRqPURPmD3+6YZNQ1BqBS0MR5XS0PuUFgXp8b5cf8E6xf95kQCCOoU17h1Y1e
         qSTX2lrC7G86V9Z1nA9uVuDVaVav0SiTyfs4UhUA/1Lu3O04ZOOSEJS3Jiq+YCpIovPN
         4dUyLsHgdHJnZocoVdUtWwEyaKQoP5PEr3ui1KwmPNn+JtNUp2MSDg7nCA7YOEjaUbCZ
         a6m4KBXncKZ1usqbKFLoity4dRO8QjBoZbByoeLKoqSJZvpnw14705nEDCDPCuEuxKt8
         ZOlA==
X-Forwarded-Encrypted: i=1; AJvYcCUxm78cxEwRz2ASf9Q157tN25X+4lm9zLpPnpwL8YoPNddEOy8Z9dQ/j42RtXooYA8IVXSDEZfs@vger.kernel.org, AJvYcCVFrAp8P32yKXTTTkHYxPJcfCW2cFsOwOcG8W8d3qvzO3rIaNLZNQi7qjM/rjkTmrhLv3CxEbAxs7wV3/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzgD4iGzLk6AFO48QOjtI7Jx7J0AF2hJdvtcvGMMHVqR0MqNOQ
	xPyyHXZhwfmCbZ79DqRWYjEsZ9mVp12za2mf9CdCj+HWUDhEKecYWfU=
X-Gm-Gg: ASbGncsTza4jzeTCUJ9Flxj9/n8C8Z//Mi67uaatsh1KdQ77sk1eHKClrywIfnx91BN
	9ZVe873PrVtCMPSXvtDQzj728hY4y3MCPwAwF3aY5GACmHWfYqp+PXmQzfhvPtT3LyjeFYh4fXn
	JMYNeT4avU+Yk0JtWHcuNv5aonM5pzwrFsMtyIYFSovv0x7u27OVePjZ/M399EU47ac7w/nWd5L
	g29n0CfScjBZtKbc3/IpXLfwLx96vXQspMk79ddcJ/6j7j3MBl5DFss4Agr7fa5D4XAEGv9eWt2
	Ngqhhip1XApTIXdAfFYqcm+T++lTJamo6fUvHCAyYlg+oRvBXe+q20mnsCsd5yqhje+oxp0iICH
	RHWCkJV0sa2Aky/yNNzdKVszEz7iLJ0IpfACyyQkjHEYb5DlDRj/seX08wtzQK1/zhdJqzlQmLN
	Wu
X-Google-Smtp-Source: AGHT+IH2fN99teaziIOWHGK7VxDqMgJou22bqD2enEg/CDdFsFnuRU01K01zYdPKcgsMarOaEboTeg==
X-Received: by 2002:a05:6000:4805:b0:3a5:2182:bd17 with SMTP id ffacd0b85a97d-3b60dd6dc38mr2826716f8f.19.1752685153173;
        Wed, 16 Jul 2025 09:59:13 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac571.dip0.t-ipconnect.de. [91.42.197.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm18577119f8f.60.2025.07.16.09.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:59:12 -0700 (PDT)
Message-ID: <04620255-73f0-4bf8-b7fe-4419e01b4022@googlemail.com>
Date: Wed, 16 Jul 2025 18:59:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715130814.854109770@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.07.2025 um 15:11 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
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

