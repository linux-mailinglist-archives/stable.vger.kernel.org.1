Return-Path: <stable+bounces-177627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B4B422B6
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D87C5B2E
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840C30EF6E;
	Wed,  3 Sep 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LPHOKILB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6F30EF6D;
	Wed,  3 Sep 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907890; cv=none; b=R+dMpckGXIellJYOf3/Mi7F3+lBOmvh0XiR2tfrmvTyR+sFQtIvPtOxPL7ZmGJrsQOrSSCrsgwFHN5C6CrlWKTUJRpFUxExDPkcf/6dMPPwJWMWEGoyDeQ8W++7AalQnP2RvfpTfNsYj6UZuYKkh3jCQOH+H4OipNYMzGfUsGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907890; c=relaxed/simple;
	bh=qmI9uCirdKxPoEeerlkveAtQlZ30H8oH9WlpS31AYVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gz3qWaWYuSZjx1tS63HMki/mnlUXpPlXDRbHTEQ2mf2Pb7eme0aLaUZxNPUmfXkSN9tvNqCHn8R7OgCOqPIsaSOb/rBwmhcd917vCVZwmTxzOnADu4p0LHpZafihu3yvcsg3wG390w3tsOo5gexUdKayGtyZFXP3HbSfnD26EWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LPHOKILB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so3176026f8f.2;
        Wed, 03 Sep 2025 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756907887; x=1757512687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrqJd5FD6WGRiM2Koxprb9+2r6q/3m46cDuQvGJCImg=;
        b=LPHOKILBRCU7mFQPtDlegXKs0VkkshcJegy9JWtkE5dpPMRkI2eD3VRcTiesPMEN00
         1LKrNPdWF66VYD8aukx0P4Pl9elPRWuecEFJAZeptcBmTlx8sluwuO7bz+yzHkTGM4Ma
         wNnooXUtfNnwUiOEryt9swWHxuesTWXFReGr8lrQS4hpVXh2dBOcdpCRyh2KkKJHFemM
         fdbh9OyHXDn6SI23J9AIIQB+W5hv1TQZwnZoEz0Y+lEXh0DAycfEgQGdkYLGvwnSg7TK
         DPVRRVafekdRIe/UG4+VuPykfrYlGIMPqBjXuNQ4/2IQ7FhDC3Hr3Ja+iVDSFyh1DRHL
         K6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907887; x=1757512687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrqJd5FD6WGRiM2Koxprb9+2r6q/3m46cDuQvGJCImg=;
        b=Z+l+Rv55eWkqpcjR6RyCLm2P7PJD1KHXlmhg47s6b7kndxreHRUifzqlKiMwji3Xer
         eDmg2OfBpGouJ6XTxTdoJpu0AspJuNVJYSPDHt/uSgUNAyRC/mH4G6xkq6kT4rAlMkUW
         AO9r8BL/3A2d/Wiyi+J+CgY0PRUDKVAHoS080qUtWzpwE6OXwZ31srPizVyuMj9w3a3d
         pvBdb0Y1m2ZQ325p3u2Ly/CAbAhxhdNEu3A1TqeEdkoQ8Ub79C8gUNA7VTwcVxNUYdxx
         U036vy/V2fa+0SDYKifjUmo/a5HPDR+HqYKpBH0ItDzTBYGJeYYqtP5he8il0M0LDS4Q
         SmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnjJJRwTh1lUu68r2sFCysa+QQiB4Gy4+q55mItcWH1lqOSt98kTwKBnEBzRlT9EgbCgAmw2g6@vger.kernel.org, AJvYcCW3covaXHvLc9Grp7L4BH9ztf/BGsnMggeIcO2r/KE/r85PdstvDBnkHB0h8BcVr93UtMLjMY+RLCMH+oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQiUJDHNPsHz+PHMMDwQh8exDtZrpjqb93QucK+I5UM+h58L5t
	u3Ep3D9xUaPOd9UR/UzYH08jF5oo4NX5LODtRWTUnuaR9w01baqVve4=
X-Gm-Gg: ASbGncsXUjaNFgDGqVYAZOIixGcRew2ookck/vZ9GpttJCBhsk/AOS/46kXmBsiLYhg
	g7F3WsSvSvwDsk2R3Z9kJ+F//Tk7jCUYm6AmKb78NYLOwqj7Tslq/gKbApulFH4gFrZ+EefKVDF
	2iUbTLBjnWqwcVvyPHB5+sor6F8pfkersJttLl7bmoLjUAi7g9ceCSEbkwD9R5F/CaI5gv8yYSv
	p6H7SjYZFxqe3gm6KxrtIROEa/vIbGljptq7PmudCBFyDoTHCY9j2TIbqVrvhfVRhmmfuQ1Psfm
	Tmnv7jmU0dWs9Ae2ZbaxfeB4Zy+yV6mO4te8ofR/qD1cyfGuXSMTkcnDtlqRb9DrRTw0O19BZ5G
	l8s/ojB8RVmPyQ4te86WkmcE4RHcMKizlPNnVyFDZk+Hk9iEQPrflZx2sopbr36CKE7rkTI48sC
	gmxjBAfu27Cva/S/HV5jI=
X-Google-Smtp-Source: AGHT+IEkQUc3AXEWirxMtaQehRuguWIkLYzGzZnyPoMRvYn4CXlpE1GuGBvel+XZFzm2O36gCn8Gqg==
X-Received: by 2002:a05:6000:288b:b0:3b7:96e8:7596 with SMTP id ffacd0b85a97d-3d1e05b9583mr9467583f8f.57.1756907887009;
        Wed, 03 Sep 2025 06:58:07 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4f3e.dip0.t-ipconnect.de. [91.43.79.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67esm23797305f8f.62.2025.09.03.06.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:58:06 -0700 (PDT)
Message-ID: <7d5a9c50-66d1-4e54-a4b5-ba857c1fd6be@googlemail.com>
Date: Wed, 3 Sep 2025 15:58:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250902131939.601201881@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.09.2025 um 15:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.45 release.
> There are 95 patches in this series, all will be posted as a response
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

