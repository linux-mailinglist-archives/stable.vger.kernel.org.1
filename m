Return-Path: <stable+bounces-215572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hSPICclmimkHKAAAu9opvQ
	(envelope-from <stable+bounces-215572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 23:59:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4A811548C
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 23:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73B2F30242B8
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 22:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255DC318ECB;
	Mon,  9 Feb 2026 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNC9ktNQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2D30C60D
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770677954; cv=none; b=qhXjQzdNWasEbwRbVEatMdGXnFl6jlDly5S34prRZNb7QehVmh9yLMSn8ztJ8AjJkoHEEUrJ9GEqznxt/M4tKBVQvYd+XGlfEHrYiY1CiPCv5+ARRrbImJ0ZeuZscONNj4FVEmWN/2+K9OZ7stxKi9l40rRPKAVJ3gCDk/3Pq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770677954; c=relaxed/simple;
	bh=j21Bg9Hu1UR/YbZ0GmOKFVH5gHIFsMLusYKnkEAJW8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpzmFC/BvBnNmr4hjbT34W7X7c6z8QHLZH4WY+pEyfkgwBJbi4kq3QSi8llL6a149DC7TyeGk3fcc8FqBYo1xOPlLGg+tUMGGPXLxMlVU48YaQximKHWf6AKZfPjJtHGwnSb45Rh0IBysEUNSnLa2T2TcEJ7XmBcIB/EAu7McME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNC9ktNQ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba6a33f58fso760055eec.0
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770677953; x=1771282753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwRl2jgVQ7pdHo4zbbwuiuP4OVpWvxht5MYoo80zj8E=;
        b=XNC9ktNQQi4mImpGLc62ZtzmZ/uiy+8/iP9YmXUwy35vj1yXb29u8T/TdOoUTZZ+32
         l7XvIF+JjBUwlL6hQq7UsA6FHc9+0mBmpb/3G+ci1JWvtwUWFeF9ftyJhjnd6kh5iFTN
         CZPO3rOQGlBaUIDG/uTRHsrliEeJICgrXB1ifFk5f0Oa9w7BdykHIcmdd/TSvtfOIHyL
         R+BEWILswgEKuvpjRS0o0ctL+8nGuq8rseELRrOWqJ+Ca2gaK8ZZPtvGdt6iyVea3BU5
         S8WnlojwbfsQeFhEMNcYWVV3dZeHnkZtNzG0Y8gVECQVDJXRkwdl9Z+TYBp86LcJhN9/
         ZR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770677953; x=1771282753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwRl2jgVQ7pdHo4zbbwuiuP4OVpWvxht5MYoo80zj8E=;
        b=t1KtRwYIoRH2C6RYIDONAdMhpi1kbPT/jJXgDB2NbcXQ0Bdo/mtquEZk5eBsm8YbGh
         /wgi589+yCSzt2F3KBJjiSb2K5oWhtuqX3cAqmQdit+ojG8mUTf7shrSwgoB+GLXW7xo
         lFnIkUz1OYusIBu7HhB+a6qq6WAxg8V8jgi+CsP0JeJ3M8IfBLbh+rwDp8R7pMgE90gC
         2RNMXNaf/z2ZOh0jJyWYInTt7dTPEAZRjyQufwiLKkcoU6ehIXSeRkz0m11YMBOqGOmR
         vlYJR9xKxObpS3Gk8Jb7diNSjId3/FHiLquRG6CdcpbfRdTCN/jJWsys8T0E2+e0qqfM
         L7ew==
X-Forwarded-Encrypted: i=1; AJvYcCXqQqjU05cj+kVyOaklLo7BQxEsV7OFY8K4GoQl/O4JzxnLjiILWtiA/a9agJg3bkjtuEf2DCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtt4xxkj/EQ3qfvnWGW+x1fZdyDNJuymJ0Qsmvpkxxj5I+iZQf
	OLsy+OjOcUPr8DLUGMnIRevIwQ1Mtecv4VArxkkQe3YI+Sx4CBOm8SJP
X-Gm-Gg: AZuq6aL9P+4wiID3PpH5dVFzT770YNjH8+YbmZ2XGTL+s95+z32Lgajn8PxpoCtDTNX
	B15535Q/0CMJ1L75JL7MatYRWgPqdOtKLQRC10oQf595cGG9hmkY5/1nFGDCtaBDUfczD5LZnxq
	Ya8zLKPB8jf7BYrfl1Xg35GC5v9tFwfuJPQ+O45FzxEMc+iRjiPtTwuitdvikn+M2OtDJ7LSEB2
	+iGGCJkrEhr5SJtfm9ajqMQrgJ8uFlUFv6wAd+VAvnPKS1u/BI5DdXLc93KrsLk72c8lnOAb1Ss
	nqKMVml04pFH4+VKO1M8Y/7CRrdzOyg6iy24ulOgR1RO/BYhRkjKHm/lA4JzhwuhDDj0/QYNhb7
	OpRwDCDImIedngs8wzTmPI8h4DA0LerIeTFwc6NzGhXsb4i16QAMY5r8WDe8dsES+CPCG8E8dEq
	kx0vOEUo0YtIr8OjJIrE0+/x7wv53MJZH7ZyQ+cxqrHt9W4KYWbH0xSTWki76o1tQ=
X-Received: by 2002:a05:7300:cd97:b0:2ba:86e5:f0be with SMTP id 5a478bee46e88-2ba8a0c8215mr125500eec.17.1770677952675;
        Mon, 09 Feb 2026 14:59:12 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba6ac0cd26sm3864791eec.18.2026.02.09.14.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 14:59:12 -0800 (PST)
Message-ID: <383e1853-68e5-4521-b344-0d41ee5e2b6b@gmail.com>
Date: Mon, 9 Feb 2026 14:59:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/86] 6.6.124-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260209142304.770150175@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215572-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 8D4A811548C
X-Rspamd-Action: no action



On 2/9/2026 6:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.124 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.124-rc1.gz
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


