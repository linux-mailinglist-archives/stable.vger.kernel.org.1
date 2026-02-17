Return-Path: <stable+bounces-217194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FRcLpbulGnUIwIAu9opvQ
	(envelope-from <stable+bounces-217194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:41:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D960151929
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA2C3019F3C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF71318ED4;
	Tue, 17 Feb 2026 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUoaTG6e"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623131D36A
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368052; cv=none; b=RG0OhMWDLEkPrRr5otzBedBAynRajzPYVyoh5gsTVEsxkEIRSSN0kAKU7T6XGBx4/PhiJ5VWQ5Ec3Qv/w07okS2RJM1oJ4n/9cu4H+gUThdRCy3+LQ6V5+Q9mbFX2/FgOte09P41sQADgbGT92Yi2n3H/itEpzF0pjG8Q53KQ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368052; c=relaxed/simple;
	bh=QJRisljU1xo3s/9wNqzGNtrUMi8cnr65B5lpCzMBYZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd78rzjC2ctCbHyXJcpa814Eq7UXiFO3WhsPah+8oAkZ81Mr1lHZjqNDkRov/HJI8pge2WnL5wa2nXUKla+sG+unvGm2UtHRGD8qvOIRxFhl14MvVXNAhoMvb1fFM4pB81QgrB7CvuooCVSMoXgPdwTFMIdoBikGs8NaNsNV3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUoaTG6e; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb48234b08so429930985a.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771368049; x=1771972849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/YWTcywYNe1Bv9Jxo+L991NobexAOv9vtfpRL/8Vik=;
        b=kUoaTG6ejMjiWm+wJtK5XJ+t8WUbCY7S3LbPlFB5yvPOvoqPXYp+RMus0Abq9hEmjz
         N0PLDiHBeLVZCknvAnd0Wo58u0mA/llEOvnZvvzDWKtzGWHUNSynyhGlVivuiB9pL2ES
         9/4VYFX15hJz+s36uhFQp3wlErlIOdg9LlmnBS6ufq9Al78kl/CfsnUzVBvHi4rnwDia
         vKg9PIyLYcAgcjLEaVHxqwQTg9PQkwPfSoBwSwzAwJqpGdoymlcUTnG7RDA0x5jENfFk
         jQ6hbL+570PtT3A0pf2+cT31FsML1hUYqXjgC2WHcvs5H7hQe2hsL3Uw1lYK3I7hD6iO
         MbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771368049; x=1771972849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/YWTcywYNe1Bv9Jxo+L991NobexAOv9vtfpRL/8Vik=;
        b=fXTked7E/gl5mGpjR5Jhi3IcxVwpOQKj4wTGliIgHxhTI/IRVLsghx7pgxg6TAOGUQ
         vDdXnMNEJ8S0oKeS8YfcuJG688c2PVS589c3X7+XutKWtBuFY7wtRuYXNW+YNeNCQKHf
         ZTd2rJ24WR5ATrNhrmFIx4tBnnvdrKpue34EGmB9j9X71gunbJXrvYp6CyWP6JKjWgiR
         bniqdM5MwD92OgwWuqSsd3aLg0hzYtQktkwRtJ/QloBoQ8lirRnSTTl58VbtZQYTJ8ai
         f/TrIxPmlaK3GbaDPyzSfNzK+0Z9+33ihJBNQ51VatbVSJoFYPNDurR6bqEtbk5NJlYH
         XcQg==
X-Forwarded-Encrypted: i=1; AJvYcCXjgfRDm1LfIIBx3Lch6IVV12Vym5g/mDP8mvQErEzm9ekzNxMwAku/VnAcAWCoDEkC26OwW0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNSR8Exlq/UvIwiOE3Da8m10q/+apczdN06fKt6BSimet3Ybf
	prgePwDFCgU+NXC1ZwO4LRCUrN2ai+c/XurZCEYPafLgiLM0tUGY0V3m
X-Gm-Gg: AZuq6aL1JiITMACZr3xZoXp5J2pqBOE1XRFLBYP4HpMDPcNiME5qUwIHSFc3fYWVmnL
	6J4HyUi+5PljZ428XuTqtrsAgCYBWnnzRJDnSmDEwlgj/B6+tnDh5pPj4wDjVHF+FsoVHGHJ6EO
	y6NjVigzzr1AmFkm7GB/ihsfV1EYuTskKGDdfZ/2NDPro22bEFHD7f36xELcGWTZfPI09zgTVNt
	J+etXLXMYBpIjQahtKTLnYDoKAVgVGTRknXgp92MGhD5EuaARHItYHIw1HUTF2Id5EuJr45O62i
	nzYyN08hSYDCvSzDRh7HBI9eEt2pVEVQzawS1/d8KRxSqlM8SAzJh6d5tgQw10PO8fpzz3g62FL
	OvyhOvWHZzymHaKSSp2cVUmc4MwXfOb3CosY/9O7E6xC8THjuRcP4jV4bbHIEfhIc8im8P1fy/g
	IA8w3BOUxyqHMo0pCA86Z2kyIjBpmRvKzOjmdarJEE2SU9349eBg==
X-Received: by 2002:a05:620a:29c6:b0:8c7:1156:efdc with SMTP id af79cd13be357-8cb4bfa70f7mr1452762685a.25.1771368048856;
        Tue, 17 Feb 2026 14:40:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b004eecsm1623918585a.0.2026.02.17.14.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 14:40:47 -0800 (PST)
Message-ID: <70d4fb96-0d71-4912-a8d2-64848e683c24@gmail.com>
Date: Tue, 17 Feb 2026 14:40:44 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/39] 6.6.127-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260217200004.221651386@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260217200004.221651386@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217194-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 1D960151929
X-Rspamd-Action: no action

On 2/17/26 12:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.127 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.127-rc1.gz
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

