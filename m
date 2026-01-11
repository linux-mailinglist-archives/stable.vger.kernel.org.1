Return-Path: <stable+bounces-208005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0378D0EFBF
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317F3300983F
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C22933AD9E;
	Sun, 11 Jan 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="os/NcsRK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFF19C542
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768138436; cv=none; b=ZFPeNFVhFV8SqKAfzOhwrA9XjGRzmT/4LhYAqjR9TAiIUjy+MdcSl9npISLZvlXRjismtDjBG8+Wz57dHCzLE7UfUcBoh2h/Cr0Y5O3KIK/AAm/5WsgLxAKo7Rz+D0hMVAhUNjYhxgJS04B0zv3A4OXR/aAv85RdgkXWfPVtxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768138436; c=relaxed/simple;
	bh=Wzvtf1QIRWhfF9BNnhKptdI8gkJPgnhFK0K96o9KUig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK5zbqe3PhcSC7AwUagDqSWVYfMytb900/ZXPIBbUqDBOxe/GMTt4rS+7eFjNOaPL53CUN36Eou7j98P7a8QDuAnsiuSzV/UJsDhHfdm5338o15Y+qEOS2IDYPFBaAnC9nqRv6ZHCJ12Mz3dwiksp161058AmldqKCwCx0jQJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=os/NcsRK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so917518366b.2
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 05:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768138433; x=1768743233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2J4zv6B0sWCplg3AhmRAoRaHMt7uMnutkNab3hdAsU=;
        b=os/NcsRKHezwo6rJgNDGM/FygWr/mRwCqeXlA5rFa0GEUn55DD+yKYxfnLxQj1qnSS
         BWTHDReiCEvgfzxsQA7yIcdTHIn6S+gVw3vHm1fOZX4a9vzJNgXwVCjaT01iRz6nu++I
         fpOTfxCEly4h1qlD7IJREKojsPZ5uN8dVonxNQgmAWfF8lfq0wC/dezu9Gh7YDxqQv0x
         6ZUNXJjIKakeQsV26eNEhHcU1fnxC0lE0h2rTHNk9bJC2rQWC6Zzd473rknCkMjX3XQa
         veJxyH2qT/wmrMzJ826tJpiCPoaDYyj3m7PdeO4CnK2mkSAZ41w5Pkxqv1LuCRaZyBi+
         kQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768138433; x=1768743233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2J4zv6B0sWCplg3AhmRAoRaHMt7uMnutkNab3hdAsU=;
        b=UBNWyux2rmt+crQlopen8360aoWwUWnBUEkQraR3JM/IHs0Oz5MdDOtuAZ26wpOLE8
         aOucvBOV3hPqwvhR+TZRJky32pO0zzxL1d8XOYEA3AqWybCGWEbTA4nDxvmFrPEQIOJA
         TvGpuw017urVHW96RComTgkQ86bghSp1im3ccZ8TQjyrX8Dvs/I/YDtURxnMRbVd9CHT
         edOu1Z7tiHdKOjj9uFLInJ5T0eW/b+LMMEml9zXgzBM4yLmJXm33FQKhjdysKcLJ5vxY
         UVk7mB4alK4SuuMFSbIEKJDAqG9qwA/JY8rV3A0G50oLtzR4jkuP/HF/qD0VdduQoiBd
         TA7w==
X-Gm-Message-State: AOJu0YzEY29+Iqy7aLJ1/mC1oE7Eu3TDtsUpyfXz+2i681T0dp9TZ/Ry
	ZQ3YxLDU0+eVCP4dado87bf7jnC4ql3BV0Vl7G5A0dlC1801YhyIulHqYtM5omBmQv0kGaZP6Gx
	GG8uQDAq0j12NSyykoHCN0gDf3Cjny9s+5KWOMQnNsw==
X-Gm-Gg: AY/fxX4YJqkF1F0LQVkXU4onkfcUWnPEQiQLswylUyDxc46mLOp6S+wFpYqDxcSSJA+
	+6tDz3ORnHopm5fvbnWJmayLd/4v8rfljCDkWlXHsGmQb86Wmt4fhknWBuC/1G1iQ4GNT9PNUPC
	O+gWu/OrNjIvEj4ZqDt/Ss8WktLrO5F8+KLu/ikGbQYFWdGNM9ekYzb5es1HbtA54tO8WusW0EA
	a/T2Y13pXY1s9O3GYyRuvz3p+lfmqQdKgHi+K6K0Q1IU923zITNBCVQ/Za0x02chTpiLQvA
X-Google-Smtp-Source: AGHT+IFIyEV5GZ9LvzKs1Fn8qJm8k3Yl/9+E34x7MwrIBE/uxpqJdywpg2jp+1UpsvVTwV95NwxPwTrXn0S17pRWm3E=
X-Received: by 2002:a17:907:6d1a:b0:b7a:6c39:8e73 with SMTP id
 a640c23a62f3a-b8444cced16mr1443786466b.23.1768138432293; Sun, 11 Jan 2026
 05:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110135319.581406700@linuxfoundation.org>
In-Reply-To: <20260110135319.581406700@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 11 Jan 2026 19:03:16 +0530
X-Gm-Features: AZwV_QhkGV9F_PPBfvZcVv0UkUfx6ZL5ME9FEBCMlS1TdDX6na1L-wwPkJH4TYs
Message-ID: <CAG=yYwn3BNTMt68xEocXDGDW+LRiSHDAD6XNPKfVN2xKN+t3Cw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/633] 6.1.160-rc2 review
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

Compiled and booted  6.1.160-rc2+

No  typical new regressions   from dmesg.

As per the dmidecode command.
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

