Return-Path: <stable+bounces-221233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MOlGYWJo2kzGQUAu9opvQ
	(envelope-from <stable+bounces-221233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 01:34:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B171D1C9D38
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 01:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54407302C6D6
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0B1EF09B;
	Sun,  1 Mar 2026 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d6ryzpgp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228191A238F
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772325246; cv=none; b=PnCQ7+IU/kl2zU/z/rMt4+sfEsh3qAYcB2KckAb+1ZY0ApDGHyrnsYyw2WZ5tEulWe6hchdgkJhGpz+ZlCxYsKghe2xm/WX2EKwjUC1QIBMI1VXxLSDVJE7oMIS2M95fcdJmDONpfqnjLx9zEzXkut1DX9SeJhogfC3R/lVdd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772325246; c=relaxed/simple;
	bh=1LEcsRNj6W7QfKGXFVyJg3sKSKg0hTbKkMXJwv8VOqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKSEYE4cNwzvxC+SgPl1g1c0tNrJ8NcS9NZpiDRZ5cMeZI50Ml2R7+O2la/odW8WNBsTRxORtF27K5HRZ2WR2Hqwnh11jQs53KPVhdpj8DaWyaSNkKDa7HUwQmgxTI/RVVzOkQuby4cuNXTyI7vDZiRN5Xb4GaG8fPoTAi+o/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=d6ryzpgp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso28120085e9.2
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 16:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772325243; x=1772930043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTKmHwe7U0QcTuk12cC2ddvY6qmz96Jk447O+dG9kOw=;
        b=d6ryzpgp7jITxkfrxa1bMxXTJl047D0M+MNVhN6Y6P9oSHZL12eFu0FBb9Mancy4A2
         ticzyeOH/zQOzOQPFjUhKh+EyOwQ7WB+8eVI8uhoorCak2KiOKayrvA+DEZ0EcniqbYW
         2D/sTbIGhyi5BMDduI9X9EtQgjcAyHk7MJHBQIKBjcWPZieOneMK+Jz7XFKsjnzWvM4E
         XMoN/dwmqJTHr3jfrcFR75hnhzDvJERyesKVwblz0I0Ehr/hDXnK8OdJ/nwIzwKx3+79
         lHPwleAJlIad0Ddy8eU0rF+lxEQf/cI+qMdP5mIDDsOGhSdIHYA9j2AWtiU0sQ8rKngT
         nA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772325243; x=1772930043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTKmHwe7U0QcTuk12cC2ddvY6qmz96Jk447O+dG9kOw=;
        b=mCaCmYb6Ccefpa02znzSvywpP2tus4yCNKMlrK1/ZFWv+u+25UYgQyQOHkp0NN7ciU
         Cd2mucpOpUZXo/BLi64qmLmK9q9z3yiAXH7DAQGz1uYAbVrZc0Pksbp/V987cqchjrxP
         ATNo50AJZybKhmVzbf/2qiKuUQPZZU805OskxmBD+oxHPNojFVNvLMCdjZPUVHQ3G8wT
         k4mTNsiE+cqKP0CFg2Sqwt4fMx8PxLKXC/sdHATfAUpUF66zGwf2Zsmr2no7gJBzBUex
         KuYh8opMX8aSdE8TMEP/zqEDvs4HHe4ICJrFQ1cGmdlEyGztYUcY5oUMniRy5h7yf99y
         gQOw==
X-Forwarded-Encrypted: i=1; AJvYcCXisNrFlIfnpHp0v7JAkkugmkxduBvei02wjjIDN2gn9+du4l2hJIzbx0FAPjhmOUYJ5XuFcWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRYgCtfpVpGIuGsPKpR849E9X01KLMdHwIbeYYVZ8bRU3mlFa
	dBZflWHSirh/t7pTm3JnUzSftTvm3ABuqvHRU47c9tSfTQpbokNLij0=
X-Gm-Gg: ATEYQzz/+eZWQty6E0uLXt0mrlxAo5a0E21ssuC68mrBW0iReWV6spzv48g2+9Bo5lZ
	6syri1yZIBtgj9j0FbDCdW3kWxFUdFYj7GVwfjIuL2v/YqfHODjT20hyO1s4p18oBqaDjnhIVYe
	huNGqwgVoCQuTxkfLyUJg7M3bfQPt29pHMxQescYwKYXbFLzuV/W0+EvhAdqMYKSnElEoVbRQh1
	cBAnEsn1gIH9r1NKfvu61CxtI5HKVb/mkaOPwo7a6yKSpsFcIEDCV4oxBCD0sV5gowpthStjAA1
	IXmUkmrWnQ8R0EHbY3C8iO2iVZSuXps4wz4GIgqUY+4gOMDUFN1kCyngqhJKkss4G+rDhg+tnr+
	xVjsxTi8owZTjkmoPU+HsRwA+MG+MUybJC3nxJIDXW1pdRsY2hXa0XzjxTa7qWVjsGESVPEbB7O
	/5Up64fxMXvzi4zsTgZRQ5nCTxGGB/53f4P4Sk0ax9cByn1ry6+/Xsc1ClDj8IXVqd2tyzdj9Sd
	2Af
X-Received: by 2002:a05:600c:444d:b0:482:eec4:772 with SMTP id 5b1f17b1804b1-483c9c2d742mr116402265e9.32.1772325243270;
        Sat, 28 Feb 2026 16:34:03 -0800 (PST)
Received: from [192.168.1.3] (p5b2acadf.dip0.t-ipconnect.de. [91.42.202.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf5fbsm94449025e9.18.2026.02.28.16.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 16:34:02 -0800 (PST)
Message-ID: <04f01795-bf36-4fb5-ae6b-c6a551ccf518@googlemail.com>
Date: Sun, 1 Mar 2026 01:33:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/844] 6.19.6-rc1 review
Content-Language: de-DE
To: Woody Suwalski <terraluna977@gmail.com>, Ronald Warsow <rwarsow@gmx.de>,
 Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260228173244.1509663-1-sashal@kernel.org>
 <601576c7-970a-4e9d-af5e-c818740be8e8@gmx.de>
 <879487cc-c667-8cc6-4775-02c7de3b8c27@gmail.com>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <879487cc-c667-8cc6-4775-02c7de3b8c27@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221233-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,gmx.de,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,peters-netzplatz.de:url,googlemail.com:mid,googlemail.com:dkim,mailvelope.com:url]
X-Rspamd-Queue-Id: B171D1C9D38
X-Rspamd-Action: no action

Am 28.02.2026 um 23:13 schrieb Woody Suwalski:
> Ronald Warsow wrote:
>> On 28.02.26 18:18, Sasha Levin wrote:
>>>
>>> This is the start of the stable review cycle for the 6.19.6 release.
>>> There are 844 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Mon Mar  2 05:32:25 PM UTC 2026.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.19.y&id2=v6.19.5
>>> or in the git tree and branch at:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
>>> and the diffstat can be found below.
>>>
>>
>> It would be nice to have a download link to an patch-*.gz what Greg usually provides.
>>
>> ron
>>
> I second this request. Trying to setup a build for  5.10.252-rc1 was tricky...
> We need something similar to
> 
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.251-rc1.gz
> 
> Thanks, Woody
> 

Do you guys really still use tarballs and patches instead of just git pulling stable RCs for testing? I'm in shock...

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

