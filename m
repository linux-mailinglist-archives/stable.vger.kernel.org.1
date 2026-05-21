Return-Path: <stable+bounces-253490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP1FIRLQDmrOCQYAu9opvQ
	(envelope-from <stable+bounces-253490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:27:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A00B5A251B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35418313ED55
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F2370D6E;
	Thu, 21 May 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ODGopv+a"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AF346FA7
	for <stable@vger.kernel.org>; Thu, 21 May 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355294; cv=none; b=T++lxK9BaIOtSEyVBAzsYeEgPb3yuRptAw0o8HnGe5/M/t272Z5Ri6a2LCc9AAkksokmEAayQk2MfaHX3jqVZ9rJi1gQSbxyT3iDBJpvc95QK6J6WBeZupzyOrjssJHfWKHx8N7ZzsgYSznIczNqqB8DcKRPknqTusgp3KyFbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355294; c=relaxed/simple;
	bh=W9nyORp4vE9BwGtWonfSAIZovwxPtkmwuWrv6faLqQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSXwjCcA+81VnVAx0seTNSsxe2xET/Al42+A8ulU5Uuz8G7NSd8Lf8rt1a5bjl4mzfzH9ZfMsbvEn3IzhMYjteMITyJUOJ7zdvTZjzjf8YHhNgyU5ueTj52YJETdgJOamSykbV8wxtueFrv9gN431DQLnKYaVHCoyO2WPM+Mk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ODGopv+a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso64368515e9.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779355291; x=1779960091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoB4vFn7tcBnU/nRMTtmwAyXHRKBcO0RDfcoUt7dviI=;
        b=ODGopv+aExnVyCytaMjFKdckYyRwwuZrfx81XgnEFcAo3J9rmtxgfwfxei9jLkkNH9
         AIcnEYUK9aw+mi6wIy/0GkdFnk9PyIHN0q8DH26R3l/DQsri7kUN5EaYZaRDiU35NhdK
         WVju2cLcZzVptoM6JlvlF2H7mqDahZsmDnaNs1VyMAXhUIBjXpMh391wdBCDHm+w9VtP
         n36N5UDEQ8uZjEUlvWGPTLhHfj0Y3rg5FaLuesn64wFd37WaHxfFeIL9V7FhYpLiKRiG
         Jg1XNVJdVEx5cKZhUH5dVXBRi8vykzQXWSbAj3A4cgwUOQslz0T/8ulEiVgFiM5V/ndw
         hdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355291; x=1779960091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoB4vFn7tcBnU/nRMTtmwAyXHRKBcO0RDfcoUt7dviI=;
        b=XdZ0sc2Bb1PBmfZbU0EOZQ5PP1CthMW+uC1y+0RCSXMEezZcUN+h6gnLjExX97Chxm
         ILzYHkSDuUVxJjynrlMVyQ0fsPoSJYQfdyz2G5ZzChhWDMN+y9KjcH12gikzr++jvWZ8
         bZ8o/hWbfN1W2dUaU9B8OL5sCVw7KUvT9HPna6UmE3KfbQmbxv1UHCUIIDB73oXXIgtW
         uyeu//9IUP6xpe6w3oMf2uNFQi1aRlAg2jXzK3ZwFBZJSjEyitDqLj8vWHY0mTRR1tvT
         m7DmVtSbzoe7eWdBqt7MQvnBtwtJTFKrE9N1vvRTQeb0KsOQaBa0URELSHSyhMSNZjn/
         uv+w==
X-Forwarded-Encrypted: i=1; AFNElJ/UZZlXBzhzei5s7C8UyCD2SavpWpPr0Uu+B9q+Cc8oPqgLZFCUL5xeBvH5q6oEeNGu+ghq1JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4ypnJXrdjbiWGQ3mbcNGxdTdUykJlURr9odUjcmvGzn9bL/8
	26oU7/qyCQCOuX1TPNwvE7fSQftDGkMI+boSwLWYCQqNHXB7EsyMR58=
X-Gm-Gg: Acq92OEu3IZqeFOeth9H1aBUwdCoQ6LCdsy1gCNSjY4p4qecNKq/usEqbVYCOd4vxYO
	DcNdQ9No0G+EnnG28k2aEDJCPC0fYEZ595dEpn6IsBxWcXkD9h2YE9Nz9rlT0CEKsb9r6VjmmvB
	mxYbrHLJFsgDPI+wzrzV1tvryo+I0VWjJT8YLLOjOa61pLW5kto0FL4DVN9wilsxvbFg/ly4Ki8
	DEYSdrPEnaWavj6wb9E2bNERMJsTVEnaDQFF6X217bs89MlY6KtvcXTip5JQspaZLjfdb8Qv+TJ
	OTlE/51IZwYCvJ6kpLpGiRVCwdnI9it2ePIePuy2pLKo5gkqzsjRM24403xIBBTm27Vv5rl0Hpf
	Y7jgGsQhj9h5AxW3uihPB3+v5S1wJiXA6nORYTi451O6xYy1DtqZ5bcnNCW988LkGiQM76hTrPj
	6bAWWKNTqION2kjbpHL9GRBiEbEsPK7Y0T6KLEjvntngA9m4j8dMWtPVs8sBjN3vz53vT140o0N
	vKabjWKh6nGXg==
X-Received: by 2002:a05:600c:1f8d:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-49036041cbdmr27515765e9.9.1779355291085;
        Thu, 21 May 2026 02:21:31 -0700 (PDT)
Received: from [192.168.1.3] (p5b05786a.dip0.t-ipconnect.de. [91.5.120.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035adf173sm16543415e9.0.2026.05.21.02.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:21:30 -0700 (PDT)
Message-ID: <b16b4836-287b-47bf-a22b-8f269ecd5ee0@googlemail.com>
Date: Thu, 21 May 2026 11:21:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 0000/1146] 7.0.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260520162148.390695140@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-253490-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 2A00B5A251B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 20.05.2026 um 18:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.10 release.
> There are 1146 patches in this series, all will be posted as a response
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

