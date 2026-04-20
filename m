Return-Path: <stable+bounces-239996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMC4E1iM5mmryAEAu9opvQ
	(envelope-from <stable+bounces-239996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:28:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A1433BC5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F6F13013B43
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433703CF686;
	Mon, 20 Apr 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hxM6SaF9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAC3CF05A
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716882; cv=none; b=MHOfEPrXGFj32PRK95eFPnc/UKqtTlYXOKZn5dI0P8tAvJrB6rY72DwhrGYYnXw82/nYqNTuyh/Yaa9j7v7tlwlFu0NzgnD0ogD/HO5iKNbmaMIS6a4eq8rAZ6UvWJJ9UYoJlihtn8ys+zU8wI+L8CyT9C3idp9H7y2ym+Who4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716882; c=relaxed/simple;
	bh=9iU8peSyNEazECgk0MUxLVht9prnh9nocwZHinGuhzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMvBlVHKLwPjnWn8atOj/4QkeVP6HxWvW8w+u9KIQGxstiH5u28qON3Q3tpyramfPY4pw0tz1bxSXedC5viiBHUNPnxA6tDJleTaPaX5n1AeAZCk4T/uMTIoT50CCRyRvM8+FqZj75O2wGC+tHvoC6NQAgycdg3oYVpX3G9+nQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hxM6SaF9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso32229925e9.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1776716879; x=1777321679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbohDM206FIu9lVBq2+3rGMayJjLBQfh1p0v1U13bBU=;
        b=hxM6SaF9wzZodDyvtmGIHujzzQQ/qg90j34gn1eqnkAOjTV/dXBsL53BAnvVBhGGIw
         l3RMQMbkLEoC/uK74T9vJZF/AQqAZRvg/9zIqmnyMQQhiSCev4FlCkanSiLgZN+IOZSh
         unWxmG3612z6dvuw/OuUr5rUYU4Ml1yLbZV5/FahH5pUqGUu5wGFCWJBlcqScHglT8Li
         ZBL5+LbmdTwD2+V/y2SuHG9ngUthL9eO3A+ftzkm30ZqeP7c8q8xNQelvwsxPiKxg6YM
         58Y652DCXXl+B5QZFEe2kyvtzDhgqQjTt1rGCR55K7xsG8c4XzXm1KIZvy5v2iqqFNac
         03rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716879; x=1777321679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbohDM206FIu9lVBq2+3rGMayJjLBQfh1p0v1U13bBU=;
        b=ev9GHy5vaVbPdA2dLER3+FjWeIbaoTn/8HjgQjF02Ri7BeQ1bakb5yfsE4xo9+lvlJ
         h8KRjzOmeo2bZeZLIIMBF4Ds29rp/vr8kPZnIvySZdZGzpYE8ojr06Al15+UEBOB3iOx
         HlUDSD1NUUIbwAIITa32DN8fc97NKQhXP+LqZFnynSp/F6HhvmCDKO18AX7HtG64lz+5
         xiNT3zfUyaq20yUCTt7n661/y02YgOrWeg+7FzYgkrRoV7ND6T3lWWtJNglYDbP/Xz/9
         G6OH1e7zTh4buXTGnoj81xAjIiyoL5axYLnE0o/F/IpextTDoFuBPE9QU4dWZSpucu7O
         mgog==
X-Forwarded-Encrypted: i=1; AFNElJ82Fq21h+78oy6zbJCpH1j+0af2fPyp5QmzuF7Jnpa6PF94Z90Yv6fjFR7xQmDnV0ErCqnSQGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTmU3OOtmN9EH3usWCkx3oak40QQ2L5PGywcKlu1txIbNUQEk
	tAk3Ce3U+3BogB6yOVsvQGiWms1lkHorE0buPjBKsFiswOdXWa4jUcQ=
X-Gm-Gg: AeBDieuuHhy82N9fWI1EyiEl/ZumtkOmrlpj0znqnJ38kGRzAoTwlerQQKYCRGbowtm
	ztxBeCC38F1oWAjycANsIFq/F0Lrd8T6QwLipgImJxeiZ3cPiYPDTOZb3ai6XKQagdA5Cxi2L6n
	own4RWCAH16ifoncoHHbKOIABz0IifugNhb7Qur3oEq8DcqbzCKk/4SCrudCWxVRRf2qpgECUrQ
	cPq+kRLXq9EOsZRTOoUxzDz+8nrds4TKTHXNqdLvb1xN14OyTyuVa/iknQ1d1s69HuJCNvmx0iA
	QvA9W9txqK5tBh79GDfcwDKZ1vUTSYUqjrZQr8ohnRnKSQ8i6F8jvBFTdTzHOOzPbqtAzu9B0HU
	/3y7sHqFar3y6OeSLX2+lX7HHI9CCmxqjflzTLHihF1GtHJjn8FwUVehZdyXXLe1YVT/JWvI3tI
	PDwl/5dfP1Wi936cfYYZgy3Jj8jRx9fQT9L7UQ1J5L5hOKCxrucATCK9XVsnvUxpz+x3U/QqNMa
	5wD2Oseg1fqDw==
X-Received: by 2002:a05:600c:4f49:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-4891ff176bamr64126345e9.1.1776716878783;
        Mon, 20 Apr 2026 13:27:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b42df.dip0.t-ipconnect.de. [91.43.66.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f4016bbsm25408995e9.4.2026.04.20.13.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 13:27:58 -0700 (PDT)
Message-ID: <276078a9-7c3f-469f-92f6-5479579b9349@googlemail.com>
Date: Mon, 20 Apr 2026 22:27:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/162] 6.12.83-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260420153927.006696811@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-239996-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: C47A1433BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 20.04.2026 um 17:40 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.83 release.
> There are 162 patches in this series, all will be posted as a response
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

