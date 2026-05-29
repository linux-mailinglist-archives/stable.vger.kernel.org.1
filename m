Return-Path: <stable+bounces-256781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLhcJ0D1GWp/0AgAu9opvQ
	(envelope-from <stable+bounces-256781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:21:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4A608720
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 563853050FDC
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623D3AFCE2;
	Fri, 29 May 2026 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZsDTxz4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172E3B27F1
	for <stable@vger.kernel.org>; Fri, 29 May 2026 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085970; cv=none; b=IVYuDJapeV/KbqWiB/Cpf7XemzgsD7Sz+WdKYp4cojtm1ta2hIXmwl7oZguTX4C8r+RgGyzXPRvBh4/O2tyA7RYf6ap//Twq3x9uECwFsihKq14lr/VNR9mptVkm63Uf7WPvwbfcPnaaEfpvMOHGANygYhy1lozvDOsufj7U8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085970; c=relaxed/simple;
	bh=STzH8eny5uuaKC/00hnekg9WJ72mmM2AoVi3Zh4yXUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLAvKxRc6UrphNz1yb2CG0NS9SeUkgKy6YK8yVTGB2gBz3OitVk/GF1JA6L5ARDdlj/QYFMUpeDwF8OML+DKzlBhqT/G5QYLb/oWP3QlWzECVUs/SI2TOsNlIgQg7Hcvf1MW/Fdf7cgomi8SXqFxAK8sPqNPdA42DTcvegky5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZsDTxz4; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1370417c01cso7252924c88.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780085969; x=1780690769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FM5MWghC9sQ/5zvBJBTe/TB1mM92Y/a8Nl9pCm7IVVI=;
        b=lZsDTxz4hfiPtDbUwZzSeKcVK86LhN3jLbe/iNv6Bl80CBh0VzVK9R3uboN3P/tN6b
         rC44mn71WIw3CpQQLGq2UlS1HsdilueBRW1XOV9A0z87Gs+8Lue50M66WOwoyDom5XY1
         UbaRl+VVvZi2Pxa21t9U9WaJ0Xr9vc9DSkoFRB2jXIK3KJFi/izOXPjKEwPbzStINczD
         dzBwoo/4vd6x8ghuUrTSG9nGum9ZVMH605J9MnRAFt0/fwoNG3lxySNXIZnL/xkIEJEJ
         4XxeN9pYSKSPBiW2fKBBgPzA7PBk8b0+JIZzayIczAWX6utqxJBLGn2T9WloUO4NFVZA
         VUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085969; x=1780690769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM5MWghC9sQ/5zvBJBTe/TB1mM92Y/a8Nl9pCm7IVVI=;
        b=pJDZDyIU6apqy8B5N3kD53NC91RU6oLfAbtmJ10kHgsH68zOCIhCDHkLxSqE9rIY6c
         cErBfLaDT+mD3E33OcuY9JxBnB+uB0RkIygOA2V/PGxFBPCL2Fqu4OPcKjukjUX1N021
         5tvLJNkiIOkxSpUO8nGqmlqwC/FlLafxrq415k8x3FMlgqBmWsmQtg/ltCQYN9wjKiFU
         cWbPp3/jgLYAF75IHQS4FYL2L5snSpJNWuwDK2b5lD8JC36vwFJQ3JsQr+lTFJsz1zxy
         rNpeQMrI/f/+kZXTZAUC89VRkv2kvOKazvgZV8/SpqKhS4oazHKjMsPBq3qnS5/95lMp
         gOXw==
X-Forwarded-Encrypted: i=1; AFNElJ/c/mwQmlq2H81BqpYp5NroopRdWyIClaQEC0fTaB8tLAUcPbW7tRAvuebAvOxG7/zndFWxtVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWfnh12Y0RQSMihX95rRhnThk8ynxX3Kpj55dIIn7AjlpsYTH
	fClzU/Kejr18T9pLgWtwAAcXJVZlEuxX7dHQuwcMV8Iqd4C03kHK5BmL
X-Gm-Gg: Acq92OHvsV2efW9XK5ypAhZNVSEaL4q2qglHjRWSwDJwSv8AqqDTp6LkAu0ma2Hp+1H
	2g3pkYYjKk2rD/qC3yf44TyscfTAEDNDwHuqrhKC9Rwva8FOlpMGtFss7EOdEeKDNrroSQf/41c
	6bNLM/XZwcgViNHSXVIBKjCBHoOV69F+vrd1QiRuEarqAo3xcQa1SDy3zRivaaL1Vwyf/QY3OV2
	SdaGZr43XAWyRHYgDJq+5zJ/pKLLZ+d9nD/tcym5DyKJBRDjr2LUZhDKdBYgBTu9iEydh7FRG++
	PMcYFbtEs4wS/q0rkM92NIsVDQimOKvb0AjiRJowoIRXxS2TKX0QWCsUqrNiBaQglZQgZEwjSz7
	0pB1Cu5LT19tQnJioFBZ1mXeWtCbGjOxmEYYelBezCbbIlBvTLren2yE5MqlcA+4wSG1LTNFxCB
	3MEVNyWW0V/ltr+Is9PRD0IRB48cfb9yHKGiXyx4BzvVgagM38XNzOQRklpXUy
X-Received: by 2002:a05:7022:e24:b0:134:df4a:2821 with SMTP id a92af1059eb24-137d42a2f43mr622802c88.40.1780085968738;
        Fri, 29 May 2026 13:19:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3d8f839sm1706299c88.15.2026.05.29.13.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 13:19:28 -0700 (PDT)
Message-ID: <1c493242-3751-42ee-8ca5-b76608099bb8@gmail.com>
Date: Fri, 29 May 2026 13:19:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260528194646.819809818@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-256781-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 40F4A608720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 12:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.11 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 30 May 2026 19:45:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.11-rc1.gz
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

