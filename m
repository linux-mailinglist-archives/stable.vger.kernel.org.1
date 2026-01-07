Return-Path: <stable+bounces-206094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59456CFC1B8
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 06:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C539304ED80
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 05:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62F626B973;
	Wed,  7 Jan 2026 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh0pEi6d"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952D263C8F
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764636; cv=none; b=eHc97jK63jXLtvF0gIrRZqcBMApjCh1bwnMnymZYh6Cz562shcEAcXGG9z9xolnw+Yx/mUpvc8n7ztoM2lDeSHW9DD+0BpULGjKjpBj7sF0PQOaTS2lhuGFh27BI9D1tTUleiT9vZ1aULx1LlXJ08yyW4cPeLxM/K0Rvn1V1BLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764636; c=relaxed/simple;
	bh=ilwm9UoEr/zAs5TApLrlxVW06QYijo4n5ZBr0zo2bds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ek4wiein4OIwS/oChFVE854E/MJ9JNKCFQGxNHNSyUKJuajWiYAGH77kzZz6sLU7JCu87MDJFvt8xrW/Kz7RoU2X16+BbyIzWqoQNrQFecHsS1SaHuY+hiv5dSJdSnpApH8tcW1cRPbtbDwOtTiCxQSjaGVzvk3Z5preAvgLa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh0pEi6d; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78e7ba9fc29so19565417b3.2
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 21:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767764634; x=1768369434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilwm9UoEr/zAs5TApLrlxVW06QYijo4n5ZBr0zo2bds=;
        b=Vh0pEi6d3mmQiNZQPVS6J7r7wYfKF6krfC/IjM2zAZ34EC6qOnKX8wqmMy6apqKK2Y
         l3U+9FoprnE7aZYYOMcVX1rsV/xJoW7O3hbHThhy7ixyAuzqjArekFt6lBzIBv3dUFc0
         Hm5zWaXQKIvXz8TBUaCKvPa7kESxrw4U2sHP3yXTZ3+crTGbCUa0nOXkqNJtpV6z6vrn
         iDRWwYE3U/hPt2mpbeYI5OpVYmzKf0rKV65p6z+xJyJ2yCqfzghhgB5/J028mIF2HDeo
         7gnlAgWcyqCYzkOs6rDb+H7+ALtV2qol+2OJeY5kghUo1LR1+Au1WJv7ayhVKpT/IaaV
         nhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767764634; x=1768369434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilwm9UoEr/zAs5TApLrlxVW06QYijo4n5ZBr0zo2bds=;
        b=c200SYctrG5RdjDIgOqqIN6tUHuXVsrlsUEhsjhCVaex9Ct3Cve4/zZZL4EQi7diPt
         f933DdPKd9Oz1Z+U9AhUL/+Nf+oixWDoWnE07hxEcauVg/ar6k691+tDQj6oZb5M34kh
         DVAq7VGMg6GnjX3zSD1k4rQ+rKt9sde4+0LuinROt4BQBrgujcU24ThxiA4ujPnphelq
         aC/VDwEU+u2kJ5uHU2Az/ReAr+P05834bPu9COHHon7l/KIqng3uZ4MJqp8cio2lCsmc
         9RXRZk40Vh0D40e6VzdYNBficcryktpqH9pepSBDIlwd2Qx4qAut+TT+5pI1jte30ZaR
         xK4g==
X-Gm-Message-State: AOJu0YzeUat9YBwdkWREKIbmxrIQnP5pQPlluMeBVrS4XeyR6jb96OZW
	zF2VtAwg0nIpxzJ1ZOOOWOBgP0gdF/8ZA0GbMqe2BK86qMX+lqZhnYwAk521dzLpfuTKibG+97V
	ZGrHeBQyT+tVDqlSlTfgYwPe3a6fSyg==
X-Gm-Gg: AY/fxX4vksbvI+06UNAQObaSW7dbx9dq0RBo33Q77SLjtQq9FOO33sEuNauf2UFMtCU
	7TOjOIRp+5ybiLxENNHzCNbbYEhZdUSpUTRe4UHTaMVolXeAa5nu87TbrGdyHpHaXAyl1kujkgx
	Z9+mrC+Pl0QB/I7iO1JoRUz3Pgi2+lEH7dX31pLTM6P8yRKg28zW1PPGb2NplDqoQdTq4Wv58Ju
	HaUV8n72p4KN0ReXa1jLmulA6+h+c7L6oIXyD0A+a0ms6oMqFZjD2WGzl3ShSspmzjzWgqAfEPl
	PWznSg==
X-Google-Smtp-Source: AGHT+IHPyS7cnQbFk2dpqpf4xYKgzJUt6buQAkcCCGcy+LI+T803p0BL15uNAflcsBI/eDZKoXp1mP7ZaY4SeTC08xg=
X-Received: by 2002:a05:690e:130a:b0:644:60d9:867c with SMTP id
 956f58d0204a3-64716cdfa51mr1182042d50.97.1767764634050; Tue, 06 Jan 2026
 21:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>
 <2025122303-widget-treachery-89d6@gregkh> <ME6PR01MB1055749AAAC6F2982C0718687AAB5A@ME6PR01MB10557.ausprd01.prod.outlook.com>
 <CAH1aAjJjxq-A2Oc_-7sQm6MzUDmBPcw5yycD1=8ey1gEr7YaxQ@mail.gmail.com> <2026010604-craftsman-uniformed-029c@gregkh>
In-Reply-To: <2026010604-craftsman-uniformed-029c@gregkh>
From: JP Dehollain <jpdehollain@gmail.com>
Date: Wed, 7 Jan 2026 16:43:42 +1100
X-Gm-Features: AQt7F2oMVCMLM7uk4ILOE25aOZ1wpcKcWwXnMVQCt-2TBXBRhlDqjNyiy3T2KMM
Message-ID: <CAH1aAj+myyuXniX9JAo5fQzHUyqtrGobhNPizc-Of8=OPgOAjw@mail.gmail.com>
Subject: Re: Fwd: Request to add mainline merged patch to stable kernels
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Apologies greg, I just realised that there is a prior commit
587d1c3c2550abd5592e1f0dc0030538c9ed9216 that needs to be merged
before the 807221d can pass the build.

On Wed, 7 Jan 2026 at 01:57, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 25, 2025 at 08:55:30AM +1100, JP Dehollain wrote:
> > Hi Greg, thanks for looking into this..
> > The full commit hash is 807221d3c5ff6e3c91ff57bc82a0b7a541462e20
>
> That commit fails to build on the 6.12.y kernel tree, so how was this
> tested?
>
> thanks,
>
> greg k-h

