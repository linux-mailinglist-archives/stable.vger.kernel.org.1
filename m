Return-Path: <stable+bounces-144173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB18AB563B
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF62D3ADBF9
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33B528F935;
	Tue, 13 May 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsjJ3Bau"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B761EB18C
	for <stable@vger.kernel.org>; Tue, 13 May 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143411; cv=none; b=SiP0N+cTN0xB7NxqTX+NrRbTTHbngGKLhMzGYxJvO/0RRC8yXItpW1b279ftejKhTWqXxEwm6M8GqYvVgGa5OSz3l4wr642VOTwdoCp3i4dBsjOa+SzOMZQxOjuMmXq2b4mp68ahw8CyuMtmmvzPiw1pvBptHolOTkBXXE7RKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143411; c=relaxed/simple;
	bh=7/JV3Bh1ZMG76SNJlwEakQzpLhMGq/SyZApq5+emUOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cS6Lec5oQgmexRGcBUsRh6HGJkbwkibR7r/mShU5c114K46G8Jym7tKOPe3ryLG5Z0lGXqkQe9gZkYMFJf66uLmzlGIICyzN1JowGBQA4QF2klszVMwFbxDdbnymUFdJ3aAKSzw9+YgEjoULfsdgAJob2bDmaDad0cv08zOPowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bsjJ3Bau; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e755cd8c333so5200752276.0
        for <stable@vger.kernel.org>; Tue, 13 May 2025 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747143409; x=1747748209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/JV3Bh1ZMG76SNJlwEakQzpLhMGq/SyZApq5+emUOc=;
        b=bsjJ3Bauhrxj66SeLds/jKKdWSZlOHCYjNoQK2rdcCsrPW2uQEpk6EGUfbnUm9Ccg2
         /qyHbjH8bZTlvc6QSQplKyx0GNjCZeITDZ15+VYSysKWPLCCH2AT6wdNLDWS3inU9VWU
         bLsgQuv5uD5kNK3rtSh//1I27/5WDsQ/rVSC81YoMt9PIBR5GJoQki6Lx///PgwJooz+
         pwicL51IebztsAnBQXUypKaCOe7CopYoAnNHpMsPBeSEVCrQj+Bb6FktymvoC9lb0O0N
         1WDNGkD+pgvltlovGQVcBHroH5cAOXSLMu7wyc7xNMT42ugeX3Of6/BBuleIj8AaATbi
         aW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747143409; x=1747748209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/JV3Bh1ZMG76SNJlwEakQzpLhMGq/SyZApq5+emUOc=;
        b=cs9KlOHSVozL1K5Epj3xQwZmFHMIgwYwbQdMg8FoPgXAArMUnsMCi4pjxl5wdUvDLN
         j9rkCdS5SMYJ+HHPyUAPuTfCF62TpTU+sbil7iAj5Pzo19kNcDGw6cD2XJQnJU9oFlmJ
         so9PCoc4JqOHMTE2LrrJL0s567Ut+go/xa8Idp612LEqqvLZh36Nfp89ZlgfQnRFS0+m
         aIez8Z247T3MFb9n+XDFht0C5MCufRjIaCfcqAgXq8RNKuUEgtjV5ooluwTBT/pffZw3
         FIupk0vCQsjaN3QCviHyxSoFphN2W2AosHiFLVZkoiuKcfIvnkjIiocZmgDR8OkD8rPf
         ud8A==
X-Forwarded-Encrypted: i=1; AJvYcCUJuItmL7Xo6iG1CXUjiPnKHbJnrTj65piPydjTDgeumO3t32Cf2P0/tuOBgaz4t27GdltrmEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8iHykduxRMpv0SX8ehX6ZRhWrXz+AfkIm1RHmdyzenyYDUDXB
	+zNZwAfjOUheePeILZO0qVO0ZIpzTBT8CyVCWyD4hbltJcRW6PQLsfCKeN1moGC+ahhIpW4/8Rc
	4l+KbYNJS2IVO5v+PXlnAUSmFxTGk3uZnQ/0QUZkA5KBuhEas
X-Gm-Gg: ASbGncuD6Ta96JY8B5JGJ0slyOwaKP3AkOTgakjjV8jQFI+/CJ4vj/epxy4dBliPLiH
	Za7D0J/h4XRqZ3iGrx3DUmdGfgWe6sd6fzhUeKBqs4oxLGlhxDSCgHM2bDZDlb9xHA2e7OTQ6sH
	z8wUndiYbX0DiKOpz3xwUP4qTO0sL5YzbX
X-Google-Smtp-Source: AGHT+IGPspzzHxed6rft90BBazRRlyKn4YRNf/+L/ffhEMrgXhwvAkFISkzPmGNOJE8q+cDfmA7yJkalBx150TF+eCU=
X-Received: by 2002:a05:6902:2193:b0:e60:a068:a14b with SMTP id
 3f1490d57ef6-e78fdb83501mr22863623276.4.1747143408924; Tue, 13 May 2025
 06:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512-pinctrl-a37xx-fixes-v1-0-d470fb1116a5@gmail.com> <60ef3803-4f8b-4d9b-bef8-6cf3708af057@lunn.ch>
In-Reply-To: <60ef3803-4f8b-4d9b-bef8-6cf3708af057@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 15:36:36 +0200
X-Gm-Features: AX0GCFtHZ-lXYmozXKJTmAfMPph60MlOaJrCz7XDyOAs3Cz7P-VVNfFyia5m6R4
Message-ID: <CACRpkdbqPLaBheEv1=ky1gUJ-qSsPRjR0J-UXEuhXf2Oix_EzQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] pinctrl: armada-37xx: a couple of small fixes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gabor Juhos <j4g8y7@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
> On Mon, May 12, 2025 at 04:22:36PM +0200, Gabor Juhos wrote:
> > The series contains several small patches to fix various
> > issues in the pinctrl driver for Armada 3700.
>
> I'm not sure all these should be for stable. Some are clear bugs, but
> not propagating the errors has not bothered anybody so far, a
> requirement for stable.

So we are at -rc6 so I'm not sending these as fixes to Torvalds
right now unless they are super-critical.

I will merge this for v6.16 (-rc1) and then the stable maintainers
will have to decide from the point it enters mainline.

Gabor: can you look over the tags? Once you have decided
on stable/non-stable tags I will merge the series.

Yours,
Linus Walleij

