Return-Path: <stable+bounces-230004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMPqDG2awWlNUAQAu9opvQ
	(envelope-from <stable+bounces-230004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:54:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED552FCAC3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE73D30417B8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE693845BA;
	Mon, 23 Mar 2026 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAEYA/RX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCB3446A6
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294200; cv=none; b=P7C7WrkgQmUjaPTsRMIs9thP2Sz2M6TgUSEDssIgaU+NcYiMyQhLpXOqCOSWqZSYpHyaig0W+iDp7MRs5nB84EWYSfZ6KhQn3D1o3HTtOz15hSHkQAOhIUgeiwy+/t9T+wdLNGh5OeF0aFqZMLxWnS4FOdQlQ2zzxXN0Ven7Io8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294200; c=relaxed/simple;
	bh=bh6nVtKx5UAPlvUFk8STPbZr2xUBTzQCe+ZYTkyL85c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKSb4rMmLVgKfAb4qW8VT+G5yuEOh9yfVhzYu6yt+sqSsQEFB+uVaiwXtN1OnWzZQbK9l/YXdemiJm6aEbzMSl8X/sa37r/oYyWx0Gxh0faJ919HpncepLmkx/samS/V7vk6Z4E+JuiWkYuICdyfEzbl8HRaLL/VFcddfMWdwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAEYA/RX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506362ac5f7so29554041cf.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774294198; x=1774898998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C49F6R+pPz/MfSx3LZ66CVd5NvbFdip2CBdIxmcwAXo=;
        b=iAEYA/RXfLc6UdDaCVvgRKQkAr0v2fSdbWywTMfhqN70bqlhNbWTXuILIpaSgyI4I6
         m6x0axKSnfDhKtSkdr9YXdXNfcNGYs5L8G/YrjN2NmClCZ25FNT2xP8zEr49Ra+rB737
         NqwplMW0svLQdqS+4flqhw05KI/X6/ddYPMcK9osaARV0k2Ny4/1m1n76KFTzI2vfZkg
         WN1A9WrUbz/uHkfsXzbLhns4wN9OKlICll+6uBsQKxZFA6hxuSUH6lWxVUhYEh07Fpzg
         NTYJfzcIT95i3I6Z9IEM2MSzBiNa43VXVC3nIWXNbw+H0dd/ibvvFkn2gIEw5efRAt9Y
         9odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294198; x=1774898998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C49F6R+pPz/MfSx3LZ66CVd5NvbFdip2CBdIxmcwAXo=;
        b=JeBT1jVvKoejOMaaZsBTd3IkWgNl5oVN76+Ih64hHqb9kZHZ2y0SerMq9M01YkyvEm
         nGIP4bAzyOPXvgS/WilzKAjgcavU5Hg9McSAOkJfom13h49LHtiw2+e6thMNebr+o4Mz
         k3PIwMvR3rAKciNezQxnizQthFwzORInSPtluetv8rp7r6q4xJcGqsQPKo7OT6DyjUME
         BWyri1RAqDQG8UDnog+AfB4NeEEUg+eE9FufmqdxapK9ZZAAeXoEYrGZNPcZsrdf5pMC
         bnNra2QElAW4dTXsqJ4H43Nlp5BcqcRufrTxqi17baA+CAeOXDtjJyfx94eDqL2kgCVs
         slhg==
X-Forwarded-Encrypted: i=1; AJvYcCU3VfRWuhZ8bvxCl3h3tm+P8qO5bbvsfeeqkVujXc+jZha04wrLpox9BV2ZHHV38lFf5roJC2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4NZen3iM11SKElDgNjNymrhwVWDmMp66ZITvRgPsQLssMBV3
	WuDvDBXvJeNVZEkI6YsA4XRxKhT+nNqadMXMnU+qt9XomCQzZ+jYsZz7
X-Gm-Gg: ATEYQzzUN6ojfi40NpSICBoh8WFPfpytbKr+30/Sl1lr6cORGgwpznmSnADvMZft/0C
	dHVMIad8M8kXMmp8qM+2icVgCQkIV8p1YKWHE9HzFutqJiBVOFrLCCNq+6qzxA/BF64AC6tIM+J
	vLz0yCeRe5BlWgQnSgZjCmZMwZDOhRCYzl9kAiEFg++AJ9kKBLTqvVYep9F6m3qgcLCA5p8Ckdf
	8fOtFisplVlPOEJWuRlKI7+fNRWp0Ive19HPSIIA1zl44gk/EZtAIPwUG1B7DxvZ4LaXKUIOALH
	NebvDyPW3lgcqtdcbut8caqioF6iGJvcHKxX0TPy7F4O7Y+RluMmfbiJdj8WOIkaIaiSDpwNCVr
	M/rRmWA8ELwJnrIp61tcYisR7h+9uU5OzoR8q7dbq3CeRwXE3ZyoiAR932dYMxQKwkk02pAkND8
	uzIrTHqDv0G/V6R92BVI94VnfwbmC+plQnN7ujGFNTa9kBePGRPxuXWzxLbZ6P
X-Received: by 2002:a05:622a:248d:b0:50b:4f5a:b0fd with SMTP id d75a77b69052e-50b4f5abba4mr116611701cf.70.1774294198067;
        Mon, 23 Mar 2026 12:29:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e9ea39sm88890421cf.28.2026.03.23.12.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 12:29:56 -0700 (PDT)
Message-ID: <be4b8ac7-68b8-4fdb-90bb-daa9e5f2cff8@gmail.com>
Date: Mon, 23 Mar 2026 12:29:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/567] 6.6.130-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260323134533.749096647@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230004-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 8ED552FCAC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 06:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.130 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.130-rc1.gz
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

