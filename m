Return-Path: <stable+bounces-118273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40902A3BFDD
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED801721BA
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4091EB5FA;
	Wed, 19 Feb 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J32hv/4b"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393641EB1BE;
	Wed, 19 Feb 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971516; cv=none; b=h0bC7XY8/nlEH5yRAGJ14AUsv+mO+E5/Dq3Htn+h0JKend//D96jbMdQAxkwxFCg7Q0SsCZcc9n+O4U6oLAJgEbH91DhxW0wxTeMuMRiGMhbuOM9h0bR516W1dM0C1R9rGsii8OVIuAf6SJUEdfTgyoIx8nIoWVjkflZGyl6ib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971516; c=relaxed/simple;
	bh=HwBLCKNmVxXse7RXAauNSA899MHmbY1+j3D37eiFYfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bf5mY0KGDY4A0Up1q7APdrU2mZ0GwlZEr2Q66IO05uar7bTWkn3Qx/4+mIrYyvBanx3hTxOu7FfIBXSXRDaEQFrv4B67WcbDrTp2jP+NVMo4BToPc/4AhcDl3Tk6RInZKThV1Yk/KYbg5v4QCkxeEV5TV7Gb76B+RdaN5dSMLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=J32hv/4b; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f403edb4eso1890503f8f.3;
        Wed, 19 Feb 2025 05:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739971512; x=1740576312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6cw3ZSdEjrvAZgRmXEizqKICNgRIdZIQG+x2ExmABY=;
        b=J32hv/4bu1G6itdFmdMDRBj9Hv0dQdGJFPKOcukY+H/jupiWnOqS44lhLbYg53R3sZ
         YHk/QvKH7HXDkKRIwri6WHiugrWmq1NWkl5hykZoaG7BH6ck3ZF/z1HLTvr1g4Mr/jbS
         fOAQgnXZndqOcO+fe5jxGQm6GV4HRZrU0iOp9t6oWZmiiaqYhSskiHP8G/EirlP16TXQ
         LTy0rUEvfz4TXIqg4pJuoc0EG2ti5DSvIdFvbp/RPM+Lattkd/yoZJYeN8hthKwX1r13
         icxvYwhf1B3z243DDSYu6I+wFi0AvWyfNl1ZuGNcbgWmXjkEmMR4IPIOjFuLVGj45fLf
         NV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971512; x=1740576312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6cw3ZSdEjrvAZgRmXEizqKICNgRIdZIQG+x2ExmABY=;
        b=mvWLprj+l9U3bs2SyVY/9rm6SEzV+YWg9nIKpCqiJk/eR4ZeqZMfccnyjhpeCQsbpQ
         UUK+XLcGDcubnwSFnmPd/+TP4XWx2apFEB+22kQmlOIiORQjBjGxqYBgIIRFFXOmh4Xd
         1HkYvZr3h1NJD0dtUfFys2404qMKGtfDpV1bUvi1jrea/sx9Ktl1IgFUIK0M039kpaOd
         oLP+3EYiHuS4XsO/e/WsWkqTfVlmiQRwmLWGcLKGaKeLKbqDbSasyJVcgI2gqvsF6NLG
         3G3RHYpqeYMjOvpM6IVVUI8Gw4DUUjKOPRJQLOYl94sEdna46cO0lPrzaFMr5XxBLb2r
         jhzg==
X-Forwarded-Encrypted: i=1; AJvYcCXVxs504+JAVlL5FJs7RTPb03a3RTGwKL9z+brPVag9GrrGzLABoW4Fd6+Pm3Leut/yRsJzmN1L3Qq9W28=@vger.kernel.org, AJvYcCXYC5iblka6cScI4T7yfddg00O2Ef45rFUgiYDIzt0StY2RdIrZ6B5Z3US6jZOsUfEnjUqp1ACg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3K857+/cp2JyZN0DwsFlTaptJk74vx2Xm037kRcAb3SYbKxA
	vKGWf+EJBi5RDIy8vDn2AD3WXj2HTvhxJgmDy3WFCypcuDiyrqs=
X-Gm-Gg: ASbGnctwS0Ejyea/kMINtPF1HyNRQ5DS9tpv8gJ4Ac2Sg+1xR2aVsLDC1uAsAffj04f
	8eVWjsMb15MrwXaO6Mwz80s6d4WoP8yeCoCyPeRyd5xalYgkFRUsG+2IWAZkDeZ/sBhd9mAc//h
	PLAbTzrenZEALmJLIsepei3JMUjXeNuAYhDTN5ySXCpsPJtsp8nLi0iEXQxGTSrVoj1NUbjb6G1
	9eeikDoPNhF4A+TsAy3tLYnzjjGvk5SBsBoEPHSBR7mIFVUUII0+U1TtxBYTblpd8C3zE/VErtx
	O+fO+mF3gyiz2u/msJ4XecNAgrsn27kOU46QlpGKrQgqWqNbJHsPbu3MIP0AFsZ/YS4l
X-Google-Smtp-Source: AGHT+IGXrBbi/q1hJgvU5//RS17OQnmiXYoQ0w34hBPh40gPj5gwJOlB2kw6ykpMs6G7ieCkm9Fk8A==
X-Received: by 2002:a05:6000:1a8d:b0:38f:429d:7c62 with SMTP id ffacd0b85a97d-38f42acc40bmr11028735f8f.42.1739971512265;
        Wed, 19 Feb 2025 05:25:12 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4e7c.dip0.t-ipconnect.de. [91.43.78.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439922141a5sm58151465e9.2.2025.02.19.05.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 05:25:11 -0800 (PST)
Message-ID: <fffcae15-8cc9-4943-9021-06be5fd46e6e@googlemail.com>
Date: Wed, 19 Feb 2025 14:25:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/230] 6.12.16-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250219082601.683263930@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.02.2025 um 09:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 230 patches in this series, all will be posted as a response
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

