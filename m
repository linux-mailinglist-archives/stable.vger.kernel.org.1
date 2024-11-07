Return-Path: <stable+bounces-91808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787FF9C0587
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254C31F2325C
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A51F473B;
	Thu,  7 Nov 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XXhGAddA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8919AA68;
	Thu,  7 Nov 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982037; cv=none; b=R/KsgAWWtbI5IRqVg/1yuQwsC8+nPsucHoM/bQyjqMrDFk8rompXUulckhqXqnYJfd8TIHYtsjsxF4hJCGOUIGX2Wln8N82CARJY1wUek3YdC9yfTna0x07qZQOgqqAu79aRb3c5Z7Gsr1LQnn0ZYd3I7gf5JDilJ7DJ7y4fzUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982037; c=relaxed/simple;
	bh=IQ+lzEzj0W8txnSHSblQ3pbXTuZYufAwYO3m204rwZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URnJ5fUO0VyYAhPsBw0tYk9QUNFIxB0caQ14fw+tCPL36CQul7HyyDFgPndVHMVadxI0UTieMSPUEmeSX36xkGitZ7pGGOddmfce4XptIXvrE6rY0o2wfgAnrCqhae4RQi9l/PWTo6mwAUIoCaEzYgU7J/PvIvNjPaJQKkyl2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XXhGAddA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314f38d274so10497845e9.1;
        Thu, 07 Nov 2024 04:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1730982034; x=1731586834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlSRWSIV6LHGeIvracfP3+zpVN6xLyNM5gXTnwqtm5s=;
        b=XXhGAddACdmaVWSytrPvuabBRCO9t4zeKZbVTXoCzeYKqRTA4xYYSZzCU6w8Rzti2k
         uJsk3GPaiE8W9OTgDcPkNw12PsKU3jpwY/Iy0+myfw/hU4qNSFIRtPSPKrq2F3OAWhqB
         HdBf4i6+CjO50jap9CehqEfP72E9wfSOn65Ev7QKGgqqgNpWBavuxC+VV8vmzzzCrUBZ
         /w+Wt3u989fAd4tah16+SDoQkh2Rxvhqzux5b8nLk1ne3UpBpAJnkYJH3FSd330LXUWg
         cw1t19MWCL0T/E8NkxMS+5+sKGu5+R1gvRWDspeRA85rMt44Rpmoy6NppUYt9clA7YDl
         zKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982034; x=1731586834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlSRWSIV6LHGeIvracfP3+zpVN6xLyNM5gXTnwqtm5s=;
        b=pCWIA5B72c2kJUSBTO10kP03VtPVdQqErUOck4KTeOH2H4S/uWK1uk3y9NbEUQVK6t
         6Gx4gPs5DcNbBkZAM+jdhr/jiUOVJ18+zLT7KkdJPS1roeEvBzDhRgVpyAxgjWjqmvJy
         wEZ1hJMon1rBuuNn3t8eCJwON26QRDt6QOmydQD8rjUj47logyXy9M0COm9fLGit0pMe
         XLmMiCA+uYIK8SP2jgpBt535Tv20Wx3zll/nisz7hrSOtb7Pt7A1ah11SiBK/+ph3ozB
         ISyjXvU9mLlsd7WvQ6HII1K0MMNR6QsuWlhqpZ2WeVZgT/PlpXS2tyPhXeGbAIUgdmFp
         Raxw==
X-Forwarded-Encrypted: i=1; AJvYcCXs9o9P4kFprbDveY31tzlNVy/G0CiRfIXtZpaL/k5aL8eJExBGMHLEVrI88ldeVQDfjfYRjHXX@vger.kernel.org, AJvYcCXtLWUBGZxRt98woZAzi2Kz7JPQu9ifTx0bGZYuCLLwf9trjNqoFShbuBa0D8un0rjMNk52pcnqsa84Enk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEjW7a/aJLlDEejOJbNI3fsEjsHhg0ubTK0BLdhCn6nz4RWaw
	lmX92SUHvlLyT1TDotXzE2VCVTZMOhl+W4paRvIObtfDOl5vXC8=
X-Google-Smtp-Source: AGHT+IGL2fX4z2U85qlfVASCEm/jrw+/7NqZCwCI+sqOVMta4//26kDAspck+hOFab7FaEXh44A24g==
X-Received: by 2002:a05:600c:4455:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-4328324ae6cmr243347705e9.11.1730982033592;
        Thu, 07 Nov 2024 04:20:33 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac486.dip0.t-ipconnect.de. [91.42.196.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e3dsm58197545e9.9.2024.11.07.04.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 04:20:32 -0800 (PST)
Message-ID: <bff71a1a-9f8f-4f48-8207-b56ea57a92da@googlemail.com>
Date: Thu, 7 Nov 2024 13:20:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/151] 6.6.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
References: <20241106120308.841299741@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.11.2024 um 13:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.60 release.
> There are 151 patches in this series, all will be posted as a response
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

