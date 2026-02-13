Return-Path: <stable+bounces-216310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EMZNNW5j2kYTAEAu9opvQ
	(envelope-from <stable+bounces-216310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:55:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE713A15B
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BBD33005D23
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 23:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72DB32E6B8;
	Fri, 13 Feb 2026 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M4P9jVfZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA17318BAE
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026898; cv=none; b=WepAUzOGI6hNICaHsXdaH5Z+GuSflLKOfT7P8F+Ou98TRpDD3pvbjzjydimRFYeskK8y0Z38x0JER8IEIYGn3NfW60TAs6uhgHZQ3sM74ZBihy5K0RB9jlZ5YvR/LCipxcq8hD/Zhzk03q0ybec2vg0oCLSADMvB8C+rRsO6XtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026898; c=relaxed/simple;
	bh=iLi0x8ABwqvP3VGdPPi2F+bpEB7csgv6xB7LFpKm8DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlH88c8J/V0L6aKrN4YbHUdL09sHlMVOP+H/xGmf5dqn7W5xa03Qsbprh3NUzHbTwTUSUI5Kc0qCsUgM9HSH42taAWrS0hzo8gkViEnEPqG7ljbDxRIF1m3Sg/iZQM/OSejJtCO3WUz7sLQHT/P0x1zwcNJ1vU/lz5zauZrR4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M4P9jVfZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso10975955e9.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 15:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771026896; x=1771631696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBU16V7AQjuzjpZAHD9wwaq5lF1T4FgGsAyYIBiZCbA=;
        b=M4P9jVfZaDMRgKiBGdWOyt10Zd1KzvKZZ5g9c/Z/4R2X9jYY7EP5pn8Kz3o4tbFjJI
         yhWTplVDEvhGpa8VmNCYS/stleR/i46nt5zlk9PavtgDzbwfsdAv+fY29Gp9eaCDuGE8
         dewCq4V6evIKhpoQWNMuRQQ8U2rE1a046uHZtm2d2PH4cNRsDV9Mb35z3xfC5fcRmiTA
         ldCYWwXPeJv/ZnYwwRq2KvRp5tBDMEdfQgWCYEEDeW4G1Di3UmHjkGN+yIMbY8cf38aD
         CtyWXzgMZJUsON9Uhbn/T4CSrfYnm0QXO5uHbhpbKiSveP8ZG9LKL6o2Jhfkv1/rTbZK
         saMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026896; x=1771631696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBU16V7AQjuzjpZAHD9wwaq5lF1T4FgGsAyYIBiZCbA=;
        b=Uvc8j5zl0jpklqYI3MdLFk9G/oAPiV7UZkOuhiqkxsd/55NKuLgGZGrFjPyWFyAl7Y
         y/33OeUJtXN6L8At/Peo/MYOixMoyd/vqNpn5b4Zm7OERdNele3b9Kg/l1vSnpcFaWX7
         FZE/s/+4HhQx8184drcKruYxpW5dE/VYNiOMvXDqdsWNNCAlFoRKI6gpu8AjHmgmWrnC
         9hjtlSu3Xeu+6c1d/2DTpGuc4orKcRJJzOiKQH84OxCifWhAJCMQf6NpXriHG7aJqS/D
         eL4w707xQOaHVnM4csf46PUGCJu/X5IAASSruS5E29x4sSxRUsHYwFFfNrewZfnxjkJ9
         5Vww==
X-Forwarded-Encrypted: i=1; AJvYcCWypQgN+jY9g7EvnNcqRvVZTwzAxlhdgcrul+xl9YXrsaftuw88Fx/IcEezePA8yc4JZuS/iqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGYmSQXRYBjPalKiYLNPMh6EIZEJNmy0wMFc3P1/3LqOqJbZB
	dJdzqrMSs31r6Wj8+9AlmA69lbYH42dmAQD17e4tC+fHrQEdZQPuD64=
X-Gm-Gg: AZuq6aLbSaW0OgK8ejlBbAzPv5Ac7s1lcnNBSQkKdKAI0uYSICJlC1XWGSM0I5h8ich
	TISJluE/ouQg0r1K3O8DgIjQ3RVSaXTGsGpdeaEE7zIZqov1bIPCUqjdAHsJY3wdpDNvIHPu0Ci
	7wrIkoc/o2SEa8Lzb6UGTJU1ZO8NDmmXRslx6zDAVTQhliScSzk6wNmpv0KPAs3fKP7Dw/2yRMo
	yPRo3X+qtCCHgrznDqNIuPokrjjKlZahiWUXB9giqaw04/NZsXLcNIR2E9mLA0dlxYIV5RmIpFz
	vcck5OLyT0uPTbp0e19vJvQrpC7FF2G3C00rAPgXRMPctZRz7qofNyMIVuNFebvBhcF5+kDBqeu
	8+EETtwa+WIwuyyU5nJFhyW2+VFBXuVtGPMBmvdJYLdwj1h4eSLjdla/RlU9vyV4/PaKxBlWBh0
	KCGjKjyTwZcvvAhJsxCyyM27kcSjtVPGvKjF8mSAAA5ZaFxyU/MCLWKMA3xVgT1XgVbTAhoEpKF
	Sj3
X-Received: by 2002:a05:600c:314f:b0:47e:e970:b4e4 with SMTP id 5b1f17b1804b1-48373a6e371mr47029055e9.29.1771026895679;
        Fri, 13 Feb 2026 15:54:55 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4a9.dip0.t-ipconnect.de. [91.42.196.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd1bsm323916795e9.6.2026.02.13.15.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 15:54:55 -0800 (PST)
Message-ID: <443570fa-1e2b-4043-9625-43c740551794@googlemail.com>
Date: Sat, 14 Feb 2026 00:54:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/24] 6.12.72-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260213134704.728003077@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260213134704.728003077@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216310-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailvelope.com:url,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 54CE713A15B
X-Rspamd-Action: no action

Am 13.02.2026 um 14:48 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.72 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

