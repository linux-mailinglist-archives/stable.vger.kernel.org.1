Return-Path: <stable+bounces-55771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE17916A16
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799B5284C5A
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2556016A95B;
	Tue, 25 Jun 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S9jtBhjS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD9158861;
	Tue, 25 Jun 2024 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325089; cv=none; b=ezBTI361jytX5BF/T1WF1/Ql3VW22qvDtjswYsiDKNSDErw76/PLkwRB1/vFlltlzSoAWASv8y7uyvsUBjxQCDFhXiB//Y3nDagW3CY2R+dsE7q71W/oh4QI8MR0w4Ncr+q7ZCXxspc/YEXyZK63gganYLTteiYPdo+hZuf80fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325089; c=relaxed/simple;
	bh=BaYfxqnOObdNpzn2swt4a13d8uBre3Ho9RtZd1PZMnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5cCNp085TZrmKRTw5vo32mHxehrYL3etLjQX89G2A5OqIpzjI1px7hDo6QXI7Vj4YXOjKFAkttAqMmujx1hAEbZaccHwCpNRnM5FqqWc8PATkWxSXpntPMPGEBuulZ4F5tbXuyaigOZpsQ5VoBtJjCMd3mNDmwMPJoi1Z41HIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S9jtBhjS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec50d4e47bso41902001fa.2;
        Tue, 25 Jun 2024 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719325086; x=1719929886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ORvOd9QIO0A27sD0yjzAJaWM3oVFw7Nj8mJgN4e+RI=;
        b=S9jtBhjS0+v14plPKwxa3JgazpdfPYZNueUWFtGoYrr/Apa88ZfluQRAsSmvas39h8
         ko6ZsgbFhS8aUw8vSH6orZROFhFn7EHb0lGhv3Im06QVD4u8ohwiQWp51sH0mwA9w1oK
         CCr1pEj5W2iWTBdIAia41Izl7TK7npjAWfK3ZtdgsczNkM1Oh2Mjad6IoLK6bOCAfjgc
         qw1KYnPk7CM0bnybEbc8OVNN4QGMtKKqkDsZXptBap555XdQWW2hfh3+aHVjPgPKVe6F
         6okM7R5mApdg2ecM3ygcgVkhfidlesgEhKLvgSOGrC9yFcJlAwFEqhSRa+DzOogNzYTi
         seBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325086; x=1719929886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ORvOd9QIO0A27sD0yjzAJaWM3oVFw7Nj8mJgN4e+RI=;
        b=YqOucRFnoxCt1pJAF6eoRMyhkB2meYGDMVH1+f9h9bl6GhWpUyFXv43iKH7SK6YTaH
         W3dqptqLBwWRpqI+lOIxrGKjqZcNk7fhclsGUlLSd4kQxclHtkTOg56RBguHXiANT/4c
         /buKEwc4SN5aREhXHjsf0VvLjb2DlzyvYRQFd3iGrA67KqpdWT/2mP1XIuYsGN2Ljc1L
         03djoVt21sWLs5m1xGtDPVJUTHztt0RR3wbMOV6ihM5c7/Gw9Z9XIWpb4jJMhpYUzCdQ
         YNWSN/XqJMxAEE1PZMxzuoYNKN/DaZaiNK6MO1yevDRscKWvmje2c/8hhvPfWL08K+tx
         vo7A==
X-Forwarded-Encrypted: i=1; AJvYcCWDa+Her12Y8ptrLuvaR41FTEO7bA9mV2niOWzMUyag7LmIsy9BX3qyr1FbP4uS2eqgH5mKkoEI28hslKiYHILjEs2w8EmGHPYn5eQIxtHVjAvWV8800bHrDcnC2bmD5k137bwS
X-Gm-Message-State: AOJu0Yzhj98E9kJyf7qWY/NCrA40Q4BG2rPuhhMH47bn/NMW7HUnT8FE
	vszMAGWAp/6/MaA0n8XB/+E8QaLguIJcvK9b/9VOa6/M9x/yRGY=
X-Google-Smtp-Source: AGHT+IGmK41bcBWbwZqPaNcNgMM9gGnHoWpBcPBIBZOXSb2Ippp2x4oNHo1MwNsemFX0W8yC03jJUQ==
X-Received: by 2002:a2e:9d88:0:b0:2ea:7e50:6c94 with SMTP id 38308e7fff4ca-2ec5b27e7f9mr48469431fa.16.1719325086080;
        Tue, 25 Jun 2024 07:18:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4a32.dip0.t-ipconnect.de. [91.43.74.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30427976sm5979314a12.33.2024.06.25.07.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 07:18:05 -0700 (PDT)
Message-ID: <f09ccc14-fa33-4887-a443-669d8e50242a@googlemail.com>
Date: Tue, 25 Jun 2024 16:18:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 000/250] 6.9.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240625085548.033507125@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.06.2024 um 11:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.7 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works fine w/o regressions on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. 
Up and running and compiling 6.1.96-rc1 under it now...

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

