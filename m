Return-Path: <stable+bounces-194481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECFAC4E1C7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9371344E1E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D766D342506;
	Tue, 11 Nov 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="sXqvJ2hd"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA043370FE
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867819; cv=none; b=lGnY6dfIQwH4hiydmYxlREQrcH7viDLTXG2z8zpfTyD5bFk+zI6bp5zIkP9bqlmNloV3qobRijcqPuhaulAr19KSqCEKpGaXf7v8h6BIGm+ipFwg+uje/MDj2CtXAaBLQPjwo1ksX0G4c64TTkx/JaQE263kvcxTxD0bO25/eSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867819; c=relaxed/simple;
	bh=qDZL6MdNd/KZflfycs2sNvxaMjuSrNaIyMnm/7WrZ8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8cOo+GWgunwVp3s0d3yrO463A+QYJJ6O1zzywMhZJFjT84UM4ScrdtdBmeV3bB8rLqTo607Kz/+W5FNM8WPI03JV9d+cKb2c6E0Qs0VkCY5YBPMUBDRiZLGECjeatiJ0yMVN5eWFQCvP6mC666ZiTRb0XPhgxZNSvgtj9hI81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=sXqvJ2hd; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-43325879139so40998115ab.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 05:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1762867817; x=1763472617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YO/KwJ4FC8gmOpZBF6DOQfsCk0MQT6p2iYft282HbI=;
        b=sXqvJ2hdrrY4jGEbqz4H7pAMGZpIG8Q1EOPl1L+3s2EBVzVVx+5Vw/Unoz28OT6VSn
         RhpPcdLepdmDQBSBbFAfC2plpIJJ+rcO6wgY52EsLblSGwxwRiyFH6gfnprzx1wrLHDq
         az0RslmwxYFc/e+oHS91IJjpAto7nlPBpIBhekhLsbvfqWfDXqAJhkb2Ggmnzr9iCE8k
         aSX/9TtLdUHM8H0bwzMtmJvDi0/gIUU+IqH4Vg2Sfr4Y6vLZtQtRIPsxclZwESH0oIbG
         gWWflJS0ToRjiVUb43HRuFEeeKZ/1hM8oh63w+JR/a5Tpsz3dG23GItK9VsX6gjZDkGi
         mYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867817; x=1763472617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YO/KwJ4FC8gmOpZBF6DOQfsCk0MQT6p2iYft282HbI=;
        b=ppWtVh3TqL4COEaECZ//MKL1oBFWjZhWfeK0flH3AKG3MqdgMfoij9k5IJQks+OC7D
         xh0PgYYGQbLFyIHKXwthDpLgbVrONesznMOe2ciY6aKWV5sMlYvviPKi1m3PTrlQ+DOg
         JvAyXliFlI4T/1hSBVVvDhGVOx+mtWBIL2Kr9Tt8qCh765IqZIQQitWyjbWNWCC0DZqd
         VR69VHpMfjVRiEr7LqanA04H4hTXw2WkFbwlSgy7/WrzGa/HG3dMEdyH9CvzWnII+3CY
         QV72KDaib7r0xcTiXlbgcVYx2jHgiZULwDpetDUqtxUCZQMU0XefjJJO1HBmVUHsinlk
         Wmww==
X-Forwarded-Encrypted: i=1; AJvYcCUwSjzfOeQobIH+VS1qqpVNwa4xFsnKYQdlXqXyiPZx2bceIbaStmtdyfnsRokHE28iq5GE0EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQg7XMokUyTCUV+Lc2//j0DYVUArbUIoZ30irIY/99Q1WpyB3c
	x8VQNO4JSU7sAnY1M50E0xj+85b4CSjkS1IJ0NkRgg4lgeEbgXzCyaIoF/xipgUI7ik=
X-Gm-Gg: ASbGncu83DUUHYWbO2153QcpdUls+Q3PR8Va3ysP31OvDX0djsTqjQaJU6hhxpFxLpk
	HNBKbM2PfPbNoUa2Pi91dqG+12CieB281JG073bIO31NY5s76uN7Z0RA++ZVL2z9sz0oXa6SSqY
	CxPl/ETvTPw35D/v9PzAryYTgzL/gkoASRAn3vMFtpmhUa2H6TVRISzJdvem4zA4lda/vH15MWz
	EY+ske95li2klv2zDv3PP1EK6noYW8vbvsHzCz1Kxs/TKeYxJTOfJjnGnbm0Lc6/SJz+ZtgFzO1
	r7rsSdGsEcZKQseaSpaidWOuFNeSLY0mIlvVLRqwHo0WLVpKE9v3rKVhukvEH85Uj/ue2DHEO9f
	mXanQL1Q7HEfWhCIprIqZ+sLvRwSH7Av6g2F+ielnKZkr3K+S9EJcJRkEfwqmYLx8+tsjcmNU8S
	sqpTbLULSfboXbhXY+BHNR+yCdUw==
X-Google-Smtp-Source: AGHT+IGW7t5Sia4TYMC2RP3zk+pxpMo/Yir0L3mxaMYdOdYqoFxgBtNrF98A/H3TNDJQ3xWRjsTrXA==
X-Received: by 2002:a05:6e02:12e7:b0:434:720d:1c2a with SMTP id e9e14a558f8ab-434720d1e3cmr5300985ab.20.1762867816968;
        Tue, 11 Nov 2025 05:30:16 -0800 (PST)
Received: from [192.168.5.95] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b746923a66sm6246780173.35.2025.11.11.05.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 05:30:16 -0800 (PST)
Message-ID: <f6bd6612-b0ea-46ee-8807-bce12c040b5f@sladewatkins.com>
Date: Tue, 11 Nov 2025 08:30:15 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251111012348.571643096@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/10/2025 8:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.

6.12.58-rc2 built and run on x86_64 test system with no errors or 
regressions:

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

