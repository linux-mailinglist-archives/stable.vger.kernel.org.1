Return-Path: <stable+bounces-200740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9348ACB3DB1
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 20:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C10306220B
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89540329371;
	Wed, 10 Dec 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POTNLwJH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63626CE23
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765394822; cv=none; b=nRkVAJoiaXYE9G+zbE6fc1S/KCkRjVIINJAgcVh317DBeU1M+sW1SihRawOwayQErwkSljzvismlZ0qS/d8AsQS2Ag+EOo3Wm/xKaevh368Ui4m2pcakIzhhRLgfjBEFmaILgQx4eDjPqTKEgZyTCKIGI2EPxZ78nAzXKFbvqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765394822; c=relaxed/simple;
	bh=PVIFrxcI8a6iClue/AecDfT+Cgc+g6BwZWAHt0f7lNw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZuMZYTrkm8hqSlpxkji/aJvA0cPt9i3fM4ZWoQP2tzcVz0CUHZu6b0aoKE8NHGYfDnWSrpFnf2eN1LLgePe53QOcCrDjSmQSLSv3aCGotGL/4NzPhYuxZIU4EC1pl98YL0jJgyiLrEfvoGoPChrHPjwB7O5CSey5+jEufQPfkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POTNLwJH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b9f73728e8so24122985a.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765394820; x=1765999620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/q98iSrJdM4mfCqPOnP7IYL1OiEgoSGBl1IkGB/3Aj8=;
        b=POTNLwJH0G9REg1nKaeSYsvLBLrOjohBhOeMai7PazTfu+EBcLra/RQMEW0LNcRHvI
         SRLuAoDnESSHkEgtTwSVUMVS+NilkoXFICttVrx7cPnBjsax66D2mQ2tqLtXXRN281E4
         dzpFS3TE6UDSyuIV+3LMKJtOYKKhHFtnp+LADZJtY8UohRWg94FtvqiNI4utucW4rfvE
         cmZL09HelHb7fTUmjpkZXLP2LpL/NkMHqDlnn4MVV1fTqa0MUbLTaX31OSvNiyQFa//j
         TbmCJaUQKTSSOoQaXdYFtoCN+ncMzUAUJz07OlkfLgG/oqr7q0sTiwH2LSWTuThH49JO
         libQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765394820; x=1765999620;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q98iSrJdM4mfCqPOnP7IYL1OiEgoSGBl1IkGB/3Aj8=;
        b=ltE1E6Y7DJWvzl7d6kKHJgZT/u2PmnJG0U6NCpKoTaBPPyMTNZlWTpWxBTr6pBNrXD
         cCcS92kfq5YyWP95cjkHUwPf3hegum5cyDAIwWG8NxFITsRNmC0hgKYu+C+kl0C4HrXy
         DmU0wjspoY9+vrzzECS8SPyj9p6W+jsTDdada2Ey/8eIq+OVoWFyq5IT7DCUI6lUcgSi
         LZWeZ35mJe68vhZ7shBbhkFFnS+54IDyPmESxOAVwIEkz6lMEj6lv7CdfQ0bJ14LIYVb
         Qtrd9qxpOLJDSIFHMBkiNbsdAIllhnWV/Z6cP4jgyf44KXjDMSO5ZF8Z+31gVNG9cxJF
         ozrA==
X-Forwarded-Encrypted: i=1; AJvYcCX14mg3/NgS0kWa1Omk4E0HKzPki/BJqF8r/JPlwsmIBtpX5IJW7Posf1Jv1bewMdTwJyJ6Je8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTkBewQejkjll8Wlf1II6ZHmB6Ng5AmfJiXONW9i0E9DTyvq1
	G6IHh4ptD62ku4/LiWKmbtIKuy8J7+yBRJ6kv/zhIOOh+sUZ6rujtPSu
X-Gm-Gg: ASbGncsYqi2z0sedTB4bl8rlKS1Ju34ME2Uv3f1DgdOqJEuxZOzx8NIjV8K67URVQol
	ZtVHnp8cQvt7nN/d6UrzDep7ku2RqelRQAG+VDUkmKEnP7rqb8VEEuthXNFfFpMKrWbpRxg2QfS
	7SvIS2GLfEqOD+7Rib6seynRWgxp6vgKoYDn/djHVQblFYIIf47p+/mnpALgWSL8vDt/bXy464M
	XS+1HKamDWmXVGcvtQiAFZTxLU9TAcF0qlt3bz2fcKEZFiQFaxcGFsfXZZjhbzMaCeEqsaUhhmA
	Dha2WYCr0osReTkyVYc6FIQlWXsOyDA/lGfK23J6Ao+n2OcYQVf8Zp31uewyQkR7XAx77h6tBxn
	JMXFe/jSMxNo2pjzzr3AhOFsHLgQ7LtVc9YEI77VS0Ok+hOUHVF1koTzhx2INxk5tmNniDIsz03
	CEOeoPv0F3PI/UXXg+rw3XQ4VPQ/RpcTSw3n3QaE+K6Qw2in8s
X-Google-Smtp-Source: AGHT+IG6+0Kk0tHL/n5UjwxVSbyrFw1tcuQwlM2/4x05hTxL/GrdPc0gIjMHpAINCgx/FcO2tXZQbg==
X-Received: by 2002:a05:620a:6cc3:b0:866:1327:82e9 with SMTP id af79cd13be357-8ba39a2e126mr570904285a.16.1765394819731;
        Wed, 10 Dec 2025 11:26:59 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886ef1a0f7sm4207786d6.49.2025.12.10.11.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 11:26:58 -0800 (PST)
Message-ID: <f8fb8c9b-9ae1-4a80-9f56-bba76e1a0602@gmail.com>
Date: Wed, 10 Dec 2025 11:26:53 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251210072948.125620687@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/9/2025 11:29 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.62 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 12 Dec 2025 07:29:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.62-rc1.gz
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


