Return-Path: <stable+bounces-202774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCD4CC66BA
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 08:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EB7D300A210
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C2335BBE;
	Wed, 17 Dec 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="iuJAXXGp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D98336EEA
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957238; cv=none; b=QCkj1oswwW8l/hMzlJ2wDAkibcz/Ta97t1r4V+xeQ2n7cMdz1JVp28yYvt3KfLNjVcdWJP0rtI18r5igpVFDuCmudTt+FTyk/XFmevsGc5rUN1f3k4Ow1oRqEl2thWpxO6oEDw51p1uqlEEeASxjR7RtLzapqxnsBZ5M/xAvGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957238; c=relaxed/simple;
	bh=fU099nj45X0tht7QIRvdYz8ExAJLyqmNMEoS52Por40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNGUNg1wJMU5AIb4yf8ZbH2rROCV+O9SMJGRMGRpZk1V4Zhs8joGte6Nz5KwKDfYS+kRFx+J7PKUFXxVCicAX5jUWR6OGBoDSziMg1RbvF7nGAFVxiLCyv/HRG7vaWvbiNRsmuW+Rs9fjzvPkGx1eVQ3PNkfCdDYlj05xT7w9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=iuJAXXGp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-649822b4b64so8432307a12.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 23:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765957235; x=1766562035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d0gyntNuzpuZQ4YLwBZHoVwxkZh9qXD7dDqgmQ798Qc=;
        b=iuJAXXGp7hSwIC02hgGz6ON7oQb9HaOgcLYxMX5HtR9IFKczHVvgrdAbeKtfi9X0u0
         tivvVebLDHWputz0Oc2Xcz3B7uWgP0JvxUy5AtPXk92cwNp0GDOpqhMlknBY7kM+X9dL
         cuBGJFc50gd+MqshQXGGuJaiFJ1xd0n/fMbUhOP2Oo66wwKS9vmG5ztQTbfFsUJtP8zl
         o+quZK57vwk9w2s8nAU8C80lgUmdqz/XjNhpcMY0rb0J/0N4V7hACrDlti4Cuc18D2u6
         sqivnYk2F/vVE8b5+RJNUOUYMk1BwmD1yJYJYuVSNc8sdB0MRS0+L15yL/6AUTJqR1HD
         +rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765957235; x=1766562035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0gyntNuzpuZQ4YLwBZHoVwxkZh9qXD7dDqgmQ798Qc=;
        b=mt9BSn7jO5Vxdwso/nxBkv+gaZtO26jyeQlcczyJ/KpnCZQDlDR6+OFTSwOgsgr65D
         yb5IjPtACatt+LcMlYe6fg0UAnhf+LL/2F9cT1SSS+dB6R2dFGUu3YQb+TreTbd77PXF
         f92D3aZJGaZlwN+zLvuCr2oU1/gnJcEvpYhbbPVJ7bKOCnCJTZEXrC3oOkNAPMsZ29kB
         RkwGPjC2rHUzZQxQwQS8qZbJ5qX/a9oa8ru914EAjuwkyDOZShNImP3UOq4VV/sHZ3yq
         FOfhUmymPbARvvJNDZFdLfiaC/5m5rEtmNR1vnO5jUoy2to8c0tQBjMuGU2fbnO9RCGs
         4BfQ==
X-Gm-Message-State: AOJu0Yzt5BxU2DQ1g7UQc6/zKFWb0RujhcUo6i2GYox8tlDgF5yqVTON
	2rbC8cKModpLwEyBcDFgDmwAOIkkU55w5RkJ+k0DqDflcm/v2xj7TXHCQUDti8h+uMq3thMvwoc
	LhEFbhTbQJJazHA6VyfV77yTxJEHlYHPNMNr3spgECw==
X-Gm-Gg: AY/fxX5OvE/Z9zUbqL1GoIP95q3EQQFpSDmt4mASOBT/jeNK9HPf8Ph78NjCs15cCdO
	DPM66HbMDXWwzB7Qfg5JvIf94etxXrXWg462T+6Y5Khmwy+rhMuI55QD9j0Ex2omaFu8jGP6zjP
	psThNVaeNAgZFLpHfgpw/ABj+TxOVpaE3tGA3bKs82GK1W4gmGjjr+hCl8GO/wWxyiPiubkiB7l
	IlBBTlDYvH6KIbEqLvgKbXEHmahjysEvyRhyevccSv3Ffo7jGIsWhoJpjjeLI4lLSswmQw=
