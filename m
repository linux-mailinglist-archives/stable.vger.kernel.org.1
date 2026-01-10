Return-Path: <stable+bounces-207929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA30D0CC72
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 02:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F43C3034A09
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F323C39A;
	Sat, 10 Jan 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="FxLmoi/M"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0AF1A3164
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010001; cv=none; b=VUTVoPv+5o22EHJtwZuhbvC04klK3fCCKWXcRkVYOn90pPZ8/QnDHEmTenhG6GrTA9kWOI4Z1WzO3gD30NCPQFs9Z8If6PRZI/W1bucRMLu/byCFs01kAVChwBBbTiZB84GXJYoTjMrXAQLUOcbBgdIV37SXt2nVsntjONx17G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010001; c=relaxed/simple;
	bh=GeehpRlx6KNWuZCNeqbopn2o0BjHDRk4zMUWKQlXJY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uACs14muy50JsWvywEQhm45xV3da45NWDBcvX3NncNp73OF52mWUgV9j1ImsssZlUELj8QwlyxZSohfQ/9Ek/g94LmIFaV7/cZ86wCNx7IZFoaN/DOFxSUhgo1tH9ASHOXKbAyGa+lUK49juMyywXBmmdzUYmywFkL0J4V9g1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=FxLmoi/M; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed82ee9e57so61218241cf.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 17:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1768009999; x=1768614799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVDboeC9+82CKe53ZqC6Zq113CFhLTjqB4RptfAb4yA=;
        b=FxLmoi/MN6bse5C1QmPHkPMdkyKYInV1OfjhY2Mb3UMS0ZR9OWL7j7bnRv3kr93R/Y
         wMmP7a7hgGoPYY+Bnbw18HhcT8mr9X3c3GKgCe6v7qsd0TcUmbhmeGibf57iLuQSj8bs
         tx/53YLGwONIoxlqzJOOYNTFOhlqKg2LRBlNCMW7KnTEstXyORcF5aWO6DJoPFW/3Iko
         baY3q/wueiyZsyCA/W68brlPE90FMfBpynuhoQYsOPlHa/l4+pEKf0rBsDfK41hC4Z53
         lZtPjxo28/zG0w88uyQGThFlSwuRnbY6t08NXcY8RTRIfJN0FiH8rjHmqAOK6JJ2sFD1
         q4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768009999; x=1768614799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RVDboeC9+82CKe53ZqC6Zq113CFhLTjqB4RptfAb4yA=;
        b=VsUPoYmTweGl8X2M2fFHdzWjThEZOHDY6gFOJpRvlB8NcRB9rfauA+HWCiGey1O1j/
         5aPFojFkCWdEDW4ZyikdlvX70TUntK/eKoN23oYF84RG/vbSpCa+W5lS6RvmECei6AwJ
         GNv7hVc3n3vW5YbW1hBL9Etrcc+jL3TBCJlmpjr93U0wHDdnjDOPLYnPSqYPLrLuKRDG
         85qVdrVWX0ft+liGcl+ZwsyD4hWhWxmXOtidfOB2zSHPr6Gd7tBKT2Tm2lEDO/kUc04+
         zZckEa3IJ6pRNMzP+/9BMqwU+f8fAE2M/816Tlwy88xnsPFEvUfW1hTB8JTXGvTykDds
         lthQ==
X-Gm-Message-State: AOJu0YzXHCH9pQGAvYV51M1lfN647MVYhT0z7H3RNx8n013y6VCi15VF
	33wcu52oLhvWbTz3Ckgfo7MH/hMyw+0RBGV7UuX2bRpMMzqRYje85EQhQQTTnrglR3xmSaemRWM
	pxWPM6jCkj+J79/PKY95lN3vDdBWtkplxGGFgHZYEAg==
X-Gm-Gg: AY/fxX7ygIIAId8X9Cssfn+UuNk3rsEk7eNU+M+Zu3xbmqsTkMgvc32r+mOSQP1n0wd
	RTdwu9vhz7V8xXSF0TPEZ+xj16YFZFCfbQJVGgK/v3yO8YvxVsmd51dBFEmbfiY41qGIT0FZ+oW
	fyKwm91uyeIoHWtB7Y02mG6fU9pH7H7AUsgppLDjsZZg3XVSxdjgUFZZZt/l6cMjQfKOfX/dKz1
	Nmm5qEozmqHIYmxS3GxeQlojLlm6ShVJFPuCszgllB2yhRTht2ys9XWWc5h1mf6bN1hQ8iv
X-Google-Smtp-Source: AGHT+IFBAvFm4UTkYW3hoIHb8o+LqhFifTSyjsVt4C8ZzMK5qTHZEbWE9qWlkGMgHnWeQSvYr+zMFFVuDEaZ+IRPHzw=
X-Received: by 2002:a05:622a:15d0:b0:4ee:2200:40a0 with SMTP id
 d75a77b69052e-4ffb47f06bamr151788801cf.3.1768009998710; Fri, 09 Jan 2026
 17:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109111951.415522519@linuxfoundation.org>
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 9 Jan 2026 20:53:07 -0500
X-Gm-Features: AQt7F2ol3Wz8pAuxNDUeXf21XUvQxGAViCMTfXtKvQoQUxq6iWzBitQnhluJjgE
Message-ID: <CAOBMUvjM8DAJ36H0twWoVUk2BkO8yevZtYvgCESF4w2Jg-5Gjg@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.65 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.65-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

