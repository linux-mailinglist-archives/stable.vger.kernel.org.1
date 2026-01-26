Return-Path: <stable+bounces-211646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAcVFrGPd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:00:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89258A70A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8FD5301D31B
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473E323EAB0;
	Mon, 26 Jan 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kn5Hwcnb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097E1E9B3D
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443229; cv=none; b=jm5Xh7GT7kfjjUNI3HOUgfPoNtYk1HRLIqYVoxzH02vCtcN0g22stfo+f18GFgjUZwIkqKMAL5zBLzIYxNOx67GYVx+BCWFO0x4xNpjGUFuJQBDyeuMQNCl9WhWBQwN1mVn/szMYhm5gbe4+3mmJvDTQBLvX1SgaRYgPczpoKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443229; c=relaxed/simple;
	bh=y0xLU910YLgrYE1tqlzNmhLes89yGDIAX41Z+JYkq94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqPS39dje+gF0AEdQQt4/vpryucn1OBlZQftJTl4hVhWYe0lu5Y/2LEV66kWKzX/RQGtKHWcCfKqG1SeqzX+1db+lqgSYGe5Kz3GP3po7Z2SDw9SMeyH3GBStRYQgIFNaCvCyt++S3orfOQzbS+zAKwlvNS+fS95/st+zx3Hw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kn5Hwcnb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b884a84e622so742936566b.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 08:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769443226; x=1770048026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YnId+vgt8x4+Rf7Zffd5lJwpwT2its5PFuK3z+vPO4Y=;
        b=Kn5Hwcnb6nCorsnTjrzuLLEKdbmP5jWLH9b8lv8Zb+Wgb8EIiFzk+IQ/vBV4qUYbOc
         fEDPE1Weqju6KkNdcxavskxo+bpKXkcv8IIvBL3jX4VZvSYpD12+M+jw0r4UzUlXX6uK
         JEohl9qWyXglJwn3ujENsVj9enk0gz2wxq6L+bkQ6MpD7Vav/+rmGREMwAjBSHuZR2VW
         1k2vm3ZTfVOXPtg8JYgB++FFzwIz8j6349zLRcfIpXr6YZAHgKK7U1qZXhJjxjcriR/l
         eKugzsfoUOxlf+BN3Y18c3laP3VlzVMU0tmRXLCcCv5e/V6EcCxSnRlCH09nTGvfFkii
         sfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769443226; x=1770048026;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnId+vgt8x4+Rf7Zffd5lJwpwT2its5PFuK3z+vPO4Y=;
        b=l1pCaWLoPLeGutlc+DuICMiXwpzqpsoG8Z62Es7IjNxdPT+k1fxIYvSeOzTeobQDgV
         9YJn+ZO/adJj30UcFPzatGMZ2Z7XR7HQU3kw31cR+M/u7/amdBzJ34j4WDXN8MFeh4Vb
         Nx0YfnF6gC2bvvg5NGRt/2F1DPMR3EHuv1HsNmbJzPsmawOR0Lm+sYxBUQ+Jg8eRkpIM
         WPHOJkiE1ZvxDOgPL+pRfnuOa3RU6pYlSEndzuROGottn2p98bgcd+LFekXUbE0T/Kkx
         FEHCltq7LsQiAAtXGWKDpMLFD/ZkU3JdjRxJ/Sd7PvE+OqvUzSBpu7202u6kqDJ83GZ4
         NA6A==
X-Forwarded-Encrypted: i=1; AJvYcCVXenc6pM8dKHznD/Afd6ypTXejWFt8gzKMGxPjq/6kfJcTxevHMimy6w9ERdas2Q1wVM6ylV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2C9NVbm+WqqhRFzgKN4qLyM1yV/TW9tlReYNj5UkJkk7fUxen
	lUAISkfRRLZuCRpc76/vquPJ9Um9KGukLf4YHpbzqX1Plyl5hhMurmbb3Qq5UvKIO34=
X-Gm-Gg: AZuq6aJvoRJpoGTtiHZ2fPA6tRrCXKtheMPnUIEx7qrFDEw0BiPBR7IBJDspqBUX7sE
	17LaEMCaRYw71y3JKbZQupSEXugcsrpaHwCE5vhRTawbhjn+YuuC8zTXlycb6HKRrtiuxfaJHaB
	NP/x7Je9Zdr5Lop2NyoRuzFsLhSXwUnIlakjrMpS7IO8/kyTfBhwAyXpS7U/RrLHAAN62HdglQ/
	rO5Ciyf4z0nouy6X0ejWsMsIVAciySk5Zp0YkBZOd2L1RYeHatJNjwFrArClJjq3WCfjd2rIydW
	Q/QgIVqHzPYdxN3Xu5TNyufyTaYrWyc+PPeTdQcUyaLaXa2bC3Rb22/1ZolIKNPa6/99syRjkkQ
	z6PBVIqv1eL0h6zmMXDfiKA0Of0gp2dJsdKk49v/cYSjrix4pFUyvon5mSZqWifLgcTfvmMWKEP
	upN9Q0CEuQAwUzAJ1OSRdURI7toH6l3fcQ4EH/H9fA90axVC93wXJganqPB6bLG4k=
X-Received: by 2002:a17:906:f58e:b0:b87:6:3727 with SMTP id a640c23a62f3a-b8d2e709662mr388289066b.48.1769443225506;
        Mon, 26 Jan 2026 08:00:25 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b3dbc85sm656093166b.1.2026.01.26.08.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 08:00:24 -0800 (PST)
