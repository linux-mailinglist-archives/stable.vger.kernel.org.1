Return-Path: <stable+bounces-214371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBY5JL/Yg2mouwMAu9opvQ
	(envelope-from <stable+bounces-214371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 00:39:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E03DAED515
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 00:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1ECF300A8F9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 23:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51814A8B;
	Wed,  4 Feb 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PY+1Syue"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678EB665
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770248378; cv=none; b=kaYZPNX2prZdj9jLxb+FIPqvaRpLBo95nO6nsFrF2E67n9P4N14EzfpWuDEk6YPmJwuf8qQ2s+4OL4kV/k/9Q7lZ8gF5n1jgkhUAX5D/t75wrTGXQlo9iNT44cmG6I9V5oAtizVFnFK/xR3Zm0JDqoInU4l5IlQEyvyDF2i0iMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770248378; c=relaxed/simple;
	bh=8NwPCPG7I61+w0yefaU/qL3EzxyKUqb36ha1hjf1lMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpnCAKfx9hcpOJ/zA7qTKYZkBUNx2mQeHGXGjYnritQsO3oe47lvcKc3yS3JiBUjv0ugOlT+JEK0t9jxKs348KROJcFlOe1N8bwouvCH+y/GrEIdYRf1WptTJYpMkJKim7VJ2myvTaIoSrFtw7mOYj/2Me4Ti0zwDYK2GVPhrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PY+1Syue; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso3662735e9.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 15:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770248376; x=1770853176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssmrgUH8rK8nzJBIo2+8RdqGcLD9sPXKrHtgFJOyxOw=;
        b=PY+1SyueIa60QxfLJ2Kh6U1UgaWbdWLToufM1l5tmzLGDPMIb5KX+1Yn/Uy0F0mzCf
         HLQkqH0I9OMWtvW1B6TDVzPlWEEaKR2yEyKoqRSPXh3DQNXTTBJJMotKCLGUf5zxUhcV
         5cANpSS1Q/lgV5kZxJfVogVvg3WdyV/f2j48z/QPEw43sgLPb3GXGfXEOk/hoBACFGdw
         LadlwNrk4gJBGxog7Ny/HHw3cmLEua7QKad5HPejFmEzwHp3vVYpRzwF8DEZBnPd5Ojg
         cG30vbJOzPOmKP0zjH/1znSNP7lpgVb6Exod5pE9Kz6gfKv2NAufu05/Sw80mSzzqw2u
         Z4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770248376; x=1770853176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssmrgUH8rK8nzJBIo2+8RdqGcLD9sPXKrHtgFJOyxOw=;
        b=MJXS/tmKlOKo1ThR4u3qK5mgNyTjjHhK32ErzvaNzXj3QZi8Lu3Y+F3MxRKJLuyr51
         sGVK9B12C2xNHHX6rPUpUlPDKyAf3A2YCnEzKyVoBnuoFQpjLNjOVrPdoxc51LhdppBb
         3AkXcyLuSfd1hLM4IDQO3Gn9vYmonwh4GQlmVxlz9ySg0ZT/HQnumQpPmlgxwiCKXsfF
         bYndSZhopt2plcN7M1cflstqp4pQxmsPCSTpabV/kXzqOOVwOVbTk/qDben6pjKVZRXP
         HzhEGwbZmVQ2lLLvFxZHgJlLF3jvteHrVhM+W0DeGT6eCjVbOf3DwfPB4omReKIlO14a
         EANQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaR0wyKKOPDSdUQf/7p6+FisiUQUDBVnG+0umbVSYvQ12Ht+HIDoKgZVxm/EodCsUZphA0pE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLhTSYC9EJ88I7jk8pFMgVNlN3MucJE+f52wIUdkPKgUQV2uV
	pNdOKHQwmfDBDa2AFiWgEdR1rJ34dyIHs++ALi/giSAnCDFEY0D4UCo=
X-Gm-Gg: AZuq6aJ3OD0tke0f35b+ou6FfWHeTJsZM0ki5uymT8B2Y387/2iQHeHpgHltWcK+8JK
	bu5pRL1mww5uF8wJiOSkDJ/8r10nfNfQGIqG1yvbChxDMcXLb5oBzvAsR4GXV61Nef2vu+wpcei
	PrAiho1F6vPw1NETPQHPqkUq7R5o/IU72NKwK2DnqklnHBAs8REaOerIgFZYAl/oekVP+6PraMo
	vMWMTR9iTk+2zLf8WY9UGgv+58hU5KH9py/Nv1XxfifUe8ilBRkMR/Dwk35S3MTn5l5vgZESY4E
	881uyVFUTSFlwyyE+433YKftuAYICR29EHXR/C+9UGJyFGr0WF/ybqrcOGVBU1UUOQ+GhRPrPYg
	shfSvjh5nD306SqD/+RXthHCafeSk92sdgmXHZN9wzXEliAm0otcxWca2GvjTEw7LO5kCMsCDzf
	J9pR5cg0UoQ7kmpY42lB31h1bGsniz6BCDhHG1uCn2wYlSZPfcYT6CrsSz6oYquA==
X-Received: by 2002:a05:600c:2eca:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-483178ebb2emr8492375e9.6.1770248376463;
        Wed, 04 Feb 2026 15:39:36 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4d5e.dip0.t-ipconnect.de. [91.43.77.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2c856sm18561895e9.4.2026.02.04.15.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 15:39:36 -0800 (PST)
Message-ID: <e360d5d0-5e48-4bf5-add9-d5f62d03cdcf@googlemail.com>
Date: Thu, 5 Feb 2026 00:39:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/87] 6.12.69-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260204143846.906385641@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214371-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailvelope.com:url,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: E03DAED515
X-Rspamd-Action: no action

Am 04.02.2026 um 15:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.69 release.
> There are 87 patches in this series, all will be posted as a response
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

