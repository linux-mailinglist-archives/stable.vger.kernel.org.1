Return-Path: <stable+bounces-216299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNsKGQJ8j2m+RAEAu9opvQ
	(envelope-from <stable+bounces-216299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 20:31:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB33F1393A1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF13C30304A1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1532199FD3;
	Fri, 13 Feb 2026 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h53c0yUU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D91A3160
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771011054; cv=none; b=X34qv7KdpmFTQkISQcRbjIAEUD9H1dzyIev0CjOv/wp3+hFUfARKci/UsAwpNF+8QcLSkXoU6qiTkBwXim0jpsEofK/KGcWC6moj/NxUmYIBdafqp0Ta6BTxULgBoVOkvwp+ONyNHPxeJQdroMGePZrJba48qxlmQoThEdduC6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771011054; c=relaxed/simple;
	bh=dAO8lB0ND8WhwH2pV1nOyXFciMHsu+ivTvc7OEUo92E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPCLJbFK9TizoOR8N2x4rZan9+2gmJv5XYlFdRtubh7h+T0kSA6f0MnWcY25M2iW6zn0lxEBAyoGZViHso+Y2q85/k73kVvZ6ALBQcfGtp4Har5CtnHaohTl91EdP/Pdum25dbC2JYb47lISt2Al9VgD3l7CYJNXaPDvDYAGZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h53c0yUU; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1270be4d125so2976011c88.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771011048; x=1771615848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6XCBbxcLfgzoRVkZvaJQyYjeS/eWp9B2ykayYaVUGo=;
        b=h53c0yUU/FK0q9n7Pz5tfEsOW++Cc8XAyMwStbP8XbxYbqPIyUMxVZXFf3z29SGJJO
         ehTA7YhO8BYYr7r9Z2UfxQIT3I7S+QVxpK/FE/dcY49zgAn5+aTSbcyd4ZoBuTPTip+l
         xHqXaDLItdJuUn+98iV+3KoeR+JgU/csIiKjtxrHl5ggOop7A+0KF/S7P0iFYbEtNqKU
         8BB6OX2tl50aXmXRJjnL0F6cpk8O4CUtDKRD0kLYFXWI0YSHcYEDESQJqzwbqOPCZnMX
         h1GnWMmfU0XQxbfJyzU4c1U2aAKhaIu1Qb6NKgiOyePpAa1KTmzFwdQsBnenHkg+XV34
         thAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771011048; x=1771615848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6XCBbxcLfgzoRVkZvaJQyYjeS/eWp9B2ykayYaVUGo=;
        b=lzd4IvoXSpDFci85MlqELpj7XGpAaTJTGp8C6JyVrkZ/gh0u1KhCQNVF2B1UxKRjTu
         A0/bOGY2pmMVB6MZdi5KLASSKw4XVQzoc+RGysdgQ6p6wadRJvoLui0czxSnpuyANm2z
         dBsEho5Lf4ExtJqss4SBWe7yC+0e7t7CmMcdZNI+Aa2UDOG+ZHQ1ypp2Or+0zff3mf9A
         4o5rCe8vfaoo/3AWG9HkT09skvi35OYBmODItLbVLVqGUt+561Ql7YD/BTuGB/Hqlzun
         wxxUvTCgb4mihlh0swSYkv2q2ygKM8spqccO8RDOB8nJEWc6vWAYXTpw6U+WZvHu0GIK
         ABtA==
X-Forwarded-Encrypted: i=1; AJvYcCVms014ULvjDGNI0ThaZguxoSZQ5k0r2lAWBszGywO2JyC37gY6YLas0F+3VayBUwgJsKtMAvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqrPr7JozxliESl/xvprN2NKk6jw+ehMhRnQgInjhmFkxj1tjP
	ZByVS0XPIF4NFeWqhY6R3ZtmnXHeLBIEa8AKMRFqZoclNv+pCJQY6XxrE22iBQTD
X-Gm-Gg: AZuq6aKmoIROfKycPwu/PWcZBCBVyyXZNWNrqWwjeljd+9rN2nKCxKJpYY+t6p+Xvlu
	Or5/QL0vFFv/bdChImqUXKyD9ffvJu8PM2/GD+PXt99U5C07tqlvtO1BFjNg6b77ookLk4/wBhC
	T7ZaEHcQlxqYxUe9K/EGWmu5/dkOIe2tizAXajrLIYu9ai9pDVgakCTILQX0BVBjL4rXK3ioDG0
	6aD7yQlfhEH0RCZlHDsbLZ7MymCOcqaL/lkw773nlrl0FxA1TCl+VGkChsJdT+0mMeoA6NE151U
	K5h6FDK+Yj/xN7eU+z7o6Zhf2jOqQks2tQkoE1oTE0MMJUltMz/aQKniEDHXSN4MrM4YVEc2C9B
	M+Ea5vSTkSXw9oOAMijYLuXlc7nPIEN7zq2qdp7n0yo9dJB7Q8K/1Q1+lw5NXkND1S3p+rbxbD0
	2eue4c+azbD4CBXkaqFeGhH2K3tQ8FTigdeejvHwX77Ea0W7M9NpMgXZzfUiCA
X-Received: by 2002:a05:7022:662c:b0:11b:c1fb:896 with SMTP id a92af1059eb24-12741b63659mr291180c88.4.1771011047993;
        Fri, 13 Feb 2026 11:30:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1273eb11a30sm1350851c88.1.2026.02.13.11.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 11:30:47 -0800 (PST)
Message-ID: <56cfb554-ec87-4058-8ce1-7629adccf73f@gmail.com>
Date: Fri, 13 Feb 2026 11:30:45 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/49] 6.18.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260213134708.885500854@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-216299-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: DB33F1393A1
X-Rspamd-Action: no action

On 2/13/26 05:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.11 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.11-rc1.gz
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

