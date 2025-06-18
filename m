Return-Path: <stable+bounces-154634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA4ADE3CE
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9203A9D7E
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A2A20B1F4;
	Wed, 18 Jun 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lddQ3fPl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4A1EEA40;
	Wed, 18 Jun 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228753; cv=none; b=I2QKG7MIiS5J1ymRvYp6svH7VXi7wDLofKz2g6YqEofP2KbP6VaErzxN6nYAyBZ86Hit+ryKLdrW5lrTMu9Q2ZIKV9Cj/QJzEJgJN8+v/cj3tNDJuyo4sNr1/fK9iH4kfNmtq7cmzzb+bawfCTityW/4CN6vTNj1Msa4fYw136A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228753; c=relaxed/simple;
	bh=yLKXkq2hWzm+CDK8b1OfCGIFmkTLFTnZu6jQ9olvnQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhqqRmeYZ41uGmypjAuO4VHVYc+n6l8QBdYkfdp9ePX87FfeSvzqqjRZAy8y9qlHs/NPCy9q+jPlAY9MC6osxQsN5MnsCKi+nbdamFIf1BvYy38Fo+lov8KFT6N/smGYRRng14u23Folz/iw2GvZn2lZpO6W2QrB4uA6+TFzgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lddQ3fPl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d3f72391so72854595e9.3;
        Tue, 17 Jun 2025 23:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750228750; x=1750833550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZvA7RNXYnHWimVMEH3iW3e9Ck0yo+qhfNRcio2uxRM=;
        b=lddQ3fPlE6Arg9YTRqNnq+UUO43AN6tenD6BoHPdGMSgYZRyTiup0zyiGrIUjr5bmB
         8fyzggLTi52/3NxSHS14fx6wkCCldQ+pbz4VYd39kn3AtjLY0VInlMQUl6H4W2Xm6b4c
         0JMnfvTC6CcDWSxcKxqgFTgoQRNuRSRuMTJJj3FthxdzQrlV0viJTe080Y0xbNZNMteS
         aC/vk92IsnwXSPpQ6RJccWJhqGeGAFBVU86Gh1LtSzzwxF5JzQreWMC7HQvDARR6d9Nu
         kNi+TROpCfUfmrn8e+dH4vHKbcepvs2w88Jj8MOWgQIgoiTvlhGbREF/ek0X4URtV5Pa
         yIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750228750; x=1750833550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZvA7RNXYnHWimVMEH3iW3e9Ck0yo+qhfNRcio2uxRM=;
        b=d41SlpZmiwVXvxoqrXQCzehDx2DnJkY/GNA9j2yqfo8XVzdOfsvbP+OYhxVIpzwVeL
         LRo3xuW4DEWhs7M08R/vhVc861Crsi8sDhYhVrRZEkvg9epwO8Mno6D2HmvNLHC/Y4kL
         wytiepgfSanYWCHA2dt0NkBOnlcLs1vL+AViH4CSuFfmOPxvZAaUlPA9kjD+RfbBcnt8
         OtPAUOllfFOIvQYbLFKz9hztTUDiMWi1ekB6+PbR1Dj6MgdyDA3myP77Q84GgX0HDFGK
         VITN+t3vtfb88iKqaN0DaYeRABKbC34//7C6Z9kCC8LGHHYESq3n0DgWyAZX7tLpHGi1
         lV+A==
X-Forwarded-Encrypted: i=1; AJvYcCVX5MtT5yTzHe3rWLgsW/FzFfb2MJF7Yz3LGJbrA3rYmLhjFxY6hnfmBSYPQ+N9QhlscqCBWlHDS6guyOY=@vger.kernel.org, AJvYcCXCuyTnFdjl0ta1v2jqUBUsXQGr8lVwSdMGtJv49zrAeV9zkCVLD+zRvvzAydypgN0RnI1dxLYK@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWYPSehqR1CSTfEFyvLh6ki0JFJoNNir+UuhxbWCFvLWNnyYb
	M0X8JNATPh2pUqAvcNTRLviUFhwOWc9gC9MbdEGoNqQCCJLnefpTUVc=
X-Gm-Gg: ASbGncu3sgROy5Q0PhWL3QgNS5FCCzJ49x/dU3t/umgTsgXxKYD31dEvA/QDIpmF9je
	ZKTn2tTldzeRTh5qk2s6OhI/mNM11y5fYtx2CL8fUpgB1lFxqy8e/qdstZ9uuhF8SkSicpl0ykP
	7BPsmR0U94syfK37PlFYz98agUnHJc7hgQ9v26FRwau+Ut9pp4xqLeCZ9umi2chNdqSY07n6ooW
	xxfjuvUroLYAhR86s/VnQOyH0eLP9iLxWzNz3jfv+hLGx3VO1k6j8qhlq2/SjDIghutlz3+ULrj
	xWdCMO4pm9DyvxbkR2fY3zLj7jp7+vlmAXA7J/kq1B0sd1KmHz5MT6MIT+jeSeHgitunG0Nb+fh
	Mp/xLQ+Y0A5N8uB9FwOJO/3NYtVf7IrTMtHlmlw==
X-Google-Smtp-Source: AGHT+IHEtfg3IB7HB1Qx7tkzhra4fFOSKPEVHYVs49aCIYi4XUVNknTwWAyV+lGHTwurGsG/s/RK4g==
X-Received: by 2002:a05:600c:6211:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-4533cab86f3mr152258125e9.18.1750228750144;
        Tue, 17 Jun 2025 23:39:10 -0700 (PDT)
Received: from [192.168.1.3] (p5b057357.dip0.t-ipconnect.de. [91.5.115.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1cc5sm201907855e9.16.2025.06.17.23.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 23:39:09 -0700 (PDT)
Message-ID: <22e04ad1-2267-4dea-98c3-6fac1a4edd84@googlemail.com>
Date: Wed, 18 Jun 2025 08:39:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/512] 6.12.34-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250617152419.512865572@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.06.2025 um 17:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.34 release.
> There are 512 patches in this series, all will be posted as a response
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

