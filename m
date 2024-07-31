Return-Path: <stable+bounces-64805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F700943731
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 22:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DC61C21BDE
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 20:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212F1607B9;
	Wed, 31 Jul 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSR02Q0S"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D633B1BC;
	Wed, 31 Jul 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458424; cv=none; b=GsO0S1XRByvZ2kzA/NBo9P6r6iURQPKnwJtbTF0iHK/UleVNBn9QbuTxEtmipIEQYtFj+9mHAZYmOz9Ugv/NFybbuXueCkAqVAgGepPBoEe/OZaSkJn9pFl9zGwfLmNXjo9CQeay+WGvEcofAWp8gvRgknlDdO6b8PUOennC4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458424; c=relaxed/simple;
	bh=dnTCwfwpR2fZ/U+rLRxcsXNlPsZKuO1GAVjcoVB/T5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShXzwFeh004CbGb0GV8etgERkq4DdFLiimscLPiQur1kk8Amn2Npc9RLyIxfUCVtugj4Jo7BV5dcp8DQOLXTOIpSTBQMH/PmzS2dmMxejikPNdPgNk6M8vc9UKXiuDsMcyp16jy44GbK3LI5fqug8Q/WQ0klTHRSBJOFZ7tfFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSR02Q0S; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4929fa64542so1535890137.3;
        Wed, 31 Jul 2024 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722458422; x=1723063222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KfFH5hFnCdWhgM8cvYhXX6WsvjJlUIb8zg/pRIkwRzM=;
        b=JSR02Q0SBJk1RLUWlmt/DQQDTBPnrt65dWROD0D1dYVCH20b5/CEVNqZfoE9Z68UWU
         ZqE+I7FZFoW/+XGUvO/1NrMf6CWeH8kcdHHkPHDm8ooTlviyenaaqGRB0vbgN2J4mB1E
         WxNa4enBvvK7aT6+XfcAXeKTPa/eV3I9r3AO7HlxLz4qQnUSZSoNVFLZMszaqOO4Wp1w
         AnrlNfuRYo/HZLbhALHsJFOlEFys3s+B4qPvmObeXglYnNJ5y8U4/O0UeT+TmsCOAAKb
         BYQizNNEsFge2e3Etn+9jtQjkjztlBbEtPF2kvU71NW5jx+Jk99MnvmGi7JyATPnHwRD
         0jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458422; x=1723063222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfFH5hFnCdWhgM8cvYhXX6WsvjJlUIb8zg/pRIkwRzM=;
        b=ZihlXj7cnwVO/s902XPPobYiJLNyN3K5g/TUQEUkAu/qJFLl0Je+ulm68OyBsDrWG/
         4pAGz0lh0Ei1jHrL3IEMx1RTrCU3UL/rH97ENSIwlkY/jw7PLyUBhkWZBP3B2IfSLV5a
         s2MPEo1VJ6MNuFyZn6fvEAHWr5o3nGZZNMIjL1nW/Hfb490sxpu3hOWShnJvzIXjPBZY
         cmmOcTED5qa9Pzg0ev+VeqjxshWx8YSBbYwksTQeZEBOSFGmWl93+oz+abViVzr6RldG
         G1yKF1IANuXt3ZFmMGIefKdP+Ir+Se47j1iHNoDqvwyQR+PSBDvkIgFAxaMmR4TxA8tB
         lAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH9ZBU7PWiksSXD6G609KLAgNPWn1HQpMajtOBFJB8Vf7u88RKA2SKnvvqlZrvMwVWxfsRm+jS5eJnXz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz028N5lA/kgLY+A66DURYrofBBF9jatU2Md1GrO4fdjJkZ7J4H
	UQEfY/kBOeOCxp88RtdVjzVzFnmbnceu7SwBLFCIBfE00JcNnJ1reKosrYfqWjpIDsHZKBw61sG
	LdybPuuKg4QKoV+RMwSgcNE3BMcE=
X-Google-Smtp-Source: AGHT+IGHSp0+BJUMLdY/YTJtjkTxtegSlcf/ZkjGU1NcHGdafybQ0qoB7lHBh2nPjzA5xooIpdoBAf7/fQXoZLQk+mo=
X-Received: by 2002:a05:6102:54a1:b0:493:e643:bed with SMTP id
 ada2fe7eead31-494506e171amr759434137.13.1722458422202; Wed, 31 Jul 2024
 13:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730151639.792277039@linuxfoundation.org>
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 31 Jul 2024 13:40:11 -0700
Message-ID: <CAOMdWSJTaczJy6U0jC_8b+_M3Mqw8_wBrV_Ns_35OT9COZw-6A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/568] 6.6.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.44 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.44-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

