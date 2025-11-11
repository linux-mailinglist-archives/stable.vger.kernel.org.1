Return-Path: <stable+bounces-194517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E0C4F662
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 19:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81734ED3BB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 18:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E07283FC5;
	Tue, 11 Nov 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g6d9He+a"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263A218AAF
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884933; cv=none; b=gwdVTQ5P94CepAC6p7L3B8RGoqNeyA7EsglnxyGlPLAtecTwq0iwCMGmzvw8Xa7GOJ8uAsBksS0AbCWzoMOHTce9O/VyMrLay5ZZ0BGl3tyxCjbij1jGpWr6oPeZZjgq9fbxqYJwqCnJyMtGGsJBnvzL7UHm1m1i8hphdxSSEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884933; c=relaxed/simple;
	bh=WY0tvD3JrT6UDkw/8hTycx0qbVjC0GxEVNXJGB/A9dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oafWoADU5Vv+2BBmAqWy5L0RjOub6tY8TElRqAONqBjqgctwXca2vFPmXvvnMqyJvOBDKId8VK7H4PJiRIIRLNKGzfGNB9rG0lSnuJMwL/XQYjaP9ueElCKUP0eknkDMXW22QZWgklw6q5toq4mB9UlqG3g297qXyBv5Z8Ep4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=g6d9He+a; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so272115e9.0
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762884930; x=1763489730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYuH1i5ZoIizzTTIcboUh84PgIhPsB1tWiXRAjKgYIM=;
        b=g6d9He+affsB9ou26F19wNIOgfBWoN8nX3nYLN7pcA1Cg6+tWPE5QCoMG0YlvaKA7e
         iIsf4Br/qbqb0q7AikeX37Nc3ABIfp+rH9GlU0sIUGDvldGQzjq+oXd6LJ5lq9CuZJ0i
         3yQeUcLHzZg9xi4P4wk3QJ2ApSwZ8H3I2NL9WECisgCiH0WniAjKE+VNdIlG11WlPUy6
         jPBVlt3ZZ0ot1xBEAFLH9wW2nXQRWwzNX+vSo5JA0AWUGTZW5S6AgaYB+s6tdkEDQw+N
         CXzMwNboX4g8zLDy7sNzd7UxeQ1KyOSfLd23Fw3xn4sTvbFG0fFPL2JkfVq61VcjKkqK
         qHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884930; x=1763489730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYuH1i5ZoIizzTTIcboUh84PgIhPsB1tWiXRAjKgYIM=;
        b=oXpJpXTHm00izA6uAXOOr01CJUlPqEz6Sye9tn8ZssxvViFpfGJX882vh/BF8i6GE6
         kdsRDdXo/B5Hb4FPe0o82wWmheBQIFt67XAkg6bo2mNavJR1Sice1klNlbYjuDhWQ6K3
         BtBvriG7msyTti8KW2YZoP1Qe97hnUwLBxouPRGt9thQa/5vPP9Gp1V6eUbAOKqyE0px
         ASIZjiVBxI30elr+2bIp2kJ6YVXR1V7tBDhLQ21vkGwrOOU7J/zd/EqChyIJNaRR5i2/
         WBd8/yqEMoURO3Hrk2ruUSbJVbSX5E1mewXFE7zQW3g1V/w0/Gv+7LcDPCY6+IUGoluZ
         gbDA==
X-Forwarded-Encrypted: i=1; AJvYcCXfHd+oSRcRwoAkKj+HP5BiL7/WQ1BDAampUKVX9w/CXZMx8CjChgNbrfoMXVeTPlKRRZVcnNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20NLLI2Jpqk0lwTL9sdk5sDsysVcOn4QxFscp1DGeSlQ8Q0X2
	4h+qC9jBwYvbqELl5yZt6FFJIhnbNzV4T+/3/NKOfmsJ2Z/i8zUHaX0=
X-Gm-Gg: ASbGncuoUAa2ZOmzFgw2QLvE+sN/LpLjhbrKkd/ev1t3tu9zqmhYhKaH5eW/7QqKqNN
	aQAZSxm9Sr7ilSss3Om6fX+quxK/xrad3pqboT+QKz456gLvSm25/pGZh7Wgq7n3olM6NwC62w/
	5FbiywOZo0OmsmtZDVc1FZ5Qei39sD8nNw+ArbuF8rabCow76OsWkQubQxSdxVDigT24LsekNJZ
	3c8izv79/GdwGJ2Vy/xO5nLJkl9pOWUEpOUqdGOVG5kk9sOLWE5pL3wDxylnjfH7O4xzjQe/CaN
	MN1kDJHhwdR9udI9UxX7qjQk/YJgT0wSMhu7N0N5Ww6M1j4hI4P/pj3Sd6UUyMuVcD1Z58fMF51
	lGazdjK+DSTdlKnZQDRVv8Itdi5dukwx46nl+tsZwElBaTEm2oxNAT4AOzfQLlY3TiKsmJGuN1X
	v5yITLVImlpRsUnOQz7xCCdrEAFxvawsd85Par0EubBWoqzjUEh27X23q2Qd7VuNM=
X-Google-Smtp-Source: AGHT+IHIoHZOFXMv7iwBPA10zJJM1peaNTeyWqz8HkDkOlb0lFxAYESnE/oaas1auLh1AqL4deR9OQ==
X-Received: by 2002:a05:600c:45d4:b0:46e:396b:f5ae with SMTP id 5b1f17b1804b1-47787046a95mr3297515e9.16.1762884930128;
        Tue, 11 Nov 2025 10:15:30 -0800 (PST)
Received: from [192.168.1.3] (p5b2b46e7.dip0.t-ipconnect.de. [91.43.70.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477815faadesm25345635e9.0.2025.11.11.10.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:15:29 -0800 (PST)
Message-ID: <870f0a18-8a5e-44c9-9270-8d3a70ce2eb7@googlemail.com>
Date: Tue, 11 Nov 2025 19:15:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251111012348.571643096@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.11.2025 um 02:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

