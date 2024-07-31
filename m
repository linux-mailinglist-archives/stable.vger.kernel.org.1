Return-Path: <stable+bounces-64797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B47943604
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 21:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BB31C21CE2
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4C35280;
	Wed, 31 Jul 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aR1x6fcb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D840D51C;
	Wed, 31 Jul 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452655; cv=none; b=UY0raG3iwA1KMIeiNGTgTCELigwMqmz/+ELm2NfnoCe9kUpVKHtnCk4P1bKb12VDKknas74R/Flxz+6OftzA+6kotp8rG6ed6lDYKi9w7KXPZIOPAmVuTYyOcs/uz6dF7qeeaE8XbP4BGZqcMqgQfhNci1NJs8PUl0pxubMOCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452655; c=relaxed/simple;
	bh=+MvyBo2H6Y8yiRyRHf0TiyAD5R2lLXljDQOJRl/ofIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4SqPx5Ezx4/tn8hCaFKczUptkyUWMO7zsqPfqpoFXeOFNumBIp8LvGpolEOlFfH9eK0lXL83EEB/Gb3vh+etLedOGDl3lsPxBI26CzmsC671qsqkpmWUk2JQK+i9VH0MF917reX2uNUB3JZryJKc/TQ58IcCAY/MzBoNUxeSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aR1x6fcb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367990aaef3so3267123f8f.0;
        Wed, 31 Jul 2024 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722452652; x=1723057452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FyhqBwngf/KZmQNhoC+ky+u7X/8DxKtgdDpV78vvEg=;
        b=aR1x6fcbpujIcduNzPWFKQn23PYdU98aW9hWBAu0+x1xt5PcPZYFuN7iKZ0vud61dw
         boS6U7ZmGjNu+DdJMutBjuVKCxLLU8CVTs2Zu7kI3ZuOwnpKXV/JW5sDmjd/Aj8odgtG
         eU+8MOY5HTLicZ4jZk92pAKCpEKKmIghgE5Rx/GM+bjI0IaITEgrNrRCJLeWf/z6PLrV
         Y3kpL5PAYD8JSbLO8joMmHHxnUNL4H3d2bTzhBokT8u/yyAzPgqTExdPPd+NG2wB/AUP
         VABsKKoepZnUYlAZ2lQrAYHZFPVZKwuGtZn2qcQP58jHHh+qxhBtItO1gwQukFjeBy9E
         IMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722452652; x=1723057452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FyhqBwngf/KZmQNhoC+ky+u7X/8DxKtgdDpV78vvEg=;
        b=WI7xhjm1JHSdO5ySz2KyKjqDWm6RlYpdfCPgwly423DdHw3Wq/1pAI/z4DavbKPbkN
         PNit1Ly96sHp7+yR7FYAe/QEozUzJtYGTVE4OhyFv3viaBKs4ibA/uaaWR7MosmYCifu
         JaQhNkMejc8/fMtu4hHCTQRgRBMu1IAJmBH9Q5SzGsnnAidothJ3V8+Qv/uA1lbys7w4
         5zQFmUWBcPmuj530Duk6+lteYjOpicYr+wmNabblzMBsCC5VhSc9X8zBFYNHOc2o45AY
         PINKnI6vUXE3R1mG4IMPMm0sjMQA4lYB46DQ7WQiXlRYTgzd12yrXnRdy5frQgISQHnK
         LVgA==
X-Forwarded-Encrypted: i=1; AJvYcCW78AidCwbVMqMsgvXyxVHlBY3z9eYdaMArNbEEFzA7XyHkwUiVKHSQbSazjoxTcv1Zv+TUqby4mVy4dXJ3FHDDZh9t7GBlerjJc1/+y2MX2vhI4zZVTX24TpjgemxB0davwYr5
X-Gm-Message-State: AOJu0YxgEihRHYySXTVKCJ4zeLayx99WMYpvcgSMe5y5sbdi2pB7uz1S
	Or1akzuzJ58YOdzaalqj3tRkQd5d8akdRNz+9cYbEwG/pAmo6kE=
X-Google-Smtp-Source: AGHT+IH6fw4jG0HDdoJ7Rn8PahT4zwlICFi5K/wz2JahioLHATpdd6agfaaWuGLu6cvYWPHseMgIsA==
X-Received: by 2002:adf:ffd0:0:b0:367:98e6:2a1b with SMTP id ffacd0b85a97d-36baacb623bmr144624f8f.4.1722452651449;
        Wed, 31 Jul 2024 12:04:11 -0700 (PDT)
Received: from [192.168.1.3] (p5b057724.dip0.t-ipconnect.de. [91.5.119.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d66sm17658356f8f.83.2024.07.31.12.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 12:04:11 -0700 (PDT)
Message-ID: <78db8b6e-cbd5-480c-b8af-5ffc3d771199@googlemail.com>
Date: Wed, 31 Jul 2024 21:04:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.07.2024 um 12:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

