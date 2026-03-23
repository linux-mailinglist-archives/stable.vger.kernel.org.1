Return-Path: <stable+bounces-229990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFR5IyGLwWlkTwQAu9opvQ
	(envelope-from <stable+bounces-229990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:49:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC44D2FB8F3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ACDA31B0992
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FB3C943B;
	Mon, 23 Mar 2026 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S8X9VEuh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD212C0296
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288722; cv=none; b=Tq676m7iZ4O8MnYjMpGOqGgsxnK9HDxAGwpV7QiCh6LamqP2syIx5Vi7Vfs0dIxcrAF89q2qtl1UetQiGHia+9wc9tMX822jxjXWGGJfh4f85uZ2Yi26bRAG/0q8OXgLxt6U3xH4oFW8HHK9opK6lU9hgjU9lhzuKsI8yxbqNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288722; c=relaxed/simple;
	bh=JoIGIbJWlZ3JqaUmsBKT4AsxRLSJwIJ08kbl2ygi6V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLCILs2OpNeMk1Uf7fUNHG+Glj1G7+GFvPowQ32kwPwkP+udNh1vOS5cquSdGbxipEJrhHvU3SUS4Y2XTgdNDVSJcGGB2JDoYP9YKAi59qfC+sJxmKPOa6BsJQVCj3RlVzIywcdeLySE3RDXwMb6ncUsYc21URcIM7I7kKQnuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S8X9VEuh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso4055475e9.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774288719; x=1774893519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NF4TYajtTbEevb0sTKIPHFXOcUrsMVnj5VjH10bWuJ4=;
        b=S8X9VEuhKRZKGfbjVEadJrjpcFw1cf1o0Ns/wkLe7uGVhqJlzO/BGs7XcE8+i9lmMn
         9oZH/rwxNdyAiSk21cY4MZuV+87FyeEXOkrRI6teCEnTM7+AXgKPl/oUnsQyCuJ4X9H2
         0I2zx3UduVCdZJdmqzmM0rfD1isbT2scV1NiTiT5b0Lwl2Bkt1OtUS+N811734MSyOaF
         cJBh4xqVjcG7siDZwhFQ4kiTghoTcZGCkkPKfaZId6URkoLuDjYGEQ3vB//Dk6zKxQkc
         s8Hw5mXEpKF9agjOhyfH300JOeOeFnO7qVSynFrjfpecG43oOaxKQ+KLsF1w3jfxsVNm
         mZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288719; x=1774893519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NF4TYajtTbEevb0sTKIPHFXOcUrsMVnj5VjH10bWuJ4=;
        b=g+OyNDDPG2na448jOrlXpLN5JBLfaii16akZaw/e7seXv2WMpq/qErMZ1nFM1hlU0t
         HRaLaPUFmjshxo0yPhL7+kUqoeJwdugJbyQvwBzX8QPPiIvbi/h9rgd+hMZONal2JoTZ
         hmdPyU21w6F+KZpFiLDimOdUybYk7wP0kln9ZBs/QEFiWjYQAXTPYadTAJzBzi7sHiXe
         1uv8OKeGempgWR535AQnf8rSR1eI1aR06CJKn6AD7H4U6b7uceTe0K62c8ZG19PiHLRT
         rNDFZK5/Jze/plos/vrfLUOK6exzV+gkBMsUKwfWQCM4DZn+xup3D/er5IPcr4NVxM0k
         gWZg==
X-Forwarded-Encrypted: i=1; AJvYcCW4rN8N5bl+fCxOmpKcGcaieVu5lnhYo9eoaN5LRGJmz4DLr6oBFgQgh/KFbIalBNCkcV3II14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6syIjCWfjSF1yfa3+szJaw6utC801fksaOvDYpDtRwdpEwvnO
	z9wnLc3x4KSD0YUKoaYvwVHsybd0vWID0fjEQxqvwMCxcbVVKyElUh4=
X-Gm-Gg: ATEYQzzJ9tkAQR3S1qscaXR8WGPV5+FjeiZQPJiCn4hcYDy13IuFHD7qBJF1ygJ9bR1
	fuCfhIdmM4mvcrFXwCdqn+yFKYgvSZvagKQf8rK9dvgfLaP8r8D7EZGsvMvv42CIo/7dKKvLNBu
	ikNR9W0pxzsAN86E6HvG+MQESDMrlkapehpoQhmRJtxNQBt9ho5frh0cCFLl2MFtT+hI7Z93b29
	r2nUa7uUPpdCI8LEXUuDy2PCBMY/ZqL5RizBqmC74JFa1JXqCrl7r9PeRF4eGqe6KmwLcHMb/EX
	0uvnWHfwpbFzmyOQHHL1k8r461CMCFoXaF0suPDLY0RHGLQTkFBLUKKCJe1jSNgxPUFERA+CdbR
	0LgGCFymciTBdN04Q/IqCifTaWN+8k6BGcFFhasAhWJ+sNjuqupaPRjrGfoK9AK5yrJaI4gdiqJ
	T3WEV9onOeuh3qPn2aJc+uvmQWqYH98Gk6KKogcFSLiHOm2ZBwwyijSsbE+ajppUknlegUhxJL2
	Q==
X-Received: by 2002:a05:600c:5248:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-486feb5d845mr196954565e9.0.1774288718737;
        Mon, 23 Mar 2026 10:58:38 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b444d.dip0.t-ipconnect.de. [91.43.68.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48705135631sm220474025e9.15.2026.03.23.10.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:58:38 -0700 (PDT)
Message-ID: <d080ccf9-6417-4144-b14b-646bec74fe1e@googlemail.com>
Date: Mon, 23 Mar 2026 18:58:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/460] 6.12.78-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260323134526.647552166@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229990-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: EC44D2FB8F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 23.03.2026 um 14:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.78 release.
> There are 460 patches in this series, all will be posted as a response
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

