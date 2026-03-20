Return-Path: <stable+bounces-227599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB4oN3WJvWnQ+gIAu9opvQ
	(envelope-from <stable+bounces-227599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:52:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 850382DEF41
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 287BB3003417
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440153D813D;
	Fri, 20 Mar 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTB/xTPp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E33D8132
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029133; cv=none; b=CRihrgxHeOWt10QhlRn0QVnUqGCWFxt7fI3oH6H2gkDZU+pknAYlxu1PAbRKk/HPHA9ynjbqCP8KO1W5ghWa+poVk6BoxpED5JjMhJYu9g8hMLM5bxcVX2wE5NURbUvQUbd4uInauV/AZRh2eSeLuFKsGxPlY7QWabpxZHCELbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029133; c=relaxed/simple;
	bh=FBAp7QXTdTxIcK1n7ZRiKy+2vN0cuhF+4SCsdQX1Lbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgK6iAGyM/Uoj4oYeSRKCkG1AmO7aKe06rumCg8mDm3Rx87iDxDFTd0/sR9suojOpGGXntwB4LWC2HSDHvCPCV+V0/qY2dRCNOtNVb5trZaC/s6Y63Ifn/Cb3fv67imINktKG9qA7THH3kbW3JzBYMVPSk3rpkPsylartQtlbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTB/xTPp; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89c68b0763aso31386196d6.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774029127; x=1774633927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5p/eh4c0iTvoIkHEi65nOWI9t/D4H6eibwcW0anhep4=;
        b=CTB/xTPpCYLXM75o6CT54Fue/4QrNWgco6q0jIF/svMoNgmgg6j3n8XI3nJrSUgPli
         wVHq18+InPVZ/Mu4fYG5Gy8c79dOiHzyItUT3AcHl0H26svf0Nk9ZJGF/bdv/UlWqxfK
         XKeT/qxJKSAceK0aZ0ppavlvsDcPAbZa/Fl5Tq76FfGKNSoi/UxU72nzhvp9aTmXxvTX
         w6ywWpevjnuuyMjv1DSOgw7CXYh88oxTbcuoCe0jPt6f9zwQiF60Xk6L/UMJ6i+ojVK0
         mA8Dgjm5Tm8mYxtuuQ/bjUGkjpB2IpuBRrVL6ETuEJ6w5FDNI3Xu7ipLQXBv6ZrjNEJ8
         uP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029127; x=1774633927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5p/eh4c0iTvoIkHEi65nOWI9t/D4H6eibwcW0anhep4=;
        b=PAkdZ8rWQ0p53FYeBazof1026E94L09JvDlxZrpdV8QeeeBRA9Vi7Itxfw2jhLXRf4
         T0Q7atQ/oJ6N/EzQuolXlQFPXCX4u0xPscTlRewSiZWCdPa3nlwtabwqwTmrXQgZRQwa
         pTOFUvbpHD2YS0gmvUM0hQuJEqJDQdscPrCjIS2KGvCa5vWGrTZ7Qz8wGFrWxTI41qF+
         fu9FLqC4Fn1xZ9+07xZpUx+wuXkdvXL8B6kRlU8ONEgMhiAPAw0mzDuUx9aHo0ndpG5g
         v5yOlN+/etHTIjpcvNKEa/B+0kdA76WL1C/OAtIgR1fX2yTXkX5uuuUUk/SCc2tK8gKT
         Ty7w==
X-Forwarded-Encrypted: i=1; AJvYcCXjBp4fzYB4L7XBCY2z5iyxdAl7aUMyKO1ebAzR2DS4ELLy8fiBcuMUpOKI6HMt8g64ARRXXSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKPYPiL0anajGHZecw9s0t3NPoHkS3xkZGMjP+hyExz7YjCn4
	5PaLA+MrdEgWVAbcBe9jRv0NHEBfvhcHulXWRDdcBJb9gV9ILUmU42F6VVOFwQ==
X-Gm-Gg: ATEYQzwTBVESVh2yDAhpwjVwwNDVxw3H+K0NKu5qCOljNyd3Ya29L8k2fewzIS5nuWo
	srF7ju0byeRIvrFlJRVPSNc/qlTzJQKfd8wVQtQ48wwESxzg3aOuwKhf7F+lvrT223J1taQ3aiq
	8hRUNFdEwrvHzxxkDwFRDAliTHoYcf8KO8OoXhH6wqf3JSHPGi/TyEYpggWh2jPzi16PaKvMYWc
	pxTTtBdTNmVafpPqSU1U9GiECWD532XRFMTPT2uchYFPkqoZPKpD6DSfKmm/gKstKO+LDwmkRt4
	5aV/2VOpr4YFNi6iDtCoHDQthhR4vRCw02gGF/7s3DIjrFZDh973txF7AzMAarfgDzeEbpgcZNh
	O83zhtAoGLwwbr/StcY1wjOYE3ScTJRjoPamORo81qWBlWLz1qxvrLv5v1YlV6Esbr4jekS7rz0
	TsTU6G/qRk64+uVrxNk6KSp5Xfe62akOG/yUdj7e0D4j2edJnHIg==
X-Received: by 2002:a05:6214:5c47:b0:899:e567:f04d with SMTP id 6a1803df08f44-89c859d08cfmr62371766d6.11.1774029127597;
        Fri, 20 Mar 2026 10:52:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85335771sm23656696d6.30.2026.03.20.10.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:52:06 -0700 (PDT)
Message-ID: <d3fd0282-da59-474c-bc42-0497d87e67ec@gmail.com>
Date: Fri, 20 Mar 2026 10:52:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/335] 6.18.19-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260318122621.714862892@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260318122621.714862892@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227599-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 850382DEF41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 05:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.19 release.
> There are 335 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Mar 2026 12:25:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.19-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

