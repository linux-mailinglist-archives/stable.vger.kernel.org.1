Return-Path: <stable+bounces-107918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B481EA04D4F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B41882AE9
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645CD1AAE2E;
	Tue,  7 Jan 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYSzAi9M"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7476192598
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291801; cv=none; b=VKzcMbUG13Mhj27Q3PwuMfDyU5N37rbkLcqD/jWxf/tk6GPy3klQ/HCcr3zpLFHHPnvJq0fgUMowwIViH2iMq8LDWA0x9wwBc4SGq+uhUSD7L5o3dV37TdH48B3SoidF/VLjadMju4pb4zQgofJgBVPOz5Psfd0abCkBtzoOUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291801; c=relaxed/simple;
	bh=5f8+vCD+W2ZyJES1S39viCPirAwFDjPa61O7vco6+BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkLGoN8Wneyww2CaalVMu2yVlJVcwy3gUqgjQBOBpgI5pI4Q2MTwZoOp/Ha2B2SZkLMCCAfnPRzqpHSxUfFbTVsuCEMHRvO33ztTJjpximi8GVFlfhxy+5xNy7jWz0ei5tGHiFYnJyhQCWcOA8zpSokCl/1rd3xVLGBA1jVJo10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYSzAi9M; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844e61f3902so1352898639f.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 15:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736291799; x=1736896599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+KAvtq871rslFmjjmy4HmKCpmB8dEob7QiZmKyRRok=;
        b=aYSzAi9M+0l2HSIaE78Y3FRWM/Z5FRn7zYREJQ44pHVPQra6n4usXJByGrqGOo26NV
         hU9G+tcabFiIjfVpLdl3TpC7Kd+j4WK4Ejg/XDRyRkU+gx2B5If9tEkShicND1e9TgHY
         HnEOcRbNHXV8p4y5KIKc9nLnaLxbgop7obyr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291799; x=1736896599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+KAvtq871rslFmjjmy4HmKCpmB8dEob7QiZmKyRRok=;
        b=FrW5e1wkEy5Qa54MaPbiAKEzVz/UEC1lNnJlO2aPnW4QhfBEErA5uYl26az8B3rHyf
         WxXMK0WmZDjlG5449pysI+tbHXF50O64Xz1v7eykgbQwBgcVljIkvP8Ud/wPncpgVpAu
         3oUC8CSLPRkymclvDLxnMIinfy682fSx86eRKtLAvqet5ewdmXgqvy968hCvMMGfNVpj
         YdWmy7jjTMY0ejThpxEUUUuOX8Qrrw7FvtQ4puF5hf4Vq2zEEwMWLgLZUoyxvQOUEsTC
         4KQQrm1X10JOCaIwXipFsWxaVjf4ZrSWqo7xs3owojm+pO7kMnFWs/BxJefTP5//Xbtq
         9T5w==
X-Forwarded-Encrypted: i=1; AJvYcCWS8HtRy1qr7nrj6HJov4acjg/83gZoaZyj4o9IHrmhS+G1MFRyD9fB6jyqaF39m9FbJyrgXko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyItlah+OZS87uPDSZ/uerrVDrbWZt6yP52+ozGiipccbAoc82Z
	Eid/00jFFK8h2LMNvFEnMN/Rh9YScKflaxl88E71y7y8ZvGCkXbwcizGlSxSozU=
X-Gm-Gg: ASbGnctmmwQilX/WefriU9WZc3jq32NlZgkBYEl1eyBKx2rgTr9p8LvqE3a3JwjpMgg
	ukp6MrhiSUdYoL6CRP24kQk0NJulo7+a/4mdLy77V9gJbQmyPpScBiso+7V7Cbr9H9fnUqhMCeh
	nznmhy0qHqknQgffV3vv0HOpAia7d49n2OI3S4FDbArBAk1095FleE/L1Aj8AHGxnZBjpgYlaIE
	rD3J4fJcx2xAIVh/MRfj9ipdna1SKNCXnxQwUv427ISrk+6+IQOEJdtDGeCZdyU1OP8
X-Google-Smtp-Source: AGHT+IG1ttLh8ZQ81EvLd+eMylyuVC0qCz7+yfpfhFhABQFPRbMTUht4w4ZZZP/8N3DZCdo4ccqCMA==
X-Received: by 2002:a05:6602:481c:b0:849:c82e:c084 with SMTP id ca18e2360f4ac-84ce0095ac1mr99998739f.6.1736291798927;
        Tue, 07 Jan 2025 15:16:38 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d8aae78sm968120639f.40.2025.01.07.15.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:16:38 -0800 (PST)
Message-ID: <4721d4fc-0a4f-4b81-a385-bd0b61912975@linuxfoundation.org>
Date: Tue, 7 Jan 2025 16:16:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/168] 5.15.176-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 08:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.176 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.176-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

