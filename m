Return-Path: <stable+bounces-60421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AC6933B44
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819E51C211E5
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E717E917;
	Wed, 17 Jul 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WjqAL6NF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555C14AD20;
	Wed, 17 Jul 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212832; cv=none; b=qNbPGJY8a7YBros4MUOVB7RvGpxqsElxrWIbXh0sy+tRzjHgayxWVjspI3irHj16nWOR9wLMgU+NgsEAFuh2qBStnIrOBGcrsIw/8IME3xe8MyLwJLemB3t/0Ds1BcbV/ZsbeyFuGXMQCJSwjYM6xHeNnJsW3ZKzIDtQV9qfGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212832; c=relaxed/simple;
	bh=nLG7HzQccjTqp4Lu9GgprSBfB6cJU6QMPbFU6J7wqV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLcH8Zqkinx54Y1G16mjOaZ0aC848VwWxZW6wSpGpqleaF9ibI8hSHYcSdHfKFKghV3kPMhPMS6qcpQiq2KzHUs2qyADkDRLS0ncgV4gDo75jnL9WiYselfyHblUaBRiOnXIVaO9Pj+gclkql3/r5cMCJdWvI3E24ebQjyWCDPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WjqAL6NF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a083ba04e7so576694a12.1;
        Wed, 17 Jul 2024 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721212829; x=1721817629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeiA4+yCeVCI23SPrGp8AYyUosGnfCOYmYJM+U4xtYs=;
        b=WjqAL6NFo/+k5WXs3HENfMMVwX2vT8y3hTROn2h8IJW5wp4En0/gMfqeR9JH9v2SAy
         PrpJ6vBvIozuJ3PGfjOsN496zRvCG1O8LIo4eNqeCxelMKmMZLfjBJSPR9REXG8RlPIk
         Q/8JZyPr5Ugrz+N5nqjmlOEKXRG58Zve4CSMFVCxf8oFtVfcrjco/ybhru7OxLx8tpTx
         7eYGUL2zcpO2iViDJJmB+g7pglp3pT9vl8Y0WjkSYKvSbKGJXo8KdX32PLss47iPfgAl
         cpzzBAzIVHnl/TyAGD0Rubdr1oziUVoezV7Cbhk/OvhvH5ZBTN4eNMdN8Z+oEeVKBCF+
         r/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721212829; x=1721817629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeiA4+yCeVCI23SPrGp8AYyUosGnfCOYmYJM+U4xtYs=;
        b=dIPWSAa2oNtSw87KethI+4NQWfhMVnT5DqGW8+yuWZa8ikeqk3O+rFGIfCvjJ0VT0p
         BruO/6sX/Rsr+a5OfU+JYI+wi5KSS/+/9MS2nGIFmnNoxQFF1JYLpVFgR5mcRcD27I84
         uAIHEmXp+Popm383V0QpEu4MG8tbujMl3FgkDFu2bfH5h5FMFPsm0p+tsLrw50g6sEmD
         W4et6OS2faIvod4kcRNioETR5ydCkm+o3mTovOZiuAyIj2uLom7/7Gai0K9fcIBidh21
         PGyVLWmj+AcGioVnSdZmcpQSyVyY9Fv96cpByV8E/7Ts1cJ0llvlRUe7PWOGn5fUUhPY
         Pd6g==
X-Forwarded-Encrypted: i=1; AJvYcCWcbwhEfSYbJuAwkrwXdzXYDZg24UD5q+yhfFecnRP3lC/DSFbNzOVwinz5KUJza23V1WAjdZ/FFc6nzxz2hXTeDBGUPaNT8mAK9NnzW7xTMtcZJ//6gOCxwD31ePwwuayYDYv+
X-Gm-Message-State: AOJu0YwnhH/fOrwunh3ilryqXVDqEpiGXq7WKOEViuR6w6EifGwgqNl3
	yb4/wqlA716iFC7QQReCVMsQVQBVxUO+gosnbNQ220c0hzD8aaA=
X-Google-Smtp-Source: AGHT+IGPRYWY84cF4GKQ2fo+yH21EEObN21ZhtKUWYglYPTJwNess4mMJnLwjb5N0xFC6XWB6hbAVQ==
X-Received: by 2002:a50:8750:0:b0:57c:b82e:884b with SMTP id 4fb4d7f45d1cf-5a06a475fc4mr1217233a12.19.1721212828702;
        Wed, 17 Jul 2024 03:40:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b0576fa.dip0.t-ipconnect.de. [91.5.118.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a77114sm6820425a12.6.2024.07.17.03.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 03:40:28 -0700 (PDT)
Message-ID: <eaa61714-6326-435c-9786-08884bfd1d51@googlemail.com>
Date: Wed, 17 Jul 2024 12:40:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/122] 6.6.41-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063802.663310305@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240717063802.663310305@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.07.2024 um 08:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 122 patches in this series, all will be posted as a response
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

