Return-Path: <stable+bounces-191321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58465C11761
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 22:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46CE34EBC4A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8530BBBF;
	Mon, 27 Oct 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liLxZiJ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD522DCC1C
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598897; cv=none; b=lMgj06gGTJ2PV8zufz0vlTdyafpWu/r9mez4GJXctRK+rm8/AOSgAFxmUUXZ9I6fuI+qIymQx4hUR09FnI7ufyUdzxBZ6vSUqBtLIwouP8NnDZkOYP8eGaQWar/jPoutc2L+PgzD4/PyYZNfqgrXJwZbuXNlzlPJwBZ8qIUdMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598897; c=relaxed/simple;
	bh=EZp5BK+kY9z9HMDQNMaQsFSUJ4La66FEV4x+BFlDz6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUY/bAy6semIZ0RQ2yE4H2QdpiO5rPtdlmX12+iExj0dWX1Zj3T99t5ETz5ytIX65GV2nktDK1jifxtJsr4V7NXh4nts9Y7U2BYisZv8d0gc0Q/spvqYlA1Gjiys1bLsttEK6s8dy5gLO48se1KYLVXvU6YvUecsejCB8ux8lsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liLxZiJ3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-79af647cef2so4397918b3a.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761598895; x=1762203695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8SoCD3YzmKQQpH3IErNvrdu6c+r9DLyIYwtyoko0YU=;
        b=liLxZiJ3Olpaa4ZhSGVYlY1gwc+jEydCml+XbHwohQdIU6mWhWpzNwxTEEs5tjpe/p
         qdQPCR6HoGWhynJQLEWXukerioNQaJL/XemVwwa7VXvu1trOPxlrU3LRTbsNjxmO0ViH
         lTI3PwEiVH7iuPxQuErzW/yBggpOjyH5z8eu3OZLuZrZEShea8XI6skoz43T7HRqS2pD
         6aW5y+qqVGq2A9M/p5GjNrLuSn/tASExAElx+DZMR9OhxwjbHA89iMJsqiFWWGTULSHo
         /7Z9Udj3pMvxOZJfNSxLjW4SEn5XPkSNVqNmbxt3N02gXDgaSxvuoKNEUiltqgspVmks
         VxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761598895; x=1762203695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8SoCD3YzmKQQpH3IErNvrdu6c+r9DLyIYwtyoko0YU=;
        b=NhBXCZ5kcRdvs7sS/88oeYc1EAvklGPAWRyiZ3nDBbrsPIZ4l/TqH31SL+bk+Qr8dF
         qxPoZDdkhsQiFb3Ppm0F5X41OVHAkfxMHOLGYuNgFEQUXLybxN+/AM+jXVwi92zTno6F
         gM4IXrblBU2YBBzjA83evx3Es1qMp1kUHVYqxSPL/eWx8zZlnhrb/jhmZGrdXPTm+95S
         v27210jjEgtE5orUIB4KLgwGpMyEmjdy0S3/WEL14o8pfAVgqlnAkqyWl/r9nNuXCk0/
         Ipx+WlCdRCn8wlwxjaqi0LOVj9b/ykP73yc8e8/Og1Fpa+gH4/6MdIJpUM14RKt7/2Ig
         jVcw==
X-Forwarded-Encrypted: i=1; AJvYcCVJWqVmC4YOKeqiTsf7HJ1B0dc8cFbzM4zsUNdGeAZLaXBUEzBFiXIfusC0HnS8GFgKR0HXy24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNxtyLH+P9d3nVysLNS8Kd9Fuq5/9WmgDasada5ZFUj0b3cau
	UA2Ag4elIwZNZ8CAQnr9Ikf4uy6hS0wDXppKwWRyFEvJDMcErLm4bOjx
X-Gm-Gg: ASbGnctqoSaYcLTY7/bra56RVoay2ZhZUXW70/FLVyglmLlxhqpSQFpqHn5IHuMmjjD
	G+hbO9ou1b/STNdIzLNycKc0auELzS2E9xno1VNNkKPWUCIJr7kY/KlsxcIJdl8Qt4478S55mqc
	/p8OCFqqjStj1dyVjPjV1AXCPbFgM2W62S5GAc6017fu2sIG0psIaQ4Q2c7K06DF177EB5VisWA
	EK9Q+nYzd97hRCZNZgXndoEhTnOIQTGexdEAs6CjxoH3rj1J1coox4VT9F7dCME5mJe3nShAhaH
	IVvofYwd2Ra8jozkhtFcWuxJN3Ffsfnm6xcaqCFKLtLy2ttluMLtA2zb1EEgSSqUcZlE3mtYMPz
	Pi3NqfZaS30IBjxb3t7YWnme+mFFhG361rZ4Q+JAHD3Z32TfXiHTAp4xIfsisVprA5BbGPGCjaf
	KAGDD7xFYeoDvtt8lP4rXhyYCDmqY=
X-Google-Smtp-Source: AGHT+IHa2VYZJfjdEJOEY0c+qP4ZQxZk2QwgKpEDvKCAvVbLkScqmzDjwXnBYcxlrWLzuBDFczggxQ==
X-Received: by 2002:a17:903:2f85:b0:292:fc65:3579 with SMTP id d9443c01a7336-294cb38532amr14538255ad.17.1761598894570;
        Mon, 27 Oct 2025 14:01:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm91739285ad.21.2025.10.27.14.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:01:33 -0700 (PDT)
Message-ID: <f3172b29-f4f2-4b95-b67d-cb6cbaeb3bbd@gmail.com>
Date: Mon, 27 Oct 2025 14:01:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/123] 5.15.196-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183446.381986645@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

