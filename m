Return-Path: <stable+bounces-221231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zk0sK9iFo2m6FwUAu9opvQ
	(envelope-from <stable+bounces-221231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 01:18:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2501C9CDD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 01:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52F673019C88
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 00:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46B7080E;
	Sun,  1 Mar 2026 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qrl7dLaZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385741C71
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772324306; cv=none; b=n82+DVrXnePQj0qSENA7NfhJ1nserXWyLQxGw3fr9CwqIg2VlAuGXuXzLdlF1ohXt5Olh0zYtpuR67jLfMn6iuqq/QSEHjUy1fYmoi032R4UU61sYW8G+Ej64n19fIgzeT66i7Oi/+XvYE4p6x+QmQxXOtJoVMcpjjhdpYKpLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772324306; c=relaxed/simple;
	bh=Tej4BScblLRTyLzWX7iaHyREqAFL/TqNjNa0l+wUk1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srTaFk7mqlT1T5+8x/7bSL9U7TEM84h4X41/IsHuRpOPJZ2+4gh/ma4kl/7niPH9G0F6Y3ZLIT0UPeAkYqalC39y212KMqUvowxRo7Ypw83ZWLqPNFOBjvMJhREt0G/sptGxHHBCNbmILG8ii5fUwL5pIC3B6E+09e/JN+k6Ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Qrl7dLaZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371bb515eso48191765e9.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 16:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772324304; x=1772929104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHE2ewhG8k54UEMPAi52HxzyK7PCP25Pin0r4ScsA5I=;
        b=Qrl7dLaZe20BJnh3Z93Wa09jKY2/4HVsxXuYKekBhyt5DH3/OHGjWszfbGa3Vxupmo
         WVDeTAiKdaw5MujDIutPvqcfNqLQNw/JTIdTJ2v6uizw+Q52z8FcanoyH2bzGEugJfzI
         Rpxduw459gNZ5HOddH1q1hxOPVuQbqsBrpACpive8gg7EMKUpnk9YcYE631ogUV+UrnN
         wXghhjWrtd/r+aW9onH55yJikhoKD9ii/PmBJhUjY26hBmel/j3MMuu9W6+a1n4NGMZL
         ELqcEEUWH6E6RtUKNoGAA66FJxGUvRdmR1R4FOOFETte1iObgJuFR8DAD2yXlKW8T9hn
         q0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772324304; x=1772929104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHE2ewhG8k54UEMPAi52HxzyK7PCP25Pin0r4ScsA5I=;
        b=nziXB4gUxiaIaFTBJGxbtE1xcalywtSNX7BVk/GY90nkfP6pceSK2MGmfH8Dt0pmCl
         AK9R0kcKt10LYgIQDRhJDiXTKYc2fAHp6Z0lpJb8FLPayZ0sE4DtCvDqCPIvnyMPJwgN
         aD7bir9vS2fC2IIYpjIYQgReoNfdTeFvwQhFaDoEpaQPcMfzljnV8k7gqRbbedcbfSK8
         qTQSaGVxaWRbYpx6U2ICEjMbkhNG1yv0jmiZaTW/vUr92yQ78iN+prYJutySNl1BRxrf
         IJGP7Jh1q5SHFZrg/99jkrCLf86xe1eBZBhim3w7rhmCM5CDK4dkBFzn73wnriV/j+MZ
         TiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyLDqjBrI1Nqg8aptXc9T1MV7mWa+s/6myERqx5JfMar8Rif8ZnL9gXqvuSkwRdxSVL3B5ehY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2ItSK6ONLLd2BhLREFxY/EeE8f8gr570eRwoFM6rcHaKfLIS
	/e7VEGXskvDttJE90bHbD9npeLPnyKB+6JIr2c8rg+O7tIDoal+0924=
X-Gm-Gg: ATEYQzwmnQ4mcOErkh6VYZK80hVF7L9luLfCwhY6ek8hqreR3jWbgOZajQPzU9az8Ln
	Lj4+M837+I+ls9yzcDU5GnpzpHVCrMmVwV7X/TWRV+K0VfzG6TJWu5+uUGYZFzPKAs2nY5vyGht
	X7yfCT3hg43fBDE6MeFLeb+Ey/nwOs4moa3EsG07q4U4vN9zl24lBCmPRMolcvo8ZJZwvurIBiG
	XTGaCUAbw1SUcgOllBP+duDv815TkDFgQ6dEoehfeuovTbtm/GDH/kQwyyZqPV77uKXbqeiA7tq
	W/ia0vnRlW/BOzFpWRTqdZVuf2SY9yZKJX22DT2ZQoqb5mhU2bWIceHK14iCymzcR6czSybmXsZ
	bWvw5wGOGSmpie16LDsCtyjv7H0HWHKkm6h0VmqAHwgFQjzyFRSDR9JFTEtHtY0ZWZpXeO1kdmi
	lmAv6Aw77e3ndH2WG0r4q9SYWD8LZGl6IljBg27CzaG+nKEPtuUCr0jdb2eEcQNtmNmhkjiAikc
	hhcsNLHY7qE8O8=
X-Received: by 2002:a05:600c:46c4:b0:483:8e43:6dce with SMTP id 5b1f17b1804b1-483c9c2143emr122483575e9.29.1772324303505;
        Sat, 28 Feb 2026 16:18:23 -0800 (PST)
Received: from [192.168.1.3] (p5b2acadf.dip0.t-ipconnect.de. [91.42.202.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm165085355e9.5.2026.02.28.16.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 16:18:22 -0800 (PST)
Message-ID: <f78a20c5-11b6-4f33-b97c-8ecd0fc8e689@googlemail.com>
Date: Sun, 1 Mar 2026 01:18:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/232] 6.1.165-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228181119.1592516-1-sashal@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260228181119.1592516-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221231-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E2501C9CDD
X-Rspamd-Action: no action

Am 28.02.2026 um 19:11 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.1.165 release.
> There are 232 patches in this series, all will be posted as a response
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

