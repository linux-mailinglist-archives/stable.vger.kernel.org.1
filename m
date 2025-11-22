Return-Path: <stable+bounces-196596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE6FC7CCE8
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 11:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59EB4E363E
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD52F6577;
	Sat, 22 Nov 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="BlbQaGi5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970327A123
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763808896; cv=none; b=MqLc27+czzsJTs54Xp5ldNQB73APNkeL1t8QAYeVhQjLHAxnZDSW7muSKedIiahSd8gv+Z/84gFVJHXvTByT2AMtdLLqWC8GghFucIupUh+Kw6o8u17PH+epv72VbiyKVN6axYPgyyRBgsE3wH6gzFVZ9Uhd/Nm2xyKUo+6KCrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763808896; c=relaxed/simple;
	bh=jSJpFIcNf5X/MbxjUak3Rvl4RnkPgFKjeLSJpVlanLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhdVgU4ysCal7fLKdYdJVWMiUMd5U4xvx+ZXuxnt4DJ/7O71Kx3naN3ld4LxkLP6lSnbw2gVnw7VJVjDPhZKdljXbT2qASGlxzx9jgwRG/elrf/MaL4v1IIoLE/sMeMrXDI8t8Sbfd16HFWM1eYg43qymgW05tuqNz3s/1D8TME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=BlbQaGi5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b735b7326e5so672127666b.0
        for <stable@vger.kernel.org>; Sat, 22 Nov 2025 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1763808893; x=1764413693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2w0S/MOvnI2vXjST3F/flJWz3cP9paOtxU+i24HDDD8=;
        b=BlbQaGi5eNnrov+z64FVSBL8Gr1PXh2nMMj4/6YP9ywcmdxsRwly+tvikxQSxDUX9U
         k6nOeMOroDCHEE1juyQBLwCgMSaXMSoiTPM6/oBG2N5FZRUFWR8NzCnnn+WYHGi5SDg4
         VGrwtQTiDmerbxAIJsRAgzqH/U72JNuK5ORFTNGBcCLDYfR70XjujVmpK39jVztjG0El
         OTitQG2FJUCIC3A5Ao0c2A5JhVgrmVU1AguK2L0QjOh6iw3ejl9sEM5+G5+4g9rOgxSX
         xShV5BPSWKd9lWbNwrkMFmZXrvHUzVnTn364BwTLkTkErEuqn1vVjQNxk8l5BEyrrt1X
         LHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808893; x=1764413693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w0S/MOvnI2vXjST3F/flJWz3cP9paOtxU+i24HDDD8=;
        b=Z8AUG0Z/oQ4TNZfg0wYpP+8POJUAW+TUVpveoe6tXW48pzMoJK5Xb+Hx0pAqee15zf
         QFFoDjUH2cHhrJfm3N6Mwgn8c1KeMRlhovcEKK7Npvzm7/aW6OoDRaeH4uE+AiGy9vDu
         140foEexfCPbwSV9PtYLXO5rsiPrxdyx6evwdb7PWbiIH1zjv9/uq1Z7b77Dz8AwF9N/
         bP0xkwudeGjuWUoR/cQjFTxsi2wFDVlnymX/izlfrfCONB8AdJRZwMU0tdpgUDu5fgAU
         gDTKPRQIcQ9NAEqcG5XwS6co4lOZyAmKbm+s9QN7HLWLggnHbXOQTdkxjsRsQ51B9oVG
         bKOg==
X-Gm-Message-State: AOJu0YwwIG3hNOaKvw4VpseOnfd7Fze5uf9Z8oW6IXRgWVGCdGDJb8F4
	NNZMS6HLU5p7V3n1cj2nrKUFfxyqg/O5w0cZCCvl4EC+GbviZn6+InEbGDrDPz4CkhXgcoA4LsB
	ifBNaL+1zoM+Ny2PwKIuWx5DRCgdVokXdF2zt8/VHRA==
X-Gm-Gg: ASbGnctDsNI2AmS/0fzWzDI2HPOQV48GruvOmIOxSdOsoANr4VB67qO6SWi8HoqIfBQ
	QBCmwSXlvVLm856cckUB1NReVznLMKNna8/yj9kTD2xMW+9OHZ4WFi2y3SJEcjFudwE/4jCVR7m
	2Tr6Gjg4wIUKVZc+gzMoyFDyqyaWCFWq5GDp2v3SgkREcn27iju7LpXVlqMx2h2pHhUUQPRvdbm
	fzkvjUsMbKcgLcLtD+CPX0ZJ8ou4usVSUc1PV9k2PREnjNWe+VKlFmZ7ODewNy5nUcxdYzt
X-Google-Smtp-Source: AGHT+IHm6iIMqioUj0kqFlWY2aiwSYZq1A96eq18m1j8ysRo9Qxmk/g7XMdsctYFAUYOsEToSaPEpw8IHANRDuuY5Ms=
X-Received: by 2002:a17:906:6a1a:b0:b76:4082:c60f with SMTP id
 a640c23a62f3a-b766ed82cd5mr744694266b.6.1763808892811; Sat, 22 Nov 2025
 02:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121130143.857798067@linuxfoundation.org>
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 22 Nov 2025 16:24:15 +0530
X-Gm-Features: AWmQ_bm6vE4prTrmyAzCnYc90PBxpTlMvUPLkBbW2TNuOADdTmiQIPkEUgt63ow
Message-ID: <CAG=yYw=P4-cWVfQBBdRCK+u7r6KUOz3ZmwrZmSn2vakZXT_hsw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/185] 6.12.59-rc1 review
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

Compiled and booted  6.12.59-rc1+

No new regressions   from dmesg.

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

