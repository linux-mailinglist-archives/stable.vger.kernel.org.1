Return-Path: <stable+bounces-219689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAj4ACFAn2laZgQAu9opvQ
	(envelope-from <stable+bounces-219689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:32:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7B19C502
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64A4C306C84C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011083DA7C6;
	Wed, 25 Feb 2026 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ahVX20XC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7E32ED872
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044082; cv=none; b=oGlS/wdaRMrwFKYkmOLIaUj8AUQzmkUHIQPt74VGeys+bge9DVgCvktf4JvQ99hYdUS3E10XjdOBhFpwKdWSPeyTjo4+Y4/lbE4wn/qcsn5IjvekKPCCW23rn3SS/nF/2Z/iXwyFlPWj356HLPEpKDj4Of0rHksM8n1VeO7Uk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044082; c=relaxed/simple;
	bh=9tVVzABrfYESXRiAqx4OP6+dcVZfUlVvgVSA0Y+C6cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oH+WOLVysM+AK+zZuL0YqsmNuIuLD0ZXdV2OJ52iAWBHpiyqVsvdL9Sa3jw5zBFm0zLHjTw+Of1K+4J8rIA2QXwtFxbFgm4BBxin8LjHcw0peF7UKPzgAzNuMSDGX7GeLLbvc7Y5mWa0h1yWEYPZ3sg8TI4xGptuJiiITSEyOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ahVX20XC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48370174e18so417295e9.2
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772044080; x=1772648880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hd5W4hkBAFqLmz9UiLeJS3I2LCVeFB09bmE9bveO4Gk=;
        b=ahVX20XCUBwC1Tn9VIWyHX2zJbrbwEHWCEmjxmCH8lM3sSUCfaRxXTYAljEWLX55On
         V1oaYOzh3y662DAqmoBJLhZXTd6xnRbFTCeE5+EODV0b+lgGuMiC3yO284AFS36vYqEX
         a4I0Ij+e5DKn4+5jjOpbY5GxHn+HSzPQfLh0JWqXOdtRFi386pU5v5EeC3jYWQGWgezR
         LwNM4Cki0T2Zq6M1+GZ564JU3vs6apBQlDdxn2dN1jtCV3uDYdTJaSd8bFSjkctSaby6
         SGLZ19tIJfoWfJRgshfmhTnEDLiTB64PmJwE7je7Zf0zaNbkjn78n5xNEIeM0CBk3LFV
         qrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044080; x=1772648880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hd5W4hkBAFqLmz9UiLeJS3I2LCVeFB09bmE9bveO4Gk=;
        b=dV/CuxPpu3Q1HarJ7dl5/mQx9+0xAltlOeGBhwK3nic8QhEB6394UW0kFy9oy9dwpO
         1/Rlp7HLnw+RtJdODd0FJs4hYlHlqjoDj9qgh3CCCtNWs7dk0FaIw63ZKvReGZrLt5cq
         ldDiOef2R/ALtRAU2Qjp3HPIvUFIytJ1sPecx2t83pCKJyaca6PS2FQl2zx2qVvLsqcn
         TpqzH8A85G6tnpElDt+ro61XsZC+cn4p1LIFV5a3TUz4KT7Sw4SdfEaxcYan2k2Xxd8R
         fHbIX5WnHc1CFSdUDSQdCvcxH8+z/ilhlljFjnJq14DdUlccb4TOYTD+M9WjcdoqEyul
         DpKg==
X-Forwarded-Encrypted: i=1; AJvYcCWhhMGURg7bFmMZH9D8vhOfvnZsc0iDfHI9Qe72P+7HAD4PcFYONMdJELeGEPcJV5XsJflC7rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKRvIBaBVDZKap0bTgBEJbNt/MlM8q8bxH3M4stZR7qoI24G9
	A4/XvS72nM4Eke+0jOnzPC4MaDI7ZE0YgQns8pfIGnhX4BwhkacSW8g=
X-Gm-Gg: ATEYQzwim0pq+jxnga70SH4230tIOpUjUA2vYq40AUzFh5rUu0SOLkbKqeaFio5Qa3B
	ryjQbQQkAa8IQjnvZMHNpZ9SIZgbYxctqNHiW4Rcx2Mm95X2huhPxucvgXKrrVau3qN6chGT6gJ
	zqtopkgu7YCEqqFFU1ahncAurk97MUwSK4c87ioAz9ZSbEzGNBUvOy7Wvr3gYD7obG+/ylgL1Bm
	6Ajwyy9RUeQ6oQTyjroIufgNREmvEbuOElqiKBVz5OMpHci+FTJ9FLgmoH2GfXSm5hz7QJbGbiv
	hnsTS7Zjs+toDhnoocZjZH2z8d3zgTfC9DyUYEfINljIQKfEpUNjqPfF52QHtOX01G6drQYAkzm
	N4cu1SAc8NWCaARPnqAJGuqxY+AudHVC/Birgj6ju0idtI3b7MMp/LTVDmPfEB8NufFX93Cgnxm
	c551GQJ1CL/U1xP+eIUBwDWCTjMWovVkbKlixL1wfFE5xlGuCTPbhTedl9JlDuwUHvqn6p8gfQ4
	B0=
X-Received: by 2002:a05:600c:83ce:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-483c21a9ab7mr25059665e9.31.1772044079551;
        Wed, 25 Feb 2026 10:27:59 -0800 (PST)
Received: from [192.168.1.3] (p5b2b47ea.dip0.t-ipconnect.de. [91.43.71.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f2f88sm87884625e9.2.2026.02.25.10.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 10:27:59 -0800 (PST)
Message-ID: <f3aaf329-6884-455a-9f52-16d98f0db4a9@googlemail.com>
Date: Wed, 25 Feb 2026 19:27:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260225155341.094945851@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260225155341.094945851@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-219689-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 45B7B19C502
X-Rspamd-Action: no action

Am 25.02.2026 um 16:54 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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

