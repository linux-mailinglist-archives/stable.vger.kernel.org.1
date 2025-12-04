Return-Path: <stable+bounces-199972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC4CA2DC2
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 09:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9EEA3003984
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A032D0FA;
	Thu,  4 Dec 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="MEcL8N5o"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA71E0083
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838300; cv=none; b=fdWaGNnQBgYvO7ttEjeYxHzxpiR3EC2WMwCtLEz544208/9jzERW5EYNa9nYoYTrqZRa3T/RZ5Rj/CN2MfWpCIFMJvDEiwaGsv9jYkX4Fj3UoEVbW52aGNkH2lCSo135RP18L04FJdsSRvVjw9Z2Q8UJHKc07CwjqFUp6SMyGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838300; c=relaxed/simple;
	bh=/TxZinxeGe8FZqkSnGDqKyD9UNHHXo3bMabEh96HC4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKBlPKmXUIKuDxko65FwyEH8rb7HyyM+/klZuopTH3c3h3qONtIqcx9VKCGmwtsnjozoTdkwy4ihekpIt8Tw1TEjBLGZuwSvoJQ+cMfabN9QSyD0qs6L4ea4TVZSlRKDU9FJSz94sF5AqFP9sZrSH87I3Cgw3P8n58EYtfJI1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=MEcL8N5o; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so1151380a12.0
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 00:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1764838297; x=1765443097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Trh/W13e+8lZIhANIojCqFW0J0vURtDn5XxDF++7gII=;
        b=MEcL8N5oovv5j3bBdVQyzLIIwf18eEgiR0X/d43a2BkLK+o2YkU7/MU1YeCoolj9YO
         LEV2Fo0UTDsEiua2qmIwT0SPlHL7P4RCH3GQrWox5kU3OL3QlRcha9Qk0sxNEVf66wtM
         kaSxbyXT5+5CfaoDf5dEtaoEPMz3MJCJX+1cr6LqEWc097Wy3gwLxTxt1HugjLNkHsml
         jB+DeTXXiQzLD3N/5y/PZZhmDMbKt2dFi03KSiDFvqtLh9QJJoWEcAUlaJlbqmKLKWWI
         IFOipTp9NMp48f+rRrjdSOTQjOuMil+DhI+CED8rBSVq5oPmKL1/BRlGA3et5DxCqEMh
         HsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764838297; x=1765443097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trh/W13e+8lZIhANIojCqFW0J0vURtDn5XxDF++7gII=;
        b=WAZbrB/t9CDRL1KRDED5ka2ed6MkejmiSHunwc+tvHVuU2mPPgNFAD5Um7rJnaSbcO
         NFP21xMdE6VhfjpIjYmdl9h3eu0cViVtnzg62tKzTZC/n3pdDtm6HQ4wNG/aCS7f9K3t
         l9kSGczhs1rg9MyD4avOtXQmqM8ZV59FD804YbKmXdMRRvheFyD8j1FVOt1G1YUsei5W
         I3LJfFr/+XEan1vBxJh1aqCNxddjuTcaMHGYEkwDtzmaf1VX7D4A3UEsZMqwgGwn9EDF
         5UTmEfkfJFkGz41dLgz8YiqMD8b3GWP9nwn59u2QlRA9uK1vuE90uV95fay/AlhSqrSm
         s7iA==
X-Gm-Message-State: AOJu0YwFqM1B51Eiz3HAX4Pq2r7bUe1+i6IwfYrOZxf2l/IO4V5D4pNC
	0fuHBSwwaoGo2oHPbHXZjPJhKGmsOQxRtKcwXdmyHDKmVkt2/g/jhv+itWpgLSo5wiWn3KlS1YJ
	ncCJBF+py4tcTd1LhZkyMY5LcKwN/vj3zrvNqah8HVA==
X-Gm-Gg: ASbGncvDy3VBwSuc6vNFhSYbYowlHhIdgWzG4dDiDyqqiI/cGxXe4+8xwSfTrQU1Gsy
	GBQHEjsF1FY4xKOiey/l/ats8+Dcoat+b4UzoqfSdfFe0qaGYnJtm/Q1GuJHRTngC5vdUAQVP1C
	a+qdCCV9bWoYxyJ2xtbj5ghEx/PhNFOkgNmlz6ioehDii5KCIeyzXiEv0SFFQPSWgjr0T6qM17s
	6hIHFcA+6pWy/EeYKc/82j/00d/aVzz2WrJVCBay65V1dLoc8eznpwxpjm7X0BxLpEoomt2V8uz
	5Ox1Az8=
X-Google-Smtp-Source: AGHT+IFe8Rga/oYQgzdhd6L3ShdQdE5SrtoHRIXzQA5MsSpxY+g+j202sxOBUYItr6XYoCZHorI7UkAZwQax5m/pSoI=
X-Received: by 2002:a17:907:86aa:b0:b79:bd38:4dce with SMTP id
 a640c23a62f3a-b79dc73a0damr533070466b.37.1764838296923; Thu, 04 Dec 2025
 00:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152343.285859633@linuxfoundation.org>
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Thu, 4 Dec 2025 14:20:57 +0530
X-Gm-Features: AWmQ_blyCTrZy8L2aD8RqSEtpAYOxd_cD8HHC16wXXwOuM9mODtNvrlLoDo3ZsM
Message-ID: <CAG=yYwnx56mKkOOdtsk1TnFVgNOPN29qF+cDQKFNViy0DJ3E7w@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/132] 6.12.61-rc1 review
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

Compiled and booted  6.12.61-rc1+

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

________________________________

