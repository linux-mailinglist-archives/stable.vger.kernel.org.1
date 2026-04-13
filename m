Return-Path: <stable+bounces-237642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK4VBXdB3WkubQkAu9opvQ
	(envelope-from <stable+bounces-237642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:18:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDB83F2905
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F18F13032F5E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C445138D005;
	Mon, 13 Apr 2026 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRlurC5T"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A638E5E8
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107700; cv=none; b=Xin3LODzGdfRMEjMYdTD+nOAmPdU1oMjdDhqX0C62mfDKpYto3MbgSpdgDksiJ3urP4EW+S7upGpVQBRVIAXazdhsL01x4yu7HdQ++6F/vH3TtKFuHpj/689XmeqNoP1TkGv8qdNDcl778zdeab5SyNWfRZ/XHJldSoQND2uTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107700; c=relaxed/simple;
	bh=hjrbUh3K16uhPv+qGKiFJMHaayQ7zUPBcGTS9VdYRT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eriLC40w9RezSQ1LGqE/7qexbI4lu2iTEl0Tsku6OYbSZDMN9zAr/xIqRP5uzCEju1bjb6Gfx0Qn36LXuSlStBwf22ECEtmp1TxI14VqHxUls5Nb2EwOJK+mKU196dhxxesITX4UyPJ5W5l2OnMTY76AQuFHZVun6+P990OeaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRlurC5T; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c45281a06so2733753c88.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776107697; x=1776712497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CQP3NmVGMh1UqGBteJSFQx79n5V+bZQmDU6yBEPTYU=;
        b=rRlurC5TKFv6O8pRVsv1dG4rMz87alNOWepmhw4Ej7MOs8ju8Ucldho+Sm16Z0iBx/
         omQxhv7+zH5vQ0sM0FCGtRIuEmivnSg6P6aRhQD8G3E2c/bsvwAVuiD/qMk4xGlOReX6
         DjCpN5u7E5uN+uJ9rDoqcGb7iirUoi6iSMWxZMbCzMBe7w6AccQ2LEtg7SVwBKhB+kBN
         NjPF7nJYvzCHo7YC5WWCcyAu2lm4H/jHKcuf0A3gPocJmHnXPitrG0RmKOX5wuMzhcRf
         wKASMOiLrvfjksXZbIvB+xbRJpO9siHyiJ5FO5T69oLa0DLJ0tU7t+oeb8G6V7POB/7m
         43Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776107697; x=1776712497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CQP3NmVGMh1UqGBteJSFQx79n5V+bZQmDU6yBEPTYU=;
        b=lcC5ZN99kjXAQiG4mZMzcyHj53LNhoCyAEbunn+gnX+WhsPyS/rB2Yu/c0fl+JQdqO
         zJEM9z9U7sX+F3oPa5WA/h0ooexUdcyNxl3DEkRHRnp/Pv0nCefR+HDV4BnpNi1ZhHul
         AAtPCQAslXXCsKRGFt7EK+PnR9TXh/GDnRedacpqtu1wiETiY7ivdjBz60ipXmEQXe+j
         Q5c3q0oofZsRUVdiSpYiEBtsswvdFzP+SLZwn8cNyN0LqC4cKQES+1rpR0qud7sCIx/D
         wVBAZR6/Rmjiwi+av8kZ89gv6B2TMWZ2DC1QntiQDCpR5a7lydxEa9bZIodykVRYFRqx
         oHIA==
X-Forwarded-Encrypted: i=1; AFNElJ/1KsqcKoobGsP8bbTgFkU10RsCRvDlrodAl6S+TsuLV5ouP7PtJXu08NyIrQDWVHChnE+iH9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN1aCoG223BGJ+bLfZnRUgg2xVLFOvM5WtFXnwtpLMhLpXqsCQ
	/foZ218ClTU7uZ6BSQy34xa8LWuYdY0UQhdQgd0X2DkbxCInTL50p/eV
X-Gm-Gg: AeBDieuA05daPawjYOaFUjPYoLjzuRpnaey2YmWgfLEFcYLsVjn+LY7F4pK7Tbk6LO/
	WgBZgxz0o+WWlmc8w3945eqrjH/snn9gbGxBimCp+41jmpeMxdiH+olARIDvAMHDe6T1dHuNJrL
	uuRSleN/iUeEvb8ox8blkUp/S/ihwkeyegGgY5+NjOa6eWK++lT2Uy4Hw9vILGkqC4JpHxvxmCb
	/mDMhPitILwpVpzrGKXwcXh2+wmtS2RTnqY+LyU6lED8l/HziWeoJPCy5odJIefThNvNo+fbwi+
	FqqeBcu7rOr6SXPi3UYN3fc0BW+2O4X4RDYgYXR+wuSg1alkZ2IWKRLYJpidKqG44LSbP9EMtg0
	oQ1tEPgJ+AFdZOkdErXQR2zAm600wmBB/QkvH1lxF7xXg75sHE2SCnYvKiC8hnr9khVZJSu5x5f
	tdqiCy0hQlvcykOZbuE6tIN+54LuoUa4JGzrPavkFGw70zTMBm9Q==
X-Received: by 2002:a05:7300:d70b:b0:2da:9a3c:8062 with SMTP id 5a478bee46e88-2da9a3c91a3mr1371099eec.17.1776107697433;
        Mon, 13 Apr 2026 12:14:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa571csm20993898eec.10.2026.04.13.12.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 12:14:56 -0700 (PDT)
Message-ID: <36b828ee-71ff-4c48-9ab6-139a3ba6bc1d@gmail.com>
Date: Mon, 13 Apr 2026 12:14:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/50] 6.6.135-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260413155724.497323914@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237642-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FDB83F2905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 09:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.135 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.135-rc1.gz
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

