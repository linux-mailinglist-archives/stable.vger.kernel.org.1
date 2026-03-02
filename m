Return-Path: <stable+bounces-222668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK17H7/PpWm1GwAAu9opvQ
	(envelope-from <stable+bounces-222668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:58:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3A1DE258
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712D4304A32F
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4D2DE717;
	Mon,  2 Mar 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QiNfTbjC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D43112B2
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474277; cv=none; b=T4X+3ixIRsU1g0frNFkOZ2BKeGgyW1LqS/eCbVxkbzE8R6m2sXelQ5I0hfCSXQA0rxAgRkVCCKd3xIat9LxQ4ASNy8XBpmomgAZgfaPAaAerS3QOkwtRQcct2jcZk7kbaSp8N/OrHZPRNzkqcXdMbkGlIPVeHZB6HTCu3lbMJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474277; c=relaxed/simple;
	bh=Z70LngUR5BR/zw3bhe3+3VK271EfWXQXzkCckfVQqfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpO0xdYbYtaljlm8qLBqskMTVepAYEQ43eH5cbAVWMxcZwv4R82BwoE4SiUcDEdlmH2vVRMHyNQNPY9b9amD1tQiL/1+QcWrEL2bmPRsveem5mJVNOzz/7W2RjztyYZ5TBJbP7koUXdA5ZRuoMrC8WCcJiTVzRixHZeL12XLUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QiNfTbjC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837584120eso34537655e9.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772474275; x=1773079075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/CIADyXEE3wl+nWzZOQLBr0BrVFgY47ExHZeSHkKCQ=;
        b=QiNfTbjCStrLiI8qublL6edorPITC81894AIEXqPfVq+/zm3UoX5BxBHMVMcToESWT
         rOKeSPUOR88G5FA27ebC/NwjbC29wg+6R+HFyLd76rGlt3G5LlbpoeWd/tQobHFENTlK
         4ruo3Liv25nbagvlFvWO2qBNZ4Qnw/5NyOyYznzEXiokWvUMNht7r80YOrCNkk7QkwYM
         uEM3vn0suPdJP0y60VkdkZ/XYwirmvGo9D4vrlfKMQVXDLNIf62ZOC2s+lmXEG/3nqj4
         h3VlK6ElfMv2a7DPUqTcM6oJ62R+azpVEF51gmEP1fgGqpLrrwG/Sf/Og1fDc0U/9hXX
         1dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474275; x=1773079075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/CIADyXEE3wl+nWzZOQLBr0BrVFgY47ExHZeSHkKCQ=;
        b=HpFyy/eG+74esWprUMuM9Ge3w6k9mRqcAe97jkbrYgJqjhPJtk9fmpKLkc8ct2l5b6
         UxiSeR3GJKDyR1hEBkex8QgeRaL07hLDaM1ybMcU6VXZGM0op5F+yX9cDBh+WaLTzjvn
         Fjl8wPzyhOVB8hNY6tTmhaf5KZYKISdEFPtOKQvtakNWFp4lHF6X4KHr5M6YTMG8eSHv
         unrG+kYv8J/LV4CoT0YQJTnTLD5qMqPMTV86Uu7tCYhldIYMsgH1RvgK91UPm5KHUI0y
         bZ16qOgK7GtQKfDdWtiu8dyqus6CADs8HKUl9a/G8Ga6R5i3XrxP5VnJtVkU0RK13+78
         Mceg==
X-Forwarded-Encrypted: i=1; AJvYcCWu6jV5WS3/mue4FyC+sB/Az5lRmIP03DraBhvPgbrbGxAzP5KAUSKUzuSRfZYGYBT/iJcZYkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7qO5oKv6Si24f8UXN+WnpMgb8K2CNuGjO5Fx/A1QqLV9uw4x
	xwdcy04eE5AEBOGubf0X5pByfQXQYs97J2wArCm/9Ac6G0sZo42hSGs=
X-Gm-Gg: ATEYQzy4F3YVAPjKzphax/WSKV4fhafm8h4xsHRCaeTZHqM7GR9UIMOWx5/30ZH7m6O
	qmiSAVL9BarQGlF/GuiT169VyzC3ZTQiRDSCHvaUthtlq/zTarwWqxiRD7EcMF6Bn+t1bMIw3S2
	FcTOYAt2xMVGwI7rEGyE3fTn1aV5dzkLvzsVGr0cHU9HBmeELSzmOM9ol3ErpvvWPf4RP5uKC2c
	WTHwt8k0vz1Z3JQlw8QFoXVyFoumPOco42x+rAFiGrur7mcTrDClsaeKVp1B6x7+7htAzq0Mbwr
	zF/4/0OuchXH6npuNquShByrOEXPnKFkn4dk1pbW2a7BiZ2gepyeFMCSOc/FR2fsntBzeajW+Hi
	c0M9D1+cwjgX9wOg1XUYRFEz1xdgJVDQrSFhTx04Jt4INmF97UKjtbUnUbMyjdUkuG6HbmJq5QQ
	VSoI+X258DEXqY21ryy/EuADF4AnWb7UqUxe5OZ6EfPHbJ984gkMCAQbHw60sbvpUyNnBKu24Kf
	YHwuIXkY1Fl
X-Received: by 2002:a05:600c:4f16:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-483c9b942dfmr225314205e9.6.1772474274505;
        Mon, 02 Mar 2026 09:57:54 -0800 (PST)
Received: from [192.168.1.3] (p5b2b433d.dip0.t-ipconnect.de. [91.43.67.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abded86esm18412745f8f.6.2026.03.02.09.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 09:57:54 -0800 (PST)
Message-ID: <abe2fb5f-61b3-4597-b27b-c6c61f5efc7d@googlemail.com>
Date: Mon, 2 Mar 2026 18:57:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Content-Language: de-DE
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160943.2522184-1-sashal@kernel.org>
 <66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com> <aaXNiwFkUEy8SaTm@laps>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <aaXNiwFkUEy8SaTm@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEA3A1DE258
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
	TAGGED_FROM(0.00)[bounces-222668-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailvelope.com:url,peters-netzplatz.de:url,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

Am 02.03.2026 um 18:48 schrieb Sasha Levin:
[...]

> I'll drop it and push the -rc2 branch again for all affected kernels.
> 

Wouldn't it better to push a -rc3 branch then, so as to not create confusion? (I'm confused now... 🤔🙄)

Or did you actually mean rc3?

Also, the causing patch ("x86/kexec: add a sanity check on previous kernel's ima kexec buffer") is in all others 6.x.y 
-rc2s from today, so maybe Harshit should quickly check to which 6.x.y stable branches this patch was meant to be 
backported/included?


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

