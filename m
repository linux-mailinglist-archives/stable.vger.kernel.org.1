Return-Path: <stable+bounces-110066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90229A18630
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A1188BB2B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328A01F76D3;
	Tue, 21 Jan 2025 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TEOyzYId"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DC1F76B0;
	Tue, 21 Jan 2025 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737492100; cv=none; b=PRzWB44kcwotEYuMoa4oHYnSxCqpmBd0UfM6XWsyAGqB5qkUyx+K4U7N2mDM3eQZPi1yjItGI2dir5OiIeg8wmYG8C5tz8QHdzqhhx6+lLvw3blk9LNfcbqaFB1H5jNWpnE2S2QtT2nDEPulpQ3sWxZZ6yOvS6+9C4byZhC6j4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737492100; c=relaxed/simple;
	bh=pJvD0Byg5cT7yNzWI5VwoB2sO2pY+1inKuBQY5s5MTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRN+7jCkZMffCccO3WTmO8gAUpwgoC8gYlk7sSG2MfCKevOLC8nV0/Sbb0sncgVxm/kisFzoyNiG5gz0ILv3+CQ+AiV6s1GnRITnKdyjXli7TJlxWQnS4o0ip2qoHGHGzBN2AalQyHr+FdcrlE93xHZPWN9tMCua1yUE0K6uQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TEOyzYId; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so70624405e9.0;
        Tue, 21 Jan 2025 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1737492096; x=1738096896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gqq0pER5wPkh5iGf1j6nB/PK1FvSTu5KMsWg0fDNlwI=;
        b=TEOyzYIdkQrUATlIlUSYIoYXi00fKE4ICesJZlggQG4n1WYbzMvODEAPssBgP3bhdD
         cmGNoRgK5vVpuZuB0w5CmTxoORqjOTl4h3URiwGGV4hF7jprQKLLkbffHqLUjGpSMk1M
         RENP75pFGL2RY1TgPeuF2HvrlTS84mvPXULeF7a9oUeGOa3gr5gE3UFsKx8hZ4QY/V2T
         E7Q4bmivX64n77JFtVLwBN0HUEQVwmO7wnWq2HFpwwR/QJV5HtBv2Lu3QxlqjvlX2k3T
         aMrsx6zOdOVuVQOXuOgMNFYodDvMsC9UUcnBYzZLCyv5nsx33ygqXmjw9NfWfEXrUd6t
         MUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737492096; x=1738096896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqq0pER5wPkh5iGf1j6nB/PK1FvSTu5KMsWg0fDNlwI=;
        b=mNTX4TJOPU+wSHJ4r8n/dZlgh33w38+IKC4rMWBsKVGEmJjmZjwFARilJwqrfAU3BH
         XZoz15VNOfE5Rp54x2gBWHn22YJEbbPpH5mTOX+FF6pI6XrtZ6NctcVyLoEdmXQsMO67
         D45qeYgXlXkV2iN5YC7stzo+jcf+W2aFlUrsaBPPhIqNNiO9C9VcBaKc3/BitTh+fI5h
         pvVfuO3VhuBXks9wz5vQMFD4mdcEc+kL6N5lthHHBsKZMJo4d5S00MveQ5nIs+TmkC35
         dQ3h1QvrWsVGDMGeq0pZOY8NKTr79OeEThStypow0Q1UAsnslQp3FYZilOT6rAEWZj9X
         7mfg==
X-Forwarded-Encrypted: i=1; AJvYcCUCmBk2FDS99a1aM31Q6CxJZTccf1RWVeSzqlebfn5dthN88dirEDsQpIRgvrNCLToQfytB0hTT@vger.kernel.org, AJvYcCUEcmnkJVByrmtG4Vxp40lhsB5C4aoNGBOaBKJYKjNeiAeuBSlh/uPGcUEwFtROyCmvSYm0zi4eityC5ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysf9fdaaXTc9SvSRjF5ywSIvlH7Bof+ALa04kSTLLkiMhJZ6Kg
	rsVh4afhOBdg3LTk/ClNgH/snHGHDzjISnFTGX/Lroyv1y8OPMA=
X-Gm-Gg: ASbGncuaO5EDvDheFbAYhmyrFpQgUXEFed3xiHXhVYGZqcbFyCrMKJEkrPP6oKQsaLW
	HJWIrXNuGl1NJVm6aq0dyHJmBggu7W8m48VHm5w11uVPEnczR2LZOvsBogVQzuBeFmzymOnAXO1
	9qbBzRDcxYrkl/sNlNcp8UY7Ql8IWDZ49ovs8zm+U1xvwOMtu1eCJ8i/TFn/tzz/JU68QUCpugu
	aWm2k7K3tRwzCMVhIHy2o3zLDs6FASHVIgFJMAHHC53lIjfYhydSTwprWmPLjse1cy19UDbqmnN
	chEzI9iBUrpxo9z0/jJGKZfYQs5JyygYAHzsJrNBL1tvHoY=
X-Google-Smtp-Source: AGHT+IHkUE/jJDfPnSRgFVx3UNOQex96A0RnCok1gUEbjuI/9XZFAfiBKTtsB/KE1zltqg0GNc+KYg==
X-Received: by 2002:a05:600c:4f42:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-438913cafacmr196268485e9.11.1737492096363;
        Tue, 21 Jan 2025 12:41:36 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac60b.dip0.t-ipconnect.de. [91.42.198.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f61bsm190232765e9.17.2025.01.21.12.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 12:41:35 -0800 (PST)
Message-ID: <3bb3ab8b-66a4-4da6-8f02-125ca37cb4bc@googlemail.com>
Date: Tue, 21 Jan 2025 21:41:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/72] 6.6.74-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250121174523.429119852@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.01.2025 um 18:51 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.74 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

