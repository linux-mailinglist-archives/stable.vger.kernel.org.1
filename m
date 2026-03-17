Return-Path: <stable+bounces-226905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IK/IbfBuWlYNQIAu9opvQ
	(envelope-from <stable+bounces-226905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:03:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADFA2B27B7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97CBA302BB87
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8838A712;
	Tue, 17 Mar 2026 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VisVu/jI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B211340DB9
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781425; cv=none; b=NHJM0YEtib0rtKVgiwqBKGmJKn84DGxoilp/VaYBdTGCwmdD5AP+R8kjUhQ85RAUToqi5IKcAjXqVWJNSycdYHcitNvkmvg1tSfbsB9YVX0JZ0rpd+JzbMfiX2idgxrnBYd57saTnQCRFc3jWtviRmfjE6Lajte5evSf7A5B8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781425; c=relaxed/simple;
	bh=bdXN4W8dbAx26hVc8+7B8poVIYSFp5tngJk7XmJmdPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5yPfBldI3Qm4jx0GaH8JRThDlbiyMn9WxtypIALfXO/UPTArDssmRpkuLfI4fmJ4xT8OgsiME84qoO/uiJKlCrAmicxeb+alzOZwN3EQ5lqmee7dRoWgErq7zrkjWkTa+dTcuo25zyjXweLk14xBdeUiy3YThMJpxbBFFdpeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VisVu/jI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485345e1013so2038215e9.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773781422; x=1774386222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxBhZ7CdyArr27GxY+04wnB2mrYkUJhRWilAMxTkQI8=;
        b=VisVu/jIRBrGxV5heZ/bG+/0BUaj2ZMKGe5GruugXl0cYeenFb6SkYPFfj7vbc3f7H
         Ndc3rPRZZtuGBHXZ6bSdHdbAHW0GYZMPn/lY2KD3SGeKMsZJupZUu33h5JvGyca8epg4
         EncbceABV+sGuoUWnU91ruvJYrFDC+w1e9Tgn+bDSS54Krm8J5c2vIdPB4NxEcxvWyEs
         lj3q4B40ROhtrquBVFJyrh/xDFNZdorQVGpkfoxr3VovNFdvfAUBdWGyd2RQYUwOCXBI
         wF2vLyd6iHCQvbcmsbrBlNemOM1juVS+CEKAw2On7Ji8UgFoKvtsrwajNY+YhCDbTLPn
         FIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773781422; x=1774386222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxBhZ7CdyArr27GxY+04wnB2mrYkUJhRWilAMxTkQI8=;
        b=jGIVB5AsAzIwHYtV2Ra4682UxEBaYQnlXg/TQJkQC1bmbpsmUGVEPe4hBkQtRqNczF
         ktS1/Me/OmeQvf8qAC1XcXgAoasi3oG/EP0glp4qogNWC6SCyY9CxLAglPSCP0XKfEiK
         RTJd3AGZ5pbeh4P3PrZxy+Jl6MXjFldZiv7olcyjtfKa+E1JNexBKkaP6HvE9kQpDaUg
         aJfKXvuKc/fk/AxsXKxn7X7Px3RWIBwNg1DprmcS1CpQuxV3kGsRxFrt3qPqPhJDc75f
         PaHYEMyyZ4z1ePah6SKj6YD1VwUA2gh3Mq8lvhMiUG1cVTHdXPXP9oWPng8bNZQbiYkn
         zwag==
X-Forwarded-Encrypted: i=1; AJvYcCWT7PM+veXO3p00raE71XVluZCTD2tYkS4/muC9o8DCWuZPnK+6TAsHpcoar9H0GrsU/NXWFBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfCtdyDXZMPBbsUs98qUXVmy04JlU3VwALUDc0vC/n7eAFOBd0
	jwhft3o7SIhfI7hSf8mkGXiSmkFT1+dPsbEg8UHXlUMrD1MrmvdmiG8=
X-Gm-Gg: ATEYQzyB0lQP/8aIwOAgA8AU4am+k2/t+OXzu2PhkCgI5uhloXrUC6XTApQ7hx1W/35
	pdAPhNs9J7CMMbHAbo4gt4pXy62iCgxxj8lOtGh+NTjRiV2xEMkxKBap/FpJR58OBnue8bDTX7U
	RzA2OfebB4G8M4netuivqM2GwkxW1fL+4DHnxgGYFcZv1ku3msRUySjAK4Y1z7+MIHKeZpFYoOP
	eZn8bestSe0xxdOfN9gqWJaoYfa+jzzZB1OqibkMNnXARtWk1sjpwuO46lD/5LYHIWAwdmBhnf1
	kyGG1g4XX9/hJn5u03tsHye53aVEev8EK9CriOHAYj3I1Cp2E5TFY1J652JeNnvcfjRJXIWzH3V
	ca0czxYMBiksLPpub7I4PaGz6zPTcR6JDSCgbJ4yY48pu0APWRg3lG6giQPU++1zOJUbomNonn3
	A6NISg36yZftkfyaeJRZKmNocy83icSfZlq9OITDYDhRtz87BgeUugQ1QYdr5WGfIxLQ6+h3VFZ
	C3T8ekUBntZ
X-Received: by 2002:a05:600c:a00e:b0:485:3428:774c with SMTP id 5b1f17b1804b1-486f40a604bmr21513105e9.4.1773781422216;
        Tue, 17 Mar 2026 14:03:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b05714c.dip0.t-ipconnect.de. [91.5.113.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaee04fsm91129815e9.13.2026.03.17.14.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 14:03:41 -0700 (PDT)
Message-ID: <731ff34b-3967-4a21-83e4-d85009c48f1c@googlemail.com>
Date: Tue, 17 Mar 2026 22:03:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/333] 6.18.19-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260317162959.345812316@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226905-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mailvelope.com:url]
X-Rspamd-Queue-Id: 8ADFA2B27B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 17.03.2026 um 17:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.19 release.
> There are 333 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


Same build failure as in 6.19.9-rc1 on my 2-socket Ivy Bridge Xeon E5-2697 v2 server:

   LD      vmlinux.unstripped
   BTFIDS  vmlinux.unstripped
WARN: resolve_btfids: unresolved symbol kthread_exit

and git revert 0507972c8244d6454cbfd242157e86bb01971bf2 (kthread: consolidate kthread exit paths to prevent 
use-after-free) makes the build error go away, but may keep the original bug the patch intended to fix?! Wentao Guan 
wrote in [1] that an additional backport is needed to make this patch work, but I didn't test this...

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


[1] https://lore.kernel.org/stable/20260317175812.707723-1-guanwentao@uniontech.com/


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