Message-ID: <1c9e86e9-0e66-4cce-9a3e-f53e36e155b5@linaro.org>
Date: Mon, 26 Jan 2026 16:00:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] media: i2c: ov02c10: Keep power on and use reset
 for power management
To: Saikiran B <bjsaikiran@gmail.com>, Bryan O'Donoghue <bod@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, rfoss@kernel.org, todor.too@gmail.com,
 vladimir.zapolskiy@linaro.org, sakari.ailus@linux.intel.com,
 mchehab@kernel.org, stable@vger.kernel.org
References: <20260125171745.484806-1-bjsaikiran@gmail.com>
 <ef6cf6c5-3b5d-45f2-af67-0567262a4561@linaro.org>
 <CAAFDt1spRkj7kySCa8P=jehQHbYVT2j+nxLira1vwYkiCJ7LDw@mail.gmail.com>
 <b699fcf5-5cb0-41eb-b9de-e5c6e98aefaa@linaro.org>
 <IlpLwcSSsQ89AZYFUkWtRcUkztg6PClgkVOyWG0StiDOUCE93t7KlF9q18JPi3GutJ1OQWj_2igjYq1OD8FLZg==@protonmail.internalid>
 <CAAFDt1tjiEXbuChcY73+NYxPW=rB83P4Bks1TPGsHTTqoSzOuw@mail.gmail.com>
 <ed1421d9-f094-4306-ae6d-e07b3a72f82b@kernel.org>
 <CAAFDt1ukAdXwADuFVoZrs6Ay2fB_sq6LMW5FCnsjqUL7V62mfg@mail.gmail.com>
 <eaf30b60-c0fb-4cf5-bc37-274faa187734@linaro.org>
 <CAAFDt1tgFf5MQcHm3s5DJEDHDtbTfj56_0-=fTz0ekDjSqY3CA@mail.gmail.com>
 <2084a247-053b-41c0-84ef-c56af640aa74@kernel.org>
 <I-1OPz69QKXF-LDqvufQARvv_3TIYaLyZIETdiGvSj_JSYhnJNeqiLERDUH2R0kclFyo6MqMRsaiZaS3RKmdZA==@protonmail.internalid>
 <CAAFDt1ufYyM4_xTy+AZTdXBB0cGNk+nFQHD5+5U7tUMQqZ+o=g@mail.gmail.com>
 <371b38d5-9322-4629-b378-ec62e0924fd4@kernel.org>
 <CAAFDt1u1PxgurdGigY+maPhssWgCrj6srqKwqF9d3oUFzv-yJg@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAAFDt1u1PxgurdGigY+maPhssWgCrj6srqKwqF9d3oUFzv-yJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linaro.org,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211646-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wikipedia.org:url]
X-Rspamd-Queue-Id: C89258A70A
X-Rspamd-Action: no action

On 26/01/2026 15:40, Saikiran B wrote:
> "Failing that we should try a more liberal power_on() Assert Reset ...
> Wait 10ms ... Enable ... Wait 20ms ... Clock ..."
> 
> I have implemented a strict power sequencing in v3 as you and Hans requested:
> 
> - Assert Reset (5ms)
> - Enable Regulators
> - Enable Clock
> - Wait 2ms
> - De-assert Reset
> - Wait 20ms (T2/Boot)

Yes understood, thank you. The ask is to extend the grace times a bit so 
we can be very sure.

power_on():

     Assert Reset (GPIO Low).
     Wait 10ms.
     Enable all regulators (RPMh votes).
     Wait 20ms (Allow PM8010 to ramp and stabilize).
     Start the Clock (MCLK).
     Wait 10ms.
     De-assert Reset (GPIO High).
     Wait 5ms.


> Regarding the root cause (LDO active discharge / pin states): I
> suspect you are right that active_discharge should be enabled by
> firmware but isn't, or the sleep state pinctrls are missing (causing
> back-feeding).

I would be surprised to find that active discharge hasn't been set on 
the relevant LDOs. It is possible but I would also expect then that 
Lenovo followed up because, this would an issue that would also affect 
Windows users then i.e. its up to the firmware to configure the LDOs.

  I will investigate the SPMI registers and sleep
> pinctrls separately as a follow-up, as that affects the platform
> stability beyond just this driver.

Yeah if its not chip power-on sequencing then we are probably feeding 
voltage from elsewhere unbeknownst.

> For this patch series (v3): I have implemented Runtime PM Autosuspend
> (1000ms). This effectively masks the issue for the user (rapid
> open/close works instantly because regulators stay on), while using
> standard kernel infrastructure instead of custom workarounds.
> 
> This approach:
> - Fixes the immediate "camera fails on reload" user bug.
> - Uses the rigorous power sequence you defined.
> - Aligns with other drivers (e.g. ov2680) using autosuspend for
> performance/stability.
> 
> I'm sending the v3 series in a bit with all these changes. I'll
> continue debugging the LDO configuration on the side.

Send away however, instead of working around an issue we don't 
understand, it would be preferable to root-cause it.

Please read:

Documentation/process/submitting-patches.rst

Documentation/process/submitting-patches.rst:Top-posting is strongly 
discouraged in Linux kernel development
Documentation/process/submitting-patches.rst:  A: 
http://en.wikipedia.org/wiki/Top_post
Documentation/process/submitting-patches.rst:  Q: Where do I find info 
about this thing called top-posting?
Documentation/process/submitting-patches.rst:  Q: Why is top-posting 
such a bad thing?
Documentation/process/submitting-patches.rst:  A: Top-posting.

---
bod

