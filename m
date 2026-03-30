Return-Path: <stable+bounces-231056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGJzGLpAymky7AUAu9opvQ
	(envelope-from <stable+bounces-231056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:22:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5127E358102
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB1A6300B2A4
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F73AB27C;
	Mon, 30 Mar 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7LlnLcP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA13AEF55
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861981; cv=none; b=maFSno+ZqITviRI64QVSxna/+nQT79OeOrdvqXGz2L/HUlqyL7HZi5Y8yfdZnHSO1oDeYp7H9xp5oc9Bb3fK5iDMRnYIfqscKeUEYa5lTh0nxret3o+vL15ebhBrIDbXGidKqiFS1uK2dqCutay5ep6SMv0UJKoiF8PbD+p0K7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861981; c=relaxed/simple;
	bh=BpMetpjX8k28ETSJkeggdZayufTqXV3027OvqdPiFQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHVdp+wyvcFJqNhOeygSLnFYXHHVMiGgnGtFgP9zc9fh3eyEjUIe3VyiD/o5Lnw510QgPDbk67FJJO6SPj+NyAW6br5cSjWmVjMNOQqMu1E/1/g5MgYDhMhN/K15N/ez0Wd1R3X/6N3z9CWiGJgy+YTUnQp5eLf1r9ifrjnolsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7LlnLcP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so42030285ad.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774861980; x=1775466780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=san1INxb0psgZ8O2/M4yukcGM/Vdw3Vd1dAlpLP5aHw=;
        b=H7LlnLcPFEiKlavJfJEx1TpccXwULgBXmQCf5mNnW3qFEYsT1IVoQRzVHo/X6UtHNO
         iorCZ7ua1nZOfP9ZsJnZrNgsNNApSiILoXwn5yhm99gZ9AvA20uh6aT0eZpUPiyv00/c
         66QN766kD+TzsGeeRg9JmLRJjktZAL1VkZfzWuEDyUts8XnoJZ4JEm+WttflCJhRBEPy
         sT3KdQblK4EZzFrCgk5BlL0Ef8SAmmCHkOgbOZrZRTn4rJ4TrvPWgcxo2oLoqslj0N78
         nCWQswoT2MXyuZABxCN4LG+bB0947970DmidtgdsJVzE0ccO5dNsvsT1mdMAEoQV1mqL
         Leng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774861980; x=1775466780;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=san1INxb0psgZ8O2/M4yukcGM/Vdw3Vd1dAlpLP5aHw=;
        b=jzMTidDkq484D4DFeZ3PkApQoi0RuaO08oTXSErO9yDdLxTLW7Iv4UZPCS8upKYq7L
         iRq6vpE1fgNxtDEi5ZLUhIw0bEQpJ8i0rGvLvg51EJgpjjepwpIwqobiiT/0tdA6w6RK
         M62nLxkEVG+gu+8Ngf8+0ILRWfuyl6NuYU7TGZsgUALlqHwxwCngaZaiZ2k6HCOMh4pr
         FSbcg9MiAPzT0ZESPA40qsyUdf5N0MYT9exhB+UKrYJgR5uemzymrQM9B2bfDpRKD7gw
         KCuci2al20JrkCjFEWwG+/Qg7Hx4OEUPI5MN7z2ygsNtL2i40qjxjLIZ+awl8Pe4WyN0
         oiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrwfA1imQK7grH6vIBgy1mQgE93AO9THJhvfJkNJY9aq80YZJsK3I2KOBJk/DrXiwHLdDKqYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJcpTG/s5AgBcTGjfXCYVNIeDoukeBVjdfR2u+LCHdTTpmQ7Y
	nK53OW+XV5eI7BbjMeaSacs/aQk7W/kQdyd6LZa9sO4G0CS0Nb9QofRQ
X-Gm-Gg: ATEYQzyIbcKiTFD5f9Exs+Ta0pn2TgOClzB7nkpQCNjoFwH6lbtDLkGdGRwkK7TLqtY
	zGglRFUhsFFL7OU5Zuje+mjmo+pAMEutiteWFzAQdbGZkAYiFDqorXClDjUlP3NfKXLMpkSKK84
	5Rz5a0XFfQQsXaEQo0TlNakoebVEXjqWEVEGzdm4sb57Ji13YaXKXcLSf5gxcQLlqB4iMyMoz+p
	KVidl+y8XvuXz7+JJCGZDb5TZWLgGASdlC0uqDwodfylsW8IbZ56sg3rr7amvK3Mow1d0mm7JVg
	zw2XJy+GCNU7k1paJh5XAMXILRliStcFP7aKEnVZi8226sASYt8yD08ot1ZvJSNuFjNecYlmecY
	5xKP5PKHS119ftBrRu21f2H3mHxK6Gy74ODIuOV7FvzYNbHPXB2kQOlpGBpmRoh7vWU6ayJX+5D
	xDqJ+2JQn88gTyDSZTMoD6v5UsT9d4HKbDKZHoWUHDmbo8ntii2e8ghRo2cJkgReNND/+wXWTg
X-Received: by 2002:a17:902:d550:b0:2b2:4728:aa26 with SMTP id d9443c01a7336-2b24728b236mr72869965ad.35.1774861979779;
        Mon, 30 Mar 2026 02:12:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277fb50sm71186175ad.56.2026.03.30.02.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 02:12:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8ce43a1c-3198-42bd-826e-a7ec5276afd1@roeck-us.net>
Date: Mon, 30 Mar 2026 02:12:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260323134525.256603107@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231056-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5127E358102
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 3/23/26 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.167 release.
> There are 481 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
6.1.y and 5.15.y fail to build arm:ixp4xx_defconfig.

drivers/net/ethernet/xscale/ixp4xx_eth.c:390:39: warning: 'struct kernel_hwtstamp_config' declared inside parameter list will not be visible outside of this definition or declaration
   390 |                                struct kernel_hwtstamp_config *cfg,

This is not surprising since struct kernel_hwtstamp_config does not exist in v6.1.y and v5.15.y.

The problem was introduced with commit a94d5447f6bf8 ("net: ixp4xx_eth: convert to
ndo_hwtstamp_get() and ndo_hwtstamp_set()") in v6.1.y and commit 612c622ab8efe
in v5.15.y. It can not easily be reverted due to conflicts with a subsequent
commit.

Thanks,
Guenter


