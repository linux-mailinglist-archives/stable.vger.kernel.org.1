Return-Path: <stable+bounces-249047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GHpHDLuCGo3AQQAu9opvQ
	(envelope-from <stable+bounces-249047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 00:22:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C646455E14F
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 00:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8ACA3015477
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E238C433;
	Sat, 16 May 2026 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NEi92qrG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0938C2D1
	for <stable@vger.kernel.org>; Sat, 16 May 2026 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970155; cv=none; b=njaN91iVaHN3mlNy9rW8AtRl/q9mfYizN4bITC8DsgkKcwFBAzq/s1YVaZ3adhfpo7+sWiGqb8mwk0a30P99dCml7RcPCxG7b+bHIixwrtAILdPDBcNYfRVzR6WqozdhBJ0lRALMFn1f3MTAXbhJ+Bq1v41lMei0s7lSsENRm+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970155; c=relaxed/simple;
	bh=4jugQan87WW62OkdA+/W9xo3plv+dnJsx5zP15FbgtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/1TTI22RjydGAhe5Xva+tOlZUPxLsW5uduLipWjCxETso88Z6S3AYnIxCQ/StW60mzkB/dG6dEzQeiCk8TX9dedS397KzuFBdTbXjoF32nxpN/fjr+NV88P0f9SuHE5Pi53vuq+NDcPT9qXJwa+H1voaDzqI3EAbKSIxhFGw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NEi92qrG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so5167305e9.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778970152; x=1779574952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KJ2iP9YLpv0fim6ZmaqIgPF+/tIhMj4Q1ToMIsKE5U=;
        b=NEi92qrGDwkwyML/S6Jzkhkof08uaVynm9YskU5YmcnD/pDR/nLgMmTzxLGDZqqSgT
         QMR8mHVSJXjDkuMObwqJqNQ99trlmFmirZGC1HK0KqSqy5enM1Z1DRvVd793huZuK40k
         pI6d3dSFPhiK2LmJSmh/AIwpsKkW4ujpo3Xvell9xTD0oPwlphJKp0qJYKYOn6y+NAyZ
         N1uo3HNM2h6d75pQ7obJzmweKrWswXMd0x5dZMlua4SOn7YJ2K+LIsB8FnhANgPTaH76
         KmYLrUuF+2MGFaZ0Giyq97vYNbUmMFf7CFuF0jsA2l2vX7T0kfBj89gukYtaTf4ylF+R
         Q5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970152; x=1779574952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KJ2iP9YLpv0fim6ZmaqIgPF+/tIhMj4Q1ToMIsKE5U=;
        b=TEo7xlWAAYrf5IQWC1E09Z2rNnEbTzN2sca/E7YxrBRO5T6fYjtX/B6G60mxghPF8e
         mr+ooKiUExeWN7Q2xAyy3K55qt1/utDDBKiZo8q326HlQV3/GrQVTmyCEfzSS7TVrvsn
         Rush7YSlNVL6tNT6A4xxlJqV1V0VRClFPeZsSvRKJmeTIB5VJftNuda4apEM/EYoD1IW
         ad8SJItXIca7WHicAsMgUDiSIR4i0XdS9qR327Bsf6h0Kp257BKrqNIR1Y7Rzjj+l0X0
         2/Gt2mKZmwkKfO6RM38ZkrViFS81oFZGhQnVktKKDNoT3RV+Acd3sE1EzAxd19jLbVzd
         AKpQ==
X-Forwarded-Encrypted: i=1; AFNElJ89/Zs2dhUMLCBv/N8SURSb9555wreLCqwd2ewEvNrnqLGraW9hEA+eogKbYzPvLfQSw9Pryuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkb8qhvqYBKzp+CnPc/GfAXvXEEbHT9zAnD2ED8kU8F/r1myB3
	41KVgpdY3P3er/qKE5n6yL0rupEXwMAzMJb9C7g0D9MtpxA6dGVSPYY=
X-Gm-Gg: Acq92OF6061y95kj/w66HEQedH9jq9iB202h674Xe0E/XEaOvIrWbt12LMstEN45cNN
	ci8VgicMSwBfuN9TjyVa0S7XLoPsJes59m6XLcNr66xKG5ilAD3QnIAjUEg5qS0kSI/nxw/i3W9
	FOM/v561NOFpWRBQBQPxlRuLI0UDkQXqhXZhL0w45BNdz0tDmU59Bkb1iVNAAuF2aI2tOzF+z99
	/EntYKGVHziXoReXEWmBWvKHRrf8Any/ly2eU2UaSr+1UGmHugb9GWLzG9P1FPKIXrRENO7RZAm
	sY1FXxzkF+VJqUilJWQISuNgz9cLq2V4JshZqD8Bp/IFvXdtq1Q8OsAXKJCuSFEp2IheUcR7xQK
	0dn7bETrrQ5punnjmizaySjOSAsruYy5N6oRf9GqhppURc0QCNkicBmxwpcMWNNsa0r3UiByEsy
	wAbtX/L/a7PBzRgAnnI5W3L4Dba7epjAzFzApu6wJzsAryZBIzmSTVE1Cf8t129M8HrluQdCHHr
	+0gMW4oi3AyFg==
X-Received: by 2002:a05:600c:1688:b0:488:c21a:4754 with SMTP id 5b1f17b1804b1-48fd646b8a0mr131869295e9.18.1778970152386;
        Sat, 16 May 2026 15:22:32 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4b92.dip0.t-ipconnect.de. [91.43.75.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm25463416f8f.28.2026.05.16.15.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 15:22:32 -0700 (PDT)
Message-ID: <31029eaa-1d73-4ef1-8849-85b0cbd9a52e@googlemail.com>
Date: Sun, 17 May 2026 00:22:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/187] 6.18.32-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260516102236.209957148@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260516102236.209957148@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C646455E14F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249047-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Am 16.05.2026 um 12:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.32 release.
> There are 187 patches in this series, all will be posted as a response
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

