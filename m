Return-Path: <stable+bounces-240206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA2pF0Kr52kM/AEAu9opvQ
	(envelope-from <stable+bounces-240206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:52:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8D343D9B2
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D810F3082AA9
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE38237BE7E;
	Tue, 21 Apr 2026 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L8bZVMLj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68782362156
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790064; cv=none; b=o3BhmIKfkb/KUjVCSSYanIeVUQsvCyzVeiGJUiLBXr8IUetSUU1pjFOvRj1rvmTdEb3giGPYSuSxRampcuQt+pBBLazDxiWpCbURSG4HIMjxE0aKvQ/0+wpc8NL5P13NugrXl39fJSkRAAw6lV0ylZROijVvu9hKhetWWHDXApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790064; c=relaxed/simple;
	bh=rzyvId4uK05JEtp0z7aiwfMKxJW9XdrPBsxYlXrWwPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3Gmya7i09UIndlYW6rufdzc6fx30yvHbT+t1IeQQCnRgNUzn7uJllGVTNm0EdHQHwXb7Mg5rT5ouoSrG/ZU3cN/hljfzGyGstim6sbYKcW7Ih5VQpev3Dz9j+RgmKocBHEMJv2VtHaootz7Wm29Ok0gQ8pmmADsU4FEQHAc2QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L8bZVMLj; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbba5076c8so2480850a34.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776790062; x=1777394862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz5WxDcfM8XI3iueWbqq2OAOWxZLAUEDV+X56vrw7WY=;
        b=L8bZVMLjEYrYmNc5lVB5jYH822VfWLUq97Uwhw38n9uguW2GWBhBAqU9fLA9+j4uha
         QbHBK5y0ssbkwthauZZIl0pUx36Tni+l45c9hPFP79IE7s44zeTUA/LwbsJ+82XKrISl
         wNvukeNe/BLdaJtlhGAAwCdN4oqNefHcySPzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790062; x=1777394862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz5WxDcfM8XI3iueWbqq2OAOWxZLAUEDV+X56vrw7WY=;
        b=GVmjx56Ms0AZ9uLvKDiqyT0bon2Le6lEzM9g3M9TiPpe3eCq7Kwr2hMAs1oLiFUkBK
         3yPVFZ7fxkzt1VzgePdav1X7NRFoI+JY+MNPySFaNzcK2v2ev+72ALx0NP+cme67A0jI
         xESAzDpClhcFdEdsLb4WIW4Q5F3PelCPNUsAFhd/L9Ao1Y8Ze74Yj2sJVaGqd6oJRhDY
         vdrtFn+PaL4cesooX6Vw2uQXVxDFeboUA+LryHfm7tmg5tDCzMUCTcvM5P9ZBx0NqRnX
         3+hZnpc0fCcfx+Z9Px/4VuYTYKbO7+HGMbf4Z5OQ2FA3/UPI8/pNPXlw1ZEqsPXtwEem
         wlnw==
X-Forwarded-Encrypted: i=1; AFNElJ84uxoCiKTlyC2cB3zPT6hKDvtY2xAEAAZnijpkLCPnalqBaijcBg9NZ95fy27qymoR6Sfnnpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlklEm9OZnvlgINb1QVaDy7e0QF3SndJDr50ROmneHD4LErkWU
	JCTu4c9GXJuiZTSwYh/ULndsbIa0k9YDuUhCucO3EwYTU3gBUHLFHCn5iuLWk7Ii7Kc=
X-Gm-Gg: AeBDieurlmWqUPOHrRoL3aeE73Z/4gzWltWXxiwgf/0x1CpTR7v2QiJu6T4ineV+tbv
	7SO9CWtXCL8n3Y/z7XhsnCDmQh6Zsxz29+gm24g8ofxWY79X/gEM08em4rkQjQ5ElrCZUsDu9Ts
	ml7svfDNSBOK3TAQhmdMm0wQiWglfKhK1/nr9OuvaaFJyeO3U5JUDReSdKXN0ZFsjZAeRj/IugW
	zlRkWcQozK055ktcp6P6Hxdzy9fEu3oRmCEnS6hcUgEFOQvZboljHDNAZG9PQzm8ImZxqTufwPQ
	9fGmuWXjZAEOJ4DrXENxVCIIHgpeo1D2pbWQ7kCql4q7oqPkyFKB+vQB65CylP9Ijm1lSaILNWt
	/zh/SoLEID6qS/NZBhh47DwHCaaC78jvCsRK4rXLkE9xlv0S8I+TNh1jjmMzQB8m+olo297R0XM
	LO6p/HFODxDp+3x0OwlQAHFEaPEyjIswiVM60yCThJ+Q==
X-Received: by 2002:a4a:ee87:0:b0:67d:e140:344a with SMTP id 006d021491bc7-69462f0ed74mr9175225eaf.40.1776790062364;
        Tue, 21 Apr 2026 09:47:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464eeee56sm9071478eaf.8.2026.04.21.09.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 09:47:41 -0700 (PDT)
Message-ID: <937497be-3500-4ab4-81da-d05ed17f03ed@linuxfoundation.org>
Date: Tue, 21 Apr 2026 10:47:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/220] 6.19.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-240206-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: BB8D343D9B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 09:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.14 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

