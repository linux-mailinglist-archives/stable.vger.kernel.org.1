Return-Path: <stable+bounces-209951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66197D283ED
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2257B311796B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94F2E718B;
	Thu, 15 Jan 2026 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="lxW8kpAo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE317DE36
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506456; cv=none; b=fcGhXVfOJszQAO0zMkkU1uHhG3xMUBW7sCU36XFeYL2wd2DCtmNTUX+ZfNF4DseXx00r7UjHiOrXsDWy8/lXF00aO7U2CYgNL8pWoZkt77NMHlAqvUuu8CkpereHjBXr086icnaAR+2VsqMwf6i0Bw1qU95XXw6dYnFOi7vtRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506456; c=relaxed/simple;
	bh=VKi3la95horDA61dcl1O7wF5nn/3hAoMMKjYxUZaguw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCU5IUu2MHYo0YVDDqgcBzdQqk5SUjUmw5X5qwIFq+p1Q84oMc0HfQoci3mnXD00OAaz5hjJZY8FHFCUG3CY6dn2Fqjwvn6pEiHQjgYVReSTxIwmLFhfb1IhGUjLq70QQExeOd4J4QvCIN28193IrMUyV17xr7ADb0gFCPbGWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=lxW8kpAo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b87003e998bso400748266b.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 11:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1768506445; x=1769111245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3odQ/pxLnGS5MFj5IkMIFC8SRNuLPcBQQcOgmK4M8M=;
        b=lxW8kpAoggQFf2FmgLvQjvpeq+zismFonzVkN0RBteSglxw3p0gD4x4GqMuyXAB+mi
         yQuNDU2iAu8y7PT3J/Ve/SZYWJwlA2SR9kVX2odiXrguxkyMup7+qaKDpmnU9EJyqCFf
         0UVKUate5qirqRgXk3esIdwUziRbv+9dBhAYcmQhTILxYzWu/tlqSsI93EkyiyGS0FZb
         PSAuzbBz286tgR/MfTEHcLEYXqez4NqyUnsFF4qEHi34Ya51n3uU0nAKyn4cdDPALY2h
         xg4gnnC0B/4ABYzuA0RMhyuUciqf0Wjv46xjYEM3W3eLM2e8eExtPQlH9t99L5pT0wTk
         lyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768506445; x=1769111245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S3odQ/pxLnGS5MFj5IkMIFC8SRNuLPcBQQcOgmK4M8M=;
        b=ZSVqOSMfgo/D+wIa+m+nLBae26OS9Nm3R3j+Kq3iPvwEp9JulbryHuLRmyyprio4uV
         27lrvtV/i7hkyyv7yeD8+kBz4azCPTd4ALrU+0SQA35PYx3TKnbydI7zW5wdlCWAyFnC
         iIW7WjNSp4EzQeBh259eLwxEqREdK/8R3OnQvJiNSIFdGaWe6hswfBvMFi7BUXcmYuGI
         sHJhKiWqsOVsDAbXEmTYRrVxEgnpJ/wMphkUokbnsErzfd+9x2lVUf9Gf1GXp3nGaQF3
         j92ctBlGz+hOQ47R5WkGmHuv3MVzOl0tODeGT7SnmmE1br2HiHumTdldMk5kYsOBcA/x
         wjZA==
X-Gm-Message-State: AOJu0YyEAuzo2H9LferLkZ0XafN+iTZa1i70/053/404zEK5kjWET7qR
	w/YoWEZ28bvhpBIKJ9NhTK95y/KL7tQkHzdheK4a+1kaepmjahnFvIOggdm0cGHlqeSOVVA/e9s
	P/553AP9ivzViMBkDiU/8QKQt2OmE+774TPsj5pTV/hV236XdI3NA0bOdSPpSsCqsqSNyoeJy4h
	Z52AqCrQ5XZsCSu9F5wTuG7+Zyo+Q=
X-Gm-Gg: AY/fxX5bNINHnkg11aQQ6nA6xMxuS3kmQ1xo1CAGyRhiiarxpcB/1yIVgfgTlHy7cyC
	l7xFYyIliGhj3uALfIItNXNvz/eGztMJNoznWsQptZIeGOkgKeuf7KPcSLBxy37cxJJmN7ITx/C
	q758izvdglM3ZPgyNHXMUJZTz1g9DimR+2WLJhqHVf294vZFgUw4waANfxcSR/rvEoHanZq2noe
	SOH2S3iRdrrd5QpJcu0rTFP14YlkXBTfPA/g99+l0JZfCDq5qPNqTxAReLsgdbPta4Fg80eRUCO
	BB4G3h9jKJGaSkcCsIXFv0pavStH
X-Received: by 2002:a17:906:3ca1:b0:b87:6c41:bd6e with SMTP id
 a640c23a62f3a-b8777a0b1a2mr260840366b.5.1768506444695; Thu, 15 Jan 2026
 11:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164146.312481509@linuxfoundation.org>
In-Reply-To: <20260115164146.312481509@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 15 Jan 2026 14:47:13 -0500
X-Gm-Features: AZwV_QibhZ9PAL5T2joVIo32SBlzjT97vwe-QD_Ct7jvNbEpwcYLciPgjCK4CUs
Message-ID: <CAMC4fz+zFOFetPaRPE3oMsq378B=B6ObpNLYQnafLBbEUZdABQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/88] 6.6.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)

On Thu, Jan 15, 2026 at 12:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.121 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.

6.6.121-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

