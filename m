Return-Path: <stable+bounces-171824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0565FB2C9D0
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C190165D84
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0A25EFB6;
	Tue, 19 Aug 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kxECvgIh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954625A626;
	Tue, 19 Aug 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621115; cv=none; b=opgKjbd+co4As4kFijY5K/Nyy5FdVdhlH3+RUTo8dops0PMLPEm2+Ay6BqBN8Fyoj9w5NXWdbQqDZzBdZzKK3q9u0xfHrWAiIAVULpW1AIvt8/w81EVTaP+zHoFC1GnoRpiqImVDLldjJADR6PRL3Y3lL0QquRQqJOu4oqz9Ti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621115; c=relaxed/simple;
	bh=WdDnQ8IR4mnQdX4Dza9pB4Wap25haIS4/SUcI4fWsOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgdJOqNl511xn8VlWUSVhO8cHccy1kyF2csXIeVJ8DbWp2P12BLjS5NIEnD6k3y7kdwef9Qf0GDFfpgM9gYiMtXBcXDTB9nnVLS3ADWBCCqb6sgFTnFKHWtZ8P7CIe792Rg5LFIabvaLYV3KBkwXBcVqXatN34k4xyRe/21eiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kxECvgIh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9d41baedeso2956911f8f.0;
        Tue, 19 Aug 2025 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755621112; x=1756225912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YeEFkpMwO8aeNeU/kCa7lT0/efhqRLkik5GKku1rBmU=;
        b=kxECvgIhI1FqwChQ1aG9DuOEB1gSXorcoSIdhYnJeyRI9D49ygY1aQFSXvS/X++G9y
         uhx7zMdxvYvPdr5Vb0ThGm+YkaeERjsbB0wE4YYu2yc+6RQN/89rxuaZvineUj3NKkKu
         qTuyyjTHi9BbCkgkvuLiNC3+UyGLkkxN7MEsLqEtEF4tFwJEhjS8X2uZWGDPfm6PDCrK
         E4Q8YJWge9RfP7uOV6je6uyKlaa3vxaGf/35RDpNysG8EvpLevcW0KM1HaIBAv5AxbkE
         QE7KudQODQuj3K4i773yM3n3+GHNrYma9Pt2YekPn6RwopZFtZYWsS1QJjdBQWH9NCqM
         Yc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621112; x=1756225912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeEFkpMwO8aeNeU/kCa7lT0/efhqRLkik5GKku1rBmU=;
        b=U3BO/MqhaI+pUd2enXcsexZIgmRx1/JloaLy0eV+ASYlNCq5VkPjU6xtSIpLytBpdk
         w7LsY/lU7UTPpXM3GGH4Ld1WE9IdlSTatwhekHSg/OyrUN1WJrD+5YQCFili0mDxcR/e
         jMkGkd/5rVWOzYRS92DmYJctAKjdffwk/Jzx+QFk9Ul2Zfn9lNhy3fDZBqHR0oMsUWbC
         +1xsaAba01Z0NHYa+4W9qnVLDchW4zAy+Z112cYc6gcJKtA5urPZ3szOne4O0CQu5Jkz
         LozqlcuqYi3YW7mMHH6fyU8MTi9Ahzdpx0iYZkOT1NANztw131BX3qRupdch5WG0dzpp
         Vlrw==
X-Forwarded-Encrypted: i=1; AJvYcCWON8wxeKIty3cOgRAZ3QxW9GNtlBlJgY63Mqtqlu+YOK4x9CbYhXpf3zGzI5bvdk8tMJSjD16r@vger.kernel.org, AJvYcCX9LrFuaNvCLjYTOoJnb2RQ1513fTBU5/JNIEKpn9N4ZXwgQvAwLN3qIu+k9zr1VX23622GNMznRb4+e50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9LCSeZeDjVtEZaNqSrg98GGgHsRemkVY7I45GPid5lmW4hE1
	Gwk1si4k7RAguje/akG81Qzx64EXqRF107tSIWLET858Zf16xJvI+io=
X-Gm-Gg: ASbGnctCm1/bfpdAbhUY5O9dLkHM01TGZ5e8R+0jocjU3ng3R69Iyw4HNBtR6aAYiB/
	O9BYPLMDSTbQbHRAnozx/QPgEl8TyKH1S2XIpYK1k1ZtaYfWBDkzsmzbUno5NTBe4wil4nBBavk
	ntTM5v9xY8JwIObiiqLowwV3DW9YJv2WWQ6FpMUesYoSZGxtF8WnFBeibLmrPCAHvgkuYyrDYXe
	3W+n6dqyUoPSRxvwEZw+EgBWE281bBUXmhXkCrYYZAHdGg016Xwdume54WXkDMJIgV8QQ9dn77F
	mnli10lWTUR9F6FkvVereANVco1pifKuSHozxSBvUUE1WP7+MagUl5EwUsYns5iQDHAJ0BFb+gh
	TFRVZpG/FFn3o2ryLbIT2akuXwwGfdV601vI4KbTgTDKUXtbRliWrPu2m+/HxNFqOsJw7uDsejq
	XAtb1/ZMHo1no=
X-Google-Smtp-Source: AGHT+IHSZ46SqCnjtV5u8l5XC83Eq7ZGTy6ayoujfA49Dv9VI0FpvywRiwsDn2MEKzprm9N3LcQROA==
X-Received: by 2002:a05:6000:25c1:b0:3b7:7c3b:1073 with SMTP id ffacd0b85a97d-3c0ed1f2f83mr2415426f8f.52.1755621111966;
        Tue, 19 Aug 2025 09:31:51 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac4f3.dip0.t-ipconnect.de. [91.42.196.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43626sm4201227f8f.15.2025.08.19.09.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:31:51 -0700 (PDT)
Message-ID: <c178f7ff-5aa6-4ff1-beb5-4efc953e2538@googlemail.com>
Date: Tue, 19 Aug 2025 18:31:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250819122844.483737955@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.08.2025 um 14:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 564 patches in this series, all will be posted as a response
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

