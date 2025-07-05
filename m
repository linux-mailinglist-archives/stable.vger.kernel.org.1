Return-Path: <stable+bounces-160244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207C3AF9E41
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 06:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844F84A7AEE
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 04:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C521C8621;
	Sat,  5 Jul 2025 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cL3fQmbe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224717B50F;
	Sat,  5 Jul 2025 04:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751689217; cv=none; b=f5EQN5EtzRi6tC2EQZTKAD2IswvaoZLVG2uNifWSbsSvHiWmrlbqvwnxfWvCHz28YGYsBogS8jKfhJQGPH/VbMRcfqhFN+6eh9xMHdm8MRJBA9E+6f+u7m6ON43mIkN1BAJI0VLDUzSxfenK0Y/SmJ5qbQEGDV0EJ+i41t4qYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751689217; c=relaxed/simple;
	bh=PP2tBK0K+j9zNRE3lMtMvzqQ+gaIJA85DfLOLawjxDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0HTl85py2IdQ8aRA+tA0plXWyJMq1+aQoxWX813Pktj6SaSPptvK+o6bQ8YPO+ygxcksLBFBFWwTnzZPMSu7+c6H5b/6XUjzxonsAz85Jr0C9TsCsImHbnvNZTZp03xUJo0mag8f/215E1UEM8/7FRuX4xS0mexjt1k7i7ZgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cL3fQmbe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so10864905e9.0;
        Fri, 04 Jul 2025 21:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751689212; x=1752294012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QX5ca/XQ9bTQip0jvg8XOVXm9dQiuDFX8AvyvylwPg=;
        b=cL3fQmbeu9geNmjlc1zOpFBjhhdACjqztq8CdH5tPJL/2zoSR+XETNFF0jOfR331v/
         hPnA0HmLqjFnAUClaQzr9UzjbEmV2go/Ya4g+odpEG8iDQil6vsUFFLi8wMvYL9Aorkr
         TX9Ui91h7PoclHwrrld4pluyPJjTeItw/J8145EMqdVF2GfqLMXA5RXrXEefJhI3yumF
         ylk8zyeuojzOywqX1Vgnf+lIhc2Wo7WrYkUfx/fpmUMHss1eba/znjcLOZx4cfBgaYzg
         Ut71SF4yVcwzPVv3mbzHMP6KhUEZWUKyoP3VOi/HJGfjFOAr+KIqnQRHWnyG+mEWBuNE
         fgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751689212; x=1752294012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QX5ca/XQ9bTQip0jvg8XOVXm9dQiuDFX8AvyvylwPg=;
        b=fEAlPqEVMU/koF5dy8kEuVNXJkifH4Wag9Ypq+zhZpq9Nxzs0i63n30ysTP0E4peMe
         EK/f2F7GDoexaFJeXfWXVMN5Pow7Wrc6O0JhMWlPxTLUclfrwp8nkBthA9a0hZX/vQ02
         qGkl4u6fdlYFu5+xDUXJjxVsMAW9s2hKrFOpstjcoRnOim/kvrsEhnhnrJC2WO/TUBLS
         3mhTMlVd/P4ahTrtRO7Z9SzOzEconoD24wdmD2HHo00xlCvq9k2oppyl0QxBYBx+Ki2x
         poxkENYHKUlaMrdgPZeF63/vr9VVnL5DtsrQkZ+2TkWIcVZyyzCE31VPKpo2Amv14gk7
         Os/w==
X-Forwarded-Encrypted: i=1; AJvYcCV0GiyA6/tz2O/IUgd/R3Y8MghsmrhrVBXflJS8zS3Xha5Pc51mWgSy30bi5cNr/85DLd3rMVGu@vger.kernel.org, AJvYcCX9Z0x2ntl0A24TBptpyaz+yAUtA5PBtbBtdCSwH8BPzixdN6uOwHpl1NkIaUb19B0AU17F8/twXgHxYfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqcrTF1CWbe0+Y7ea6z7Ajq5QV5zud1jd46jB+O+AXKBEqUzt
	u2c4VJnuu9LUSdLFC/PzDVWbPymj/4BTHfoyVSh/SnA+KlPPvhSqkjs=
X-Gm-Gg: ASbGncuUj08CgNPeTDm/dPej3GvOcO+cvzYNaeKKhwKgPsayS2pn/At+SBXMIONXvqP
	CEqhDF7o8uWdJpFqZlBPTZFheZornjzTGzspC7eeCyJ4nhRB5aFFPL9ONLqCQxNLBLtBD1E1jIu
	KWRK8jyywx3K70GQ08zjDYi/xjtlzH0y78R0UovBSrxAYHl1tAuiKF16BR0Q7oFsOSEm2ox8und
	3a/45JdQmEn6tDe3SWSk9GuWZQtDCIqgzlpbqdVX1tsaXwAXYAlc6XtGjBRls6qHYbm7VRjPwrq
	dUVbert8orP11nwtg4kddDYfPia47cvb85zF7+XW1sZR9USeo+r8HmdidDLhzB9RtaawclYnJgG
	7Z0eJRNzfYdaDOtDPbxI7JjOMugcpvslxQ+xuuLQ=
X-Google-Smtp-Source: AGHT+IGq05/HzqDo83u3mYS0XfXV4K75ereAbVKbsQQVAGhWGSGG68sBKWSKgTF80QzAXxQ6JMiXzA==
X-Received: by 2002:a05:6000:481b:b0:3a5:8d0b:600c with SMTP id ffacd0b85a97d-3b49aa0e7d6mr505729f8f.3.1751689212270;
        Fri, 04 Jul 2025 21:20:12 -0700 (PDT)
Received: from [192.168.1.3] (p5b0570c7.dip0.t-ipconnect.de. [91.5.112.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba77sm4085736f8f.17.2025.07.04.21.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 21:20:11 -0700 (PDT)
Message-ID: <e4d40799-f59a-4d3a-b103-6c3e6f330238@googlemail.com>
Date: Sat, 5 Jul 2025 06:20:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250704125604.759558342@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250704125604.759558342@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.07.2025 um 16:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
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

