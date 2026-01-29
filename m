Return-Path: <stable+bounces-212736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CR1BHgDe2kyAgIAu9opvQ
	(envelope-from <stable+bounces-212736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:51:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C053AC556
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A64A83005318
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454D3793B2;
	Thu, 29 Jan 2026 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ijEJx/BV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52393783D4
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669491; cv=none; b=VshB+1Ozd6Gd93zeqg3KttIVZnZGfthOMQSg6fnJLncGbgY1BD+1oMf2Gci3C6aH82p3xjK+TXeihsf9PC1XCTZG+bMBrWhNMcQz03K/ugzw6MXU0eU7S3R3uFfckuum9zzaGifwQLbfJy6BVMHE8tXexOlJWAob9kHAOXEvPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669491; c=relaxed/simple;
	bh=GA7NO13XqJln2AHPXGt8+LGXh56hs2XzTsmQUiyTfp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojV79i8RwxQzIgpFf9h7E6ngryhkJGF8vtKlvWVSY37VtShYoTd+tKtsQEuk8LURRJLXnsNaxCmEqs2TaD6pmr2Ft7bSiW6h/rG9QrOU51d3NC33+eWsS9QbJ9kNdPKgQw5d1QY+20bXMk59xi5QZcycib01qmVuejn3ONIOLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ijEJx/BV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso3262995e9.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769669488; x=1770274288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj6177TwkscO8D9ati6ziuLwQ9fsmOed53ZhEji1Ppg=;
        b=ijEJx/BV+bWDZ8XgjwILOdGrTlX4ESSbpG2j7f3vQG0m7vP3rUQwPRxfuFC/3wJoKq
         UC4LP5zL1o76MG/Uu3AO6oUXIdULfOt3Ad0nLxNVR2rAybOjpuXInVknL/akwaJokuXh
         tLBhJlNyHHk8M9tZ0gG8LfLQCpWzEkb/vNBLBOV0HUxyGjkOygdeeDANk6CCNrlbI/J1
         PrXVKlPEnKFshncs3fRKILsPtAUP2+c1et9Aio0zoI4NK0V/tO5VXX3gxVks1xYI4h5/
         Jm/nVs+9pmORljD6ePT34/8whrkekXnGLlQpBpsm752mbyo7nvv8e68XIMNzSE98PkS+
         rJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769669488; x=1770274288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj6177TwkscO8D9ati6ziuLwQ9fsmOed53ZhEji1Ppg=;
        b=h+n/i/dmG8zTgzOcsIPJrSHx0HY6nz6TgfnD0wJBtgHtXUdBD5BspZEfm3qhs1o7VJ
         8zhPKfaW+jus+Eg84VftrdS0SCX1TBK941tV+zfD6vV/YSYNr8rNSfe9vp9BzAS3HESS
         EJmaV5tPq9igJ/5+do478h/Oys5rnWqsEkuROZzpfhk7GnQOXByP2zhHFU5hL07DDFb9
         vA3bamgktyiTdzg9Vj8vUic3pKOY43Ca/Qu38YCodZVBZwJbEuE1Witasp47YRc6utqI
         LDc8a6/uJkS5U9LMMBli1CFp5ByU3LwqCMnxzLTt6PiBYmtCoA1ZLnMI6c2e9taUlqS4
         qv2A==
X-Forwarded-Encrypted: i=1; AJvYcCVecMdvDufIk4hpBq6oHdd0DpcSQzN+3F/gZ1aJGyNVro3LSTJBSoZzXR36kFL8pq/qOcRIRSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTLu/YFo6PATAaIMnQxW1SCTe0oLTt1r36hR1okV9lXnYxX/+2
	47JBOfshl8GtK6elCmvhaEnrUa6rQwP9fZbiEeeekWhzUGYE7Vha2q8=
X-Gm-Gg: AZuq6aKw7j3wz9wlH+O0n3MGdnHflELKIeG56Af5bbSMg41QYDvVAN/H36VSQ2StshL
	kr1gexUSLcvKo7TtOUJg1A0GEwzsyMltynkoF3tA97Ad8NmXjMYhqRvqWmeiMUOdx5RyZeajXA5
	vx1TW1UJV1ysr7QxTCUivsWC04DK0Jlc3TDnHnf8y3+Li9LzECEV3guXYL0h/uW9Ham8lB6jQk5
	QgAsEiZdx7ONAVN4gTOKq7SyDppXxLf4quWevQsUkVN7Bkt4uOm5WeUEZpeV0alnhuE7vv+FP3X
	WMQiad9H8EMHv00+QhF+SpIT19Tawn7O/wMDr/wCIbAvHufnFS+eZGnKB7K52UZ72mraPFP0bD2
	d8rPlNa/EKXiqfeJifB7NgmOpsC4axokUInhfwJ43zkLGzlmTHIi6EQGwnFYRe2mwER6TRQ5Ez8
	aOMGEeSVvtomEe2E82vcN58+5j9JRlBZIOQxIphwdmtCNBmBrg+sll9sykXHIPzg==
X-Received: by 2002:a05:6000:2483:b0:435:95ce:84cd with SMTP id ffacd0b85a97d-435dd1cc6e5mr11967628f8f.54.1769669487951;
        Wed, 28 Jan 2026 22:51:27 -0800 (PST)
Received: from [192.168.1.3] (p5b057921.dip0.t-ipconnect.de. [91.5.121.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132303fsm11932380f8f.36.2026.01.28.22.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 22:51:27 -0800 (PST)
Message-ID: <7c5452e6-702a-4cb7-bc68-a6115ee57923@googlemail.com>
Date: Thu, 29 Jan 2026 07:51:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/169] 6.12.68-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260128145334.006287341@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
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
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212736-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C053AC556
X-Rspamd-Action: no action

Am 28.01.2026 um 16:21 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.68 release.
> There are 169 patches in this series, all will be posted as a response
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

