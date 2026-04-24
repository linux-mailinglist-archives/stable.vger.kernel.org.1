Return-Path: <stable+bounces-241003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AUUJFea62nAPAAAu9opvQ
	(envelope-from <stable+bounces-241003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:29:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF23A4614E4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B64F300DE05
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C13CF68E;
	Fri, 24 Apr 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ciRuU0Yu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFF2F069D
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777048144; cv=none; b=Zr2z18AyQRg6VkrZ5h1aINL0GIw23RAaWDsvCHWr/1wRxeFourNiTyzb0i2iWwrXdlI82lv4VpN20BC/f8L5Qc/YrqtMCujbnn0WEf/2uBL62iB3g/B12tC8xq6LgPoExxha68JO3Jm60skL7ddFsb3AC8Ql+UzXeTIq/m1N13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777048144; c=relaxed/simple;
	bh=1nKL2oUmGdFElAVXOdfIRhy2LrbQY9k/pqlm6N4/zcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDCKPlo7bvZ5qInFMLtV3U9AMhyZeQbi6hSIyP5gco+JIUvyz7HHZqTP/pHqutCSjRQmI3RxhDmJEW+b4o9NPTlZMmM1/e/1Mjgw+h/zh4oRsZoPpZnBw3wEY+QYip/OjxQFN7GRfAeYKRzDxc8cGwFDRVDIZVzl9cNul5h1G88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ciRuU0Yu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ba840146so72282685e9.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1777048141; x=1777652941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOpTivbmVnXoG3/nyUEuEllGt1YnW5sq2zo7Y2LrDJM=;
        b=ciRuU0YuzDxJCo8t1kVfGL+pWpg+v+bsfPB4+Dc0s4/ElwnCYqNc6nt65t4Lng3iBS
         +phnGYoI7fmm+PsmnCIXIIDCoV80gbLXT+uH6vJVTL3fGMzGJJDaZQGKU5gu6ThLmqrl
         gCXzzDo3xsldb4a8NB/Q8tNOA2T0yScjadZY/0jUVANWZp86Ny1EUXuxaZJ93Q4qY8Id
         2i/OdD57CDIGA3UwzLsGlvjVFT3H1M3zUxN64HtP1qnikJkIerCxtuNRtbsTBDWqCRG5
         2SiujityFFTd5ri2lNKaLhqY7c9Kzz9J2thkUV2IzcNn92HUsCbEZmxuPNMnFWVw+Gfn
         apEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777048141; x=1777652941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOpTivbmVnXoG3/nyUEuEllGt1YnW5sq2zo7Y2LrDJM=;
        b=YJOJxmzSL+wo9LgVFHRfkE/fojlm9DCTHaoeqEEsVL9eL/auhUGloEZ4au43NLYrGs
         OVw/2/mzQ4wkY7+77ey2ySwldeORl20cgY6ohhLTl4plaDtZOt2EBqD7kwW1AZDEvS5S
         1av6SBabVdbE7jvIAfH4FLeOu29l6nwHx0/A+6T/xlhEVor1zLc2VXMVIW4Kb9EyQ+dY
         0xJXXoE2eFG8nybORLm8GF+4UIkM2iZa/l6YnRjfRmv0BE8evNmttyuFMcOFqbT6GkKr
         dwmnlUH2WHu5FyrRJGQ6e2zf2GZ21+48fc8OrZgz7qMn10aYAK59NUQZMyyhYVRgG8wD
         mFeg==
X-Forwarded-Encrypted: i=1; AFNElJ+0bEfAVNrJfxshK9CyHW3lzLE/XIzvXPJEyiJh5+hWfHUR60Y9+wRukF4bbcqN7N0lEzlJ3hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxWtGVOh6YxP/uionN6SRnmOFINdsY2EiGXgGjyAVNORxdc+0
	N/lGzaZjVd9JmAhOjIKoeXG70DNlDYo43Z0axxTLJY7jzeTr+1eREus=
X-Gm-Gg: AeBDiesYOo//SzztPNewLlMeYSS1D1TbsUUrqUdQcBeZM6AcUjXbygdS1R1bzX0gtmH
	sBQu7hbtXkmY8O6yf9V41/nZFgK3EMeURCoCxWWoS895AtK/ZSnuew5cGlIESHNRyJSjoHynNZM
	Y838dZ/vL0e0sqe/xoE9m71km2XSRG4DcgcRYWVTLE7abKgaaiqVaz9Szs+g3At68LJqFVnqCA+
	qOY40Kmjy+b/IAEgdurqnNli31IoyeNBDav+P1CT7BD+pG9mDVKmmMtgK5feCwxxgunUpkse70Y
	v5tbV9U1v3ojHpuE10VIvClB23+Db/GySDs0IdWA/pu2jOHbOyoVrvdC/3SGh5vmOM426IpN7Q4
	8JVEaFk+7ztd1ol4Clo+RMwo5MMB+3nHgTSWYzzqmfGEqCVKq8h72y35yVWlGpNl32Uorao0W0m
	z+LtSCdL45srW0CWAfcluMtQs6jkhL1xWNq50eEHYzpG/fYphVo6f+Oj69s+UulJEbVYiEFlZjl
	0k9t8ue8YT0
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id 5b1f17b1804b1-488fb784843mr368224975e9.24.1777048140999;
        Fri, 24 Apr 2026 09:29:00 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4e21.dip0.t-ipconnect.de. [91.43.78.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8188sm636115995e9.2.2026.04.24.09.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 09:29:00 -0700 (PDT)
Message-ID: <c9aa22f3-addd-49c5-acc9-309c24fd6677@googlemail.com>
Date: Fri, 24 Apr 2026 18:29:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/35] 6.12.84-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260424132411.427029259@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260424132411.427029259@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF23A4614E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-241003-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Am 24.04.2026 um 15:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.84 release.
> There are 35 patches in this series, all will be posted as a response
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

