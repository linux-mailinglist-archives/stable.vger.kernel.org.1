Return-Path: <stable+bounces-17633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20548462BA
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 22:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1BE1C22DE8
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 21:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9FB3EA73;
	Thu,  1 Feb 2024 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4tdhAmK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D533D960
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823711; cv=none; b=gcnexlQQIZTDLNUZ8MARSYMqS586KqYb39b15P6bZrjOgg4cnN1lofuVtvi8q6bF9ZUN+K7VDIDeGCPnVHMeVlc4dVgUbczxIJUYKMRjPt2dsuDIgcrrb5zQoZRHN9HoEmkOgvoISIcGfs278nEN7zS22dzjR7k7oI9rNcSFN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823711; c=relaxed/simple;
	bh=Jsp5QmiWUHsxfNaLn387KkKAm1uBQu0Hb8diOte8AzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMTcvTADYkYFxba96dUitzZGCPN3FJP43OEv6LYru0a/6aVFpRADR+RQjpcgiWKSeg1iwB19IkyGO0Mdn6ARlsnu31LsxhTx2USGOIMbEhWGhoSLpPi4cT9rQMDhVvBO3UnA4dYNxAiDh6Ow9KFkzbca2+WnF8P5NwWPwgowJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x4tdhAmK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-603fdc46852so14855317b3.2
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706823708; x=1707428508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G895U28AbORmoClqSfF6phy2kbhAbak3oHSG6RYxRI=;
        b=x4tdhAmK30HcC7VfN39RdOnfC11HOLDEd8+42Q+jy2gpj2FcSdJaYj/kzHNt0DOYfl
         NBMYtG9MKK/2pPP0fKJ6nXqE0rgGXGntNRJwMLQVI2sBYmHj28CKH0v0cX9imFuJCElq
         VmBI+jJEEsHgnnJOOHFoX6ltu34htQuEdOMPpGE636bGXLuuuFRWfYc/41MsSnO+utnb
         6AOsdm6jJqz36VFCNekIXpYQ8jM/fcRHvBEdPcsGutHpyZ+/TtHa5GDA5U0DXX89uQuB
         hHRlDa5xsMAKMhwetQD99QqOOepYnwHGdtQlwIG7EniGAXVlWyoF/yFUpyUnKG1vqp8C
         XP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823708; x=1707428508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G895U28AbORmoClqSfF6phy2kbhAbak3oHSG6RYxRI=;
        b=e1OD8REjYjs/fFjGP9pEF5bzVkXnpA0v28hkOo0GshX1BJqSmE2umv1R53WJtXEalp
         hAkUTqpgKuFrXe6blY/eleJRQ3tjkHx5L7DB53U8iqHaMxPIog6JmCr1XoK5cW10xG42
         ImvM4agJmNYWyY2rsVFEJHB/TNO4ZSeCHIh0dCrlmm08K1405kMeQWlu4oSd4QOxVnLB
         29xdQA+4wp1g5s6kO4/bZQitKEnwpcim05NCVWnSgTXBv3KLMocxgwOAqjKrKYPQBPxp
         5yI4d3oWwECuEaYoE6wMtw2LtbrwdNtrKrU5hN8PlteKOVOeNkVZKLk3KHFAgsMBh0Bn
         O06A==
X-Gm-Message-State: AOJu0YwgZsm6byRomNMOuKJ2TgehHZFTq3u98026m6vsQasX4b2XeUWZ
	wu1JHQRdXJacgZnxbn7Hhd/p+saUxpfo56CanzQO4la3PFOI9bSiSOMhS4Obp0wJb04LluLFoTD
	NyDmlfqNtw9nmTr3DGTe7zTuZ0eJLWmhvgQRdjxrwepTFI/JJuXo=
X-Google-Smtp-Source: AGHT+IHMgpDpbbmc+PK7uCNqVABaRmIlE+D6d33fWY38Idbh1UVskgWKe0FJmTq9NQq+wKGP3zbMah+IvbTa14LBibU=
X-Received: by 2002:a81:4f0e:0:b0:5ff:7c76:888d with SMTP id
 d14-20020a814f0e000000b005ff7c76888dmr5858938ywb.6.1706823708599; Thu, 01 Feb
 2024 13:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201172927.96586-1-sashal@kernel.org>
In-Reply-To: <20240201172927.96586-1-sashal@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Feb 2024 22:41:37 +0100
Message-ID: <CACRpkdYQJUKyhSjXNGdUVaxzpycyEKb89VaFfswiEOjM=A-r3Q@mail.gmail.com>
Subject: Re: Patch "Hexagon: Make pfn accessors statics inlines" has been
 added to the 5.15-stable tree
To: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>
Cc: stable-commits@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:

> This is a note to let you know that I've just added the patch titled
>
>     Hexagon: Make pfn accessors statics inlines
>
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      hexagon-make-pfn-accessors-statics-inlines.patch
> and it can be found in the queue-5.15 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch from the stable trees, it is not a regression
and there are bugs in the patch.

Yours,
Linus Walleij

