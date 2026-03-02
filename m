Return-Path: <stable+bounces-222696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFiXGVrspWlLHwAAu9opvQ
	(envelope-from <stable+bounces-222696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 21:00:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF1D1DF0C6
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 21:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60E2309247B
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4ED2EA468;
	Mon,  2 Mar 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QYQ2i8n2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025F2E54D1
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481351; cv=none; b=iEMAUtrxCMrnCHkqjfZhEthiFgW7cU9aHKBrScYWu3DBKt9TmT1bU3ZV9UhmIBQmn0wq3gx6zzi79n8p95ptDtPGoMuNoLvkb1qEcyELBtIuspk6jeQlX7q/YNiNWsfjmO0I/mT83w+2sEA/3Els6RUgkpZq+7Jg3BvJflQ5ppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481351; c=relaxed/simple;
	bh=Hvd59+usVcaZ8ifj9tKS5IiJ4a8ZMD0RS9aEr11xeNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=temkAkgs+XCMBwlu+U06Uj0apt8TsTudH7gSXQTTvcXYdfRMiihN/86/zTJwrVjsM3a/CjD5VysR84P3ks0keHw0fWBpmlllkHkBfZxrr+DK/hA+ob6U5oFQJhPisX6YxRr6kga/nehdEKESu+KgYdK69aOmpsXbOXho9j0ejoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QYQ2i8n2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4833115090dso50568205e9.3
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 11:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772481349; x=1773086149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7RGg+lZsEVvDvA8CfA6jT3knN/NNfFfEMkttW3wrEI=;
        b=QYQ2i8n2Pci3+2BHV0CxPJ8ZxO3WWgPZbXVJTtXRqNLNZxOBn53twTbFNScyRYAnNn
         4yH/u23mDUaM9Hn/+AO1K4SPCUF+wFoxnLd6nAFhKRKMv+fYeub6LyUdg/p2hjwm3RCF
         WLdorHeRcAgoXDEht7/Xyc1ezy2s2hjhVHIPvnyHoWMgpII64nRzTA/b6jQa591wbtS3
         kG+cdZTtaJTHRIxsjnOlgR0RirmqBBxVsdL+XseaWiKyWuhmd+xc3RQxE2Eljxveqcv7
         anFqvvoOoHG3EGi+fWUOUyR7Iwb29Y/8g2iFDgY7IhVbNya+5EDvE1r5XUBUMjaH4HjL
         kqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481349; x=1773086149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7RGg+lZsEVvDvA8CfA6jT3knN/NNfFfEMkttW3wrEI=;
        b=Q/lQzumesvjB4tOhmk73Oi0Dg0l6cOnhLK96+IjYz1SdSguxu8TaXb9/6tXpk3jKA1
         AlwZ7Xu8jLR3yzUXZRmyqhBx2tfa1DR3rvpCI7szTxcmflDE2Qgx6xdg1qf4VPkrylWx
         e1MXVMXLe7AZB7cRpZFMg/bvowCce5HpAbJ16jFqtNEWhH89hFIX7BctZ5lSbiPJB7+y
         VZwtTbrvQav7IoEmmR5/jysIw5NHzOY82JEAVXlZXmRyp/qkRsb69I/OkV0lcpgAQsmN
         rSx1OoBfcpludiXnrhrKeU/YRrM1rz/K7QxglJifaNnFDUjjbyEAP4ctwq8l0sKji2zE
         6fGg==
X-Forwarded-Encrypted: i=1; AJvYcCUosBIO+DsaMmVio4hLI3srRkUo3E/PaKSnXxtVbZFWwfWg7I89p4lvGb4fV6lqBC6uUvTpat4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszrITt+WhCQxjOhyfgOnI2aezybYd3CSQibrwxplNwWurIEMJ
	+FgrxFScwkH0CerKEVHPoLjQf4+BuAjtA4cSQCkM4jpT11zyA5fv/Uc=
X-Gm-Gg: ATEYQzzW+w8yH8o+Wo8jqOBRIuPcRrEg0EWRFepXK0SpdiOS/rrlV3AXENrhCTEHYWw
	9r4bFQTn/bMbIUJpOIOGJ9MPVOrMUfE0NMs9kXMY67dUn+36zMPy6ySXJ7f/+Aefu2gr7/8pafn
	Kl5M42r0MoWflP+VcTXCfxnzxg6cVHXD3LxXqCYrwHEWsHKfa2UBU5G+b/m161BfoQM40Or3mmq
	fjjHK10BTEAAWwKwfBnX444A16+XMQ5N8uLlkKyNyb+LKx0Y7iQzbBsEaslWU4m3kCQvmETnD0f
	RKZPlBrMe9Ibhdv2lRQ8POrpEN4teVdjWhJrAlECsKtqBWNZX7pba5nSKFDbvr/a4t8XERH6aGp
	Y22TPkxOgSyw69ya/Ts/UxMjEMo+fJUfvEPnc72RWil4R5e42mk7i3LyMAfNjXOPFWhLI4qalT0
	tjyMWLSvG9qqqWDGsfIANHcuPxV62oYuQxYKib5G9rMa7LeYEH96ga207OPhkmBcr63n4N3kK9l
	g==
X-Received: by 2002:a05:600d:6447:20b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-483c9ba7e34mr162489315e9.3.1772481348284;
        Mon, 02 Mar 2026 11:55:48 -0800 (PST)
Received: from [192.168.1.3] (p5b2b433d.dip0.t-ipconnect.de. [91.43.67.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm259967155e9.5.2026.03.02.11.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 11:55:47 -0800 (PST)
Message-ID: <a04b1aa6-ba46-4368-9dfe-6320a2dafa79@googlemail.com>
Date: Mon, 2 Mar 2026 20:55:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Content-Language: de-DE
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160943.2522184-1-sashal@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260302160943.2522184-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEF1D1DF0C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222696-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

Am 02.03.2026 um 17:09 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.1.165 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

So this 2nd incarnation of -rc2 (57e92ee8bab0fe5c2396925771b394f13d531cc7) now builds, boots and works fine on my 
2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

