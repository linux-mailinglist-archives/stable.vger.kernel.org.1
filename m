Return-Path: <stable+bounces-230010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPyeCNSkwWknUQQAu9opvQ
	(envelope-from <stable+bounces-230010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:38:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D52FD5E5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E57F63010232
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F43E1234;
	Mon, 23 Mar 2026 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeoYXWVr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39763366548
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298303; cv=none; b=XgNKn72Hd95XNZbLF+vTmSZv9ewafRmz+DQ2zt3klQDB6e0Z3qetZXAaDksJueBCQq/upzlF1OcHFsGnYpQlwI9P53TFPUIEkSRX+fWFNS7F4ECp1U+OOxJE0ywxbqri4Kry1tl/cVM91DRlkIU4bgXqs/cnnUrbdf38Gejs3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298303; c=relaxed/simple;
	bh=bmp/yOgzmdlRU6okEZtkVNgZl7QYHRiAPp8uQ7GZZAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAJ5ISyKkN2fmxeCBOmfosSMQg0BATfzrVv8Vm3xpGhLq+daHjDADILnb5JlxmhpPCBIKTl6zjy7bioDyeT1IT/5iDmlrGE5QjBKyZjKLXRFlKDCJ4FTiNZi2NcIm6nj1PxHXX0Q9AVvoYYXW0LwWHPGnj/JHlpA7AzelugbTqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeoYXWVr; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-509061dab77so5020251cf.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774298297; x=1774903097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s7Or+WfsmbZ1yFXmrGEyc1Xjx9iH+BN4idldBQ5KMg=;
        b=HeoYXWVrRDHtCvD9X7i6IDIcK5Inhbh/qNeIGeAIeYHJCNb40Rv6FKXOpzeP5pmTOP
         kzN8+iv85uk5RdbIIPUJrh1AvTHU1q9+bhhPMh1hXtRMl1e/ACZzgQg1bYQDSabzuWMT
         FCQq9R+5u9eqga8g6GQ/jPcP7E/mylQYldo9j9KQqRmGBI081YmdvEjFgtBWytF7DYcy
         2jNqoFX9w89glg3k0OeTKnt16mOr31oGFYBd5+WV/+ZmkcIApJ6c7d6bFfwjsKWMBYU7
         Jeys7I7EhGKY2x9W4AAcxsVQa6pIRDLokmZRQP0GY4GJpfDXoLaNGdWxr0EM6znGxw+1
         y2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774298297; x=1774903097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s7Or+WfsmbZ1yFXmrGEyc1Xjx9iH+BN4idldBQ5KMg=;
        b=pq3SvxUsUiFmE7ux0QDl9K0DbTCV0F0yUyHaQIVfIYYcPAtr4R0nqZ7rH6NUcrVCIY
         Cyfpsc6X15q6xJYGxq0MEM6c6iCdfAcx0yFJsJkYbcSP1O4UQlx361a4R1gcthslWNhR
         X5hai3SOsa12GghseSqZ+gOfituL3n5SV6Cpc06hRbaZF3UIynEOMXFR5/HeGzTzF+gJ
         4fJc18iCpE5Js6Q7LywHm09ZZW9YsRqC7rxbE6b1RJtsHQ2P4ysZx0PSM9yA4cGm95ei
         1D/Cgd9kzRZelVR3b2fWpyL46RQvVIjxlrtAoP2m9FVdhBoUsaqQay7ZiU2kRJ+f6QVL
         8OeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrWZcl+oI3ISn0SenOb+XyjwmJ53gzI+eHNWSC2hnQ0jeQ884nlZJ5lkhi7W7T8VUYidH9zto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojMr2CgqYMEPNG2jeAHWqAZS/wmsiZmIoSaCSfeLGIgD/ij5R
	gBH+raxi0qtry2PTRxIUwc+7llNp8kjlRklQJ2NYdqkESffi1md99CGQ
X-Gm-Gg: ATEYQzwoaTTGQXo0+1Ib7vTdmF9M5/XYAOPPKYAQ2tFSreFtcM2ylS1QFSlg1eBQuk4
	lLiSqbVCuQJmTpjEUy9EjfxyHY8tzZvhra/lFqyWVuKyoyzHKJsWG642t3aVkCEPvISazVbvmKG
	yXyEUkMgXIH3339cJBtQOtt1UoOK9zUL8qYsJoMVclrGW2mTAQyePjxmpMnFMgSPQXhj6U9yat3
	rXHRJmM35BIdJZzcg64Zx9gzhLDl1dxtPEJzwNTkrcTK4NktSf0NVH0bASoLe9RXwB1txuVCw7L
	nR/TcmA+up5lflC/cDhh4dew6etylo8f4cMrg3LUv6f/EUGGft0ABDaqF7s4txsmmubO/vmSnPl
	Sb9b6jjs+QTr6JLSIQeqOdJE4sYB2ENEf9iDHdex0jqDfPsIsX9fsjLpsYACTXViZKjFPpVanWr
	v7MM+oofu0b9kR6jpNDa8fm5gxQuuaEpZD4wXA8MSXqi4ufT68Dg==
X-Received: by 2002:a05:622a:9d8:10b0:50b:29a6:8696 with SMTP id d75a77b69052e-50b373a1b75mr153981631cf.7.1774298297316;
        Mon, 23 Mar 2026 13:38:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36d0671csm94143701cf.10.2026.03.23.13.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 13:38:16 -0700 (PDT)
Message-ID: <4cacde08-9d71-4f74-98c7-cf269ed91504@gmail.com>
Date: Mon, 23 Mar 2026 13:38:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/460] 6.12.78-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260323134526.647552166@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230010-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 395D52FD5E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.78 release.
> There are 460 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

