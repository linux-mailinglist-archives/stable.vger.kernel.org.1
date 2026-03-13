Return-Path: <stable+bounces-225238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAStKiKDs2msXQAAu9opvQ
	(envelope-from <stable+bounces-225238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:23:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72F27D0D6
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A91513025264
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D46346E71;
	Fri, 13 Mar 2026 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SmgIGrO6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E2346FB8
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372191; cv=none; b=MXjuywzRQJ4YzsqaIEDcllJcnqUL4s9yyREpGyrMvziv5c3tXES4iiRBrcSFf7jKUvQFpjo2NWBIHdZLeILkJPOtupzpObmzOXOEx2q3x9vgdyD9ceiaFtw0O7UGXVtOv0b7tSUFjDQfl6zSupyncz9VVgl6wWe/Szc4KgORdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372191; c=relaxed/simple;
	bh=iNtx4cifbRl2Sc8ccWVKiU5qNr4l0WUDIo1XKZDWgNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jURz+ajceIijQiJdknqP2sguCy1CosSDyR19MYv8ZZdDO8vi/rtoH/9cSyVy6lSEi+TKoawtMIUDHQpLcxo+LNhyWMXME9oWlp/RFNlcg2mfv6KqFHXmQ/WNOw6nyrtAqgxCXPgzEo+hXdtVfwJi6A71L+NmufMFWdIc4ZJFrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SmgIGrO6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50917417efbso15489821cf.0
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 20:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773372189; x=1773976989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIZxj34/6tLtqQGtdBOTqFM3e8/L5Xb8WQCotKqLWvI=;
        b=SmgIGrO6sGxKey3QiFANq7apRyoscE/ei+yPEYc/a1wELlMDzRCTrlWqYgGikgF/cz
         8lV8+8kJq68pdWSsedE1zrDDTS1WipH6KRBvTK38RAqRsdSwDF/q13lw5ZeHQvVU81NM
         Zk8S2cpfQtAhoHFgJkNvQIKC9a88RcJysNdHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773372189; x=1773976989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIZxj34/6tLtqQGtdBOTqFM3e8/L5Xb8WQCotKqLWvI=;
        b=H0UjJyhvV+0O2+6yPsjgs51SlZGWxSBFA4sGGtb+IyRpxz5x43T+g/v7efkcM2+Uq7
         r2AKKk5VytFlXVxu6gz9IewX95/w62mGwBOsS/N5UfkPBtLO40kJBzZiWzsQYOYTzQv6
         tcaJMjSd3lHDzBo1JWhkhyOFe2E0M/PppeybU5dxbhNvhAbgBFQPuah1HLqF8JX7XeK5
         IUJzvRYup25HpuoY5h4fo5WlbL1lhoJisR1Okj04dSXaw3JH8hIN8TmYgzItOYeHPz2C
         iF/9TLbBtOcvFaA2gWevuzQAqYhYdzRIE9/Cnnqa2uq+UH4Ejy/8q8ZJhXrJH8T5rjxG
         mTmw==
X-Forwarded-Encrypted: i=1; AJvYcCWgw8lWNK9iQqzha0MVwMYCo96hjeh1zBshMHJ7wXapX/xH0RViFutbMA1LzMIu3e/uhOTxbvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CsZ3t6uU8F7yNk6d1NmrbxA5I4tE6CaywtP5wiXJrx7pgmZi
	9SdKAMjN8dOtlBIVvkTyMwMJdOPzLjW6aPfA1fQ/f8t5Mmfk5vmRkL3k/2zDRUMj7NM=
X-Gm-Gg: ATEYQzwp9rnOOo5SH3TEKMIdJFmMIv9xKsgPjjmKe+55WHEIiCPW0si8s2mjK3GNY4d
	MpCkpqyiUG3SoSL1tpH56/A5SX28W4brc70U7p+HRsgzqr7F6nAOJ2lTpEdmwO/7GdqRTpwFzpK
	TsSpxz8+pQprHS+PrcgFQ5gucec/2ny1ChS9beUnB6M6YdMfOVW7VPL/fGhr07c41C+uGi0fK8m
	eJM5VbM9YIjW7ipKf28iuuFAglphAZkgO2kn4S1bLxx2pz1lRkC685Llw7iYA1GGE/4NqoLuCVp
	5fNuYbjlIqeKdq0DgfWxyredUcLIbcY17cz08N5yt3nLNW+JvBWMBg7tKT4524defxzpXqyjifX
	uQKAOokAp+7fHOi58OihscXldiN2coUzTj76qHZD66cojixYxuivF/tu60+uzLmock0rEyJVGUQ
	N8JcGPLoMZvAjFfo4EcWw4Vmc9Vcz/8SLJHB0=
X-Received: by 2002:a05:622a:5d3:b0:509:3fc5:a840 with SMTP id d75a77b69052e-5095717e1bfmr27668161cf.10.1773372188701;
        Thu, 12 Mar 2026 20:23:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a14791dsm46384471cf.31.2026.03.12.20.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 20:23:08 -0700 (PDT)
Message-ID: <90590550-cc47-4eef-aea5-64e0df96f8cb@linuxfoundation.org>
Date: Thu, 12 Mar 2026 21:23:05 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/13] 6.18.18-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260312200326.246396673@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312200326.246396673@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-225238-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 4F72F27D0D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 14:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.18 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Mar 2026 20:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.18-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

