Return-Path: <stable+bounces-136455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7850EA995CA
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD26D7AFADF
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75889288CBC;
	Wed, 23 Apr 2025 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KvGH/8va"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6328468D;
	Wed, 23 Apr 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427181; cv=none; b=FwrHQhC0myZPr6lnjTuGkPR6l/nNNCZdurNG56J0dGph+SEpM4iZzK0BGVoJqlDJbxK3vzweK1z2smPYDB1c61sX5yT3tCU8yPRW1TpyKm4p3qA5RWLbLcAAc8M5VeI2PD9XHex0lSWn0S0HunI//jJqKJON7R/qbZ6Wd7iBlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427181; c=relaxed/simple;
	bh=m1JW6JCpT5K62iypPeyrD5Xxw8L3gfy6sXHK50Nf0JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JB7L9a98K2mQZKb036JLKu9QX0MsdZOMlPussG7ymedN1INZB3asmcg5j3a+hhS+RtMlcEq8hna/je8heYXo2PvsZt6LeS/eRog25O0qJ7IOlMUfU6oPbu9AD1jsAPQMJsO+oNP0SNTiT3K8ChYFRO3yJVhBTxHLGrCPoSJblAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KvGH/8va; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so22269f8f.3;
        Wed, 23 Apr 2025 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745427178; x=1746031978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp1u/sIDVPqsXQLkzZlVGoz0PRI6pxyHbfKJBelf6DE=;
        b=KvGH/8vaoZZnZhO3Xy18rV/VQ9XTbSUtq+j7bmRUE0FqWtRe5RIyBxL79S+zIS2mSr
         3f65XqcHP/7L7xZH9k2J/Q6yy3AOtoXQ2WYlAA2rt5zCflFMLAhS1+lOpg6r+1Z5rwi9
         +Zph8IqbC1hlA0PKAtC8IOQ3B2L+oCrD7tOBmPycLhIx+8Zm4KjqeqXVGUJfMqHPW12V
         mq21bggu1xd6fVala14bL8GD4wSdDoVTAnf4FsXg3X3zIapB+aoZRcfIMgVAd8/MU/6/
         OL86v6hKCrpywtw/yXTG5ZpM52SjTSv+nGVN6S5iH/ILq1rhrPmiEtVYotFJwcRqUSxb
         bIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427178; x=1746031978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp1u/sIDVPqsXQLkzZlVGoz0PRI6pxyHbfKJBelf6DE=;
        b=ZJcLN/9UigaNQpvMJtYN2k+ufArCHxb67G27NeXC0+9Q+gr14jSF+HAlX89RcAiwSB
         NZ8+4fSN9GklsG06yPdI0gTPAjIfUBpPM3Yy42rH+QcFzPnFO5akMS0mJFvvQE3iGmff
         8dQAh3GXQHfpxpU9Q/nUNQJe0fo6YQpb2rS1g10ZoB4Z7OA1++HHOwOBQwxwDcNv1EaZ
         A4KbjwxJ5PfxmylozqC53ayAIkZY27QXKGKl5cuiFpI7LyvQyy8FREVDNDuDJg4pPlZj
         wfdjXeyKRiM/iH4/8V6UhAp01sKJ9N+aFe/HuuBp3W34SEnX7AsKt3qm+R2JYnYIl8Yl
         9J0w==
X-Forwarded-Encrypted: i=1; AJvYcCU/WEfJ2b9BinnIJv0eufcD62W5/dCI1HnMaY34YVhcfhNUGXn3gXmVF9+tAJ7fRFtuCB0RVQYku6ci//I=@vger.kernel.org, AJvYcCXG7WYT4QTDtI4r7NbbGFPROnQoATE++WGXyOpSMc824puI9oVmLJhwU9/XCjSiOgU2gcxBT5vY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt407PMhAfIbd03jAkl/IPiK6XhwpO46XNoBOAN3GZEQkXLNxB
	j61/Ejdos5gXCqfklj5PO2i43kDX0TzEpLwOHzICKNA2Mbt5J5M=
X-Gm-Gg: ASbGncs92NnCULCl76tONrCLDFAEMGoiKiPimPp8sRrO1RRyBddzVYRMAQ9ahjFYYLd
	6TMHIeK+1T5hPreW5zMFhabUCeiZjq7a7VCz12AxYzRUpr3AectZHMZsf3mDGjfYmO676K8f4Yq
	etg32DzK2hz8TrSeDbIis43vtDF96XAC96kC6LcbbXQGk6r4XhRL70H2budFzqX0nHajwVo4xk5
	lQcQtiw64+7k5hykO4KCwOvs2TWKCBkNrF2aM9NOVJDHSHGXZfFSots235gOwg9EkQ1SnJr44ML
	uXUU+xt6mi6JOImnQHohbiuaFVQsVg1junrpwmZvX3O67wl6eCL6T+blLDZ4lhd/1wKfd0V+tGt
	fN5inX7ZUJXk6NYdnfw==
X-Google-Smtp-Source: AGHT+IHLHgQwjBt14DC1pTfqWWanbV25/yLubDo519FkOCkJkmpwKCc8feIRKpjRKMsqiMdEH3ytRg==
X-Received: by 2002:a5d:5f47:0:b0:391:22e2:cd21 with SMTP id ffacd0b85a97d-3a06c43fb78mr229330f8f.36.1745427177790;
        Wed, 23 Apr 2025 09:52:57 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac758.dip0.t-ipconnect.de. [91.42.199.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa420837sm19598917f8f.10.2025.04.23.09.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 09:52:57 -0700 (PDT)
Message-ID: <c799db97-19f7-426e-892e-7da3d36a98f5@googlemail.com>
Date: Wed, 23 Apr 2025 18:52:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/291] 6.1.135-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142624.409452181@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.04.2025 um 16:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.135 release.
> There are 291 patches in this series, all will be posted as a response
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

