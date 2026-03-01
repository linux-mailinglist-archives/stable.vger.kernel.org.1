Return-Path: <stable+bounces-221234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK/RMAqNo2ndGgUAu9opvQ
	(envelope-from <stable+bounces-221234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 01:49:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4C1C9DC2
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 01:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0D90302C911
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898019F12D;
	Sun,  1 Mar 2026 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iJD59LtZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6F42AB7
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772326147; cv=none; b=BgDoYW4xxtvJnpyvuVkg+vvQ/jA15KLowEfenuwhIjewf/CcE95I/KHlLqlixSUp0cuYKDr6qv9uuf2mtAXMw14+0+FUPlZTUo8l4z6VkovUu86kekYnP0CZ2GGRzeli4oBiFiMmYv3BKtfX6d5iSoSWrMA2AnqTfTAbDsQ50QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772326147; c=relaxed/simple;
	bh=gGF+Y3A9tvAcyE8F9j+7Z3qPg7Yl0etmcQm8MW7MKbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0reYrY/Ux8iGY+bhJLdsl7axndovtkJWthAJhwHz/EKUQvl3Z2fw5u5OJuVpWMS17OCxHx3o7JA/g1vjKSh1+J1q1InIOjelJssLdz3B30Lp0lVBiDH40/r1NYkbNKSbpYyR+uhhCYsbUMkBFNZd/Jlux46WsWZ2aOVSHCl/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iJD59LtZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso26764235e9.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 16:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772326144; x=1772930944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbH+hGxj1Ii6TXn5+5SaVTYOgraNE2wqGnKW4iCopuo=;
        b=iJD59LtZefwD4IUatzGt0H0MDBzi0P5tNHVmO4Buo/RdFTRZzXnJsnCVnCzeYRjlEB
         yoh1x6ZrW7x4Hkh3WTfHn95DcgHN2p8CsfohShtxP5OrAqyB62tUnfmvgr18SOJ+F2AB
         /HlMu7DoP4XZPbRVIOjYBoYd6gfrZrN9RSN2Pi8SkwMynZ9q8tluBlS46Ro6HFG6JDOS
         UcDnZHb1dzKV+GeVRHEZmi9wh2/qw6xwBRPOzIVuuiNUQebLVijzwKG8MSPtboFOMUyd
         1raBCza/MRYTdVIJsLTsUndSscOOUhsTrx5yu1jZDrJWjXyKCPPTCGi53OXpeiVe6PhM
         53wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772326144; x=1772930944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbH+hGxj1Ii6TXn5+5SaVTYOgraNE2wqGnKW4iCopuo=;
        b=tAdx1EjibcUWdpTIkfRU7h4s+3ok52NSRYIdud7O4hjN1bTmC3ngV4hGdmePSiMMzf
         RhB89PR21iaYJg3Om3qWQ8uDMoy9tg07bC00xftvUsUfou2TJJNv28DWWouW2PDSvQVt
         uSF+KJJlA/Ag5Da8pZo+uEwWzNpyoIUdvwZLFOznxJ89gxJJ0KI/G2sMgwAwXNLb4v+n
         B6ail9TfZzx2cMQXzIUAefMeL4JpynhL5WEOTKN+sWR3+PFINnLmU6fDS/JHeV+5o+yF
         U+JGFrnjTwCq1cjGc9YMGOxAIWidUnSCvk++weU6TJXPBP9uDqXfWyUk38oavA7quq3l
         xneg==
X-Forwarded-Encrypted: i=1; AJvYcCUC9mWzIVvAORW81hFPGNfcMPamC0ZWfl3uEYv8dmHL9lAxxXSvTXOdoqJux/ULQmTjwhYE5P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84YHsc1pOwztr3di8EVUNMVV7OckPa7bG59uB0Lx391tHFxdI
	7xVvx78O1dSCH62DAXh9X1931DjrSXOgzaJfLRCg4Cgw1oKJw1Cyy9g=
X-Gm-Gg: ATEYQzxEim1FjMwfbjhmb0aPcnBCAuLtQ1Eg8ZCbwHClHWwE7e5juR/v0N66qBRdRwM
	wZZaBrdqSTZBQLVI1uXpFWcnEftrGV78hmU05auMut32WyWbP+RDPi8CuIxy1FFOiZZOweRWhSm
	XjayrHcSp16+EMSAdtIxQTtz1oND88GM37EafMV6yiXKrXdcmjXTYyO/tcdgAe6CW9ykmF3jM4R
	/ghc86tVZSimNArRNwJWXeAwx1F9UrIiZIayjzqG00Yfyv57FaBmK9Ol9GzpqfMV/4MGz3FbyIF
	VX2TgQkKa0tFZ4bHy8R1OoVaNUslw5ZvLfDK4QS5XlD48OKc9Aya8eK52Jm5X5+0s4eqLh19dyO
	MLu3sJnJyLyJh1U3eX/841OKGu/EtcGql3FELla9KxRHNLntwWOb8in3nrdORRVa7PvWIQBYX64
	tFzO5e4zQmTAlxr7Yy2EDo6paMchw5tBHO5Ftuh18tkUPY7+qPBcEjplihLpaML+hdecUa+6Ldc
	6Qc
X-Received: by 2002:a05:600c:1f06:b0:483:7783:5382 with SMTP id 5b1f17b1804b1-483c9bf49afmr117867585e9.27.1772326144342;
        Sat, 28 Feb 2026 16:49:04 -0800 (PST)
Received: from [192.168.1.3] (p5b2acadf.dip0.t-ipconnect.de. [91.42.202.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f8e5sm19400285f8f.4.2026.02.28.16.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 16:49:03 -0800 (PST)
Message-ID: <e1b6cc96-5b8a-4256-8deb-6cfcde4e10c3@googlemail.com>
Date: Sun, 1 Mar 2026 01:49:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/283] 6.6.128-rc1 review
Content-Language: de-DE
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228180659.1583364-1-sashal@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260228180659.1583364-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-221234-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: BFB4C1C9DC2
X-Rspamd-Action: no action

Am 28.02.2026 um 19:06 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.6.128 release.
> There are 283 patches in this series, all will be posted as a response
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

