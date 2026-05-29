Return-Path: <stable+bounces-256605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMZxGi18GWr3wwgAu9opvQ
	(envelope-from <stable+bounces-256605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:44:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1455601C96
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F458301BEE5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D63D3327;
	Fri, 29 May 2026 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HjffbSnF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C63D7D60
	for <stable@vger.kernel.org>; Fri, 29 May 2026 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055081; cv=none; b=KjiqtOvyxH9ShiTaEfCZT2KmEirJ6MIfT7wBXGkyBpnn93fmNLCN37Yx0uygsaW5z145Ue7HVggbZCCwndsZCol07jHntACNjuVRKjZdQuXQeZ7uWebq59ndkbU73/VNI/q6fAChe26Bp8ZQN/tsmKXfz430Iyd8lIV5AImtbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055081; c=relaxed/simple;
	bh=L6WJzOOd+SO3INSrnI66lsTAn255xrDW7+Mg/xlSO/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2ZvrD2vFGup7zohiemjza9c2QyqKRjqFy7uPhrE066dsOFs0UzKQyd+odot+6nMNY7ujpVLv9ZUXRXRd1o6phDSUAFtsbhDGu3Ihy3S4SwQcN+RGYM3wYdckyhTEOWTWU97aVCSotcdhp0Uyc48Q1aI3VfBi38kzzUNfBtOwyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HjffbSnF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so73150765e9.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780055078; x=1780659878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+W9+aXEUWxY1aJU6VduC3yrqFtqunb/fOMUbFnaV74=;
        b=HjffbSnFYp5GFJPDBwqRG+cB0uV/HDYnJ84HAcScym7vjTBzg5CR4nJMdIxN8kINzG
         m5AmvVtsqART61UuaaIwiYfxGlSZ3LoGs2drWAFGtiy4469yxxZcDgQKrqKEk0TXOMm1
         iLmRGv/TweMTzJ4qlPaExkNcK4ZJfhKH73543rCGPXup+uSSjwea7JpgzjsKOXbJ4DM2
         rE9SwKoh0wMPVLW27GN/9VjmF+oCpCrmtYc/PhsSDlPAeUG4NpglHSuRMWJ1cA0R2xUP
         odIuLlnT8ZpgxQFp0VB8CFd0pzdlV6/02vPL2hp46vGXaJcsXLcVSYC1ptltfkISiJo4
         rM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780055078; x=1780659878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+W9+aXEUWxY1aJU6VduC3yrqFtqunb/fOMUbFnaV74=;
        b=TtM7oHxqgFCzZRnLZ7Hvlo6D+TgzubIGJq1t56l0/q2GRyzZgi/UVyd7FajHPvfF4n
         9ZnpGyIM/8TminHV5d9RomTomFzNHNV7O5Kia6azS2nYs3V/wOF2246c3g4zBXmPFzwI
         yV2c3TvFQiYCXGu+qUwhTUdCYRldqRnl2PVXhSHcgh9nvcOR/cJoSUHxj8E/0KCrAWY0
         omM0u69pPQ4SFxKSSYV8su2MFonem6EfLrRKMUp9fmxCseBpHRmiIBHdFmF9mxuQp7tr
         lL4FZ8c65CfeJ3/TEOluHm2hpCs/eWKtwdWUsdxG5SlcPE9RH/1MfEW37SSWgsAl2LqK
         lNzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t8IBQikaONM8bguXyFh1DXw/VMUbNO/7WFXIFLcbswJ9IC/2Ek9Iyvirh+QbQJ3uA4Zj/25Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4SF8wdNtY+HqNPE2+ty/TgpAVo40Q8tvDWaAhTwlzrGq+gqV
	bMTvS+k7zVPb0YDT/XkMS6ESuZKkVhq5COmGy+Oy1yEOSLhzRHH2tMI=
X-Gm-Gg: Acq92OHeckv930fxLa2HdRkfbbCCJGDFkZ9VT5gKD4vy0CvfuWVkt8CJ/cUOz4LX9Vp
	xySUPJ0+MTExZod6zAZdPM/8sHgZQweeH5igytAT/dzVIvZ50gj8Duafjhljl6gG1SDo3rvA4rl
	38U/IGszIF14GW1y2XGcR+ShA88v1q5UBgYXXq4AxcbvJG2qxR4rwUj9/Jb+Rad6rmP0U5zQOQf
	s9kQlYjZIuh1Z0q+mR1iB+lDuNmR3DbDgtXvKx5/TxEQiL1GMD+VL5xuT7BKLoYFRa55DEOY1tr
	rlpMEqTdBv4K+2C16QCuM5MNhg0bkLTPG9XZoST97Eh13kExdaSgVrc53xWFmQhRU8r1VgV8J5K
	JPRla7jq1QZMqlB/wb1uis2V6EUoNfkC6tB0eZOF3Wtb0ynM8cIdjlfOA2WIeUmLhQkgwrPvCKO
	RGHlHUmAfVmmVmk+xawDRSJYOrjWmbPmXTlkMi5eFyO+MCfcC8OZ7acYu7feUJt1h0+p9tfd8Lf
	ie4QS4crI301A==
X-Received: by 2002:a05:600c:468a:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-4909c6120e8mr37414255e9.7.1780055077942;
        Fri, 29 May 2026 04:44:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4ac5.dip0.t-ipconnect.de. [91.43.74.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cabfd6esm40885355e9.15.2026.05.29.04.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 04:44:37 -0700 (PDT)
Message-ID: <67352312-d0e5-413d-86f2-b668058ca7b5@googlemail.com>
Date: Fri, 29 May 2026 13:44:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/377] 6.18.34-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260528194638.371537336@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-256605-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C1455601C96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 28.05.2026 um 21:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.34 release.
> There are 377 patches in this series, all will be posted as a response
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

