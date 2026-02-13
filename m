Return-Path: <stable+bounces-216280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAVaIkxbj2lxQgEAu9opvQ
	(envelope-from <stable+bounces-216280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:11:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA1138878
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62F463012279
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E5A364EA1;
	Fri, 13 Feb 2026 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SsKPfyoF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DA363C6F
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002686; cv=none; b=OYyWk8l5KqWJmmFk2d+t72ZxZpXDXEyAx8abHh901riUFPk9JIIdBQNoF5MtmkqoAOk5CeexBrO9cz8vvE2KXfMAfi6ruHp+BB2HJuYiRvmYtDKndkmq5p6Vr0Ssyf5lVOL6OjPTTmLUkvybOmLFV+03RnblTFsskLLNLAnvWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002686; c=relaxed/simple;
	bh=gl4PEukzUchS9MtHb7r8yq3pzUDHwXAMVaf8FCswoYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuaRPCO8LKVCfCWcSuRfxjOsjsJzyZBE7XqS7ZocmxJQCfCm4uEvccciPqScptMs5+mbLI78InCKoamcwlPEUtxTZF2TfK+nEhTJCd7PHm9AkSG8B5KqlGkQOMKbpZNowFwSpl+7mGp9rfEA/mCrPcYXo4cvPprBoydl+hb2Oxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SsKPfyoF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362197d174so799471f8f.3
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771002683; x=1771607483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IELCj+juPsgvOxizJdp9L9Ol4icmAH75LT40uFXWvW8=;
        b=SsKPfyoFlcqU0jCubHGJJmNeIqYkuky0xTGqbgRCIoYCKnNTKy1Uv0bnwcUmFtPrdC
         b8Zp8w9BNjkh9otW3k9OBpSF9Vyyxa56gi2+U3SjqfOqxnLb85rJc6LvcTO40uEOfPvG
         t0hkHt0S03m2qbRE6uLL0vwQjPFb8Ffyhl+NKx4gSFuu/KA4RHpd0ApKgVyNAvcmQPbw
         8qPKvxHJZKKMl5DNRHQUFiUx9NpHFOCfwXWUMQqFJ37oHxByKsrV9Rne+LYG2sX1uJeo
         PAwglD8tMnnJ6Mi4uWvmB7/Zd+CuiaRY+Om2we+xon8N4EM47OjMCCjB748BnOj0mft6
         WWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771002683; x=1771607483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IELCj+juPsgvOxizJdp9L9Ol4icmAH75LT40uFXWvW8=;
        b=TKcPzjvPembsWLQIrkpwLDWwErWOFY98+nEkFvPbrT06qsu+7vE+1S+WFQYiJhhVW+
         Jrd4sOmuUshoy2VBKWYNfMH6ZBi1ib9/WRx3xMGNrRxoHCenU7cZsg8qL5+ssgOtK+1x
         osXpH6/8CGSeJ1EZlPhxME8c8Fdd78T1gPVI6874fIJKSLUXC3TdAXdyudRw4zMyWxEs
         yB0YJvShQv0Gh+jawkUkTzdG5MrUx+c9F4e4gXCQRQbiXdcVZOzOroelhnsoxQKQY2MR
         vi2UzJkiVjjO9tntZoUUwPNoljm+RfmUAhQjF9L8Z8jCUyV3nPCGwWV5Q/hDZVWEbYoC
         PbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhvsPwXMqp+Uyq0NXDQxflFTcdhW+AbFsjjQfll4widAK5IYiRV0FvNhwm6ir0oh6NyzSGl1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybm2MXDDiSaQ2P8mwy62pDKDuI3ggJLQX59v1M55zMIMilU/o7
	6B8MVRbltHS/jfql4EpJhMlRKUnK3V0NM1EMagEffvJO1z6edkcnLu+cuVtA
X-Gm-Gg: AZuq6aKpMtSLqY205WKJ2HuYZ37v1zbc8nPqMtVvWaS7CXAfXU7H10lZNui58C8rJQB
	T8m10LiZQ1DR7fUBduSX7LEUwjuYWwYy0Pqy8jKdof4fjN/N779Bs+o/z028Lks6kuPDvgKe8Da
	dZ/QKhmABMUAgrroJdZbr4HSuM+AYl2wKLXuxNMHvjigpl/wJlUlNjC4yFEd1A12ycJTOcoyMMo
	WoAHeq1FHauEX8THAICXz6zOC+OVtiK2ANNvSX3bMGH+YcMXHKFS+06qCDGWGqF9iCxONSlvrih
	ia5uutTBcv32BjJ8YOAVwJzVAm61BAzdWvQxC+w9SRz17exGBk9SY2xe9uRSzsV+UZ2hwfMLJaF
	Fvdhf1/k8lKutdZ9jhzUVhijD38jbt4SSRZ6ZWT0EPxnQGtG3iDyxZiMqVPaWPgZNN6mZBECMAX
	nvelGtvphfFBaHS6WcVGybighAWQcW9x/qVuUkH/VaMGNe3GvoSsrELAtu9CZjb1UQj2MerkWiE
	UPT
X-Received: by 2002:a05:6000:24c4:b0:435:94dc:8c78 with SMTP id ffacd0b85a97d-4379790e785mr5171308f8f.40.1771002683292;
        Fri, 13 Feb 2026 09:11:23 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4a9.dip0.t-ipconnect.de. [91.42.196.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac87sm7738189f8f.3.2026.02.13.09.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 09:11:23 -0800 (PST)
Message-ID: <d568f5d5-6e4f-456f-8828-55e24f359169@googlemail.com>
Date: Fri, 13 Feb 2026 18:11:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 00/49] 6.18.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260213134708.885500854@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216280-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 2BEA1138878
X-Rspamd-Action: no action

Am 13.02.2026 um 14:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.11 release.
> There are 49 patches in this series, all will be posted as a response
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

