Return-Path: <stable+bounces-243919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAKELdsO+WnJ4wIAu9opvQ
	(envelope-from <stable+bounces-243919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 23:25:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228654C41D0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 23:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125B3302803F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 21:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A21E347533;
	Mon,  4 May 2026 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1BcYJgL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE4346E72
	for <stable@vger.kernel.org>; Mon,  4 May 2026 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929865; cv=none; b=hN092SlOwQLp41/rpU3Lsj0Vvqvixev9vf+53aN3va4reY187AK/9exanldh39xmhdpAK+RjFKh+3n96YZgDDbCkYJJKoAe0RhA5LEVk3gJIZb5UuHrX61kC+d6unT2Ier1gEe7hAVV4oYtZBmhFwRQFr1+X0e4XNW6V2ff0RDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929865; c=relaxed/simple;
	bh=aXLhzVVDDZVTIAysVaQv57AbFUyuiddQ1N6wPA+Lz/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOAjSXMuJgwUSL9OXYeyc4QMw1DXNylIYlr2x/dKM4UGVS3F7aAKs8VJvt5EsS81XrGQBvQJcHjodqMmB1DcnJYZOpAqan81dCxv/o1iUeI2DthvlsG2sGrk8GM7MVY7ud+F1uoP5BcwwL3QkBa8Y/SeQSwKjwAUODh7c3L9u5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1BcYJgL; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so3982595eec.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777929863; x=1778534663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQyQ7sqWzfJEVFfcsdMCu5sAldv5fbt7DHbnFvMIyu8=;
        b=V1BcYJgL6aNf7oCTKxupmHtKTaiC6Xembt+36E60qgsRc8hwvI5OfC2AfMLzOmgsHP
         DN+xq1adyVHZt1N2PeFKCIo/F9qCD3e65u7KynSBDI8a8CwZHGHQU0JJ0rYci+5Xa/YV
         pt0f4w2I7bOSdbFEQYrBsT3yQvpVXRasWCggrptPy2jAIpX/4Fr9ceeLrDzpP+l6z579
         In6nr+5K6HUBKZwUmqOymWdC2DJTTlsKvozEpI+NtKARliqw3UaJpaHQMQpzlWyTXfCO
         0I9bc/i8zAPvqTxLd77gWr1nCSG6L/6/l7zpK8ILAjUcBgtDMdk8qv4DMWUkBWwoF1m8
         n/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929863; x=1778534663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQyQ7sqWzfJEVFfcsdMCu5sAldv5fbt7DHbnFvMIyu8=;
        b=st6d2DIXx2cHxiTgylEJD1YLgN3Wg6YssVHo3n/EYxK3UvnvfMBgSgBYur/i90QXoc
         1pzNsf2kcCymSJu7t1B90+OYQEIYkC+Y/hzKW6G8nvrtyaJusnvM07REoyILw1cHyW6+
         Tgrp+lxEDeGUKbU+uwOEP1lPv0K/qes9x564Me3leiI6bpV5PL9H5IYnRrttirnbWTwZ
         UDXYE+7FCubeOMxKOOQ3cv70oMUlscgefifP0eszwG2bhWDQxYYmWEXR4KJ3jaE2ikpT
         MINOw2jN6x1vB2fDtnysSc9wMK4Yvxm07SOlnlgWVLFwq6b5OVkemF5QuGfCjTCd/u+w
         3znw==
X-Forwarded-Encrypted: i=1; AFNElJ83Qgj8L7JERzeEMSd4cBt4Ib6rebJ2tyPtef72ymQNJ5q7KvVFAA6yLK893ekBeLO4f6QgndU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhk0jg34/7TOMsc6hjlXQK+79m6+IyR5ctpKsm9/2DMoktmzor
	MP9GvCz75fdif1LXWy7ODtoMoS9lu5GBye0OeVgznBejVdLqTovSazaJ
X-Gm-Gg: AeBDietHsFLjzaL7w/L4gwK1aD0t9Go1Z0YJIFvoA+Walv2WHVkaKQqgs+tN6EHcXcn
	irqmGYeLnnwJaji/zPFt1sk2XlU9F5AVkKdBmRg2RhaikPgTEVQjld3ICmb+frDXuTjK7Bb1ufH
	I625Ljve3hYPLSAw19WuiHGG+ygj93TvyAfaGhm/5RX36HPF9w/l/lHrcs9fjUO9RGkCZLZy8Aw
	+/USJEyHPTghLToABdK+f0zFlUqiPITaEkpdzQS93jgFltmwhM5EYw4EUocYyy1AsGuRxTN2Cec
	8KwskboGME1YwQ1furDWCkHiMujtEjxDluymUSQD9LSnXU6h8KeAAUc3RLYZaoSF7UmCQ1/Xx9e
	QkFikHRcV4URarlQ1j8ZIDeeiRWOGzbskID/w5AoabzMqYjJfWq4PCA4fYZzn3V0CGKlTze6AZ+
	VFcL67Tmp/IAcPcO5gGq6YyYcPpVVfKtbGUatqGxvtEKBh+97PcpsfM9JwK8mL
X-Received: by 2002:a05:7300:fb96:b0:2dd:6937:79d1 with SMTP id 5a478bee46e88-2efb89a0612mr6059363eec.15.1777929862781;
        Mon, 04 May 2026 14:24:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d634sm21012510eec.3.2026.05.04.14.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 14:24:22 -0700 (PDT)
Message-ID: <fdb726b4-41ff-42f7-87cf-00f308fa27fb@gmail.com>
Date: Mon, 4 May 2026 14:24:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260504135142.814938198@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 228654C41D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243919-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]

On 5/4/26 06:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.4 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2026 13:50:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.4-rc1.gz
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

