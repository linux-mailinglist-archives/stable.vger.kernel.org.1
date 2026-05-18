Return-Path: <stable+bounces-249355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGQFKFxTC2qYFgUAu9opvQ
	(envelope-from <stable+bounces-249355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:58:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDCF571D09
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8C5302BDD4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17FB3890FE;
	Mon, 18 May 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGEPyNTu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71041388E59
	for <stable@vger.kernel.org>; Mon, 18 May 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127024; cv=none; b=rrayCaGB6SPvRkEEQs0rFE1DSh5LunJnYRvTLOnBu2iQ8Eg5nfpYs4WKSHElff1E30skJ9JIfXkJTZnvPSqeIPPRd9GSPSH2qIEuroOfsEXt/yS6KncE1p0eBKA3b4iAiFIy33lSH6F2sMKUyAPzq9evelEeyohQLx/YQNug/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127024; c=relaxed/simple;
	bh=6Ef5zUQkRYLoDGZqzyWK1Yo8k5u8LRci9fP876wsGh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBzpZRdnL/176rmABBY/Xb/2y584LZkwNoRjke8FDVG/q1Og7AqF5PSgmDsihy+lTU46pa9TJwETOPxluPTRMloknQIFzk1fNICHZ39ZYL+KzMEmdwvWYQCMhz0XCrJVh9j/K4nzguf/TU4Rnbl+lydVIaRpsjgbW2BXdZwtlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGEPyNTu; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1354403c610so6275574c88.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779127022; x=1779731822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fr9+LJpvYtC/XychbRKgUcRTqP2ZpjjZU2abiiQiSpk=;
        b=XGEPyNTuvMJlptIs18MwpNPCCu354mE5aIwu7gxCTHR0EbXcT4z/Cbk7HTcoHpgBzg
         NAbO6X+x3c01o6R6JlPlTg8bcqnOyDFwIAgmlpy5smNiddbAQcIGGxa1nUGAwXLCjcI8
         kFwKj309SKYH5DBtJjcqe1pjXmQhiPQpFrXWB+cjp8GjhT1tmAX4nJsD3fEbwFaXzV0b
         wWCHTLr5BQFclkDSmxV45DdK3eZsHlOqqLuNTNyxFaEnNOfLeE4pIkucr0OS8HWJfSO+
         CCrVLhSicA4NRrYo3wjAz2nPm+TgOIYoh+So+SLsZe03Iy//M+GNn9RxVCnZvYSXVe4c
         Sohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127022; x=1779731822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr9+LJpvYtC/XychbRKgUcRTqP2ZpjjZU2abiiQiSpk=;
        b=aqxph+JbW6mrxpE+11mpRm7w8/sL0b4VldrOMhzayODNMm7jIMuFhwd3ieHrO7c1cP
         G94dZPKWvZyXOcJJRDrii5ncPxE3hgCJwGLroTTvmzB0P0VAehbbnRQ6eqWA3JCGWaqX
         BrTbehMs5+zU4R5B0I1sKPS9qrwiquD/MPpgQt8JlMQBxKf6FXNW+AJqIvl2j3+AgFyf
         SeiHUdjqqBSQX4fJkiFaYsLTYk7B3wOoqZ0AJd/niRgNshjAIVHcgtGjp02YX6FCWezA
         K2Nn1j4oEUXUAwvJu0zh39lCGhhuIr3NfvQCIvmYkqNF83EWEt/lmNkJ1ZcKvYid1fMQ
         1vsA==
X-Forwarded-Encrypted: i=1; AFNElJ9aLF7w62S3AwHNetH1lztDP6Yj3KeQIFnB1xc4oyLRY8OBzt9YINaOd7i9la/SOn+Wh6jg+SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYN5awAfNDInl9/KASrciX8/xgwaTSNKeT5ky3LRELIekjHeBJ
	AeZvDNzl/MtYa8yNmU/CTKFhI4gk1Z/C8WUcAV07Lr83IO4we+co0egs
X-Gm-Gg: Acq92OH5g6nP+70djQWH2GaTOKIXNf4sKfY8oGa/h3FCnGcB+YYIGvKPHpKNd6YRZhd
	M3LGVNMq/Om8LJgbHhzPuTDwtf4Y7/e1ylmc2IO+IBFjH49xNJKYT5oLObD8CJVHMqpAkdOs0OF
	PGlFIC1nH4ikZYs3kVCvlR1LseLpYnY8Z40sNNNo9hAmSkWSw5Tw2IIx+hwK98v4x49cM37gHiM
	Q8I6GyZS2xZu1HOZb9ybcX8QHbrx0cFHbSZOnP/6lrCvo0yIjq8pVp8y0FGBiMBpeq2Y+5aiwD4
	pQD9iqRL5X9Td7icIKkbPCG6GsgTcuKkyUElMJXP+cg+1s4sJ0pJ3MN1PWbeZZ57KKDCPCKCzaZ
	tvNJKPRu6QTC0t2MKMCBix9qPgWBmbJ+vuLvVU6kCQeFf8aNquLriWKbNNOQ/PyIbErqBmIBp6P
	F+qCjBq+7zMbGu2vhtKsx1EyRuMDzFKamdHtuR1CT0EkRQpEvKOg==
X-Received: by 2002:a05:701a:c971:b0:12b:fb81:d69b with SMTP id a92af1059eb24-1350542e923mr7251767c88.19.1779127022438;
        Mon, 18 May 2026 10:57:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm19598533c88.8.2026.05.18.10.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 10:57:01 -0700 (PDT)
Message-ID: <3c16d6a1-1f5a-479a-95db-014f4c540ce5@gmail.com>
Date: Mon, 18 May 2026 10:56:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/143] 6.12.90-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260516102210.570453769@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260516102210.570453769@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249355-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Queue-Id: 0FDCF571D09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/16/26 03:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.90 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 18 May 2026 10:21:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.90-rc2.gz
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

