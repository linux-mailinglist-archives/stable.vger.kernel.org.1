Return-Path: <stable+bounces-214550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Hq2Fw76hGkL7QMAu9opvQ
	(envelope-from <stable+bounces-214550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 21:14:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B824BF7100
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 21:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFAC8301C889
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFEE32B988;
	Thu,  5 Feb 2026 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS7nkF83"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79752329C7D
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770322442; cv=none; b=LkEu2NzfEMwyfHzHy8JZdau9moMaXI85Ily+WDlVGWuA7CIivHJUkn0/HAZ9xcU0MNqEOt7SGuFqO6zqVpcy5+r4A3HBBtxsreq/j53WaEpxakWoWlLnj5D4vc6eji+iXLBUrADc3ubwHm21o2Gz9Rym32mIUKvPvOo5lvkOaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770322442; c=relaxed/simple;
	bh=FWbUfHssEGzLc1oKkOl2uoJr0BVLEJRAaSvRg1pf3fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXR8aSqQEgXHDBWFIXkb7iP9QHMhz89yQpUDeRZgX8yGlLx5+NF6c+LbFetqikt5MfQqAdaUr5TW8wpp8kkC0VGLaxYesJjxF5c2eI0cGiGs15+RtE5KhGqNAEJG7a8GK8a15Fuju8BGKIjiGp4a7cb89sIwXNyJ3sMQQXeE4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS7nkF83; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-460f3f9fdb1so960515b6e.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 12:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770322441; x=1770927241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPq9mEICMjrQhzhTZyXu/GWAlidCLqLgVFjRAnOqLNk=;
        b=RS7nkF83IxlcnJubaRQLrzs4rGb0FF+sYk6ZPzTyczk8tlARWD8VZfatbKkJqaY1JX
         5uHsFjSlxPdj6qv1bNqS9iRWCnV6Y1XLDS4zvxAsgVYFXWUz/ns4vqjg+NaJvGw37ODw
         BomNEolFfbXbTlVqqeV2bCSysc4eHmFryBVOnYVAkD82xmP9SQS8sZnas1YvS6wD+NlF
         ArJke9cc4v/DE4f/shTMTjzYzTJ7TptW/BzidW9QGAL0dP4yQASTFkIkobdvyk9w8KTe
         3C/vTytGkP8FP1ZF2M9ooP7r3vCfyuF0SeV2Bj9Vfv76Xb0AIdAUtxm9+xitCL6yk2V/
         bg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770322441; x=1770927241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPq9mEICMjrQhzhTZyXu/GWAlidCLqLgVFjRAnOqLNk=;
        b=BjIizyar2gxIMG9+8sHEUK6Zhn9K0HZ1tn2Wec/U0I2LS+onsJVSRLxnwXGYCkMf/G
         YJNEK9gd2FgNpmSTq+4nt/KIz8MMJKnu0NkRPz0YCC9UDJepPaEYiTWQgBllUqA1RbwD
         94/MGsz7V0uGLNIHLhWnklwIt4uSKMszScu0eAwp2FUqq2EkEBImeimComA7yRtNf9E9
         vOxL1Uo7mi/6he7wMprAog5gNi/2dooLz/AziGOEMdJQv/Lb7HScfuBdXFKmybnV74MS
         /J8eRvlboRTFWzU8DRwcsyehQi64LC89s84yCNHM7jhb+4EaW3t8PGo/zbWRt9GvKqr7
         Gzcw==
X-Forwarded-Encrypted: i=1; AJvYcCUWSZ5Ar7zSuXvjz5vFoM/b/zTORvia+31UP9P9PbBJVrT1PhqrKq79C/ppZSDlU1E7/C6afBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZMMITU+nklKK+So3dooPSyO7jZhsh2+ZFqYOJcI73M2+52QpI
	Jqnn7TH0BsCcXuTJPY3Z79lcbWkMgIAZ1CHzpopbK0ydrVBpW/rYSaaW
X-Gm-Gg: AZuq6aLu4mUsjJHmV/No7pAlMT2aMyQ3z1k0QfGw4dIAXwumKg3OXctORLqmlxAy7/k
	TirUs+KeZIoiqvH2XojnEtO7iGfIQ7GrKMccfdiYBb0G1Srztn10521RbNQr8jXpkkvcwPI5c2X
	c1o8cYbJR8jGlk7KSevRZ+jKlyVlsiIeZ5/c4UfupIxZvqyu4feC+uM4shlpKG0ucRI7gX0PlJE
	S09pZfa4Dcmxhq4JpyMh+zwsRm7xmbn1oWUhk3B5C6Zr2+sHLQ+q3Rs/79f7jS51/efp7a3fYMA
	gOhDdZfW/gALnRQ06PxbNjsehq/iSArRXOWqhPXHdjriD+uL3NisdlY6oigZbcSfPJuzyPOonio
	b55qkgu1HR0Ifk3gL6ANVMOJKZpjSqFmrC67paSSluxgDxV0GMIIbaqcBI6BLqZLh4QYbiSyb9Q
	bffHwEebfwLcG/wm2omP9QNgsDM6UKo+Gcost+5g==
X-Received: by 2002:a05:6808:4fd0:b0:45a:58af:fed6 with SMTP id 5614622812f47-462e9ca5ef0mr2115516b6e.17.1770322441416;
        Thu, 05 Feb 2026 12:14:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a9964b304sm133901fac.11.2026.02.05.12.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 12:14:00 -0800 (PST)
Message-ID: <203da0c7-8787-48e9-bf06-70c0b6e806f6@gmail.com>
Date: Thu, 5 Feb 2026 12:13:57 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/203] 5.15.199-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260205143441.536029503@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260205143441.536029503@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214550-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B824BF7100
X-Rspamd-Action: no action

On 2/5/26 06:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.199 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Feb 2026 14:34:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.199-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

