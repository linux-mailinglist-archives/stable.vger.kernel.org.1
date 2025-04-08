Return-Path: <stable+bounces-131855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F1A817BA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880A74671D1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC381DA60F;
	Tue,  8 Apr 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JnESaUbr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB71CAA79;
	Tue,  8 Apr 2025 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744148495; cv=none; b=R8/85jchhr4xtfR3omwk71jHdsEQNZrmBM7iroCieA1tbpgKcA0uQj8ktEwW3j+fKpaZSh70CgoTwVZAHBsZEnJlbnzG9T/+dS1uIus00+KySVV0xitC+yxcP+7J1qd9+7RuPVX8lfscRXxvaV466HmbecGyUdCtbUkPN/eKunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744148495; c=relaxed/simple;
	bh=2/x7nB9FcPK/2dOBsaqrgTy2A/Pwt6KSdCUdypvBcHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltF0I8+Jrl/Q521I7vGbz3kPZIJoHBsIb9VVElQTwElJ6EANdlA1bNE+FZrSOaj+PZkSBIsG4koIVk1/8D0fDwqJmycjAUsqMlJprufziWjkHdc02bhTOLbT232plgkapr6nuM1npEIN3//NVxzChDTzPAqvKsvCK2sehGuVzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JnESaUbr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so5255504f8f.3;
        Tue, 08 Apr 2025 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744148492; x=1744753292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jujl/3M0d7wSLPXvj2IiLotnILIlcQaO5JF5yueWAPQ=;
        b=JnESaUbrGPROuLbyaMJBcmDFwqrRD5+Q8/TahfkqpxGMQTfqT0XP8r5Z1gO7S8FBeF
         ajT0AW7mdTA35KY8HaaUlbeiJWX/zDvNSofJM5U+DI8OrB2rscSJdwpCs9enUDV1XP4q
         G/kpqFCBArKh/Uitzo5lv1/VqGx42FJpHTR5oJhJRAxZpSU3aZYiMOz9egvOcLL2+EZ3
         VXWZgBK81/jxPuNzhYq8UE86yCUHEBqk5pP77KVb3+PKr7x6405xTR5FvBxxWSKJO6Gw
         UtE/ORiXCNWCqBI0xZ+henVmBDXIBlHrWQW0kknfP8dgYTLaHu9epYw03CWPY8G3FLzZ
         lfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744148492; x=1744753292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jujl/3M0d7wSLPXvj2IiLotnILIlcQaO5JF5yueWAPQ=;
        b=w+4ZfOlaW4NcL84+NnLDMg4vOC0x+XafO0GzOby/TH03GFcj/wHuZmgts/BzWNYvCj
         1yAPNYbLOyfywz59dtnOIPyIFAJoU1e++jdmrA99ULzOn17vZTlyB1ifrlbE60VLISV0
         k//Yr6bin1kDFk3NCNYhVPHXddDasqeAycj3e//5kCvvl9narQY6KO3Rj01OzvuWc8xy
         8t29GvTsvidmcDmqyg8pBzcYwH9Cn1tmtEtZinKa8u4IZ0SdJwFhtNyhAx/CYb3ouTqQ
         h/VR7l1bMaJfpXU0kGEFOILtJTEsbIIldx3oL2Sn0npnD6NiCON6loeHDg7aXcDBizZM
         Chfw==
X-Forwarded-Encrypted: i=1; AJvYcCVxHnoIfKEHOcv2gDVvE0VqCebUVXAZ+4F1mrjEmfjOV1J1IwzKqRfY4InEGBauGXy3tOgNVVRc08N6nIE=@vger.kernel.org, AJvYcCXQ9vUCcSPttMbLsO84VFmeRMA4Ymx6ioNJ1ut89j2v4W3XZg9CPtTLFlWXvIFJzsMT1n1zKuwa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0T4I1z4xok4E3SYcD6AyvhDOYZCnrB7mQARayfkoUk/NK/nQ
	mHXVbnwdDmanHsK6gBbyfZhlkcTxbH/Jl8O/yGLhihslGhimdWs=
X-Gm-Gg: ASbGncuy2DejgYLfk9ZdEKwyb+RbFQs/VfASOTku5nY54rnmFRl9IfGn7xxx0xKjQJM
	khOFWccEFKc0RSjvhLYty+V01JQdLA61SFl8gijpw8xC7ossSB0FrCY+H/V6Nzpi0FwXQ6qNW7u
	cScLYq3fn9TBECJYceasW3JatVoQKAGaI2iQg7I0Ezm0IoLeiwQgFeHC6mcjZ7+fIny0CHNvEwN
	YvaUEe87JmrLZ5u7Y+vnOWcSgPJQmIi5GQQRalhsXQiTarc3xaesZgZV8O/7/SOJvL0sW/yzmt4
	Qy1IssoMA/c7AEE8atCosP/M0057jgSsWgU8uyk1rMTNvTsuSGXFwN9wHWtrFGJ2BLUIgarbtg4
	iukGcMPoxd1Ue+ZC3unH8jA==
X-Google-Smtp-Source: AGHT+IEkH0kKV4n5A4/YEBKlji9xy9QOjToqAkLTDV4gJBsJfkJ9CHmu96vZtemcSy34BPbUEz1PwQ==
X-Received: by 2002:a5d:5f46:0:b0:39c:13fd:e50e with SMTP id ffacd0b85a97d-39d87aa55ccmr559130f8f.10.1744148492212;
        Tue, 08 Apr 2025 14:41:32 -0700 (PDT)
Received: from [192.168.1.3] (p5b057de8.dip0.t-ipconnect.de. [91.5.125.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b69c4sm15865791f8f.43.2025.04.08.14.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 14:41:30 -0700 (PDT)
Message-ID: <c29e00b4-dd67-49cc-8e46-da7161ab6773@googlemail.com>
Date: Tue, 8 Apr 2025 23:41:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/268] 6.6.87-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104828.499967190@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.04.2025 um 12:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.87 release.
> There are 268 patches in this series, all will be posted as a response
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

