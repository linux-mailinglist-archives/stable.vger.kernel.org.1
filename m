Return-Path: <stable+bounces-178839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD24DB482D8
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A32A3BDE0F
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7331FF1B5;
	Mon,  8 Sep 2025 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dKXs3krf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809767263E;
	Mon,  8 Sep 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757301998; cv=none; b=Mt1gwYtQtqs6RKaaOfY8tgacku1MsSTUKlJnxmtdVRxWrACabP0/jOiM2dZW5d1FtQnDcgzVuLMZKtPg0qDjnu0GN0Y+eFlp5RfZrrbd+7wnl5wvbfZ4I3x8Hfoc+NlfX1I2U6DSJnUBvtpqe+nf+LaxYJsRL0gnInigsIipqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757301998; c=relaxed/simple;
	bh=ByjzLQXiYPNXKjji1s2Sn9MG9KZE6Tan2hisqLYhZPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+kpqw/jt3wv5PW7QaBLFNBLNT6QHqAmkbxNGPyHf3kqYCu8I9el8KC/Qs1JK3Mm1QY/f55mOlBJyoUYuVysFqZr1+V42dxZmg0Y/lIQm7O82WXpMJwFPi2H+0C2in/VPHG9WX6igfoy7bimw12RDUhSgea77FOSBT+8/hH2z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dKXs3krf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so24040645e9.0;
        Sun, 07 Sep 2025 20:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757301995; x=1757906795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vq9kDo5Q0wIIZAFC//gNl8BJGYIetExuqEtz7zXz4Uo=;
        b=dKXs3krfZdfgPmVdMOt4PvVGGGL+yi0H+OIxB40JbLTYzotcbXZOs/4fte/EoWpXAV
         VHBBlQ9b405pyx1mmBNMG2JV+GFBc2Zyjl/+RznN6CvabgeHYtgajICOXKFY1KfCETuZ
         XcroQy36wxQK5f8cae1/QnFvV8VaNNji+l7Bdq+qbZQTjTCQ3LSw5x1G0EoT1SJaWAxS
         vRtIJDF5I2xzh2KfkhJQrxvodhfFjoVtUprZLQ+zitNIThoyTMefeq1K/WfGfNOV44OD
         ohoOqUCXXw245IhqWOv71WqghCkciGn1NsMKElo8JKG3Yk4aonmZ9kNNiBu5AF2qpLMC
         G9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757301995; x=1757906795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq9kDo5Q0wIIZAFC//gNl8BJGYIetExuqEtz7zXz4Uo=;
        b=b8OJGyS+SrPFi69TtzY8z3FZRZh7J7aX+xPGR2zffTxkzzOqUwPlHvSIDe55S3J1RN
         cIFy/NG1zRKKAkskfNJ63TcM2SR8weyvp9PUGm4TfgFjYRc97b+n0BwJU5WqBen487cf
         sEWT3PeXjD+wpOFpmloYxGX32c/vMIXoeyyWd9QGEsrkeZty1e7SbZmW2uQ+21aAz66Y
         TWZC0s6zRllTv9eFQ+Gf1imcfgLRRO81/dngyp5/CKsO/o9dSf5M0SkEPWrxUOt4CMn2
         TKJYUdGMYOJwU1VKSvW6E/KqkqVFMf5VYoE1BM7p93kdFfrlJY277lgJ+dzbEZt5AREm
         GkBg==
X-Forwarded-Encrypted: i=1; AJvYcCUExPhSKdQmZOH96Y9O6qzCt0Tv/n50KoV0FR6t4maxB5ZB85B/tbcvIq3qrlAFGWOH6W2LOCxtgxwTsA4=@vger.kernel.org, AJvYcCWEtWc4dCM96HoemIW1V2I6vYatqw0sh7biyI7oEn0EvmAwS66seFy3OKWPub2eZlAjTn81VKe9@vger.kernel.org
X-Gm-Message-State: AOJu0YwCF1ZcDKdG4GD60vyZbkg2gWslHJ788kFipczigRxqRjOuigDM
	yec23binHmYcnPLtdu9MHz7LYFdvDbIgmVE+/S8wT/hIVrQoSCONIZ4=
X-Gm-Gg: ASbGncte0Pq/aLlEELV+R6M7wCqKp1KXP1GS/dZRls2FBaREyCw9ebV7nBYy0qv4siy
	4Fe9vHIumQPFO1pJH4pRgfJDUGz/jjZLCMdAcxXuD8uaIBObo7oAwiR5Rq0sdjR7GZE4lnkRnt4
	+EImxAg9ZSoS3kSioXwj048nBYFsMKzUKdz627O7DUM9TlEkBShSMIiDwQSeUkPLJXP8GdRdx/x
	I6ku1htoXf444Q4CocaiRHP9ijVVlRRrrnZIKVl8/P92YxBxF/Y3hOmndjzeID72y49SI1cVjcM
	R//81NO/uah20Tu+vySZKP3618EO0YPhY8xgpRzQa1dhKwTQszs4lL6tPwXbvXrQ+gB/ZUoQdwC
	Auv7wpV2cSAC3Xm0xLeFe7UAU1GZ5M1Q4vofLUWG9d4NnFedKqpE+hFPk33VFN9/tFiresQgfmy
	M=
X-Google-Smtp-Source: AGHT+IFXIlAzm9Ac9sCoOgyvXFAwKtI8c3a0y9eO/X1DM92geFk4PKCSd6v7ZtQssJzwKpmOujdhRQ==
X-Received: by 2002:a05:600c:1d26:b0:459:e466:1bec with SMTP id 5b1f17b1804b1-45dddea5fc3mr42424155e9.2.1757301994591;
        Sun, 07 Sep 2025 20:26:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac262.dip0.t-ipconnect.de. [91.42.194.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e70d463163sm6550989f8f.22.2025.09.07.20.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 20:26:34 -0700 (PDT)
Message-ID: <b5dd3856-6b39-4599-8720-99554f69b40f@googlemail.com>
Date: Mon, 8 Sep 2025 05:26:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/104] 6.1.151-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250907195607.664912704@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250907195607.664912704@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.09.2025 um 21:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.151 release.
> There are 104 patches in this series, all will be posted as a response
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

