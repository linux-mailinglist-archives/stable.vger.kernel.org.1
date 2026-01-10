Return-Path: <stable+bounces-207955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CFD0D4BA
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 11:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD3A7300FA0D
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098DE30BB93;
	Sat, 10 Jan 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="Iqb+2aDe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57613288C3D
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040600; cv=none; b=MUJyUXpUYi/U2cM3/3OZX9SFRHu6MecLzx03RZrU5iiEZM1AqPSGQ8g6ecxOUhy+QzJPHYeBssAabhgmkfgz4v8M6o8pb4wFXS6SsuMfnwZZ/hUhwvd9q3eUsiLi4Jk+lpvGPdIB3H8oH/1FcQzMw8y2OUNRInfI90rYGAybeKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040600; c=relaxed/simple;
	bh=zht4NG8w5qQh6r7obvBvD8FNvTaT7jrro5YA+cdHMNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vr5q90nyUUbUdAV+MirrsnTSVUWmzIwWbxKviW5DpNT5S3goJeqz8bx3P5PAY9rXXHL+MBsBdJSmnthETNSGk21KBDPM+e0rr9uguK3NjXCmZcAbz5jeRnErridwt3QyU2fR/r1N8VFweI0WLTsgkXkqZzrurIpeSkhTBxIHSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=Iqb+2aDe; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so7164052a12.1
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 02:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768040598; x=1768645398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4BxAxZnLKOTrhzC396UdOA96f2/ytbFCPOHJqjLm6c=;
        b=Iqb+2aDeHxtt5e6+uoITOdFFQ1brhFmQ+fKOdhS3WHkrGGBIMhDVLVz9inSdqBpEX7
         DunJeV6JGr9sEKqp6Xsw3tg/0bNvQlv6IEHAe3ueJt4pZAyRx/v62JRtk+rao4cFr6Wh
         pr2Q4dubDy8tUq2ijD1Nmt6ad427CJwoYfNwPgtkhGrAjeGHQj2UwPHQ9vBDk0btzFQJ
         9FEi//qyW6BCmstQyxVh8VFR0jg4IVnRhIz1/+u2nNiMW1aO3kYYOE5v0PVMkSwrIZa+
         UPPejh+CxKDdlvZAA2bcYPVx9AeT9ZLaJSIuqFor8THP015shFdyh0/0hGqD/Y/cFIXr
         hfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768040598; x=1768645398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4BxAxZnLKOTrhzC396UdOA96f2/ytbFCPOHJqjLm6c=;
        b=uWdRJFH4Ol59SkcjeAppQ7GhE4ipXMtho3DFI+Ov+KDkya/0yc0gCAUX1SzhOw7myi
         Zm9ah7ba9YiUHnLW+dAR38qNwHv0Fjc6JrBb42u3zaQTOKM1P2uXT4VfZxdTYNW0Gn9V
         me2Yge++kshA+Ao0soTSoqeUFZjKVPfbLzfngP1XWXRdJvxAt7Kltl7NxR+2pWqtkDQE
         l72NTxQzA3PGE0UFmmjs4RX2EAM2tWr4esZBPxNc9d3LrWZ4dutew6JJ8ezl7zS88LKd
         OaK4At35kWlHSz9DLhl/g7PY0qUgPjHfW+sjsmw3HqnGi8pMuFUSC/1R4JU05bxUFr3/
         S4zQ==
X-Gm-Message-State: AOJu0Ywke1kStHPdwVrnfhLYgyxtR0bkSdRhrchCbuOQF8QMX07NnHbB
	GclkBIHCeM9c/M5V3vgRQCcD7xvn/Yv8MhX+7Iw62YBjMF4T6QcpQ3csmUf0Ar2CQReIwUnrMSs
	o4+6XFRXLVvrh83Hf6cQvM12Ho3/P2SCvgipkKk5oeA==
X-Gm-Gg: AY/fxX7FiOwLv3/JG5YI6QXCCv7x1YDVS27yEfqdSOE3avvnTYO5jZ85N31y6sU4QpD
	yxsJC4l1PtDCPP2Td+sa6JVL3/3VsiF8FmnDq7B0cer/USD0nH0g21jktAaofHk9zB3LRM3XF6p
	/eMnmoKW8cL8tjFu1yxyMl2qZOK/FTCu3pM/kQBc+j6Lch+bYdJ2QlyDdjw/EFoiTXfUbix7LL0
	zeYP8VE0gZwz+UFPzK0/au7raqyhs0NGmklGp4nQU72fh7NCAG51dvqicj5UtnKfYXQWxjT72Gy
	qF+S7to=
X-Google-Smtp-Source: AGHT+IHbSaD6+oPWJhQ6l9ENonTlbaI+R2La0ezC3QuQxixNeyO6lwscirrXz/C1ER15otFMLkzwn09DwL0wwb697/Q=
X-Received: by 2002:a17:907:6d1a:b0:b73:99f7:8134 with SMTP id
 a640c23a62f3a-b8444fabdc4mr1140449966b.45.1768040597694; Sat, 10 Jan 2026
 02:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109112117.407257400@linuxfoundation.org>
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 10 Jan 2026 15:52:40 +0530
X-Gm-Features: AZwV_QjvqJG3bwNPbW5uK9ag62y-VideFHjRLoaVWOWugaO-tbrv36PmNctx73E
Message-ID: <CAG=yYwnEy9aX8B_rzhoPRb7FtrkAbpLqsUn187gArfRwsxkD-Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/634] 6.1.160-rc1 review
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

Compiled and booted  6.1.160-rc1+

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

