Return-Path: <stable+bounces-189016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389CBFD2B5
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D2357CAC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3AA38086F;
	Wed, 22 Oct 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="en0+pvYN"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E3380860
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149432; cv=none; b=sxWumqMloA3hvdZ4UgNMxjKD1Xfe44FXXk73+csvKc7k6NaUhGq7dhOcDCpgpbpAa1oMIkP0mpYOcH06QfZYTu3Z1BzjIgv3tpPQSBMaD6JBvNyvL+I+W+F7EmtuJAbmgLcWD8y8qrnoeqzkWzudteHdTIdCqe6fHUARuoTTE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149432; c=relaxed/simple;
	bh=KKrkK8RpkI2SMuDE/cHHahMB360eSTnAZDbrSoI4o58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3hbeCvtwQYXJvzh2LQGeRUC9uWHs2wLM/1NnvDPThoXOlQaZafZkM/DFVqVug6cqH5BvZkBd4q4vVe87MDtjONpovuG5U58cGnSYAKY6BJFcWZ0N4gAzUMbTD0BE6ll0m3cgJQHAO+9+N/9l3hacHK19T6+ZrqP8+qroL4FIG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=en0+pvYN; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-93e89a59d68so189150139f.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761149430; x=1761754230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fJk0vLG7thkf+LY+zE0uqEbWMzbuwo6FawmPYnjzlk=;
        b=en0+pvYNEUmF7YkAtcnmGw5nKtnIbmWpVRua3IVrSwE0/X0airnn6m3JujwyGAKowV
         UAXFZ1+EXhpA1eGzzDXEHruFNy5fM/U1wBxyJSWDbRgui9NdDDUfwR/6yM37n+WXDfGc
         WFocoUznjyaJ6e0hOeSUWkW7kwkVyOaToRonY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149430; x=1761754230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fJk0vLG7thkf+LY+zE0uqEbWMzbuwo6FawmPYnjzlk=;
        b=JA3DYTnr8vAbJSdUrMHWAs4r0TTQkNzAJ8gNH2jCM3HYlguQ6XMSPLa9ugQ3tuyNq3
         KsVjjWeHHZRCee10ey+L8B8eB00CXX3yf+0n5T0+1BTT9zjBexmUnAHVsGMfwo/U0Jp2
         1lqvow1cnAcrp93kVfqipVRm5PpyjVVG+DL2xY/6l0cJJwV9CwSnWumg4kc5LXZ5gFre
         WJfz/zl8Y9qrQv8OP7HRmjxKDeVeU7IPLSZxI4XpU+ZfxMiLfBdvZHoq0Qiq3D76EYZJ
         hRNyS4icAD0gx0H+slcqGRR9poIilLKyWRkdG6Xc3J+r5E6ph63Ldwon7H5ouQxFkVdQ
         8MUg==
X-Forwarded-Encrypted: i=1; AJvYcCU87NqEfUOYCZzxAWEwooY+eDzKZDgZdlvgiGBob+R3FMAX/ANeYAHcuihv5hQiyETaoMOKy10=@vger.kernel.org
X-Gm-Message-State: AOJu0YygXfeX5Egl3ssjYPzA9rdcEFln1BhGiE928wu1LKqJEJ0s/x90
	ZMLr7KqQmlul35vQ7c2S70gFVyHtvBqwjaUxc5ZcUNRpPqtufIST8xwfJZqJ6AHY2KA=
X-Gm-Gg: ASbGnct4oollRJVkEclfvWm1oy1zhsXXlNLU7pdMnvQtqlSo9iKermJbMMngxuAj2hk
	OhVjo51akQV1MXR3g1DWacOiLDGKkfAr6qTnCToigCJpji42/57VsZe+gmn4i2fyEtiIQvSnFTz
	PMlriBPEOvF22u3u9zDD1LE4egb43jhXJZkuAiy8HQECaarNSTg9lpBvT300ERqkVZg2Z9M+cpC
	OzEJpW5hnmtwa7fdDEXyvdtoGoiSlIa2QLSxtvmniarNkJoYeYL+8GgV2vKEjpgiMQGQ92DnTo5
	fFGthmXlPrUyqRMRgfkOL0sk0dA8MuhvMTNcNiJ4HXXU6dWcADtDnE5cY37HBJfnAMsfMU0W08c
	8Jf6gwEKJ11QQJDyclIMXG149ReBBivsNkCIlKJcH9LXTrbG5hcJfI/kJiRfSSa9mCBRCuSfEWb
	KIuVl+qDaxhd8qzuV7L/i4srg=
X-Google-Smtp-Source: AGHT+IF7j9Lnn708nVHmf7dGCzAt+5tww1lpkvS1+R+l8hRA+Mp02MiCzDvJ4Kqgi3VuqK5H3C3cwg==
X-Received: by 2002:a05:6602:2dc6:b0:940:d157:afd5 with SMTP id ca18e2360f4ac-940d157b1fdmr2126994539f.17.1761149429575;
        Wed, 22 Oct 2025 09:10:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e86645264sm488502039f.10.2025.10.22.09.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:10:28 -0700 (PDT)
Message-ID: <79b7357c-332d-40a4-b8e8-c521b6873099@linuxfoundation.org>
Date: Wed, 22 Oct 2025 10:10:27 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/136] 6.12.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 13:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

> Mario Limonciello <mario.limonciello@amd.com>
>      drm/amd: Check whether secure display TA loaded successfully

Verified that the error messages are now gone with this patch.

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

