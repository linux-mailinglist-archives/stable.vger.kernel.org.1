Return-Path: <stable+bounces-256599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANPwIlhyGWqNwggAu9opvQ
	(envelope-from <stable+bounces-256599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:02:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B766013D6
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5482A3067AEE
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5A3375C5;
	Fri, 29 May 2026 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fmoDnVBf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932A3B7751
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052366; cv=none; b=Rtu8zOl4FUvmFvpi143Z/4Zls8/1C4ylTLu3KzmUN9l+DAgktHqNMDOmwVBHC8EOMwA0CK5Cx/W2l4U92uVk4tXe2AaoRbWSfEvKzx7Xhq1/dH5oi3+o7VuiXQYFhgCfo+dB8vvmTkYBTw0HbhFiRxuzNCGffXD60pjLfdtpuA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052366; c=relaxed/simple;
	bh=OALE1Pc/rF8dgWSwkPtQJkCEVXfiJcU73/nCbwbqG6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATnUFZZMXDx5Mk2c+a+KdZDQv6LJX3nnykXTsMKh2ZUZMdnSfk1e5yk7pWIXlKhi47eGUfjZ0yj8MHJR7LvXofPZriLYGKNB7NxEKdulE4mYtXjfNCxZa5tdTzV/VXDjrwnrrFpHDQlaZOnNUM5vTCOyxyBW58KBRQdcu6Azssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fmoDnVBf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4905e190c71so64508005e9.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780052363; x=1780657163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F21Dsc8xJ3JaBQAyJr3DbcWUQMZ4eqao7aBELV86M4c=;
        b=fmoDnVBfKy1QnDiVAyyFZbMss3DphTuiFrppppmYcuQiGm8/fLRpy+eGRUQS5j4a/q
         SjOzGEPIeW8hGM80k72OQnM982Rw8pMyA4HZ+HVJH94QP67dIYaXsWb9EBLKJMB+o24c
         u+5f+YQmRrlPc8Bnvlt649rVSBfB3o4y9izPJeQ1m3znXBXA1QLvNvDs7ne2dZAJ4k5R
         zcgDIiRadGGP51C6myPSqrBN76Iq9oqdbbxeIwjtOEyacbxYlhDCMcOdPSXHUnoS9q8o
         bc494ETZcj8FuYeLqPqLd2jSvd0jafNl5CL7ydsx9nS4PosZHrvrtY4COOIKV63hu0Tp
         CiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052363; x=1780657163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F21Dsc8xJ3JaBQAyJr3DbcWUQMZ4eqao7aBELV86M4c=;
        b=TZj+UYAj0rlBsviM6knOZivESDwUI2TPHMV+nwxv1NHx+0ITQFFT07r09IUJ+f9t44
         O0M/qXt9RoK8UQpROFlyMsKKETg/YQcKkiClIAeCjFCgt1ViXmyY+uT3mASVwQjeiCSb
         qnsg9uSJphcBt2jlpMqMeMQrnJOIhHH2Lwympwt5zKekKNvLOPph/gHb23jYgQMB+bmf
         sFBSf9quPhpm98O7Bj+Sd5YpyWwh+0p8KydbWDou6+9G+yByYzXkHPPvwPFQMRgqPc0c
         ccd0KEhkF4o8DGKquAEE4JGinYwT73KXSZGNCrHOMRw9nIb7yPsG2TzgFMjt8WJ1haCI
         VZfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8adtpsGrROG6SejuGrs05eX17NIOIE2i7ikK7MZmv4khOSYU59EWG3PLkFANPPgtQo6N+KkYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHoznW+mb9gIUuVVax/WV974QrVZmSyIMHwmtZrn+s686NdsFT
	jycoKemnprRoN7AKV/5Ur70hYb0ZJ2i8gzwDFU8zSJd08GHUVXvSU7c=
X-Gm-Gg: Acq92OFP5yuthTVomqaK9m7jGoqanbQuNB1wta6uDwmve9c0WZ73DPfXoixknpoYoCU
	08VvbjjDssmxMtysV/1UBU9TstxvEKznzynXvGsPI1bf+vy54ku6a2R6TSmKz9pY4v5dfnYLG7d
	zkNeE2BOMRsAThfqfrQe0yjj59m2iq8cW1TNvsKUOywtfelF60go8Y4tmv5jvwRq3uPRY1XbwPC
	y+tn9W2uLeMUp5LtWbgv23ACugajkwuHfqPSlmeIvT3JrKi+PgJcA4XBPOHM9O8hGpLWh75B/gE
	TitvKenTIadxcq8Jv1UG6JzjzbAMfRHmBOeTDVDuWFhLOdJjrV3E5wtUfGE851+aehMABm3Vrz1
	Kc+RTx9kFcJpbFUXOhvdX0Y8wqDe7Rf/E97u1tlTcbDsm8NyUNYd/o4AexTtDcrrMEXPzhVzvCH
	hd3EuNqkqKKuSm7mFFi8ULUIF/WzhcgaC7UGqO/m+VN9La5vDmCmmG/LVQ/c3CStuH5FbTqwueK
	wuSaCz6G96gQA==
X-Received: by 2002:a05:600c:a55:b0:490:3ff5:737f with SMTP id 5b1f17b1804b1-4909c0af305mr44771955e9.18.1780052362946;
        Fri, 29 May 2026 03:59:22 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4ac5.dip0.t-ipconnect.de. [91.43.74.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c1263dfsm12436465e9.30.2026.05.29.03.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:59:22 -0700 (PDT)
Message-ID: <9b886b8c-f3cb-4497-a4d3-159cddb0dec1@googlemail.com>
Date: Fri, 29 May 2026 12:59:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/272] 6.12.92-rc1 review
Content-Language: de-DE
To: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260528194629.379955525@linuxfoundation.org>
 <20260529060918.123155-1-ojeda@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260529060918.123155-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256599-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,samsung.com,lst.de,kernel.dk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,mailvelope.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 05B766013D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 29.05.2026 um 08:09 schrieb Miguel Ojeda:
> On Thu, 28 May 2026 21:46:14 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.12.92 release.
>> There are 272 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat, 30 May 2026 19:45:52 +0000.
>> Anything received after that time might be too late.
> 
> Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
> for loongarch64:
> 
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> 
> I am seeing:
> 
>      In file included from kernel/trace/blktrace.c:23:
>      In file included from kernel/trace/../../block/blk.h:5:
>      ./include/linux/bio-integrity.h:101:12: error: unused function 'bio_integrity_map_user' [-Werror,-Wunused-function]
>        101 | static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
>            |            ^~~~~~~~~~~~~~~~~~~~~~
> 
> This looks like it needs:
> 
>    546d191427cf ("block: make bio_integrity_map_user() static inline")
> 
> (and indeed in my run `CONFIG_BLK_DEV_INTEGRITY` is not set like the
> commit message says).


I didn't see this error message on x86_64; I built with CONFIG_WERROR=y and CONFIG_BLK_DEV_INTEGRITY=y


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

