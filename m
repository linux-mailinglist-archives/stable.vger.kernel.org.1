Return-Path: <stable+bounces-210317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E928D3A6B7
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18D063004EC0
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188E30EF8F;
	Mon, 19 Jan 2026 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="NfoezAhd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A630AAD6
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821830; cv=none; b=TRmh35wV6rDkCJI1O4RVdnf09RHuLtbe6swqgsnRMU0ej9gnq3OumfzdwGoN/pY8zUl3B6Xko5nDNE+j6q/vla48/dHvpI8wrd0OiVrEKJM2Gl1IHVRLNr0q7P+T9HWHYQst0PBkbFmTFQzuRjH9WjQHVrzqpmjxKhUpU/EgFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821830; c=relaxed/simple;
	bh=o/RYM5xvEYUmeBF3YHCsajzHuBcgtSD92WjxeVw5NtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAJw6MLPAGUjYCPAOdc25yD2sVkIXGfgivGZ4c9RAAzA7U5ojm5OOw+n55fE+jF5WEIcwNaK/3xrI5Hf99mpnklfZPVUX8f65D9JY75JM5H+PYm/a5kYWK3ESZxtzLvuJMs/HUSKgIMt84Io4emaAIL2fVEhr5qQrSYRqVu3Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=NfoezAhd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so9069160a12.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768821827; x=1769426627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul3fTjOzec1NpKK9eGRnfPR+hFQQzmswH1g2E9134rg=;
        b=NfoezAhdgoCpwEJ/kFNYxGGtlAc+8qIERALH9Lw33heM3MCPszFOJn8pMPZH/kMzqt
         ueMYBYwM1QnlYKF6/bAAyC75eaZin0lX+b7WGuUKXSs6JHlyOyxWsueP7uZk+Crtp6et
         l5kscTQAWFM5g71BgXIMa2HhqmjkKh4DRDzs/Z90jWmV8B7t4exrhAEeDOLfKP7QyuEb
         7zL80ow6VXfvjhSiyhHBwnWCm0QQfo3OY76cxmmN5j6Z9j34WzLwCWAFoXUJwbEWQp/2
         AKgGDreAcG74aM/Ddb8dEHP3dMAu03xZyXG2SOO+GdbgxBnHXwSXogUnpZk4HUl4Bimh
         MLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768821827; x=1769426627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul3fTjOzec1NpKK9eGRnfPR+hFQQzmswH1g2E9134rg=;
        b=eazgCglMYr/yXMY+dVe3DnYLZgVZcVz12IazgbSx7U8+kyVMhqXit87NLMN+21U1Bo
         tUHkJ3rM5Io+B8LU9TsEy4yDk7TTLlxNS4dZyyBYS/mp1qUY1ORT2DVtIy99gkN7uY6m
         3+V6TwuqUPLrbXoa9HRKFvA2B745iyh6XoajisS2kJXxVaTjPH1RPpTSHdGWIxKtOO4e
         6mBOCHoUG4jvjUajYc8FCpQCYQlfZsvLqM+NNpSBfluQpBJ+lifihM9hAJv+UXJGQk+T
         8JS9oUBNj4f6ORdcJORkzo7MuT1hHKgH0yoMFvrEiKbwbuMas+h62cyM5iFvFEtpCiQF
         BUSg==
X-Gm-Message-State: AOJu0YzIWc2w6TLDTkPV9j69A9lNtdHuLDGz35K0lElsyRA9zCborcTk
	jUxvouvU60y/4Ujy4yRgY+fD3x9aO5PeMgnUG46Dib92dV044TBjA22M9PTnhUh9X7wTY0h3b5r
	SGHx83hXLUy5Opd3i23PYbsxAn8I9sO92JF2ltRpjCw==
X-Gm-Gg: AY/fxX66zydEE3lyIyLQmedzU2MqCRNEhwl3P8ak+LY5CMJ5GwFmzLn0aUmyAn5e8/5
	wWuQM9UO1RHQ491OYhurtNUgwzy+uT1DOFW6pDElwSt7LrWAAp9Hq06cqaYa2FPxVdhxxApdkr0
	tx5DQZVl/UY0FP2hdF+WoW6D2E7mfSK+VVK6GUvpt35uDfF5MbhVLcURlpAp4PmO7U4zfBf/Mrf
	jJPt37J2N7Pt4qvQntpTN/fkB/BoQZ+tXbNKIw6tvL0ZH7O31pyJtvRo2KuWowWyk3hHF7WS+xd
	5Dfv+sww
X-Received: by 2002:a17:906:9897:b0:b86:eeab:510d with SMTP id
 a640c23a62f3a-b8777bc5e2amr993800666b.15.1768821827422; Mon, 19 Jan 2026
 03:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164151.948839306@linuxfoundation.org>
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Mon, 19 Jan 2026 16:53:09 +0530
X-Gm-Features: AZwV_Qi_pMq36xGNJ7azJZTMio1xOQE0QgqPG5QQX8XVT8FumhSOBc7TvPxZekA
Message-ID: <CAG=yYwmwwFL_LcGfUN8bBnHSKUhtMUcK0kKcHA6bSZE6yR5sKQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/119] 6.12.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: multipart/mixed; boundary="000000000000b212d60648bbec29"

--000000000000b212d60648bbec29
Content-Type: text/plain; charset="UTF-8"

hello

Compiled and booted   6.12.66-rc1+

dmesg -l err shows error. File attached.

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

--000000000000b212d60648bbec29
Content-Type: text/plain; charset="US-ASCII"; name="dmesg-err-6.12.66-rc1+.txt"
Content-Disposition: attachment; filename="dmesg-err-6.12.66-rc1+.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mkl2thqf0>
X-Attachment-Id: f_mkl2thqf0

WyAgIDIzLjUzNjQwOV0gZWUxMDA0IDMtMDA1MDogcHJvYmUgd2l0aCBkcml2ZXIgZWUxMDA0IGZh
aWxlZCB3aXRoIGVycm9yIC01Cg==
--000000000000b212d60648bbec29--

