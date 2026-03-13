Return-Path: <stable+bounces-225373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLvzKTtStGk4kAAAu9opvQ
	(envelope-from <stable+bounces-225373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:06:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E332288802
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BAB13072A33
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D43DA7E7;
	Fri, 13 Mar 2026 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W61Do3Kr"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BA36164D
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425003; cv=none; b=dUQbhJR8nQCRBNCTq/by4B0agGrYe+arvPz4RvZtzp4lRbR0F177GmDuqRiYla3+X0mkRUnE2M1gSzapcaSMPoXCFedqp548lQ2Xn88U1mgAIJA5FJMt7LZMMdsky6CL/VjmuHuH1lDtFX7cK3SnOjUw+TIYgww8xE31eLzRxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425003; c=relaxed/simple;
	bh=qh20l3b/0HKWTON/GYTrHeqfsIlTbjC71F7cJPk2N1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ii52lJUtr5FAMJWS7ymqofutaksu9gPwg33DRClVMA8I13yJECHaCcWM10k/WBC0v+LcD+fwaNpMwuSg8rLV0ShncdrbacFAQm/l9YrqsXXasXF0VU70wFRG4ylwvprz8fqguu+GiSp+6nG5ev4lk+rJnblwFG/3DGr0DqFFJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W61Do3Kr; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ff05af29b4so832347137.1
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773425001; x=1774029801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGqCFSULWUrkR10G0FIZvp6yvlkIMXD6lkVLcWVFX9w=;
        b=W61Do3Krn1hjKOGJfKZzySsw3DDTd/PqDaV4eYJ4bSIJ4/bfvitQt9XstnsA1Gztkb
         1pszQjpGam+GTA1q6QnwOyNlPROcsbYvhV2ksgddcMsmRTe59syPhjZR8CZLr3tpu+xw
         fNTClQxw+wksZJaWXcNI/HOd0ss+4UrWv/Ruz3naL8mca8AYjWgblidTJwhjN11/ZM1x
         2ZixQ6qGYQM7Qhv3g2GE/LiiFOIgbP2zrYwzmO5iIiGLLwLUzbPyUNNNv9v7QbDVf7uG
         O/eC5kXVpXn0KmP6gGJ4+uVpwF7WDXLmxQ4GIbJTGiBsKIkMgz93U/ks4XqRVyRMnR/V
         1WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773425001; x=1774029801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGqCFSULWUrkR10G0FIZvp6yvlkIMXD6lkVLcWVFX9w=;
        b=MiL3ThHYSoZ2mUoS3GVZdw53c43Qk12ewE/96JQUnDF9yyLb/Ii5SItLOV2iidq0We
         pzSXl8+eiBgOGMb8bzaQhArCfdcMzk+m+DfsP6dnO8YyZdwr2mTm2cViEOdkmpj+3sZF
         EOT5TsD58Ws7twcfKOyg4+qTuEQK5RtqK+Jtr5Dzm1N0hGHTks9AytQujysH4fGgAmEe
         shKhGGSJoLkXW5uGYtXlZxB9/dOGfW4N7ruxjSghUE7CHvFa/IXHbs8bpdQdIZpq8GHJ
         bnr7t9CXzKYDRpmgA14JGFQCaPy0/krd4UJJHyu6R8KIFNdfk0OwuRC6q6JO79hDD3jk
         RQag==
X-Forwarded-Encrypted: i=1; AJvYcCUI+CHvrlpApFtROSYVQ4SkXUo/DwCbiuMme8QhSazPZ+YiUthnGsZ418yZmoNjOEoybEDiYWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywlU1X7HtV5D7gE4dZ2tFvrIW8tsmfmfJy9Wdz8gO7CZlCzZPD
	/wdV+hKSuxdrBZVFP7FATw/hEXSTjzS3PvnTogDJ0dNBg2WnGZgWClFB
X-Gm-Gg: ATEYQzxoincsJIauEaHYX1pVztOacdJP0+VLEceRBGVlTrMKAFKTlsiEDQeTTsnJSxC
	IjBcpT//Ng6WAzPkBTWYgZQQPOqAl53LM1pffxiat5xKIKTnOgqQfW7rwbPn6T/Q0kw85kkZ1US
	LaQXNe+UydE6XyEO/yNDM5FgxEwVgim+ZU1ctkvvezMvoohesfYOIRbmAmg9c+Q6bqEHiJRCxQQ
	tLMDzis/h6itd+Kd9O8j4plzuPBfwLFMM6X+t3s4RSj5bGFfqm0FSdpIZv6PIbqIP5qoIitgNut
	CLjuJ4Hsuj78sOVYi2y0pTU5LL7Wx4dm1aoQx5W40KlNkKZ7kWuujx1m7CgvdkNxEw9BjuvUJe+
	uHbXGjcNhMfKvNgVIRiMgkApP+RIIV/6FjxgqwXsj8J7pdZZdEGn87iynwrQBvt+0geJk7+Jvut
	YAFhfyGWWaOAZULbzy6B75XvvWmMsxeHLhuh5r+08xT8VblHjHtI9GalEzG9EY
X-Received: by 2002:a05:6102:5094:b0:5ff:da11:fbb4 with SMTP id ada2fe7eead31-6020e1ec407mr1753942137.1.1773425001496;
        Fri, 13 Mar 2026 11:03:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda71834d9sm596081285a.14.2026.03.13.11.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 11:03:20 -0700 (PDT)
Message-ID: <2e78aa86-08e7-4d1c-b0c3-b84ea7beda96@gmail.com>
Date: Fri, 13 Mar 2026 11:03:17 -0700
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260312200326.246396673@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260312200326.246396673@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225373-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E332288802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 13:03, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

