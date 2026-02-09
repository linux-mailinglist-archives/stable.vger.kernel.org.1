Return-Path: <stable+bounces-215554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5XgiCkA6imlXIgAAu9opvQ
	(envelope-from <stable+bounces-215554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:49:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C831143A8
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1B6D300C905
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 19:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2C238A712;
	Mon,  9 Feb 2026 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcL9inY0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81338757A
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666553; cv=none; b=RQ0qad8H9K0n7wUjA7rh3w4KbpJqGm+v1rRavieGXC9bhBEqYgLCMUvUN369x2jwuDRfFAqY2elhOZadUX4USXcJrw/b1mLxJjLT+i978trYvAtX0Bq4SGK3L0r8BPwxbC4t0Zh2XVS9J0zmKX3Omlo1Wn4VJL1JeiJDAa21UZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666553; c=relaxed/simple;
	bh=CfvzO5xOG+hSOcnRJhf3SUQ/ZykvonJqJIogFnVT9I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMP8biLrOulu/22gLOqSvI2d/Qy4y1qn3NcuhIH9GANRRq9bkcmq5ancOLfobj7MC9BxjqmXV1c6TnhMBAdBeg+icYkvN0fp7ZCEMpxX/5u1u+w8WsvDQGisa8plBncptoBMXJhzqBedS6s29znx13hIRYaJhGRRT5lGn9TTb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcL9inY0; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b8675d4f93so1924685eec.0
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 11:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770666553; x=1771271353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMKxnn5tOlY3tJr0Nk+9Moa7pvSxgAQLlAon4I+K0f4=;
        b=AcL9inY0zug4LyOGcC0FJcl0LvD2CrPGMa0FJU9c2zQ+i9+lk3MM6LsLSerYVXRfMT
         Q7oLfLNFl8cugCn9HSPvhmCRaJEKuqGr5mnDKfQ2qfGnZcqoTC0nW5SQzSctshv/8blP
         zpNV/X19dxNU2yZpsZeKek+neano8akiTckHwkFT3uTroC6gogykRWwkGCgTOtkjNaUK
         dQwPvp6p3qJFfK6EQKzysAip1TGd+w8tIjcbhLLsovTEpFOSaJTohPC3H7dZqib/k8iM
         stNsEexepzgJfCYydtE5NvSDIfqo/7hDsCYw3TO/zv9/UCePlTHg2NTcJ/sLZ+UWXhGD
         XD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770666553; x=1771271353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMKxnn5tOlY3tJr0Nk+9Moa7pvSxgAQLlAon4I+K0f4=;
        b=KmUcTIeJVBSiVY6bEqR9aLEMYTWtg7qNbS1SrBLuiNwQ9swB2VXANTeFpW9zKzmlqT
         udmNuLmpYUFfPUd4jpweAPT4wXB0sqCCbcm94U9seV8HA+oRMrgQ0+Z8NvYav0m6a4v3
         fXCB1KtBI1DkLiF7CuA+zPhDbS5PQOb8yoBslNXeNgaD1w5UfmSuFwS0QIw6aO+MN9IZ
         VSypxaYA+flY5m2lvXEtEuoQ66gRNglAYbgXjPWMwukA3txk1kkPA2019jF2sduVdBTC
         JU/wHJ/M1C1YAko4vFDIqiPWqlQGTIyMHB8YrMFD72X2ypa0g+kr23CPX2ii0BP54Obv
         EOaA==
X-Forwarded-Encrypted: i=1; AJvYcCUvH9/+bUVk7CZhj7oUuJ9/wi/btISqAxSjcpvFidnXh4p0nOR8ixzjpZT995+3sgru0vy934Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtAZ/vRUl0vssmI5Y6sc1poUcvsZJrKk8ue7nrkj03SbDUC6CR
	pz1QPhhpC+fZo+v82nB+WjQD3nCTlqJqJhMqdU2xWsnJnUQ8/5Cvbdic
X-Gm-Gg: AZuq6aLLMEAEZdrXeRQ5F1v4zn+4QLcWQbj6No66KK8FRwwGFzq+zlGafLiTQCbGbwA
	YZgMSXT6c/yW/+fehLYn0af0PwQpw16m8dDA9AmcjTIKlh/6tQguoViEBDLEv/fuwGNgZQlGGLQ
	xC8U3sNAx4vIPqr7nAiVRfK5KRsr6hnM5i7O0f+DnmS5m+yyM//BNWJF5OjlR2BZqdbDY6FFxhH
	w24x7lUmX/CDYF4zmNu7L7DT3uTOg/TbjhqCxQdIlkRDfSl9iajH7dIVpmS1rlccq/JHqs/BCY7
	zsfxDbiO+TaBqnvbebcIL1JvKQGLHzuUaZ/h1RxxK5DFI5RGw4MEJYIEV510i283RhX1fl0B+N3
	m4UCIBt14GeAZNU8ZD+wkYTWX3EZRYPARf5zgAsCrfd0juzTnyMORKUAmlPcB9jnLBmUsP5nvkz
	tsky3lByFJ14U8iwE5+LgvR7iv4pC/VhwcEKbHpQL1kcDb44oSz8JC
X-Received: by 2002:a05:7300:dc13:b0:2b7:d7b:61d7 with SMTP id 5a478bee46e88-2b85672bec2mr5936562eec.24.1770666552666;
        Mon, 09 Feb 2026 11:49:12 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c8a8f6sm8054245eec.32.2026.02.09.11.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 11:49:12 -0800 (PST)
Message-ID: <4d830483-fee5-497c-b4ef-c79a27d245fd@gmail.com>
Date: Mon, 9 Feb 2026 11:49:11 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/69] 6.1.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260209142301.913348974@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215554-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71C831143A8
X-Rspamd-Action: no action



On 2/9/2026 6:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.163 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.163-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


