Return-Path: <stable+bounces-222775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCwzKIZBpmkTNQAAu9opvQ
	(envelope-from <stable+bounces-222775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 03:03:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3B1E7DF1
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 03:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5775F3011D7E
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 02:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E84390991;
	Tue,  3 Mar 2026 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IxzCoApo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF831E824
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772503424; cv=none; b=cIscI+KWjlfL+7wnJGCn/bMiJ8R5PQ2fZXUaBxJbwEZfmNhCo1jJYr3gZ9jZoFnIZC2ek8BLZZiY+LwQmUdS2fePa84iX8Jflk0J35T4Wj6rGYHpKfUewo+hhK+Mor+DKgiaY2vcuL2IWG1+WeqdcpbcYhDXuwZyZO/tgY4ewjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772503424; c=relaxed/simple;
	bh=T3U0Pwj5QKpXzxmSRwkH+YRim8csie0y/decyOjdWik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUadigBnCKXis7mTDVjyRtjdUVMiZ2yCcze7Zm6V7Yk07JT41o4xhbmyrFvUsfDkMAdKXvPdPDezKvSCka7izTbI8F14873X1hWEPrVJVLnA6rilWuQBt+p1j3VqMjbbNGOMi6HvyFCsfSKTRrOY9yZW5Jvps025ckuJwlPLAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IxzCoApo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483a233819aso49241435e9.3
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 18:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772503422; x=1773108222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acyJ4a+uK5qh5x2co2XOASuajgxYlRjQTIZAPblgzpo=;
        b=IxzCoApoK1jaJcrEJsbbxYqEVOxzon4hJKLTaHrcsojf/mFmG0+haVyEgkLX4C8Pt9
         /3/BhYMI9SXz7emeGVuFKoC5jTGfVs6MvP1zDSQWCtMaIFRagtPId4sNx6CikJmAcHl4
         9i32rY9flcGzwHSLH+6lOnClJTPY/o3V8qrx/T1BDJIcbVX5XWFzJITslBOuyx4UoyyJ
         P8ArZSceEb6XhPtba9aNhAu3JZYziRE0IiZv3JBgBfAE1r/ra9uy3kCHEl0bkFYzVy5+
         87wgKoAE/JpWIwAKYkypmN3aAsxEjVyUbxpfiYGVSpbHE1DDGQS2Fm5kpLmFscf0LnW3
         yxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772503422; x=1773108222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acyJ4a+uK5qh5x2co2XOASuajgxYlRjQTIZAPblgzpo=;
        b=NhMJN+sJWIWK2n9eFHbHHmbheiV+9nRD/Y+HPRFMgyVW6VAEytdJ9jAnE5uPio45qd
         daRwLmilgAlBV1gf6RHXUqb3TOJvfsWEUeU6/NBtHk8S0QLOi/jPa01IEKo0OzNwod/s
         v3mXPcartMBnOv3Ifqzb5dvkNJh5iejd8rue77SfKBtE9dUDUtrk2OmrrECICfQp64eg
         kRtXzVzcyZTJJPwrMxURaoda/3+QjuidTkZNC09Hm0n3nr1ltqLeJuqdrYDQVL+HrhVx
         3t9rJsu72Dn+O2JOXAK7SkMb6mKTrgP5r9lAJN7HWnF9ZNidtdNd/BSAW7hjKSBNidxA
         Eykg==
X-Forwarded-Encrypted: i=1; AJvYcCV9XfIlam2Rq5oHqq2Osl3ypDoFyc33oxxO42LeTHEhICBt8bf1JvVdSLM2BY2pYjq68Q1BOeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpzKQbp88L+O5SPOICyQWkYIS45w7l4YCyi+xzULM+OQqpiCMk
	DokCeb89/01hCR8VV8COjiLJ5exOqe4qrJXcumGb93faoXGIfKxaMzg=
X-Gm-Gg: ATEYQzx9mEY3OJ+b0cN7HiohOVKfTsHVmTdaewcKLF/uNKQpfPeqJVHDNboOTenL4OQ
	oNvwJNbcM5i0xbr2Krci7wFMX774xJT2fWIZRfaJAxP4zCtL7173Ixoyrv87Aj25gCWpZssAw3F
	CKhrbHaqxTPmjfnWU0zDnc8w0fhGp3Urf4t6Fn57qPLF5t8zWzM/rNGPyZedzxaM7rI9rE7ChAZ
	FmPSMzcWgdZO/Gv75DKKbRbBthk0TLJT51ep0zotnxEA/1RT3biRJirRal2ulGBaAZizPHQJ2dU
	oTTYxAE2akxWOx0JscaQjRqdQcOXL64vDGRll6wn9WcmXDknaNkQF0aTjrq+S8bg60YTi8bpNYv
	YB04Al7QetR0oFwl8i6wZSiLBZQBGPpgTyuoIUYSxJZ97T3HxWXaA2WUoJhbYoJi8C/IGRwey3y
	OuCATssEECrp5+FyGxkKPp/wxbaiJkMDQS3sH48CvFCPzoD+rN/sgrZCc5+Q+em2gVYKPRsYQTK
	7Fi15nDvLs7
X-Received: by 2002:a05:600c:c4a6:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-483c9bc1d50mr279462375e9.13.1772503421472;
        Mon, 02 Mar 2026 18:03:41 -0800 (PST)
Received: from [192.168.1.3] (p5b2b433d.dip0.t-ipconnect.de. [91.43.67.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503425asm13146276f8f.25.2026.03.02.18.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 18:03:41 -0800 (PST)
Message-ID: <cf6ccea7-fb2c-4999-902b-0787efee6754@googlemail.com>
Date: Tue, 3 Mar 2026 03:03:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/850] 6.19.6-rc2 review
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
References: <20260302160834.2518716-1-sashal@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260302160834.2518716-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87D3B1E7DF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222775-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

Am 02.03.2026 um 17:08 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 850 patches in this series, all will be posted as a response
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

