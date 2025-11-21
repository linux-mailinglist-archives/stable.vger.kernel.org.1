Return-Path: <stable+bounces-196539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58078C7B076
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECA164F4DE7
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52892350286;
	Fri, 21 Nov 2025 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="gVulQ2k0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D2231830
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744767; cv=none; b=cEEiS4x1iLsl9YkJMoCr6ceb6+eke/lnkYDrkrOpq3XUP9Y42b0Y2CmlXmZAYaWuz0M+07pAjMYQLpUYLzWxi/s44EG5QrECfShF7T6pvWKldMTwZvu87LGKXMBvv5mHqqccee+FO4UN4rpvR9STzWb1WVGGg9Gv+3BYG0B5M50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744767; c=relaxed/simple;
	bh=FeJ2fGaQAUSB1Deo06QXTAPTwysyboXCexDx4GVIIwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdYtUz4jeukTY0zT4SmzhIQ1Pk6LjObexYFEEUewvwe9E4f6+FdMBp702EzZo4BKs+KayMP+/XbYfbQuh4l+CsiHt+kZcZJry2bq7w6io4b6bC8qFcPPZ5KkVbd7CABMx8Um/nVHPd6MxTbzeJ/A1Z3HcENPfrKbdCiNMFKUzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=gVulQ2k0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7277324054so348656366b.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1763744752; x=1764349552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MxgDUTwug61hJ/BPXD7gvIWYP2aKjb2rzB5ZYzTrVqE=;
        b=gVulQ2k0G2k39+wXPRGjbHJgvfwE0ZAIxP4laKmgEHWMDXt8GIuL3K85m6grsM0E4q
         aRwnnaJUYFLTJxk7xmKQEwkhbopkvuDbnaH/2uFlZVWwm4JHkgMCizctAoV4ofrhfbLE
         bGdHxTnuWqeUvSTvVv89m28KZ8QzGR1tCMJS/tzB8bgkj+v5fHsrgAfutLME+XH4PZCw
         H5YbgRYrTVJp9i+apUPOMQsGj2tgYlcTxwwB0eeSqbugGBRvc1k1cEapk6Fl19fqiJs/
         M5RkYgNfU1hG+kZISGJ5ZtGV22fcI/NnTC0MnAHmnF+7qeY62pUTWsisuu2DnP61qJZX
         xvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763744752; x=1764349552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxgDUTwug61hJ/BPXD7gvIWYP2aKjb2rzB5ZYzTrVqE=;
        b=SbfhMpvknIEpkE+Ku2SC/RIEsEBWf4oYiexiMSZDa7ckk/Yfm/kTXaQt/Wfbmgwz2d
         xX4DF60WNztP5JikqgttShOtnV00a8wFJrDkLiHTAIt1N6JGXhTY9jWJkS7+Mw2oDWal
         5DFRqNWvxqNiApobslC9rSH2N1Xs399ZIxlsB04xuZmKv5qBrixXhQz2OX/Rm910xpa/
         7gIgVTYRcY2xepLqKhXAzobi7KDwSCTY7iHADvzR1Mj8F50e60pv8a7RWOqUUakS3jZw
         mbFv3daGtS8ItcocNC7qxoiGngYaK0n6P41EokUDN27Ftc8oBEQkAZThFw6Q8u+l1YiP
         UU0g==
X-Gm-Message-State: AOJu0YwNjrMIE9njrpER9lBOpkKCQf/hHIYSKOrjb8C6fkQyhcenrLD8
	pmaqtOoQJ6sKWCLIOrb3j4TPdTfvUFylmyyCjq34VBxVk72D1U9xNj57BXyMXSr02ljvdU8MT7W
	OOgaOt3Vp7XK3P4zXo8uTB/ZtmGCgtJLx+9grm94Jzw==
X-Gm-Gg: ASbGncupZRnAoLowL4VrN+j2Kg8TlCBV7KJUbXCZKB73sshMCJFv4hQkZCkfqv+L+V0
	E2hpyEEssHZycksuq7tZn+2UdB4UUDbpW9fhNW5JDaya8smA5FQrFACbmD2WxRrMgvaUHZSIrYb
	hyfzgt2Mio3GUqHu0hYg8as7pZCeGCKQOFoi8K76sW3el6sagC9lhkDWQIeXs5629xAs1TfwAJh
	ZArXeES4TGYrg025C9CsQcmvEF4lanGO9SgQgDUIQ5F4fRWxRDb/nxcWU2yNoSiV50oJ9M=
X-Google-Smtp-Source: AGHT+IG7WH7x9X2+I2x+h5fNIsoM+zLlcF6TG5fRXP1vMU/kCM3IkrfIk1asJWWAmcRFSxn946GwPYcXpA/un/l+e5E=
X-Received: by 2002:a17:907:26c2:b0:b73:8639:cd88 with SMTP id
 a640c23a62f3a-b76715ab98amr304627266b.22.1763744751694; Fri, 21 Nov 2025
 09:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121130154.587656062@linuxfoundation.org>
In-Reply-To: <20251121130154.587656062@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 21 Nov 2025 22:35:14 +0530
X-Gm-Features: AWmQ_bnkJ6yrdoEu2g0362Q1Zy7TWNbX6RphkpcUBU3ZmCPk6bDGstpKoP23Jgo
Message-ID: <CAG=yYwmPBiP-pT1Yo9Yym3RMnP6BY=yjx6UE_qH_t1nCe0gdAA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/247] 6.17.9-rc1 review
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

Compiled and booted  6.17.9-rc1+

sudo dmesg -l err shows error

[   21.490792] ee1004 3-0051: probe with driver ee1004 failed with error -5

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

