Return-Path: <stable+bounces-207953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F9D0D472
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 11:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4141B300EDFF
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054E92FBDFF;
	Sat, 10 Jan 2026 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="1vnOLFBu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B002F90C4
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768039506; cv=none; b=RZcJtblvBDodjOQXMS/kHCmu8jDJx81jwEU4IPUOQKYY46lxh54dhhJIitFwxRA4i+wnMQQsFb+4Q/RTiaWoAEWvhbkJsAwzGUk1ZpjkvF2Wax/xVPL9RUmUXQNliQ7qr4qHUKkXsEa8L9HgsgfpkXkP3cxsa9sIYjbZbzhXSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768039506; c=relaxed/simple;
	bh=porvaBAkKdZCiyHP002qAS6ujzfbEMWqze1LBTMYLhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF8HtpEuvvDEpTWzvLk5k010niY0jD62bsfb2DjBDYn3A8sutd2KmLYmOrCIhE4x/a0i5eFo93wamBgXHvGvez07lK1EazbTsiKhPLwVRKtzvQuxl5tkvtfFUt05oqOnV17o6mHFRNMxYoZMMpO3X6gsCgyke2oK69AwRr74EFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=1vnOLFBu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso7846370a12.0
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768039504; x=1768644304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y//RHTw1emsVl3ktprI7wdvq0ZBKRoCim6D9KJfCwiQ=;
        b=1vnOLFBu+TU+MY3kDrcdr72eH5tRABcilMhSWJm6tUgfXSPvLH+BqeieuEFJzhcTC3
         DwDG/zkDAaJY3ZoehacC+gRNFopao11N6cc/bkDJz1s0uO/Beb1vLYmUeuWj1wIQ9eNG
         Qrp7/QH4pn2GujhW0055YxBwl9elM+9WYeUBAz1IYW1eBUBbIOqEZvafMkSa2TcNg2ri
         /VWv+5H6UpeE2s7K5fFUU7pNAG4Nao4/04zEaXqvV+qW+BKA0+T3sF4u/LeK38KqjEVF
         Lym53G9BNNH/nBRivYYDZonPgSWuXoh1BHWNolkvGRIqki+GXRjFhErm62hjzYWKHJ8O
         9B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768039504; x=1768644304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y//RHTw1emsVl3ktprI7wdvq0ZBKRoCim6D9KJfCwiQ=;
        b=Wg0EiZX2QsYzgtgv5Cb9/NKBKT2zy9DDQh4Ivcf6xXxJlu2Ht2Ogp0pK2bwSk4w7Rz
         2rI14Witq32zdmv090TBDfek2C5lSODnclTCbKc5xWT1ccXq6F1US53+d6FfU6AbZtRe
         uVD26N1KLnKMiodaO82iDJa4dilpJRDUaY82AfCfWjTSaxRLkVIXYM5N/H7vWPCS8iyx
         S44sXHLErdf2erE8NDL8OYijQNd1F0s6Jti8wp4gIWHqRH4TIkrf7siCtiSERp25uH4q
         hADylc7De68VRc5d2etw92BpQ8W15bH/1FlPYlTffM+lSkimN+ISW10+nmgjRUxQryVL
         W+XA==
X-Gm-Message-State: AOJu0YyRREOKFpCBrJuoShlTrCfIRoznPZsfmpfzvzesteDuceyp5EDz
	pGRrQZsKVxqkcJS/Kk9OWcfZ1DYaQVtT4maEdol4Ou71DMdIjBPf6jerl8BD7mUjYDjM0Ki28cy
	i19Fd+GAGTLItH7bZUSxsW7PVneMggBwSvO5nzM3NZA==
X-Gm-Gg: AY/fxX6PZIbxF7TOuVP1HV9dvMUpmQsy+OfGzIfcdgEdoaUpxS4j2daRWU1ohB1b8zr
	WFjT2Ug+dada6u45kN5o9E5CNE6xlNCb2B4mmjRW2mYKg7UhnQHanNT6HYnpCqaC8J0uMhL5dpk
	YcuRZT+OISaVLEoZHTCsoD+QNWOr3tkvPkuUZGfKmPx3Cw5rpnRJMMmwkEoJkw1+UTQLU+FbR1r
	vylwRSprZTt0htka3CuF/ADuY3ShFQ3epWV6T/5G+QOudazaZLcYejoOZ1y7H11/HgzYw2s
X-Google-Smtp-Source: AGHT+IF1RWdN6N56ML8fXmycusf+Bq3NDRkRpW+951bAOolZtq5MIecumLOhj5YHrMsS4882UGtfpG3VIajABXJ51u8=
X-Received: by 2002:a17:907:3d0b:b0:b83:1349:3a7 with SMTP id
 a640c23a62f3a-b8444c4d0e0mr1179195266b.10.1768039503669; Sat, 10 Jan 2026
 02:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109111951.415522519@linuxfoundation.org>
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 10 Jan 2026 15:34:27 +0530
X-Gm-Features: AQt7F2otbVrWs9f-y8Zw1pDGca-fJHwhoppdt6Moya48H1a4SKOVBDK7n5-emS8
Message-ID: <CAG=yYwmnh83acEUbUNT4f=G7n6ZeQzUkfmWMAPc1FioHwLwwZQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
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

Compiled and booted  6.12.65-rc1+

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

