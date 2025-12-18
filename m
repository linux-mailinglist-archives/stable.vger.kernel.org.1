Return-Path: <stable+bounces-202910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAACC9E77
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 01:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F20F3068D72
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99ED22258C;
	Thu, 18 Dec 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AzszOLdE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFAC2253A1
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018095; cv=none; b=FTEBwNW4aHwYZeCaG+QSiGW5JdYO/v/WXR47D48MCujH/sFKeWijgv+PskkiN5DB9xflrRz5pBGIBgW5B/gZJxb4xKnklfSb7Ylu4338G1txr0CyHM5v2BM5DVdkDJNAvwf6uH73UQ5uDC73tQoA5iFyGdDBKn6pKcLiM+lXEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018095; c=relaxed/simple;
	bh=FO8LIM9dc/mVTDnts2nMeCTvf4v1hrbMfsp44QYmZqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkSQSHGqxeYck5ewjcdn14ArdR/eNQBxy0UyOnrT4BSuwZgaSTKxBr9ZmYUM6imz9tsipwj1+LcyBczlM2lIGcdx1Gg2U3y2ZiSIQyl3a6vKGCbFpjFE6GcnzfIx7ZOHjpMrl0I8p4d6NflwUdgHxWQD2FBwtZrBPoj3CEW61AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AzszOLdE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso567345e9.1
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 16:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766018091; x=1766622891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xEWnjAIItWQZkv8o2Fx3PveWA3cvN39KVpWlhYgkBA=;
        b=AzszOLdEX5masM8pxBegDXGKUFcgMlTXd9AUjqM4zCT2gb8dN+Eh4b9W8nqk4O1gBa
         DjmAJacvnxFX4nsyF/2vOasir+MXe1Oka1iZBc7mz/KFRDrhvICOsAZ2NccbkExDt8Bo
         e5Mv4QO5M8rAm2aqZCnnphxh0ITaqjY/N6pG9A8cVCcpyGl2pfCECIOyraeDGMDQAO3R
         sBsn4S8jOrsae55Jn5aO4vi/RvIB5snxlV5l2+7pXHpZsu9MtRBi51QulnN3psjD0QpH
         c+9+2OllZeY4HXcjbnbM0/oyhnzVlgTLEmchgTbLqHmOIPoL9zJTvV+CYd+3Tx77miVB
         A0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766018091; x=1766622891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xEWnjAIItWQZkv8o2Fx3PveWA3cvN39KVpWlhYgkBA=;
        b=WFl+z059MiGs0ipxcK1aaS1DF/pUfHcOBg8QtcMVgNNdYZlbKWU2K2d6jSIZbywMhG
         tbnU7RNRZ949ShSsqygP8trxEM95Vo1jggWXtR9VGEnMgC9XKz9vO5eunERTAnwnwcXL
         k2r5FugrEpssd1EigdTjdRYejOoWI6pNHXkzELbb/mxVekeiCSZN2ahxvHf89MyXegWa
         DYmG39PYnVXwmbd5l+y+2Ww8/YjCMSRgQEm3sswUhDM1d/ZQ2VNOPfUdzZVerBfmhm7R
         uFYWmFdJs2q8+S5lLyIDbjWhkJ+Xqrk6ie+gEPGlElBkq/k4EKLybiQPfXj9JTtWNE/l
         9GpA==
X-Forwarded-Encrypted: i=1; AJvYcCVD7e8getwkKaqDaD6Kde++BUwDbp67voIbZgI5ODs2rBsNw8AdRVKN1RSLhukS6sNp0Wi1GZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFabBjLyo4VL0apwgFSs8dhpLhHdx2PMggfDECJHr5XP3310HN
	vokZexl6+fEvNip8prPAZLfGd5Ou9S+lTzUgSrfyeKRGJCBCYJKOQec=
X-Gm-Gg: AY/fxX6q9FFvS5IMMkGRiiaQjtUEKf3eYB7mk0rWJg9a4+YdJmaUnsV5dS/vLV0Q+kW
	YzTme+JgBJec6hEtJK0qJT2QyyoUCeoag+yAJQupolsKM7c1mi+0hnqgj3tDkTQgaL+PLZejYtd
	9X+Bx4glHFk43sFyoJwrFgUZeUiuKE1d4wEEf2nuYHOVj33pD0f7Ksd4IytCqkT7j6wCRDoVXK7
	zCvdTlGvKgOsGLOUouDVajsuqm5mVnspW7xgfrMSYbVNuRHZs4k0Fz+6tut+Xdu3jLhoPdQhKQO
	Bsc9pZAj7GsoAjW+UgCcohlXSNYdURQ9teUoPzvgRy5hh5VwZoNxgvlFYq4q/J0Coy+Kr/lL0wV
	t9QO6Ww2Vv9njDm8JfRb3VcN1NMUZTBTaUbGnlAgNqhfj9UEzSKifE1PNZvoGADHovQZ3oiv9Tf
	OcrjZnkbPGgKEaTlrs17RIMCN1aq8SLXYUoMvFgZfvjPjv4iIrRCNgQNehLMoxGeHRYwYzjVQkT
	w==
X-Google-Smtp-Source: AGHT+IEC68J9z/knR6wBoufrtFqrl7wLOpE4FGQAXdxT50dVt91U6bBsTviAWFR33gVm6l/I6He+HQ==
X-Received: by 2002:a05:600c:4f84:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-47a8f8a7f7amr204721985e9.6.1766018090846;
        Wed, 17 Dec 2025 16:34:50 -0800 (PST)
Received: from [192.168.1.3] (p5b057c69.dip0.t-ipconnect.de. [91.5.124.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3aa7cd0sm3149355e9.8.2025.12.17.16.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 16:34:50 -0800 (PST)
Message-ID: <35c5e0a8-6134-4d65-9fe4-1778b22c8d50@googlemail.com>
Date: Thu, 18 Dec 2025 01:34:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/354] 6.12.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251216111320.896758933@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.12.2025 um 12:09 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.63 release.
> There are 354 patches in this series, all will be posted as a response
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

