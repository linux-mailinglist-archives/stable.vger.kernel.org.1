Return-Path: <stable+bounces-219677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMSeIRA2n2nTZQQAu9opvQ
	(envelope-from <stable+bounces-219677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:49:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD8919BC50
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A32AA301D978
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477634029E;
	Wed, 25 Feb 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF5fXwaB"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94A2DA775
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041741; cv=none; b=QrlbPWTn5JicNZ24+dv2KyWNX2dO22jFDv3U4+KIrHiKVb7wkUPGA4sfdybU8vUQFfE4Qe9ScDKQNocc4iKPWnIet/MJqkPCJNn+G3nkxkM1qqW0AoF4wWai+/QwhmComGleP3A267YZR3dUd+vbsMj53NBokILIaKNLSeN/1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041741; c=relaxed/simple;
	bh=LZxpww8qtNfmNYjyTXg4wiB+YYp7xy2/ZaBoEhlwrIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbR+d8eolxDu5H7qoCx7+TsB64E13zNd9P51H1F4WRM+YcA8aEGNXy5xB55RR1VKm7Jr9aLx1MU0GCiIlf9l3uSgY5TaiYNp8eGpSdjwDXf+9FA47CQCrWidlLfktV61tYYMEU7Tx6V6bvl+56uayAZ8FDJ1E3TMxXOiVsAUahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF5fXwaB; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdcb30fe8aso995967eec.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772041739; x=1772646539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=172Oa8jwqVe0zsnsyEKr+GT+lGU4uwg4tXRbJreHs3I=;
        b=UF5fXwaBVQjEB3+CcMMZny7TO6LroNk5zKrrY0slckIAoYgPj6WB/30kcR1HxpP6Ap
         nvqd6Dl4rWKUmCley5l4XfHq1fUcJWE4nCfwAQriykdNNHC3EJf/gfbZxGYZxwLWpj2z
         OWe7Z+8/ko8Ha3Q/L+k/mYEuK3F+6g4yCgCuXIATp8+ByyxrrErut6fCvYRSFbC5ae95
         JjlZfWVKHPLxhvQvx1MbN5gPWVOB3whZnHczNwmOccLNIG1+YUlZuBjfX5YgRIecsUwe
         xtwPXeRk7Zw+d4GOvBgKFRngLoDmQF+TbRHjc1h8E9x7+EJs1rZmg7aNYU151gZIKPaV
         0ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772041739; x=1772646539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=172Oa8jwqVe0zsnsyEKr+GT+lGU4uwg4tXRbJreHs3I=;
        b=R/uuaWVy4PViuyOu1Q8PAteO4EKKnohaT9neNb5NUlX/vK2uekWSffrCvOLR4MRH7q
         m2SNo0QfFVjo1qCd9LgZXt+7D71dPKFFp5CIas0hsqC7SxAZThVN06J5BE45XtVNcdB8
         JyXE0ApV2Lq2d9HbHRtQ+mGlpSZgFPuGIezyc6QDdvS9glooRI9OBLu/F0TR+/FKciH0
         5VzkEKX0HNZkjujwl8pwPKQwZjXoUZ9VwD9dN3rJEFw7NtHTDygEzxYnmaDx8IbhKXgZ
         v0vecH9jYonk6ZawPUBk8yxSONCHN37iS8k7FRsNxqwRZylxqDHgiE5INNjI7N/VCD+r
         JcAw==
X-Forwarded-Encrypted: i=1; AJvYcCUdOQZ96sC0i6ocpfxYjlGuzZmCp8kcgIciKXSu6NWDE7XsKDLxM2wx2g5yjnmLRSHE+pFMskw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKDYcte/U5G2YiCY9ZIUPutR5E6vZbLZ1xqto2Uq6EPVqF1Ucr
	Sa6yb03RGay+pbptxmMqCuHDnsSiLTUpLtuWpDDeqNK81C0U0rfOmm/+
X-Gm-Gg: ATEYQzysRJoTkMiBXL/QqcWw2bpK1Tlj+EU5rHo3UunbqFZSTezLmcKPzvk5iqvmz+t
	MwO4FSDMR+T8dkVDRPOaarUtIjc7jQlQHSTTlPLjvpJonXilEu7YGM1oXdtAn1AhA8T0pwMNJkL
	aB0jb75J7WUu4kQ7RqZhzBjgR2UaGoaPzclqgDBcQYoCnNwvjRuoaq3KuJ9yXBNMABJo5e7sqk0
	YPc1K5I8h8YZN8Y5R3NeWmw4KjUcQ15XgMlqjOBc3aJB77hFSV/QQzjIF9X/Q9E2ES8fhnPjqqP
	0nznvmPINatWE217G1d0QnVf8BHFBBT9kSj2uo0Zuk9MJkIIbh1gmH3rHniSat28dIkZR+maIuh
	6GFSBGPKFXZMvEHfgOk6e5Ml61efZddoi8DE9uOZv5TVW28lpFVpyibyqT4QysAu3VQa2vIrFcg
	58jn+FMkBF1sPLNJF9wU8KwHwb5OJ1e+//RIIBDj+Ez4rjlwpowg==
X-Received: by 2002:a05:7300:80c7:b0:2ae:5bde:a5c5 with SMTP id 5a478bee46e88-2bd7bd3578emr8168287eec.30.1772041739091;
        Wed, 25 Feb 2026 09:48:59 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da4775dsm9397487eec.2.2026.02.25.09.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 09:48:57 -0800 (PST)
Message-ID: <7a610f1c-8748-4361-b5dd-86de80c95aae@gmail.com>
Date: Wed, 25 Feb 2026 09:48:56 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260225151847.709818960@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260225151847.709818960@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219677-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAD8919BC50
X-Rspamd-Action: no action

On 2/25/26 07:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.14 release.
> There are 641 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Feb 2026 15:17:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.14-rc2.gz
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

