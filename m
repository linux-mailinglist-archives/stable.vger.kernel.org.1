Return-Path: <stable+bounces-126762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0B2A71C70
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C744C189D293
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398671F463C;
	Wed, 26 Mar 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9Sv6mC/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7811547E7;
	Wed, 26 Mar 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007865; cv=none; b=GhYVvJRuDQHS04Gx1birLqYFRwz8LVy8lpUdi9ffLUmtYAO+XD/Uv1lUVTw7SZmyIKHr5KEGsy1PIgOJyJqJFvNafnD4dIodC/JSxw0pjpAa0LMtnpXFLPKwAxnZGonya2cIq5MTl9viafx+0+SHevCtirwRmXEyMI2GyThzUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007865; c=relaxed/simple;
	bh=yJBMyf3jsU21PG1wISC2E/kXWeLiiqnAY/jasoecG3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yhtp+lEfbpq4hX4ZJlGG58Gs4C7TdLJ8lFl04kwfRNvV9M3uXQOhEl3sBEiDizZUyK/eqfjUWYmK6cpxKBYjp6QqH537v8IzUJzBGWRa4qbKyOrS80PT3OVvpwdJjprC/k50JKsLgVmkE9wfXpI46cV39oQpMv/vPPGbIwy7Qs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9Sv6mC/; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c14235af3so60137a34.3;
        Wed, 26 Mar 2025 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743007862; x=1743612662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hOAe8NppTWO9zoq1DW68RBKYaN9LktVjoWLJBt0YsMY=;
        b=m9Sv6mC/vMg5WVK9OQNmQO2vKjoS9kvriK2dyxadlpIIdWdyeAfM/Pm8RsAhwrPYyX
         ATbG/4qmsL7qFigKIdca2uUgE9arVbujX/Xe9mb/TpWzHwoXuGgx62dJKOpwU/dJi7Rd
         Ybaqi6QthZixLD2yrkW7Nnd76F5uoLbVri6g9tLq43lXIjGhIbX6pfPmCkVs8To71guI
         jOArz1DBchPMk55gHTOPz01R1Zow/3+zkbHjLaRarsSzK0oMaJfkLA3HC9qxW4CkGwEW
         +18IoLKZCe96nW55P10G8A52Aya69jj0RK1nNmgB5lLYX7ToAMJafJdWS4n4jJFsLZmB
         e+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007862; x=1743612662;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOAe8NppTWO9zoq1DW68RBKYaN9LktVjoWLJBt0YsMY=;
        b=h1B/OxafShBkYt0AlWm0rNlcO6hLNH0vR8JfM3h6Upp01wc6cpPIVBSdDxijjvjJJw
         /TVEUnPUntWcXwkr/s4YwghQaEwi8qEuZF804gn3tsqMCg/qg9y7YdG5ZD8WdYJQQeLb
         tKr5nXart1aM8rWAmBTZx66Usx+k8n6ooQblGshu4cH0ymwV9jzPsBWhAVnN4uwrlX1k
         H3MJMte0D/nWxfWcuHQLp0dJCz5W7xAfAd612KJwjjk2R+VKvKlkGXg5Bn+zi451XVbq
         k4/T9RBOXmSuwJYJ3PHtutFmQ6uTMj7dp1kUYdgZJRkA4P4dHeVva7SUnk6tM8sLTcvT
         61hA==
X-Forwarded-Encrypted: i=1; AJvYcCVZJVIt6sl7ASgGeCBUG3pcAQnnOFMqElVlm5dt62dVdooO5rcy7aLGn00pwF7bLGyp0Fdtlbb8@vger.kernel.org, AJvYcCWc5vYbsTOOuHhUeb+6ZklfwZfpVXXKZl8mXN/kXb0KnNuOAAc0FvaiDRzdRFL5E/kdioTGaZx3aP63rqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLHXY79NWBEUVICGVrUYGtEogjl0ZwuHUPLCS+mrpUMxG5c7V
	GIo19jzjiP48ERE4SuZ00dvOMaDODRUwDzSg1fMqL8HGMtpQ8H6L
X-Gm-Gg: ASbGncueJKKJwwUFWGMbPYosx9ClW+EWUz6n+mXjRuwEQezs6m0N/bXRZhaCXOl7fTU
	Dkt2sztSGp8/XDx/jLxvqatr9o4+2/AMafMa5CcqKdbdRXC7iDLR7bC+CgyRrs03LN/kbArogv7
	L5/ReRhWWTELIgvA/473WmaIUvSIvSmvXiWpWGKXGYBdbP7rZevrVbnMdoI8YieCR2u34ecYLqt
	LvsDsGQ78+kb1qNjw76GXYE3YtzSQbJIpy8h0k/6A0vNqey4LutN12RIxaXwXeuq8tWGiKJ0gjR
	Ph2y9/+CwFdRFPcSUVRF3j4sDzNCWv20W8PsxwlgXJ14ccHTLH3aXZycR7wqpPCD+naJC8/z
X-Google-Smtp-Source: AGHT+IFPKRWGLiBcjrjLsFURZF/SukMW6XJTZFRG9r2eH7jQ8Q4+akVlRgnN9pArBCca7rRFg93qDg==
X-Received: by 2002:a05:6870:2889:b0:29e:65ed:5c70 with SMTP id 586e51a60fabf-2c84819f69dmr161676fac.30.1743007862339;
        Wed, 26 Mar 2025 09:51:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77ecd79casm3145272fac.26.2025.03.26.09.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:51:01 -0700 (PDT)
Message-ID: <8acfab35-35cb-4865-89a5-da41b1122b01@gmail.com>
Date: Wed, 26 Mar 2025 09:50:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/76] 6.6.85-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250326154346.820929475@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250326154346.820929475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 08:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Mar 2025 15:43:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

