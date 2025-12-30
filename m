Return-Path: <stable+bounces-204233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C4DCEA155
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3476A30039D1
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF58F2D321D;
	Tue, 30 Dec 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="bWQILTm3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE0241665
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767109151; cv=none; b=RaueEIXh3Xgdf7BlGZBn7AhQgwfQdft2n/9ovG0lKfcW0vmwOATKJnay9v651fYl63FtHOVmNUIqUpeFFe2JmbopIrsOP7w+6lcnkyZ+fPe+iLoXn7b8jPnuLVTR+kSXOjClGrNQ5wPuKwIyun/57FfCZnl1Nn8PLUsGnRTpRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767109151; c=relaxed/simple;
	bh=M+ghxDkyEnMAHLZK+xSgIQxY/DMIVo9Fki/cauWdV5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R94Ufzw6pqLVRLNH6E1IKEneubTycxJelm+ns38TlmefHyWcDJ7Es4Alt/Az88xQf8zTiZOHMEHor4RPkijwINZeTPMnT+5bY//EOICkt4CV1PKHQsBZRWrmnj/J1vDAlmHY3OzCu8XrYGn+gx6Z8lUTVFQdftqT3T1ezR9aEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=bWQILTm3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so10629741a12.2
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 07:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1767109148; x=1767713948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/iGKYPy7kScRKALvoiJl5pQO0SCaWoFIYCUOvfEdec=;
        b=bWQILTm3xOGQ7e75z6kX5ou4I7aW7gkU+dMjYZqSyLgIfS17BD/p/ylhv6Wq8x58qR
         LolVA4KovTUOiVF++1y9V8Bq+1GXMmgtAzf94zcHEn72d4B6IEnsqoll/N7tOu14beMq
         wAyEpgXoGm9+9LZ7MRve4cUEcV/D4cjxZ1LV6QRYMh9kOUJzwK/ULkMjUQfXwxh19+eV
         eQbQN+57a3ENqMkFUU3w30jB6Rw091CSE28VgMG0kC/aOdiUmhVIKwruXfX0HwLHf5sM
         23e9PNGD+igxooGohvcGd/umrzvov5bYS+aIzRV3R+N1Zt8Z/2n2E+QcD1uhIa0ZMyU6
         bAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767109148; x=1767713948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/iGKYPy7kScRKALvoiJl5pQO0SCaWoFIYCUOvfEdec=;
        b=hboHQ3mS6B7FuL5aNABLEOUt/OW6AZ9lIni82Ikg9JIdJ7tBwPEhqCzirTaqCXi/OS
         Gf1OeD4o+cLzeyC5BgF3/oeRelH9nH3Yl6mLKqK6MpfenctegwjsR9laOzINNJSiS0vp
         DZkpsqKu6YOA77yloFL8VotK3E8HTQVFXGh+c9NfA6L1Bm1Pmy3LVeshcIt1dljPwOOW
         Y8yNbMYr9K5zRAZQlllqaK6Alaki0T9xUbSnXmDmB+6V9cfrSM/42SM7RNlORfndXwbX
         er0zF7LxNRAOM4jePYvB5HDDkyHGz63EcszCsnxh8CddNmxNjCgpf4zi/QqOZh/JTPxR
         86Fw==
X-Gm-Message-State: AOJu0YxMnsw7J3847tjuMt6t2sSa9vC+TDUlIwbnNP0a4OpnXJIgmgiF
	bc4NJKWm0yYfFoF9GS8H0ga3FAcDvhqIOYG1W9Wan7gIoMk/4YoQlAatrE1yr9WvJBtr3m9g8tL
	wTbOAlKTtlbdhkZKhqh8RYtu/nujdPaFMEd1vV7aYdVH6pMN4ggbtO+NKGw==
X-Gm-Gg: AY/fxX6DccEBvIeH1fA1Bqqv1jGQdK2Fd2AeadCqG843xtp3P8ZGHz6DXxZn3VEsDA4
	YB8GhZFwlLhleOXop6QCybzsXi05Mp0Ae0luZF6TswBIWlOn1XF/zLPSN3Ih/upVI8Oku919GDK
	t3c3p3JFwdrf/RrP7PPeBUy87lcx4t06CyARCmuMdOSsd8iAwXhk0Z83xBU3CpWQE6WDM8Bcyc0
	K8GuslGltYZvIIVdJCj/QW1Q02tWK5tQ0qWPjc2LI49+bRLwBaxaswqdbr1HpdOF65qd7Q=
X-Google-Smtp-Source: AGHT+IE0v+rA9dVO3MGjq7zMSf8k9fLsm2E/a0kpKY/MH2zvaTSMwm/I3yU75tbfYM+n/9OcaW714tZmTmzmtr97Y18=
X-Received: by 2002:a17:906:7312:b0:b7a:1bde:a01a with SMTP id
 a640c23a62f3a-b803721826bmr3737689966b.62.1767109148361; Tue, 30 Dec 2025
 07:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229160724.139406961@linuxfoundation.org>
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Tue, 30 Dec 2025 21:08:31 +0530
X-Gm-Features: AQt7F2pjknXX3DkMcbVdm_x3fyQaQnJrAsSZCVdPg3JITMjxzgdTkMkzQAK5ov8
Message-ID: <CAG=yYwmqyTWtcoaosdkDpD79a1+gjyuKaZzRCokRkn1Y2VqxLQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/430] 6.18.3-rc1 review
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

Compiled and booted  6.18.3-rc1+

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

