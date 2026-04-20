Return-Path: <stable+bounces-240006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKnTFe6f5mmyywEAu9opvQ
	(envelope-from <stable+bounces-240006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:51:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF83434604
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CF27301CFD2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB493AA1B0;
	Mon, 20 Apr 2026 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fzL9HlHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1939023C
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721897; cv=none; b=C964MkO1zgLbnhQglCEyVhMyjRFNBFO6Un1812ENbQ2NTBQhQXfW3q3ckL+zeFpy6atVcPfoE6fbvFrlLtvttAqoUTYMjJVbtlSmje3+3fbl7ZurlBRbv4BQfApQdk8XSMWkVexjxPPfFfuhPcA4pWH/MBlFkwUBr//aoEjU3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721897; c=relaxed/simple;
	bh=UCH09i9kr3HwymcHQIHQgdfUhNnnJhDUwwT8dkBQh/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PH7UvuaiKKO/CJoi/MuxOLvU6C515bM/8f9HrVioTBz+WG/KUUBI/PdbzP/qGob6MHpoQLlMjsIzpAUysmFDVe4A2EvZu1Hn9ImaOD6Ah0MeLN8YCsIHkL9aE6+FHgO4/kjygZABk3YsGYHfsl5PLLNs2XBwM2Iot8PH5lVkweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fzL9HlHI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso47116005e9.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1776721894; x=1777326694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWGpw+d0ooBuRhyWKv3BkdREzSb/1BEA1ncaeoqJZ48=;
        b=fzL9HlHI6mgd1LDeAZeScDQwY2IoCYTzTUXR7GAUE03NfydzL95P0uBDF0Xt3FPqTs
         LCeYUStJ1yHuggbTysep9tyR0l6AQAflKX7MYjaGaXC6nNO/wunJpvmUU3vB6XPA7Lgc
         hx7qs99RreeO9rG7YlgrJbW9IRc/OQN2qMh+xm7q9OPB7cxiiEk5iR3n+gAxrCizmygp
         Xh9KeIOko3rl8npti1T85zi/xalKjMmoOXABSioeWbFqne9znPPQRIahDLIrKs1VBGsT
         Vpsdo9csqY+vrnejfgO6I39uKTYJ9/5UWwtK7XVoGd+vhUavem31/jFPdPofbL3zCKlk
         TjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721894; x=1777326694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWGpw+d0ooBuRhyWKv3BkdREzSb/1BEA1ncaeoqJZ48=;
        b=VEq1y4z7/VCG1vnRC66ZWbk+iifUCjItRwRRMxFFjKGhp+bVar0LPhHLy/eibHzSaJ
         uXFHz6Ehyd8uZ1osfWYozwRTfXcveCz3kfZMB6x0sY13aoskT1XS2Qa2doWolm7gM4wO
         KrdU/OoBTg6giqRTvrbJzNeYFr9vNqvccNXVrOqKlRnYVOzdN+HHuqoKM3xpEh2jkMmk
         84xVUvoxbnwQVVy9uJ2ZaWxnIjkAIIQo6r3QcNcBu+4hw0X/ldpr4PnTKfGosIbrprJi
         Nz/pJXyF7oMPaG5MW0MpYGOEwS4WHBMU3ytgFL0aU8ODdAbaJhgsAePomV+pjdrSasTF
         DOIA==
X-Forwarded-Encrypted: i=1; AFNElJ+l3I1diDNIF1l0X89kQV/4NIjsR6mSWs2usV/9nwGowWcBXdg9I5SHZX4WC2z8FExGbD/pwKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymLkcAl0ZV04PlUH/P4fY9EvGsoRI+xnsyyQoxwwhgI93cO2Xa
	C0EpYAe5YjRUOZm1J623NcLnr8mG5PZXUwuCt8G9y2qPrnpl1wfTHJM=
X-Gm-Gg: AeBDietO25jNqxYqWU2sPxHdEC1fP3Yu7KlBl6CvdeVicby7jGi/UyY4eSlNcC8V4vh
	kI9f1gC9BuUz+TXW72k1SZqc87qExitrnL3eqg6g+7WIgzpARshW7y1IAevFd4Gefygb329c8+l
	bVQctFmPa5cMOpDr0jeTW6LV9yzZ/QaJJ2EJB/XRR6DFIm+oB67D8c3vVuqgSM3yCuYldVOjh4G
	RHajd31O9XeBbOM6XLp+CrjFfKnLVtsq+OnCv0fdARg3scl/pOWGq2B8AI6Eue/04bNakc7Llja
	d+2y3ZnOx1VYjqnNFY5MoeYtAA+u4xkcEpeBgUFGfbFZSa0dR15e+ZwYJ8dOqxxa8poQ5aDWVF9
	4W4SJ5JykTJ7X8SHOS3exMOA2xz5SyVLFkvmsYjiDUAE8T8m991/MJ3QDHmaHdq7nNw5xvmWsHq
	2XF4u/xya/ya8Ef2zm0dqHGzj7hke2SGnuZRWUzyR41TMIoNs95wuajFHYWUnYZGlnn5lvVUGXp
	wK25vd5AVDEeA==
X-Received: by 2002:a05:600c:3483:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-488fb7787d7mr197990245e9.15.1776721894021;
        Mon, 20 Apr 2026 14:51:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b42df.dip0.t-ipconnect.de. [91.43.66.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm147966165e9.5.2026.04.20.14.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 14:51:33 -0700 (PDT)
Message-ID: <5474b829-b135-42d4-ba66-bdca67f04d66@googlemail.com>
Date: Mon, 20 Apr 2026 23:51:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/220] 6.19.14-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260420153934.013228280@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240006-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Queue-Id: BDF83434604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 20.04.2026 um 17:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.14 release.
> There are 220 patches in this series, all will be posted as a response
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

