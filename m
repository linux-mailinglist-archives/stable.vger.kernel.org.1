Return-Path: <stable+bounces-200704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71648CB2BE4
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9430301B4FC
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C632142B;
	Wed, 10 Dec 2025 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="j9Ue2q/W"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8730E824
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765363986; cv=none; b=NOYLIbqJN8pbdEUdUlDnF60+fC59XDP9A0Eah9st9OCKDBmLMcNcFedck0xR2YGX1FWWFMdH3oeAbQDPXwCzDCnVdxcDlOdbOW+3eI6M0bfHcN86RtBxc9iofU3icu/peXaTtk8wHJX7mNnCUoMZOcqnma1GyxaQR06vQtO9fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765363986; c=relaxed/simple;
	bh=hdPTeQuwLO7nazKVxv13M7+YgWx/R1Ig5Ft93YvGDTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oarcNw/UdeOGmvuNYn8ujUWXQsfcpUnvRvl8+WYardm13+J56XDLktLcwER3NIPH6qi2JA3DUJprrQ8zUs+36iyD0MQKzQc64W5yuh4QDFq+40d/AM7MtFZjrgdKUk4Frv/HwIxSYrZhf0zuaZ5ScIkBfo84YKVn26BCXARILXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=j9Ue2q/W; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b735b89501fso814843366b.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 02:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765363978; x=1765968778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SiX1h2OqPOIl71TO5rHafVk5bI1qE8eCSevWi2fIwEw=;
        b=j9Ue2q/Wf6mPrP3ddLmb5ihUOxWgQxOzunuoFB6hL+MSsl+BGpJjZFd7Mhv9KYgZFt
         SG8/BUyK1h94UDV4Hi++jb13JYQsJCPfbsFZSTGizgaGX6vxIRPXOd/8uCHG5KlJPoTX
         i+uKDl8gbQ8D//lxOvJq/0q3yspV/NxF79R538Q9e5KLScuKkSXgZ55n45Leg9ANpguH
         zLCH0TARBrzbcEbX32NsexkNNv0G9RM3p2al1hbTqiu77OH7ccJIoz+XgFx32Z7u2sGf
         mk2Ir/qVT9PuFKNpm+rqnuPzIybKJ2HiJuUCdCriLWo/I+ZqmhpXpQJX7ME7YwZn0zby
         MKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765363978; x=1765968778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiX1h2OqPOIl71TO5rHafVk5bI1qE8eCSevWi2fIwEw=;
        b=N1sOmyca9xNBWfKgjr5VBWNZtKTu7/ei/w8SoNb1UCKoY4Pbg860T2YOzE+Qre/5i0
         WxVnSvHTcZC35p8GkdtPw5m8Kb8AbNqcZrv7YCnT6x+5NeMnX38b8hHG7I21ZxRDgV8w
         /i3PxX8dflX681jND43fBRQ7mC+MdhnPXcYEKWWQ7khZ09tVld5HnyHZ+KTP8G3d+Zgj
         VkT285/0DbZ7NWZ0HW9BTEpV5jg/8vmSIzg+yeIBh/xwab7F8n2/kCOE6cRasP7nOdy6
         K9hiLYDH9ooxCFqmyHSfjbivuvthuQ3jYxwAgYpWVt4IuHXmpIzFvEmanZcsNa8VyTZ2
         QtBA==
X-Gm-Message-State: AOJu0Yx2Zc72/n2SVxG6Cx3x/mX6QZditO6vaiGgPctHRnd52SX81rNi
	U3kuv8JPtlx/jt5Kwu9vAY7syUbYWTHRbbU6nkQWeAktXi3wDq5apiVycWrs2FYUY6ZPnjc4bas
	w90Z36qhqKggNXlsKdm/lLFRY+DNNchoToMZJj4hLkko28pYLNAaevti2zA==
X-Gm-Gg: ASbGncvCl9VRQjqqnl/UR3EDB8V8p21XBhYT5rSJtKF49QWG9nppoHZze8wWHXHwSAp
	RaEnKsVeP+mwCjSNi5yfc4LaX0WvcWYF7ObUdCr+s3AYK1loT0v1Jk19dHSymyWF/XN7L5/UOvZ
	WvJgPA2cMM5dcHdsP3fGQO+PxHtOJWUqh7kBMnt408WGQDOi3ixVzujZT+wCQ24LxxynB44LXAU
	qXpifcUHenhLBMovlBuPsMAcEihhJRYleGTD2LUESJuy9y+aDpgWg44UOnLwVjbVcR1G+c=
X-Google-Smtp-Source: AGHT+IHnOyX+MeIfc5YygFoHa9XnwbAGln90nbQwzkSU0JLZLA5md5ZP+J21/Q/q/KDYEoIbinYN1M/Ahplq5mMEdHY=
X-Received: by 2002:a17:906:6a01:b0:b2d:830a:8c01 with SMTP id
 a640c23a62f3a-b7ce84f8116mr202027366b.61.1765363978430; Wed, 10 Dec 2025
 02:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072947.850479903@linuxfoundation.org>
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 10 Dec 2025 16:22:21 +0530
X-Gm-Features: AQt7F2oborVC3dV6Bsvx5PRC4tBGvN3PXLhGN5xM1ExAoAOOIAgKUxLQUelhpZE
Message-ID: <CAG=yYwm==BjqjJWtgc0+WzbiGTsKsHV3e4Lvk60fcartrrABDw@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 compiled and booted 6.17.12-rc1+
Version: AMD A4-4000 APU with Radeon(tm) HD Graphics

sudo dmesg -l errr  shows  error

j$sudo dmesg -l err
[   39.915487] Error: Driver 'pcspkr' is already registered, aborting...
$

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

