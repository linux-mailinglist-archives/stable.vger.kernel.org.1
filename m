Return-Path: <stable+bounces-177632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19C1B423DD
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 16:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813131BC2FEB
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859320B1F5;
	Wed,  3 Sep 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l+UI9flE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CAA20A5DD;
	Wed,  3 Sep 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910251; cv=none; b=NMI2DfNzzIjJ24geSJMPWcameRxq4T0Pi2B3SzM2Rx3tR6DFR4KdPoCtTl9Dy6EL+qjb6eZ0hr2+VigVD8EPI2ExoeRAf2yO/9PsRR51Jl1IEBIFtPvhawGKGeGNWS64zbJI+wNHLv9gV1YcpHMoTncmlP6Ht2tL9pn15c7zg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910251; c=relaxed/simple;
	bh=Aq4SHoJGJIP8AYS0ZnZjQsp63YrAalqNoxFoARZaKqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkuOHvCeqDl2uHdK3ipSVcvHBBxUvmAyB6UfXVVDG9aJVu3Wg+mQV9qDso+TOisloo3kNgPxyXIFBUUap6/trWCsMAl0Kn0IdOT43RCz3YfV6wZwLqlL+kLJlrws00a7TrD5RtHKjxh7sB3+7bRLO4EigNIFzCCgTpoEBFU10no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=l+UI9flE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so455797f8f.2;
        Wed, 03 Sep 2025 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756910249; x=1757515049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3zaWeppSnK/pHW8BPkcRdM3L21v1uIAD/evE300Qt4=;
        b=l+UI9flEEzwiw8P6iwlL0gNncKJndBlfSUuNInniFDQXz42x+zbh+xZPjCYP+DRUCU
         P7GG2AaJfc4vjWKDAAzDLh35FTeiLmXFLMamgF05ZA3JfWg/Wf2CKGKZi2wFoxm6MFzw
         jh0LmhmBZqVwBYubXPrPPTZZHQ0Pz2lRjpVRGeVqo2Xsg7qkrukHsS371s0f+l8gnp6L
         INMI7pzDZJ0BvQ3VkbYpTJC3fcDr2Z+1/Q7iAzeQ0QqLwf6V7LwpsKjCIlXLdlb1uuDZ
         xOE7jvIy+rSM1DjtRwcN15oHerc42VzhP1EkFhf6Ou3cZ+GIhnrKBwDUUwtuhhm8juH1
         7R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910249; x=1757515049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3zaWeppSnK/pHW8BPkcRdM3L21v1uIAD/evE300Qt4=;
        b=I+VN5q25Phov31DxvJBN1aafrABl9lufdJrw/TAQLSlgOTklkXp0RzSU8o5zN3GGqJ
         3lSZlyd/Mpkh8SBThRx5VchHyk/FaCUTBOGyMq+tHzzbgDwVnuT+4yfgOJZ7jawnLUOg
         VepMHvujbA+6bICrHGDYX0kE+Hf0F7qvkswqmgfBA7tnY+mQwzqSkDObMT2bPwtbxZqu
         vXAwdUfv5LD1zBdFAK1p5bG1ReI0NruZXRG/QkCflJHG4/3LSAmSTnJ5jNmtJaIBNiJP
         XH9GlngPtm9CMpza2lu7j5z7HETONos7uNi3V1p1bTTCP6O84BY9EjnQEv+epo4KL8ZP
         0rVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzHYdRXwttOFqLSrpg235KKRUTFJUE95wujNhozA0zJYrcJ7bEbNa+OgaAOkqwz8Ll+lbjvcikmAzjKPg=@vger.kernel.org, AJvYcCWNtJ86Avscdk2mIWF5IbGU8Km4UMA17cF0J5ckX/+r7WMvqbdB6jpoageQTZ42IzSqu0W9zxbJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3y1Yv4h3e4n1mfpgx+qt4OMgpKl/1b+w2avJhN6ZXqVQWF6C
	cCFai9I6QdnaxTOHyPlp3yNTu49XJz/bANLXf3PA3xhtWXRRopz4/hY=
X-Gm-Gg: ASbGncuhMtBTRIUUu6KvOkhqHQC05XkSotj6nlZF4FzsTuZP/CGajlsQJHtPh1puL84
	uDj4/f9VDGainJ2Dvf1HxIF3hw3Qwe4RXMJOk5/P1tklTY6QE6CuLnEzwcAiEMDRd2k1zLY/nn2
	NrHaBpkrRYvfw7o+tLLVY4eO794YOASUz1CmCop13X9GzO7e79uvF2OBHTzX8O+qJX0L60GAcZx
	QhWzSe60Nz2Zh9hyD9J3yNcm9ltiDAgKHYFhVVqCF7clfe8NU4cjnIut7FQgCpJwRZwpQfS+d8h
	hu0Ne0gmXPausERU5j8oD9Og+UCKAWgbbJh77gqwRTlXo6STwjjzN65hUMLUo3aedzqtYjBcVZQ
	XjSv/qP88HrMsfGiVn7mGoxkhNJMyq9L23+lc8dSfmXka5Jx0MdzQcBqRU80M5vXPLaqGU6g1EA
	==
X-Google-Smtp-Source: AGHT+IG7hE9bsPPkY8ZAxJMMDGP6woK6Gl560RIJ7jfmU8rmZwkXeHrmtsXRvMw2WB9rBjTmU/0piw==
X-Received: by 2002:a05:6000:2c06:b0:3d6:b35b:1539 with SMTP id ffacd0b85a97d-3d6b35b2241mr7954168f8f.6.1756910248434;
        Wed, 03 Sep 2025 07:37:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4f3e.dip0.t-ipconnect.de. [91.43.79.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8525a94bsm197021425e9.15.2025.09.03.07.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:37:28 -0700 (PDT)
Message-ID: <c861af96-9d44-49cb-9cee-741f133de504@googlemail.com>
Date: Wed, 3 Sep 2025 16:37:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250902131948.154194162@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.09.2025 um 15:18 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
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

