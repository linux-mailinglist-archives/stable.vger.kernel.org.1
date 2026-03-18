Return-Path: <stable+bounces-227136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLBICmT2umlvdgIAu9opvQ
	(envelope-from <stable+bounces-227136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:00:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EB72C1B99
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C052E30A0D14
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30A3E3D9D;
	Wed, 18 Mar 2026 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="asainJvy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75778306486
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859441; cv=none; b=L3ZCosUKdq0pSF79CRZcrRGG5Z/WjYwg8N5ILd5fGsIY9S5W7x/IZiGU8Dqt38pI5fYrb+YWJ8EQIfNIMVVy6f9nnTCvjUZhe5IPbhqXHS7+1zBy1ad762u55XXPRlkFocxfHMAjOHQlvvP8F1I9+Kzi1tZRT+W2Z9ftp5V5X7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859441; c=relaxed/simple;
	bh=8Vcm/N9roL1EiGoUQJrKpZXwbsvsdhmITMoWN0rleZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgP2eMm36ewsaAz96lylakTd4Um0S9JEqPVgGc3nnNt33KUzpIkGn06R+Z0R5rJacvA1Ra1wfb6XLUG3NBPEjUVrPrYYEe9xS8BnQbKBK2YcDC6uJ33sMamAZqu7U11V50ZrqZozRdNziwn9Cq4nq966PI/YqYjzDnYK2E8hmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=asainJvy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48539d21b76so1357995e9.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773859439; x=1774464239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5gQcxECEznuueIY7HzNm9vgGiTnm3cM7BA/R5amhsw=;
        b=asainJvyB9Sn/8KlHJuvRAhIcCAQc3v75gGOqz/UhcyBKR1QIumNghujYGfAtzQzLC
         YaxfsqGtlosLgUackY1NuM3c/zwcl0p9jNlbRZEqNHgAGKgpBbdA47kPOKKSyyOZVteJ
         VC2D1+GrCq0++sPTf3e5ZQwLrfRxp8fZrHLA952ktuOr4+wswniEnV6iHcx79BRxK1RT
         DoVsGpoz1rKT6kSbWt9/EI5tZ/LK0erg+M8uS/q+FDLhi0CkvDQTi6kUHFRCllQzrqCb
         d07UcsP3xP2pkn8Wix9j/km4p2SJwXE0OU9t9em/wtDoyWqIWb3n//iwqcXaB1XvATr8
         bTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773859439; x=1774464239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5gQcxECEznuueIY7HzNm9vgGiTnm3cM7BA/R5amhsw=;
        b=GtH73vkST77OOmjVlOI5Veopxe+OT81UVh0Njl4N3QlbSBTJS9xN/PmalXRtAZI1wR
         jQaiS5X+rxXEzoUsx3Xv5sEdjfbCQ+WShP92UwGbyZ/+a/sIzdYHI2lRG0c1jhipXZVf
         88RZkhRJFi80x1JhY0gKglkqG9jZ09AKyfFvuQxhLN0Nk9GiMWNoTm2eSB/DnnyGI8xw
         OufDbPXMg4DWo5KJW2noq6ylflJBviy8F3iR1caRbXlwE9wEhaTSpYUlVWaPfjrp4oAr
         0KdaYQUU6zdqOHOq7Oamqvd6Hy8fGg96KegJCcjsWPIyTxKu8knMa0fuOIo8fLC52z/p
         LLDA==
X-Forwarded-Encrypted: i=1; AJvYcCVWp4EPeBAWRDJodRPpstvS5wzLp32D0KfalBov7iVdu3rx17+4cp3WTvYSU4OCzeZjINY3Fk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhuoJsENqjsPaRl8Tt8E0HJzOxhmJIUzU673qZX78czECPCLU
	Ikr1DLgePqrhtdlbaUpZKjNDuQabIOZQHRVJ69pDiCzY2g8KwDqhTmY=
X-Gm-Gg: ATEYQzzdHghjNwkoVXuFsDoSkkjreNHmUGjsHNOJJZaXG8njChvSYKlHVXWHYD1+8YD
	s+/SNhbYMow6GpdaSxD3sCpOH1EPxgFuLcz7masvJWLzaqpJ4x3hwrRF318Y3r045edyPIvxR8B
	x7ppTr/hVy8F6s+0D73ZZYjOLZ/rrw+OUw4zWfFb1+OsNm30iG7X2lazmedyX+f/aFwVGwjB6ly
	1btTa6dG8uB3dH7XkWgvTeCJfvdn7WjS/hFwhN8/dnRNRkjhDuKVGe57uwdxZJ2FbXEzMMZ1dIE
	30I4gffvyiKQuMUadVncRXWYuaKSWwnvMBsgGgKLL3leeeVxKtJi1/DqX60UcCMH167g6pYoKem
	kqcahiECrhRe90gXjjKE2Rwot/K43jWpO7JwOFLsp3EUvX8Rv16aJg/Axlz6cHaEP/FvuV2bsw4
	TRlXiYcCVr/1mvAR6N05h4wDKpv4lWGd/CuFYiMBo9mcC8dxO19FbvqwCCP4IzsRNGDpPuXlmSB
	9k=
X-Received: by 2002:a05:600c:2d15:b0:485:5d25:81a9 with SMTP id 5b1f17b1804b1-486f4422231mr44915805e9.14.1773859438445;
        Wed, 18 Mar 2026 11:43:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace2a.dip0.t-ipconnect.de. [91.42.206.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4baesm14540345e9.13.2026.03.18.11.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 11:43:58 -0700 (PDT)
Message-ID: <3b36d8bb-2450-405d-a23d-9feb7a755dea@googlemail.com>
Date: Wed, 18 Mar 2026 19:43:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260318122547.233850204@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260318122547.233850204@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-227136-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.481];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[googlemail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 27EB72C1B99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 18.03.2026 um 13:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

RC2 now builds without error, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities 
or regressions found.

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

