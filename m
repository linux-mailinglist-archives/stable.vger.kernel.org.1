Return-Path: <stable+bounces-206141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D2CFDB51
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 13:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E378C3125412
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F5E2417C3;
	Wed,  7 Jan 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="c3dsHNs+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0972D9EE2
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789168; cv=none; b=H01xQ7l7x6BgbQC2wBjdEWeD+MLmN3ioF5psD64dvqv0Em86sZHsQhTdZb6G3sogwIjCmLl1tAoVijoSN71lcRZdHUESQI2Te6l1Sx8fm8o2Nn6dDhQE2ejinA+CzL4JCgSFn14CpiX1hmuQIiAbZYSFtUwaoEsKBmJMFq9rre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789168; c=relaxed/simple;
	bh=9NXl5W0MfOCi2j4t6/RiSQyQHxX4Vd0WKOB2kfY6gGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4YxQgRFTt5Gfol9f8kHnot5hoRAP/1o413tTfk0lg9HedQW4Pv1ELeTWU+WoTjQ2h2lOFbQwJF7Ykep34Er4/UrofYXfLe2AQoUvDvyMLPyxVn/wsEYGEP5D7xIlrQawCbtcbRNUcCb7igKRCR8lVDCK9e69vwKokBjgCHVK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=c3dsHNs+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8010b8f078so324959266b.0
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1767789165; x=1768393965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BfkBO33x57aujCCNZ/7YzXNkZ4PGmA1hAlSEDo65Z7Y=;
        b=c3dsHNs+aGEirTl/Dzq1+uD/PWhqUbcma3KjbEyG+KTibFzZnNqmmFFpPca3MF31ik
         gvKMscb8sjGSLuw7w1LniEEhsEt0vymiIs3xHYcmHgXLbtrGnL19GrRRFFt9/J4U++Tv
         G0/nL3qj+/LayLOJNsumSS1ONSCQFXdEwWxS4GvLHa+w3Nbv+A5pSM74eqIur8wGfzFf
         ieXqdkCuo6imt8r0f6CBPoER1z3oop7Ebu330C0h4tKONDcgqnqTgrAI+CIio02pRL6w
         ybwLiZikP/rldMnb/UdCZk18lY4gjKb4L5biKV9d4Dprsi5FfzKA6SPLHJriWqNGwmTP
         6ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789165; x=1768393965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfkBO33x57aujCCNZ/7YzXNkZ4PGmA1hAlSEDo65Z7Y=;
        b=cFk7KU/Rwgc/SclIBj69/l3KbKqzoDDdvDC7PB65cppOqBp7JDUCOcLdy+V5i4yOqg
         iEWm0fTkxOkGS55+PJ5bNA8p9smzwmSBm6x+XgtHt5ZuVqNU900Q/VT6hILY5Kl1QAso
         h2j8+raXStM+cJ4zs/+SshTfTAfMr1/oSlxkHqjiKORdW1qjVHqSCr82NlNcQ6np7Aim
         Xk+YlMLutUhWKeu5V1XFId0OCWnGtaAPDIMJSvVfwjEPpRgkh7DFJ3+6B4OhWUj8a45R
         ormCJcHHTB9GKnR23QXyNxvkhjTLKVd8LsSutfKaHJMSoKGNkUlrAvyVJhFru3g15aVt
         F0pw==
X-Gm-Message-State: AOJu0Yy8ai7ktQQLUoxqVAaRvPYeKdAiF3xRsuDwlOv5E+xwDHzxrUxj
	BfS9eua+JO6YVF5E5GzpntFy0iS/wFlb8WPqhK87MSdyteUMxaRd+lp/fmW2qrUHszb8IT5VARI
	txym69QbD67U7W2bprbOYD5wvrBoSYCUtRmj6hqZWUA==
X-Gm-Gg: AY/fxX4HmRiPkkbSzhMal1q8WPfKskamt/P/hQYRXOoYDIEewBe5s/YseC19dH/mLbk
	DKo9Qa7clf4tjIxJFH7EcHNemlxoi122CQxUvMplIwTwUv0sFLZH3r1G7Q8DNDmjsrx8NpOyZSm
	CjgvJJSKVvyR6MkJ/jcpA4QU48pST3+b0+YiDeh0ybxHONrU3lXAiH+SGkU9KgRgwohrWbj+mvB
	8KEPyCiXkU0Yu8lSCD9eCAWppSyRz5Ux99/dlDtXUzrhn8hJwj3kLpMDKfYoKJq3CLNxKhJ
X-Google-Smtp-Source: AGHT+IHOxw9JvjRlizzPnfcQvbzMAkTiKS4EzbomLsx7MmU0gtG8jz2QlCt0LHS/Sxtw6ccg2YGGblRmBWQol9MxulE=
X-Received: by 2002:a17:907:9483:b0:b80:3101:cd13 with SMTP id
 a640c23a62f3a-b8444d4eb13mr283995066b.10.1767789165164; Wed, 07 Jan 2026
 04:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106170451.332875001@linuxfoundation.org>
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 7 Jan 2026 18:02:08 +0530
X-Gm-Features: AQt7F2prbfkT_CozKxUycCxd-okzJWwXa7sMgEQ4M_QD7UVD0WzEQqSKL-Pk25I
Message-ID: <CAG=yYwkR-VoXihnmhd_YtUsgV6AYH2noy+cOUop+yuWroCC9Sg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/567] 6.12.64-rc1 review
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

Compiled and booted  6.12.64-rc1+

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

