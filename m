Return-Path: <stable+bounces-256747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK/DOn3qGWqFzwgAu9opvQ
	(envelope-from <stable+bounces-256747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:35:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2C607ED1
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC60C302592A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD63373C1A;
	Fri, 29 May 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plo+rzPQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807A376A17
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083206; cv=none; b=jJggs98bVQ8XgoQ1qb5tTTf0Tn4RrrKBAjldJ5bT5jOzfLEJ7eXi3gDrcO2lDMC+UYf8kGNdE5bKJ9umL30k1dg9lSjB/peeQp66+jG/qxiTgbSTpyLvCDRTtmZgWwaBgjLSZWkb3wp8ZH9R7IT9V0dq7GcapPU91ITW62i/J8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083206; c=relaxed/simple;
	bh=i4dpGhW5T68WIUwlYd5eofVckO/HNmKTiF1m0nQ3GBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nucmML04D1chWLEWxugCeSYNDOHj3XtUeqccCC/qq2CLsSp+//JsPkGauw09jQ/flpaF9+Xw2lp2IykCAwipRIfvpHW740Fz6gWEe8zjK4cs2cOpWf5o5M6fpYTltYt9YggemT96AKAacG0dMFJoIGNm+gOUOTJfHC1yz3BYr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plo+rzPQ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5102582e23eso114175571cf.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780083204; x=1780688004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SiSJ4bH8ZMtUfZ/nsfhYHWoJ7VZh5Xb+WRKRtalot4w=;
        b=Plo+rzPQ8APGmXHSRReRTxsANWyZ01v//fUpXP6xV9Zb5h2GgGoiAR4M2iqfd5261b
         1wpP1tGZecU09fZaJhixWc967LZsIrv9B0PCA1PK5OFZyetebA1VnfsWQeC5r/Li01G3
         dtXiqK+EA52yZWX11cHsr0KqQoTHf1u3Y5jmxxeVw7e8k/vKA/ABgR46AtjlO4ano9f3
         yK+3BomiPPRHVSjyjhveCfE/PJDzIxtoDCqkz3KIJNDTtq4mljnp19chaDt01MRoOeNa
         GQBP91kA4lirxRPB9pUoDnX0tBUhQSp/utQ88VNKmisvW3B+hXivECU4lg1LXQTffefF
         YEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083204; x=1780688004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiSJ4bH8ZMtUfZ/nsfhYHWoJ7VZh5Xb+WRKRtalot4w=;
        b=BTfDHyGKptuvQkIgGXkLxKsJk4mHAkLuRWOKExky7IhMqIIAUeWhfdUdVeN1xbaSqX
         +JV3hSz69WkcI94HQmcKqPNIW47LwpiML5p2bR1sutkwvWoIhBde+2KYbWfTXO9prjXt
         g/vSG2yWFYg8yKJcFsbImZfnmfogiHIsAMTWfjg7ZtD8PLA4IFRQYFLpRl1NNPy0C3QL
         PtNti5PvT1t58XS/ToLf3sCvqkMLz6MKLVYWuLNmyrWu2eGSmVr061mP21EdPpvVz22O
         9Kr7kwNnTsFbEK9utWzEa/OvdiPmG0X9uvmgq/BXCwyqpdlWGQY6gPyYsjw+GZ6QsK7m
         vuIg==
X-Forwarded-Encrypted: i=1; AFNElJ9cu+oXcPzXTTUmRQSa1EEmth4wfzYpYKKFMXoqTnEEVpW+c1gEsFUsyvTc0NB5LeCA+H+cP3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48cGfU/xDUh+3p5AgHtGo+G4iaGQdMYC/8aQjGuPtKAAs/J82
	ssYElNiQ+oO93wezrhZsQWFv2FSciXkL0Cyswzziz4GKhmuaHkPPXohi
X-Gm-Gg: Acq92OFtRGQkrkS856EytSODCWtFE8Sf2UEHaFLrhwbtZ6WaoqUfx7hkOS945vfoqn4
	SJCoRPdk5eBaJAviTbq91xCSEGmiS8MS9os3odCz/gYT+Wd9LxmRXu3hUsiiNlA1wXSXrFKuN4w
	Z1PZhONSKSU+31amcBDnvbjsTGcBLrgVU3gRbSmW0YTNqpcXbvLyg8AOkUucV8NaG1BVVxkuY1G
	JgPeeEWrw6vfdKDR0qF0yZQlZDza1QTNW+bDxBKfx6Or5WbTdIZf0aAxf6/Jmr+uVoMXro6INzy
	Q/auYk9EUbZ6v8QKQlLJ84rovBFdvx+52Ye2b0qwWfuWGpGRRC925t4DCe1pnsFE/7Ma/lg7Mzo
	96dQHrYv2J4O0g/6NBpwseJYSlV34g397vRFZRcfT0/6VxAt6vnoIFhNUycPFYgGGHXb/2RebAp
	/JGcnnJ4KEtAOUaLXnUTRF0mpvrav84xwpl/S7P6VuVSME9/CcL07BNa89uNID
X-Received: by 2002:a05:622a:5912:b0:50d:e471:2d1e with SMTP id d75a77b69052e-5173a7a33c9mr14237631cf.35.1780083204572;
        Fri, 29 May 2026 12:33:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517397eeec2sm8684571cf.19.2026.05.29.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:33:23 -0700 (PDT)
Message-ID: <56735228-63c4-49a6-a25f-08d37f604aef@gmail.com>
Date: Fri, 29 May 2026 12:33:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/272] 6.12.92-rc1 review
To: Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org,
 broonie@kernel.org, conor@kernel.org, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260528194629.379955525@linuxfoundation.org>
 <20260529060918.123155-1-ojeda@kernel.org> <ahlN6TPTgMwBT9_d@duo.ucw.cz>
 <20260529122623.bio-integrity-rc-prereq@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260529122623.bio-integrity-rc-prereq@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256747-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,achill.org,linux-foundation.org,kernel.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,gmail.com,samsung.com,lst.de,kernel.dk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gitlab.com:url]
X-Rspamd-Queue-Id: 6BB2C607ED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 05:44, Sasha Levin wrote:
> On Fri, May 29, 2026 at 10:27:21AM +0200, Pavel Machek wrote:
>>> I am seeing:
>>>
>>>      ./include/linux/bio-integrity.h:101:12: error: unused function 'bio_integrity_map_user' [-Werror,-Wunused-function]
>>>
>>> This looks like it needs:
>>>
>>>    546d191427cf ("block: make bio_integrity_map_user() static inline")
>>>
>> We see that, too:
>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/14592368004
>> We don't see the problem on 6.6, 6.18 or 7.0-stable.
> 
> Thanks! I've queued up 546d191427cf ("block: make bio_integrity_map_user()
> static inline").

Thanks, also seen here, FWIW.
-- 
Florian

