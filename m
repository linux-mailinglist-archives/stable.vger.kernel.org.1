Return-Path: <stable+bounces-243872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OLLIanG+GlQ0gIAu9opvQ
	(envelope-from <stable+bounces-243872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:17:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FDC4C142E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85CD5301584D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65F364923;
	Mon,  4 May 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B3G0hyhf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D261CAA65
	for <stable@vger.kernel.org>; Mon,  4 May 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911460; cv=none; b=QpHBHvGPo0LwEL2fWx8TOlxpm78GO2XiW++2Ro4C64GTbrO2LciSw/KiRQq5wj6DTrpHeZnXllQBXF4hHhd+m3yUIURmP6USllhDaGhBDh4vIrmHdQ7t/pTmCB5FM7WKkEU8+OAJIoK1Q+psh2Dd8CToqoOBVB984U1KozcXBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911460; c=relaxed/simple;
	bh=e+cYlcR/4LfpdBr8x2GQmIc7u37KbjDc+gIlNtqc2B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbYaenkNWm7qPPQKleBvXtoXTRPVgyw6g+/HRbTVLdggs29Gqb1iUNI8SoTSnlNEizrKcPBcxQEG/9ahpVt2Kh1syqruowLoMHoDMdWjiDJWDWMloe8VoxWHHX8mW8XUTrHRDX9awaIEbP3EQQlrgfz9eZHaLxfTgafTqW7+jxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=B3G0hyhf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891f625344so45461425e9.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1777911457; x=1778516257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PB0CX69KAx5rnBO+d/cQTMDVxCggaKTqEnwtGGRcSVw=;
        b=B3G0hyhf92L/m+dBk9uTC22OJQDi6agKoru1Ru6m0PBSl3+21SwZ/UYbXBJmkCyqDy
         tI8v+H21XWNUP2asvQYqs2Ls+qz8EgLppaFRj/3dn5wgeUj8Ju5wkyRQg+RjDMjBFL+t
         W6jERvvCxoSzD0R3vhdE+s+beMkEWbfIQPsYgpqleENhesew7VLzXhw32Bdpol8kxVK0
         SSX/bUUmhbjwDA5Lb+TUcBWFnwv82LfhXGcYNHEW/w19S4I+6qTKlVmNex+AetgClVAk
         0MO/sFyJfwOsLoxdSvxoAAk3RJEI70ZM7APOBT+6x9nEt1Eh5dxSp3tGAlp7d7QGS4w5
         803g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911457; x=1778516257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PB0CX69KAx5rnBO+d/cQTMDVxCggaKTqEnwtGGRcSVw=;
        b=SIrxBJ0S8a+Jhq8mwrb9Li2/Mt0EX5e5jFI5Ef1NWZ0YaJqKbfshJ3RQax3K2vDFir
         JElh05FYHRfZXhkyvcWgv6WZ7s/3cI7tHY5GgiF+EyS3W0fq8Zr2NQVYEKtZLL5HBKtt
         dKwOieaZxsOOofHFghRG8JHrJTlcOjTmX3lZTAjkDorVLuTBnGx9ag3zt/UxDeAxnS0K
         MeI7vzVTOvnI+fbTERbaK7tJ0vbKp0CtOzyvnqK3TtljSlqf9MIIWuH5AzjiU9bdcD5X
         0KBJ1HkKL8guQTxiZpRomxhOE+SUV0/v/uk5H0Knd/+SZnbbEzv/kOlBnufVJ/E34xn/
         LxEA==
X-Forwarded-Encrypted: i=1; AFNElJ+luC3/7qdhIUEr0ZEMX8hZZTqBNO1oIURXTyFIHnF7vRlGIZnKMybihyxbGHz27lgL3lobO2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHTi5hiYqDSLakrrDR/kin893JzPQ/KSxstHPaNKjthcX8f50
	v8/C6ZbM0vPu8prfz0//2YrqGbMHa5YNAIjRnQClH469j/2Tp8YRMMs=
X-Gm-Gg: AeBDiet4hxmasW8lJQRMzdexqjULMBsW8PSodEliygKGF02rdvQFxyREoREX/Sjh1Ib
	kJmp4JZiFBR3V6bohleah9xYmHAra2dxTayMBQpI/6U1ROllcgCmxF5/z3taxKLksxCtz4ArsNt
	rJDCR39B2ZzGEDRjj697XUPEqOlAQb/nUgQ0JGfbqTNFYWsYzaAaJRF8w3+acyiBlpZs4MXAA7Q
	WJSxMnZKI0wI2bPxyqDE6SOOygJ/5cHyKPcLVMrJi9RcaTl96pcoLDkIGd+vhK5mV3nIZTjE5Yi
	bVU4Jra4RU+9VLN3z2PNfXS78vuSTtFUAIETPsIr9mh8wPNFcrSKSOb30LGSLgrLZj+Xr92+Xj/
	bTXYKY60JqPKG6InHAjgEcx0IpTBnGjIBBNVaT5oaAMYIq7b7V67k4BAerpI9FkPYtYjhq5/GE0
	Xy2vvkBEr8oCTyaVamZ4AlUsSCgPmIebmr62XTVrRLEl/TXcF2rPduCbWvISp8KQQ2u+UTyxffi
	RyzDmXVD3uLEA==
X-Received: by 2002:a05:600c:4f42:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48d1426a438mr3174505e9.13.1777911456922;
        Mon, 04 May 2026 09:17:36 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace33.dip0.t-ipconnect.de. [91.42.206.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fed8ea0sm143100235e9.5.2026.05.04.09.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 09:17:35 -0700 (PDT)
Message-ID: <aa485951-fcba-4e09-b01d-e586001e54e9@googlemail.com>
Date: Mon, 4 May 2026 18:17:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/215] 6.12.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260504135130.169210693@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2FDC4C142E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243872-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]

Am 04.05.2026 um 15:50 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.86 release.
> There are 215 patches in this series, all will be posted as a response
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

