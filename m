Return-Path: <stable+bounces-217197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LUOIML2lGlzJQIAu9opvQ
	(envelope-from <stable+bounces-217197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 00:16:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E0D151C28
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 00:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36BEB302F242
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A9E2F39A3;
	Tue, 17 Feb 2026 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPiJ7G4K"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2431254841
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370163; cv=none; b=s/KaDZq4iTCs0K8vIEFO9F6kbuCtRBq8qVecka/mKWH6Jvk4040hBq5iBNWoF7qp05uwEmRRqjZF9Nkseb+9S9wCCuGC6wAV3qu5gruEKdbwkv5reIODhTDGZlK3bqfCNEb/6QbNTK7v5boaphkjXq9Lz8Bh3e81zJoIB1afocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370163; c=relaxed/simple;
	bh=1PD739t4ZS0LVSBx19VywvEm0CBVJ9CSO2WxAAT3dNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6aYBRDds4l5g0BHlSTp0mAux3hsFOikzgPFteUTzU7bm5PSLsxEl+HkPDwhPY0cLhS0Rl65ErdciIvwWQ329QbEkeq+x9tyUtcb4CBZSeE3MmgnG3S5a8EU47N6f8U/1a+vQicrhbUwEitnQoAl/e+JP1H2CgZOVe1iJg+Dy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPiJ7G4K; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2baa6ec5638so157945eec.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771370161; x=1771974961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pcMrv+r41UeNiqyFo02w1fzNFCK6uftWPvZvbC+3wM=;
        b=SPiJ7G4Ko+5T7b1Q/WUvHnKtXLnZuXgK7Fx9NeHnq3hcrbaPuWylma7hJ3W40PazAd
         ucJSKiTs7vmpSLb+ayGR80YX5nXVV6m00H9rALFj2dHGZ2/bn/TUV0kSzGqriXN22yQG
         och8oZyDi97Ep2nsnYteU4k6tLDZQkwbdWA/6dgXRQ3sN89PqNZlCQ/WVAPOfSvZphCv
         w5n7+UjPWiJwn0nbUbCH9ZbNfh1IGuz4wH/f0yVcL/RSB7OZHOMW9Lz1mMRurqRKg18i
         fZIRd/DixCctpdcrquWDL/2Id+iTst9YvaA4l7VgJ7XYhE73xg+tZc/n3isEufPXstU3
         f8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771370161; x=1771974961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pcMrv+r41UeNiqyFo02w1fzNFCK6uftWPvZvbC+3wM=;
        b=QGXxfue8lX+qZur3KmtxC4Rb8VKrCclV58FVKFB2o5NmOSuTSKeOQxWGQvWhQzcIfY
         CHMbZRj1pZiLbzGIY6fQxpsJaf8UaNaeFaQQs4je+s6vIkiXofNKUdPrvLFEt6W4l63R
         16POlMjWgmegslnIPNZ5Q43ApiJGl6ev2a+WuCtZqnZ+Cnut38QVh624+lGdMAbXi5Y9
         wneKRy5grxrcPfxlSBlW5/cWc8aLej0XSn5RxW3upuNrgdWuwj6RjTDL+RpcMsReSwCD
         zj3MmvVznbMuvDFKdqddaKT/RvNXwm76ek4sPEGsgK1K0q+DwBdG5ZXIKdJm3AFmKt8w
         ONUg==
X-Forwarded-Encrypted: i=1; AJvYcCWs5QTsyIgA1+ygrlE5uqZnNYaeGcyAvTDtZdW88cR6++LrmZIeP0r/jcxhbWFYHtsoxL9GFgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5T5EROBWBPDpjMhKytGP+KIVkTgYFrAVhmg8YC+r12T24UBkn
	nNmCwTaBiR0IcyV3BUHmgqe8HpWzqEib+Q/Pqrq3ejuoFeFeq+MWjSG4
X-Gm-Gg: AZuq6aIr/IglQO9tEQfq5zndQ/8tplyST7ysf+HE9yPwp1lqG1Il+kftlDAo22qHPng
	Z14y7DgtRhwv9n+Nbrn+nBhbUjOSxMmTr6Gm/zZuR7chYLEO1XMVjKMn6XSvdGSCS1rOvbDC4zq
	AW44KMZWq7veSkxJw551Kh6Oxo2Z7vdYwsyeP+yhgndjVeG6GXP2+INnU943p3dCqjP7JOJH+LR
	kTpUdL/5r8fHHfSv0WMqbnjkFZLDgol6kx0Bi8uF2Q2HZVf5sZOtcI8OyZ2P8EEzyQrA6fuyE93
	y9StGbbGYrVZmeKBqIaBK6Ea2Z1fQKiB8el9t6Au7VhYSKbkCTA0JGcq0S2lM3xrwS/Nwvr1v7f
	pIosu3hhwdW15jlfCazSL2C2+ULjDgTcHf13JDGVM0A+u7GTegDCp+TfzO06z+DNSZgkMYONPaM
	Vyoyg2Zrjh6Y3vA9rEgHJdgDpw4Bca7DC6cRFRBGSgqDpOVvZYPWDQ9KmnFVOX
X-Received: by 2002:a05:7301:4192:b0:2ba:974c:4954 with SMTP id 5a478bee46e88-2bd50a048e1mr23850eec.11.1771370160555;
        Tue, 17 Feb 2026 15:16:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577bcasm15836517eec.12.2026.02.17.15.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 15:16:00 -0800 (PST)
Message-ID: <f57a47a0-3c87-43e5-bbd2-3f9567d11e1a@gmail.com>
Date: Tue, 17 Feb 2026 15:15:57 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 00/18] 6.19.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260217200002.683975158@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217197-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8E0D151C28
X-Rspamd-Action: no action

On 2/17/26 12:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.3 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

