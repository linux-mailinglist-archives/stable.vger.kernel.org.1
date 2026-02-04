Return-Path: <stable+bounces-214368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAdSEwHNg2kFugMAu9opvQ
	(envelope-from <stable+bounces-214368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 23:49:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0565ED11A
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 23:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02EDB301D044
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81887311958;
	Wed,  4 Feb 2026 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vqd1boQx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2342848BE
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245352; cv=none; b=gh0eei7RGj6A1ZXXyGPtAh0n5DdWf4/65f8u11oaT0RufC3fj1OG4ShMPViznb3mCjh1KjmtUgVtj+T8CCJdKOWC0TPtynejbw2U//k0KtsiEoxWF3tEWv5l3/1JZGsrLXDVk3bb3zGg/8DYRccKixUPvcPDXVHzPe8m4JJ3w+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245352; c=relaxed/simple;
	bh=K8Ia9lTuVxFlAkgP+U+4P9KlYj6mtvmDyAoZ6tK7wbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhRhRoAGHouKzB8VcocaTdh42PfS5QBRHTat+lQpZggaBAJA3+DUBR8L/9bOJ7H0ntQ25Lp46vRt1B6IQF04bnUFiMpqJYaGS4kN687MjrLshFn+i5PdbXh6rTu89epT7gPfn5/6ITE/fULxb+hGEVj4aaYvL3xEm1o3Oke15pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vqd1boQx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4805ef35864so2260735e9.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 14:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770245350; x=1770850150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFSXRzFkvPUDEYf1jFMVqisnrtt9GSXABprqdw3T+io=;
        b=Vqd1boQxXFGBy1wDXMviJ3Bk7vlA9fgiWQ0Z79B+w4RxqIE6LP7GZJrd7z4L171Jut
         UGIjAN+Sn9sjq1ecWoivmgnSuWzV7hoQqcYweMJ62xUudzzSwSL/ChNmFxF3zwLMC/VQ
         1aYWCGO5h01ViHYQrvM6avlrOEB7G5YQ9pjmIMKXxaNruIUMdTpwPzplAZ9HoroCYRMX
         JLYsMQ0eHqdoMDmS0T9VpJVqq3Pv7iZvvnlCjsYjRM9yY4CsJ89ExgWtR0AVbG4aCPrw
         KDXxnXMJ5Tgn83uVB6qpmOKBCHkrAnIGffijQeLiUxYNs8rAofKXWnWX1yKMjhcTI5jR
         35Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245350; x=1770850150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFSXRzFkvPUDEYf1jFMVqisnrtt9GSXABprqdw3T+io=;
        b=lp1oRVfMTMuOXQlLswe8j6Vbvuydq0iu3RVgGYgU9GlKMJZYRXtN3yYHKQPeh2is0O
         XMdUJ0pwfll1D9LjEUK34VxamZwWtAuVzyMuPVp7h7Jh9sWp3lQu9mBEBxQTE4OWkRTq
         drrzIWdJsFnxadl5rUYLyBm6kPr8FqG0ODuAl18mIFI9PtqMY0mRmJz3aYbPyTNXR8+t
         rhNtWFWDehhPMpmqfvP2uyNvkHl/Wls+z1Z71B/JpucI6cSYr2DT7tP14pIbMoyPLlJf
         d8/B+jbS3ui1Hxr4JmEdNtuK0qgNMfjhqiSVDAL/hA947cDF0BNRq7qFUEwGIlHf/ikH
         aY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCn0HleVq52S0VfOC+uNGWJbitigcSkXoAE4ivoCbG93lNmKapbmwzupU6ZEHSUYY37ZlACZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIqFW2iX//cjFx6859V1McFx9KmT+dPX3jm5Q1R9h5H9itc+v
	LLycVCFgF54bjASXNOSO9DW77uyFJII+sspJUqOts7NwWUc8tb4r66M=
X-Gm-Gg: AZuq6aIp9XN2UnpMyVG+iuuydLgaPBmj/ndM5Vym/59cyWaZNhI/DL4pw4H05mD7C6R
	99JtuwV6qpUVUd1XZeAIIN+btr0VnHUiEQnNCjordAhpk+vXm/WvN4geE6JiWkoRq6wuGY4+ee6
	vfB1IsMTKSd3bEz/OxnsPjwMTU5KMZI9nEsEIsQSI8t2X+GyWrM5W/wW+hdOe2BoPItEC/w+CbX
	8suWrU6oswbRub5tqt0WWus/C+Mcdm4HrkVtxkPIgBdGIxxo6GTdmiuejKB/rn6Kt120K/KO5zJ
	miGnJK/RjinWh6DgT3rknE4ljohE5rSfnI4tymNP/rwqFM83jVFEmM6S1JP+4rGLu/SxyUK0OD/
	pfOVd7GavwZUdAur6HJIiQFpUgZz22561BnNl+HNdB+EkIsFUbbWyVGpTa+UmbPGEgC9BZTmIYy
	IV3F0K2A/1Cwh9nm/mqo/j8dozeNoml05L7vMEK8EpoMl0xTGX21KAx4TL9LPjLw==
X-Received: by 2002:a05:600c:3b16:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4830e993349mr69936875e9.30.1770245350163;
        Wed, 04 Feb 2026 14:49:10 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4d5e.dip0.t-ipconnect.de. [91.43.77.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec4a5c6sm43932035e9.2.2026.02.04.14.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 14:49:09 -0800 (PST)
Message-ID: <ca2f07a6-c098-4274-b5cf-008692949c62@googlemail.com>
Date: Wed, 4 Feb 2026 23:49:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/72] 6.6.123-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260204143845.603454952@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214368-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0565ED11A
X-Rspamd-Action: no action

Am 04.02.2026 um 15:40 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.123 release.
> There are 72 patches in this series, all will be posted as a response
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

