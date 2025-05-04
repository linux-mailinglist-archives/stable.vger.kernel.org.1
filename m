Return-Path: <stable+bounces-139574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8435DAA8964
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 23:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD47A7450
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92882472AD;
	Sun,  4 May 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="af7vzxCZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CC189916;
	Sun,  4 May 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746392852; cv=none; b=sWxE4cA9pGQWuJ8a7LJhnBtZC/Xp/82VoGoWO6uQI8sYvVteQWankFS8hNwYnf6xOIZKfIAHwmJk9dMMpGDWP7onslBUUwaFqZg6L7AR5ZaOCvuNP8Z8bGIvy7qlp62/ll6lMx18upCAN3DhAK8J3rjb4AOv0RaDBpERfl5623M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746392852; c=relaxed/simple;
	bh=AUnzwvptOByim/ucOYr6TfZ9ss3/DQ7PxM0faURq4oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch+ByVM+nNC7kRwtA7GcdsTJDpWvIDyePBjTU2BcA1YeFyh94WL5yL0fbTV7MIzeZBcP0KQSG4wnvaynIQry/NOLzISL/w5M1AdIgCExr0/YE1PiWatNBooSqJ4uT/DAXLs2c7VaMw2+LbyfgQOTiDmxECG6Y73F0/g+/fQXXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=af7vzxCZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240b4de12bso61192105ad.2;
        Sun, 04 May 2025 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1746392850; x=1746997650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUnzwvptOByim/ucOYr6TfZ9ss3/DQ7PxM0faURq4oo=;
        b=af7vzxCZWX86fWAJgCKZPXMMI+lpCl3cMjP2ePptHfvzKAHftK2LGlfSC20VQZPPRL
         Hkam64KKfD8q5SsafHzRScdM9G7dfU8UBds8BR+v58WpKk4QHpgdVhGEDZzf1W/4D2Ls
         WmPpN8Hwd5uJjO/kiyk49Ny359iJ2OvE7RAYm7WUENv3XByMBtOtYYZNJaGlGLAKQPy2
         AscTc4jHfUi4Svv2CT2k55J8E/hklsS9fHochbC71H2pYguaSLcIq/PaVboSgNOzjrjC
         yEhY3DiyCbM1s5c4J6BOldmA74XffI3MeN8MKIbUVFszDyxZ3YSTtWRnB+lSWl2oW5LQ
         0bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746392850; x=1746997650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUnzwvptOByim/ucOYr6TfZ9ss3/DQ7PxM0faURq4oo=;
        b=ZHpya9ZhRKM5RUB14I+73D7/bktJ7AzwdmoagpnCxFHvHb4FkQPZRoLRftEEFodDhq
         eZnn1DJhKw1KbyyM0Hf8jYp3z1itbkss9uMRROslfO4uH1Tc+hhPsHKrBtniMgmBY5NP
         DEGRm+6uCjEkO0J5aA3++bus6cqq3iWmdDRkA3U66qgWDm5NRwXuErSYu826i8AS1Czr
         Ap4JB4OIdvyfqnur+5hdsoPDCvKWoGwWls14arpLYvQVwAF8AMpjmdqNUDOK8ebhsjSM
         vKF2VBLP/MYMVIAoejO9bv7t4kW7oprJsqwsviIhrX3pSJeMalVLmutVHqoTMOQ3pLZC
         00sg==
X-Forwarded-Encrypted: i=1; AJvYcCWUjoRn/DVfBwimU+TrSQE8NY2ubKHWRws+ddjXCz1OKqpGFrW0gnnWVt2AOFh6sko8m7GsOxqb@vger.kernel.org, AJvYcCX1SB/HPFz8th3SRZXvz1PhM0EcjQNMocvptszqI5WSlN7gMj4xYIIbqVrHYdhMK5iTLZitXxnjTXKZ@vger.kernel.org, AJvYcCXMZjvGtvQX0aVqZzAD02EbYokNTMg6IP64whuqkGW23Csz0+Y1z70vaOueQjeoG3d4mLezLp6yDUf2q1pj@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgKpIK8ENPomISBwuDbOWCGWobLKOmW2Eh1sVrbrxT+cH9iqu
	qhvlOxfMgmAN1SRHIUyZ9eMBrZDUPxArY87hGSiGi8SNyxqGz5tpG1DrSGI5Ku9wPdS6HfgMif8
	66TNqknJFcUGjmGiMfl6UJ/r+CFW+rC5y
X-Gm-Gg: ASbGncvXqja0CNXbr8o0Erc/ca9OsQGdKk5NONzLPW5AFsBTGQW2ANQRGIwVzpgXi+1
	Gmak3tNNFlUOMgtDeTCe4X8woYpqApwedL4nfUK1GrlimIJdjiiVT819mkZhVR50lYvxgZ0qaJx
	oVt/gKCMq7pMb/smDSxMNMwDiAiUvmhsZ1I6zuKvynyewaidL80EAf5qw=
X-Google-Smtp-Source: AGHT+IE4yCRULV8L0X001s3hseepDxE2pMX59fNpwmKQdirlnzPxqBjXHGsiaArFgHU3ITvCieH+XPwI6UqVlx0sRJ4=
X-Received: by 2002:a17:903:11c8:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-22e1e8c3ee0mr62089055ad.11.1746392850175; Sun, 04 May 2025
 14:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503084443.3704866-1-christianshewitt@gmail.com>
In-Reply-To: <20250503084443.3704866-1-christianshewitt@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 4 May 2025 23:07:18 +0200
X-Gm-Features: ATxdqUG9_zNauUndvpj8bS3vMeW4x8DGoy38X_LVK07lpYOYelvTZu9YHJNhxnA
Message-ID: <CAFBinCCcGk9dRUp8yj740OMcgcck2iWe_cN-J0jOt5M74+zBgA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: dreambox: fix missing clkc_audio node
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Emanuel Strobel <emanuel.strobel@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 10:44=E2=80=AFAM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Add the clkc_audio node to fix audio support on Dreambox One/Two.
>
> Fixes: 83a6f4c62cb1 ("arm64: dts: meson: add initial support for Dreambox=
 One/Two")
> CC: <stable@vger.kernel.org>
> Suggested-by: Emanuel Strobel <emanuel.strobel@yahoo.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

