Return-Path: <stable+bounces-200734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD0CB3870
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 17:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 680DC31497B4
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3078E32692A;
	Wed, 10 Dec 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="sq5/L6EL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD83254BD
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385355; cv=none; b=HaZT3wBxRvJwB051apKthYBcrE/LpjKpOl3XwvFH0Ynjvy/xnaNLjZPCfPtQJOMTuSWFYl5GeCTpcj46bFVmWd8HHvKzmChp69VNfokVV9PSYrn29rIHP6J7UPy9iLw3Fya0WNf19xU+545OPFKt87UJCm6Gk+qVbPfjFRRuo4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385355; c=relaxed/simple;
	bh=WjryKRyGSADBuvbSpI7v7yfJSchEyUut33/C1V128gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grMcSSrnu45DX/5q3qCL1kTR7m1fvcOgSmg9moTa/HiiWhx381Rq9y2vfu2e6pmhoMDhmKmKzw0a5YncIaQezTYGHTNdWMBq8yG3ErO2QzCjO5FNl52/+VtEEJ4Bld4xFr9cVFExHEmcnNBBJqpWWUCEa8dRCpBzj3r3SEZufik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=sq5/L6EL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b77030ffad9so1024479266b.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 08:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765385343; x=1765990143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7aRZ2LeZjgs+oT8fLSX3wAeN/zXbQNp1vbBsVzoBojU=;
        b=sq5/L6ELRHM3ewD6alqzKmJiC5mpuWH+6qJsJBgZjQmc5qARd0MAblQ4QgiVC5IzEy
         eTLYYCtvXlSiqrUPpEs3cuJy4v6udSvXbxrgwrJGJtbQxbZojAW9Hy4eZV5g+qgLArfM
         BC9BhFs+78KYp7b4EIeEybbxNI/VJUYI+Qj9LqQgS3DU4Wtl8VOKZinW7fRPvm1vuqE3
         VZ7ivADv1e1rlj5fbyo//GWVJUs7xk742PDAR7MSYBDUDx/EZp142D3Ym+CeYBCCbd/s
         s2tdYZj6n3S62EJMSkPAH3jpcB8hF5vwq6PlTDwerRRaof7tPM/Z0QmfecIxtq/79BbP
         mhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765385343; x=1765990143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aRZ2LeZjgs+oT8fLSX3wAeN/zXbQNp1vbBsVzoBojU=;
        b=ioTTsmh9VT5kj4lzw67ajDivq7uFwRBOuOM7aSv3KVHmohMTSUR7n4G56rZQuoZW+h
         Omx9JRx+oV7gfcb1Iewcvc+XdO8pQOwhZu9HQd/XMQxkgHBm73FtQUFV+VhyvrpcSoQC
         64hkMxXcvngIaqGqQYfuP/V9SOHpVjZEe0kb6QyTw/jIDxgg9IA7akiFszl2RyIcHY2Y
         vRznids+1VdL1k/rn7VkK8XTuAaOxL3vzD5C1ye+1oBCNENtwKshezkShxHYjna+t+MG
         HXWC9ZWnb5SIfPkZE3Fk4CotVhPP5Q4MoRVZs2dzs+lwnS1ENK91A1ykN/XMCTPNneQk
         UAgg==
X-Gm-Message-State: AOJu0Yw6EodRqQFdx9tQZk7zfsKcd90Bb2gHwXS0qGsP6s7Oyn+IB2kJ
	D4TlgdTgx8DAWuJU1VLk8LkrB8lhr3bJjP5qdcZKQFPvpfPprf3B+T7+d9BJwO35cKcy/hb+Bwf
	YjBbxhEypEX5l4YWM9zKxjx48DyHJj/3J0LrPEooDaQ==
X-Gm-Gg: ASbGncukNOKizmrle/jS6RSsCPvgtnQePboog1VsvyGPDdB1MRofREx3+I1PHRt3EzP
	tl9Y6tae/LLC4e+t2SmoZgfkh5PssLef6ycoLK7m8CYFNDPKDuHC5l67gY1IGU1gay8K6QaCPYS
	ig59XoJ1crhuHI8dqKRg5lBCC7+2TQNc1HffqSBp+mIVZBkvCulTlJrDRpvzSqozQUhDFbV8mH3
	1QtktizCj1d0Gbf8jKI/+DOOzRExikn09e0s/OOC5LFi6p2eFu4NEkVUYwbggsSKURQ5exW/ugS
	woN94g==
X-Google-Smtp-Source: AGHT+IHG3EATL/ftGHhQuFqxHwYTnzohbFRvs6w9NLW+Dk/26SkKGS0IjJ5H1uKtdDVFnNpnL//uU/iFq950dlrLdvY=
X-Received: by 2002:a17:907:a08a:b0:b71:29f7:47ef with SMTP id
 a640c23a62f3a-b7ce85308bemr296913166b.61.1765385342687; Wed, 10 Dec 2025
 08:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152414.082328008@linuxfoundation.org>
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 10 Dec 2025 22:18:26 +0530
X-Gm-Features: AQt7F2poqMWU986okgWXaQ_Uv3mpP3y-4c97KhwqKkvBqKbjtGSV7ZSeV6nJIyo
Message-ID: <CAG=yYwmkjqHZbSDN3z00G2O=zDar5pR4GKAE-w-Ur7MYCgTmWQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/392] 5.15.197-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

Version: AMD Ryzen 3 3250U with Radeon Graphics
compiled and booted  5.15.198-rc1+


warning  related  to   dmesg

 [   13.924408] block nvme0n1: No UUID available providing old NGUID
[   13.927216] block nvme0n1: No UUID available providing old NGUID
[   13.930683] block nvme0n1: No UUID available providing old NGUID
[   13.934469] block nvme0n1: No UUID available providing old NGUID
[   13.935844] block nvme0n1: No UUID available providing old NGUID
[   13.937880] block nvme0n1: No UUID available providing old NGUID
[   13.939234] block nvme0n1: No UUID available providing old NGUID
[   13.946032] block nvme0n1: No UUID available providing old NGUID
[   13.948137] block nvme0n1: No UUID available providing old NGUID
[   13.950842] block nvme0n1: No UUID available providing old NGUID
[   21.906207] kauditd_printk_skb: 126 callbacks suppressed
[   38.522153] uuid_show: 4 callbacks suppressed
[   38.522159] block nvme0n1: No UUID available providing old NGUID
[   38.557254] block nvme0n1: No UUID available providing old NGUID
[   38.589733] block nvme0n1: No UUID available providing old NGUID


Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

