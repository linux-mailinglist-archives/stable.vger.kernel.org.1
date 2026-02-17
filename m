Return-Path: <stable+bounces-217192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ/ZKU/slGnUIwIAu9opvQ
	(envelope-from <stable+bounces-217192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:31:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 164AB1517DE
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71CDF301A3AF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468A5B21A;
	Tue, 17 Feb 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPRl2kSi"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E71EB5B
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367480; cv=none; b=XwhI9dMirWyrHIY3YLF/rJZntUh+Sio4DK0h8y/cyfW7rHN16BRyzaBTyeN5h+YuEbs4f9b2IIo5sCHLuYXirp1+280soLhrF18SKn4eFel1kSbZqTMJVJwiCjYHmHmSsAUE8C6t5aUrbwmeR2/DmM4pv6EbVVHPHXb5Iy8Xei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367480; c=relaxed/simple;
	bh=/hcfgfnNsUh12ni1Y2Sk4wBfr48WfmgnZhgYQyw2Gts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHwkyJqbQqLzyB675cuMz44NDEmnQRQ2jKSupUOoF6wM7kdrapr947K83ZX4O+0GJi7NeyLHkQjTAZ/HIfjc4G5WQDX9rMypzW6xiaZLHI9c+wuAWw5Xq9/jPSHd6gTbdUXV2HO+LUfcuJvvaopGTj7Rf/9uNtB2pRNQC3jhg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPRl2kSi; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732e6a123so693507c88.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771367479; x=1771972279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MX1GlaEzkiiHgH7rrnveVU7hjk2Hhd6hxXYdLPwdnSQ=;
        b=mPRl2kSi+cx3rZRcqT7wfeBmewdjsOnUP+6aTIbGyGSML4BTecehMO7GHi2iPHImEC
         RMNQrEjp+KUmlHWpQjqZtY7Bx9dBAUNRncVVa3wLs+WguGodoorACsjLZ/V1aSi8dg2N
         xgyGATzHQbag0VjuCkUrTe7J6Js0ZXIcnT+O0DluWXOqhvyjwAEsjg40upvZtubNy3bv
         mEkOCU5CuiwD2HrYwVlHGUjmAK6NEph7O4sAWxZstqQCl1Mu8XTpAYC6q6M+iZ8mTrc/
         h0Vj9YkUgPLi/nvO4whB++rj39cVbo79izA8ESMRsNKBtTytnGHJrbTPayG//dD67Y3f
         NOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771367479; x=1771972279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MX1GlaEzkiiHgH7rrnveVU7hjk2Hhd6hxXYdLPwdnSQ=;
        b=hIlZRUO+pSPcoFPmWXqzF7trd5uPvkaVljd6pntdkK6TNmWsvA/b30IqT+bjgjUi2h
         aO3MvegrLTmpN7xD4vYpc4KGMCCY18xYdXR6G0TplyPpT0wvdB/aJaIkvfUmi72x/36L
         8PyzpRwqSQLbeOM7A+GeMcGgmO/X3qiiZUtdqj/rR7IsTMVFQv5IaTRbbmOSY41KOfAv
         3sJDaeMRXay/rp0Uro49mAf8XrSU7XorWAfMoYiVAMHzA4OhgShGorL8j42Xl6JQgO84
         0A0GUTQRFERRUXVyWudeunbhRG29DEpKT6KLT8CdHWBegSGD+J4CpnijZPDzZFu11K70
         fBYw==
X-Forwarded-Encrypted: i=1; AJvYcCWzvJdYI1JoNN8AZIQm7YUdRg/4xeh8ZO3eseaGGaV/uBuXY/VN8fI+C2duMDK/3ITTFpAA4pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyt6ubYtsY0kdOCLHdbpbM/4URMUOM1ihm4Tm8gXqehu6/CHU
	PFz3olne2hXTpSgbMSaInBWN2780OHlfQB7hPxydEzBvSuS7oMkX7zsT
X-Gm-Gg: AZuq6aKVSrDSaFx5JjFWAJZnCSShYxzD93EsbCNF0w5eYwzbQolFxNJ3s5zVkv0ag79
	WQnKmxCbqVACDjbt6ozR/yYrHQsuOI9eCK7dM4Hg/9S+bSW/tcIgwPKsTNYQtabmo2Lht5BoQjC
	N5oKFdZ6CgCIMQKZKdez/p84/z/56gq+NFpKc9QE/f2ez3h7D/8aj/ovPymEDM/2Ksr3WGvO6no
	h2usTvPd1uUgtOabhdV4FQ2576Hjy37W9Jv+v2xBv4TnHUhzU5hH5VpUcsg4Y3HwcKqCQtXwPfB
	HidUwlR0N3GCEuT1pnwNrA5WGY7tWrOqT/mkCAmWoD+zUHFQFs3/R/9PWOYzpSJWaiYsnaUoZ8u
	CYAHTZCo2eDp9m+Z9uz9WMj9C5BBYrGowuT72ff+0Jyish8IWzMV+F5U6C4/bJ+PkfbMOuCe69u
	HIZUXYfGJywS6hpwl+xJID+WqvJ2vy7Z7lKqMukmxpQN8+CXWVZw==
X-Received: by 2002:a05:7022:926:b0:11b:9386:a3cf with SMTP id a92af1059eb24-1273ae8f205mr8215143c88.48.1771367478665;
        Tue, 17 Feb 2026 14:31:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c63feesm19433128c88.4.2026.02.17.14.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 14:31:18 -0800 (PST)
Message-ID: <cd0e8049-36d0-4ab3-89a2-eeb01459bc6f@gmail.com>
Date: Tue, 17 Feb 2026 14:31:16 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.164-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260217200007.505931165@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-217192-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 164AB1517DE
X-Rspamd-Action: no action

On 2/17/26 12:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.164 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.164-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

