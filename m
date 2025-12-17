Return-Path: <stable+bounces-202778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A920CC6C45
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3363096695
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD2C33F39F;
	Wed, 17 Dec 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="gm2XvMt+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329C33F8A4
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962309; cv=none; b=o8120QnzF6LRHGAnAnhBVJktS3MZLpMjzOm4WxOgzhds52r4B0L9dN3CxpvvWFUR+hqt7NvIKXZZFzFeHDaW2vzivm2kNTOiYukfmkSjXDf798kg2g6xjwTE92BJJgw0Uts245Di/bsCb9uvFggSryVUGOBgmvIfaPbKOg6WODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962309; c=relaxed/simple;
	bh=OM4FzyVYJXN7141I+sRVlCwJk02pcxDkeltYzT5wrfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GW4C8V1njnP/78nGeh9P2YO85vdcHtmLE5YSq7MVqYNANc0WWVvM7G1WA3OlWcRzqn0/26cLTrXkcCJpBaFzBfJyQBCdL1GH8Iy22oSN/pKkh+/EiQUIqb7KpiJUBTJWfndcG43iCzz8qjWKHeLmOR6jvLS0vi6qTMlkvXRS8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=gm2XvMt+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79d0a0537bso754431166b.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 01:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765962305; x=1766567105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkVwpIOsWUZvQIJ22N4k/LfmJnYwu2A7xQiSxZ5o6c=;
        b=gm2XvMt+djgLUjQUj74AdesAiWPw8ZDFRqc9LhDWgcL65u64/nXp+9r900NajKD3CZ
         ewgvFVG8w8WQJgyfQPyvzdxUHqaIWLDDQD5t32dRWHgZVZ4yEVE/U/lGdr4McYZq3+M7
         mIW6/P0Puvyk22SbOoFd4+omReRJGVBAyTra03W5ppn3QlsNduMyuXC0dA/A//y0gZkT
         FV2SObNh+2ehWFAmVKDHgH63Fsm07TOmAHqkWVY0BSpJC/sYeRUtRgvb0dSQBDOqkku5
         HsqthWaxMt7ZrCJKuJ+2Qscc4pJwQMkk4akkmkcq5OFy3VgnZ3ZHgB6duSOksNA7ri9q
         SQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765962305; x=1766567105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMkVwpIOsWUZvQIJ22N4k/LfmJnYwu2A7xQiSxZ5o6c=;
        b=qw9a2Pjsh4WM9vIlSHankYXPOqLI4WRE6DK0arj0dYBMqWT+IqV4ktgN4qmVCNz/UE
         fZ3Eg2F+armZYHRoyMWkiFk0gdJOS1FEA2b1XdFgn0LXhtY7kDphjC2LH5hlvxJtNmvD
         pCCF0wQn0WE+vk/CO95EVIAGd91lKWSj/nO4E/aie+K5HHZdeKn2jZXl3auMDxK3w8dD
         TV9xRIgY/c/edYV1ixOLzlyPJnhyRl4M5lus1+QxphRqCA1Wz18Cpi11/w1/i85p3LFC
         15AtOOsIliyRum258gTc70ACiPeBz7ynhMIwowMxusC2dY4vzFx/xrkF7ylSo/S3BBhy
         N6vA==
X-Gm-Message-State: AOJu0YylVh8rqzvvOWOkA5KNpGZ1Gg9mpOh/OMY4+oBC5rSRMvojmHot
	wqpQ9lBTxKIpIMP4iLJZGFarDy9DG2CeI06E/+0H7sgN+/8ne2Gy4c8EUj80TUGPUV8mjnbX/Ka
	NLbzlupSd34ZEOlvWPduJbSwyH3YG8ycx8jG0Mo3AgA==
X-Gm-Gg: AY/fxX62ijxnWvmEqfNhd038UYM13+1ewm4R8UjktQyWSI82CTE9+gi/xpf58cjlHQh
	m8aPsS26UC153wqt3yJzgasB3761PIqdPNRBifh0JHv4C9AbsEIcbFuAYtYH6rLlvYbCbF6inqk
	AvU3GiEmbUGMCEy1SpHPvzBSZjJ0ilMJm23UF+pDuwikbdyymdrZwy3fBFD7/M7RAsbpHqOJbpC
	r6qgkTL68WC87fJa07eChAb6tffEt1PPSZjnXDNZurJBfKWDOibe/lf0yen5QpzgHTbOlA=
X-Google-Smtp-Source: AGHT+IHtMkc38VLU8hjjpSM7ejcsH5D0kgVDjWS6P1V7a+lKrYAhAMrBiY21QennLuHiErrmDl/2K9v41bemwj5tthk=
X-Received: by 2002:a17:907:3d93:b0:b79:f753:68fb with SMTP id
 a640c23a62f3a-b7d235c7f02mr1960617066b.4.1765962305265; Wed, 17 Dec 2025
 01:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216111320.896758933@linuxfoundation.org>
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 17 Dec 2025 14:34:28 +0530
X-Gm-Features: AQt7F2p2uIrAAXFtmq52ONtkGaO7LLartmy4enH8lnaPNuRu7W1luKiciP3JYJc
Message-ID: <CAG=yYwm4Q_q3ZzAUg639Tb5Ruuyo97Byq8iw+by02Bms_jUAUQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/354] 6.12.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 hello

Compiled and booted  6.12.63-rc1+

No  typical new regressions   from dmesg.

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