X-Google-Smtp-Source: AGHT+IGRmTV0LqkvYsaR/Ni74+Dv9OY5BQXHZ5fquyjz6BfKca0DAU/hhccIkjejdxvyIWeabJqKfKwyVOohgaSWUKQ=
X-Received: by 2002:a17:907:7e97:b0:b74:983b:4056 with SMTP id
 a640c23a62f3a-b7d235c8495mr1625314866b.8.1765957235313; Tue, 16 Dec 2025
 23:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216111947.723989795@linuxfoundation.org>
In-Reply-To: <20251216111947.723989795@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 17 Dec 2025 13:09:57 +0530
X-Gm-Features: AQt7F2o_ES9P9Gs-Tac9DwXIzKB8s5SKa6EGyWjFsp86EKYa3uiFWdhy2Knc8e8
Message-ID: <CAG=yYwnv+EsEhOSUFFFGQYm6MXzDFzPKq=pp+wk2J5rvLupoQQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/506] 6.17.13-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: multipart/mixed; boundary="000000000000b3507c064620f5c2"

--000000000000b3507c064620f5c2
Content-Type: text/plain; charset="UTF-8"

hello

Compiled and booted  6.17.13-rc2+

dmesg shows error...  file attached

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

--000000000000b3507c064620f5c2
Content-Type: text/plain; charset="US-ASCII"; name="error.txt"
Content-Disposition: attachment; filename="error.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mj9p5x4q0>
X-Attachment-Id: f_mj9p5x4q0

WyAgIDIxLjk4MzM3M10gQlBGOiBbMTEzNjcwXSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEwNzYK
WyAgIDIyLjE3MDUzN10gQlBGOiBbMTEzNjY2XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEwNzYK
WyAgIDIyLjYwNDM0NV0gQlBGOiBbMTEzNjg3XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEyNzUK
WyAgIDIyLjYwOTExN10gQlBGOiBbMTEzNjc2XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDExNDYK
WyAgIDIyLjY3NjgxM10gQlBGOiBbMTEzNjc2XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEyODAK
WyAgIDIyLjY5MDE4NF0gQlBGOiBbMTEzNjY2XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEwNzYK
WyAgIDIyLjY5NzUwN10gQlBGOiBbMTEzNjcyXSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEyMTIK
WyAgIDIzLjA4MDQ2NV0gQlBGOiBbMTEzNjY2XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEwNzYK
WyAgIDIzLjA5MDM3NF0gQlBGOiBbMTEzNjY2XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEwNzYK
WyAgIDIzLjIzNjE0NF0gQlBGOiBbMTEzNjY5XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEwNzYK
WyAgIDIzLjI0NjM2OV0gQlBGOiBbMTEzNjY2XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEwNzYK
WyAgIDIzLjI1MTA0N10gQlBGOiBbMTEzNjY5XSBJbnZhbGlkIG5hbWVfb2Zmc2V0OjIwNDEwNzYK
WyAgIDIzLjMxMTE2Nl0gQlBGOiAJSW52YWxpZCBuYW1lX29mZnNldDoyMDQxMDc2ClsgICAyMy4z
MTE4MDhdIEJQRjogWzExMzY2OV0gSW52YWxpZCBuYW1lX29mZnNldDoyMDQxMDc2ClsgICAyMy40
MDYwMzRdIEJQRjogWzExMzY2Nl0gSW52YWxpZCBuYW1lX29mZnNldDoyMDQxMDc2ClsgICAyMy40
NjQ5NjddIEJQRjogWzExMzY2OF0gSW52YWxpZCBuYW1lX29mZnNldDoyMDQxMDc2ClsgICAyMy41
MzkxNDVdIEJQRjogCUludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjMuNjgwMTg4XSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjMuNzI0OTcwXSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjMuODUzNDgzXSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjQuMjU2MDQ3XSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjQuNTU1MjQ0XSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjQuNjU0OTQ3XSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjQuODMwMTc0XSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjQuODQ0MDEwXSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjUuNTgyNDU0XSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjkuMjMzOTg5XSBC
UEY6IFsxMTM2NzhdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTMyOApbICAgMjkuMzExMTQ3XSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjkuMzMzOTU0XSBC
UEY6IFsxMTM2NjZdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3NgpbICAgMjkuNjQzMTc1XSBC
UEY6IFsxMTM2NzBdIEludmFsaWQgbmFtZV9vZmZzZXQ6MjA0MTA3Ngo=
--000000000000b3507c064620f5c2--

