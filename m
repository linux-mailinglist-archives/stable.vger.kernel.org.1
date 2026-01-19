Return-Path: <stable+bounces-210304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBFBD3A507
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2F96301EC62
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710930ACEB;
	Mon, 19 Jan 2026 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="LTtPvL8p"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC903090D9
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818441; cv=pass; b=t7PM3FUR1BJGxKVWQnRAcxPMOD3828pbRnuqGn2z5uJFSgXtnMHwHKOUE1qGOcM50qtX5iJiG0eqPfIB6pq18VLLQAS8jj2nk9ZN6TQFfkoBMDu6DxNJqvfjQRVxR4pmwGfkIWkKsGRP8r1psPfawxCafIJGkltcYmYV8Go++zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818441; c=relaxed/simple;
	bh=xiRbN4XJdZjr8N7csDEom3Kp+k3jsiDRQhxQuX2DDGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1cs9tfybKyI+Tb/hv9JFOD/fElEto3QSnCGiSi7mJEomNCUnTxXzbY1OfMy6z5WiUFo8sbzitQn+lxhBQpkJC4rnnFqvTTXAN/vSafyrXmvWZpxgejJCyLPedwutNhbOo8VUaA3AlTrcIPv0PvYaFV1KZvqhXpEdomy6CwVL2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=LTtPvL8p; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso5749205a12.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 02:27:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768818439; cv=none;
        d=google.com; s=arc-20240605;
        b=ZJsIkoBdQUVD2Uv9d2vj4nOcTUg25NW3bnFbnDhEy3iH9C3WVxoxnAIWgIh+2OHGU/
         68B+P0Dz83GU10+heEHi2onTxFEgTi75U1fG20T4+KCAMXmj66bfPXmNDyV3gPEBi4IG
         PPqMNPpCCzpb8ZOEsYMxZkkJ3qET5iETck5iS1PZ+qXBOAhmOLTNn5Rqqu0WaaCLCxeE
         ml2XjKZVSkwpMkhxPZxyC3FjggLaQsQaingoEJGyv3NlqySlCcLZetfg46fTo5z8ewij
         TwZ8HCZ2d30YoPWoxBVDZ3Vz2CpePTDoeWUad5Miv54MjHcBjWP8eBVTyFJWMuigq2To
         cSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fHIxQ5m2OAAtYYdWwYLl4b3rixBPfViv1/3IQcB2Da4=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=fME3Q2m07SkI+fsL/M7Qi+jGiwDRdDO2q0dGKuNQ0YW+d0at3SyOa5lHYBmzT/uHTq
         U6eTrpLyD2UJLKDGSSoWUL5XcPXKLydlzJf70mLkgKOW+v4vDnag0G0QmIvdMLTcbV1b
         5esXD0/hW99VlkrGMsjPsuB+KSkUCKBil6VFghjQxr0EAcykcv3WTLHsvNT6U6ZVEuT2
         EFvWHcp9Fle+64i0rhy63c/WP/Swj4M1qAgQHg9+NGtZWjnW9XgmReBLOIJaxIe5mkM/
         Bkadl2GB/DW/gQqIAREyS0IfgW/tzd87PShtnYJkwv1CQtxw3TFgp++Kd1J+6iAc8AWE
         N+aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768818439; x=1769423239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHIxQ5m2OAAtYYdWwYLl4b3rixBPfViv1/3IQcB2Da4=;
        b=LTtPvL8pfKo1uQYwCN8GhCjCjRngzfEXFRZCW9wMdH7+rY/PE1te5z86mTu1K4s0Eh
         YuuCo+yUcBjwj1XFEN5zD8HAkxQXRaeLPn+6a+HvOcHuehbPt+BdqfR2DsBopK//WpXR
         FE0KFlMUXNbuT63o6hI/gv6r5uFgIoCZiCyo4u/kn04EA+ai0VUgCmGuoI4W7jxxYA2R
         jDoFknn+EEyC+plQVgdAUNdd6hUZLmUr3RKDDLNNjio2/f6E7Qrb7U4Sx/An1LOPeDe9
         DHPhgzU6Dgb+C4MZOrfeLHdcw7f0BLjfrip3Z/2YmETwFERCYH+0LbO0tPJor+5El2Y9
         /8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818439; x=1769423239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHIxQ5m2OAAtYYdWwYLl4b3rixBPfViv1/3IQcB2Da4=;
        b=m/kxwijG0bxiYjeXT6XFD9GvgDhRR5aOvHyxTYK4Ruz/NjDkaz+F4mWgi2Np/CLyIZ
         UR+HXmShHZBbQ7cJ9Rk5gCoFUhg7cmb9ogZteDO+WYiHVGwq1MeZCMnBlZxrxfM90z5g
         GmlgawMMlIDOeRnubUQCZW4hQSpPQGZfGXODh501lKBO1FSYnfIGzr2FloHooByBT9hG
         quvDtdaSP1NUds5hkwo/XfpQnP/7NvRy5zDILupIITwSTFRgxnp/5epsZLCLfF7mIznX
         UBqjg/1ssdXYFjI1cH6cQ2ydWSKW8dbZOL9vBLtROD1tU0xXiWdv0jwfD94KcLmf+m+F
         B1qw==
X-Gm-Message-State: AOJu0YwnzYc+fUrJ33RdN4Pee18oRqb86w9GmSIRUiEaKT7h/aMIZfGM
	IKtVIOho4pwV4tRRj10VupZ6AoIrW2ODUV3JEMy57L3tPll+0N8uBH283txDfT58ELFoUGbf8V0
	RvQv8ZsqDs2VSQPYYjpbI72IHbQLpP5FBn2ZbPWl5RQ==
X-Gm-Gg: AY/fxX68cmjYXFXBh/XX+Mogg6a0ailgAOKqNbbI8T9FuU2PnMTxAGvSKF4iOBbwkBx
	xZ/t2qbCCBmfzpxydL21h84gYymXGR45KghdMZDMQaN1CeRjXAIobh5wuUBBfJekOkWtlq2Efw/
	yFVQrXhbLWC2HUFz2g72IClMNwoFgmsVHAs+OjZ9sVdAQmSTa0YqgRt2hij2OA/CE4K/37+8P1g
	1/gawJMJjqTEZOBCxFvT+nUwjT/GDvrpDygximSomOdhvk3krwlq/Ce4oOgdnilZLXbKQofgA==
X-Received: by 2002:a17:907:94ce:b0:b87:1b2b:3312 with SMTP id
 a640c23a62f3a-b8792d65770mr848372666b.16.1768818438873; Mon, 19 Jan 2026
 02:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116111040.672107150@linuxfoundation.org>
In-Reply-To: <20260116111040.672107150@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Mon, 19 Jan 2026 15:56:42 +0530
X-Gm-Features: AZwV_QgiS6CcnD6jvwyY_oX1lqpGVNcOatdTgCgsfGlhOSR0HeBlLiglihVYdVY
Message-ID: <CAG=yYwkoQL7S0uJQS9Zvw=gzU9k67Z8EMRaQ3A1m2oN-LjS1FQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/551] 5.15.198-rc2 review
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

Compiled and booted   5.15.198-rc2+

No  typical  error from dmesg -l err.

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

