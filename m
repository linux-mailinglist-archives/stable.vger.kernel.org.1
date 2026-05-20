Return-Path: <stable+bounces-251491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MThJW/1DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6F594EA0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 054ED30FDE40
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398FF3A3826;
	Wed, 20 May 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3KXLasa"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7ED36A376
	for <stable@vger.kernel.org>; Wed, 20 May 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298120; cv=none; b=oJQxMfLaYcd0J9k8TmH0pV9nCjhMXefJg+3h87UtvY3KrTG3gR6cIVwWxSvfC8BdceCPvu3PQRaF2cKdLs/AtYR3qF9fuj11msYmQiVqKOyw161EAzu2E1Dr3SQ846OMVHWxOsvR9QVfAzs4PsG0dQwllg/dTorIoYMf4nkE+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298120; c=relaxed/simple;
	bh=1JoJ1pMrRta66xrnAqvPlRrU+s1jQQogKj7zLypIcR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3coebfnpgH5zj8rDVD4Kp56Km8f/OzyxgZnhjygmnY0LwVeQFonqy2a6SNZu3HZYoXVDpiF2x6Zx02AzO2XmFvP4/Tlm5RMvv4NTxXhQ/+I7hJqGCftM6k9fhN4cbTm8vs9eZ40eQoUYYwxraOGpnxRg66e17cdNbDr0A+afyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3KXLasa; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f7020a928eso7438314eec.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779298118; x=1779902918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuzZ4HzSRbjeOjIzQh3TiYGdA8Z6tPjiq5L3ytoki9Q=;
        b=K3KXLasaOBd/WxLvn4uUth1lQVkWcW/f2eGB8gnIdf0Y74l1s7DbpHEtXJFl2TVNZ6
         DRnz4f79dLLpSHs/gGbM/UVOtONiUALlN3yFYsIksDK3+YqX2U54DNSLvDlvoFBuRo2Z
         /LiwG9ajAowrnACkoCsiiv+glZgCV363EejPcuV80LdOa+hp+U0KdG+aprWWa+nPcs3/
         g2nVXOAMkJgG77YPio6VRLyT4TGhPIkgspwHGYU2XkP4ZeEuSj9HjCSq6F2tTtA9UqjQ
         iLfbwnpc/PLQu/FDujF6fKPnS0oFt2M6CyNAOQvK8hHET/VH5k8CNXV8tcU3h/JVdfmH
         14lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298118; x=1779902918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuzZ4HzSRbjeOjIzQh3TiYGdA8Z6tPjiq5L3ytoki9Q=;
        b=a+ed/S9VBVnOSLYo6z1QNmRDjaS2nG8By3QzjW0M0VYCpHHcmp8f50mS6ZrpXVsTm9
         M81EAljvDUS6yPMMHDbzQUFfytTDVWx7ZZ3BW4QQQbNwyH286ryL0geMH0QoE/UD3K9m
         qFgg83VTYZ7UDP2/uA1JDc4wp9st/klxOnguvMe3WnlNPVZonbj4vNopvXONi8BvMhiV
         KxAcuTk1nxbZSCucYsUkArAozXdaCNpCVswZSyD42L9yVwQYdk2P75anVX7LlAZvkhF5
         JQwlovMYXifKQxgpfedaZKxbYa16wSnLbGu1xgxmaoEgG8V4Y12BB+xH6IWXg12iYF2/
         dd/A==
X-Forwarded-Encrypted: i=1; AFNElJ/sJPgRp5A5rLHshE0eXty8xAOfebqN23ZTeAENWZYS/6a2TgUGRYEff3O7K4kVd8L8P63x0UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQta1izg2cPM9gF7zF3E+pOQCBSEZyHs9ghvAMVZBwhxt9hdea
	9tF9fPwZSqrLO6BMDHEATuPeqLsxfvK3s9VZ5DSqDO08d8Mabt4G3RnR
X-Gm-Gg: Acq92OF/UKvGC6Ujer2c5RgMk1JHpIfvdht0jYJsHgoZy1OKqaUF0o1dq2IoNURhFsf
	h8rW8RUBRqUefiNLt+7ZcDPGtK7Gx9mYNyoc9hCmdCH5NkNPtWE1IYIYdT0mxafszI2IkAaEXrj
	AnqH/69KR9cL3EC+txWBeZCH45CTA0VKZoGDF8K0yYzRGe6eRcR1mFb8GfWaVlimk6Unj9jyS90
	NaZvYahB28IR+vUq7KjnzHsLhibybcd9V5UInvO9/8XtCq76N93bg83NrHgTSx4iaJ5aVcmo2eN
	4q1Rf3Oxh2baBgUnulyahltQbVbaHAQVwU71Pa8DJrYUiPvgjNeChSqKtj/okdtKImina7sndGn
	GMiNzKwtnJ7CXvNRQzJ0pqtia6DwB599HimoFNMmotzUYwuiBEhppfsuLet2XNNPtZrc7Y+3aKp
	hMVkur1E7b1j3Adkv2OTBVQKd8NDN4pU33APAQyYJQpQQGUWubss+3z6ryZedr
X-Received: by 2002:a05:7300:b586:b0:2e1:e5c0:7992 with SMTP id 5a478bee46e88-303982ac675mr11233548eec.8.1779298117688;
        Wed, 20 May 2026 10:28:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc458sm23876517eec.18.2026.05.20.10.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 10:28:36 -0700 (PDT)
Message-ID: <6151ce91-aeb9-4dfb-ac57-4223078066c2@gmail.com>
Date: Wed, 20 May 2026 10:28:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 0000/1146] 7.0.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260520162148.390695140@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251491-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Queue-Id: 43B6F594EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 09:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.10 release.
> There are 1146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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

