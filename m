Return-Path: <stable+bounces-206350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20137D031D0
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D355330DF70F
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F813FB560;
	Thu,  8 Jan 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ/0c41F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF408364E97
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878619; cv=none; b=dXeMtgzDmVvA/cGyHSo0MCTWGKiVs1YewZ2sxEP7Da4dszWgZU8QvGzeEmfBceq0QEFFBcPjVuZ799Bnlf9XNq22Qg80hqbQad3fgpg2+KRKHneRugFGjt33fNnFI6Sxsu4wPKj8EIUO7nm2qLZoE+ZTLLwp+2En574PKWymqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878619; c=relaxed/simple;
	bh=C3MYVjlASBlxLSn6cDz/BHDVbmrPqUXxhqPL3kfs1Hw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRpl/GrtZaXu54cB+GL1/YKDvWiRCW8i799WSFf2uepwO3f+aQXsTewoQMFkBQ4/2ZZJ8uWWtw4qwLEQjfJu5cJUJOWLurGBIsSFA4lN1nc4MxpbPmi9jiPWcBGRKhnz9fxOaC9dEyIhNnw449UnU62NHOqNIuFxjybhYC5naVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ/0c41F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412A0C4AF09
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767878619;
	bh=C3MYVjlASBlxLSn6cDz/BHDVbmrPqUXxhqPL3kfs1Hw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=IZ/0c41FWu263HLjVjWo6uSNBixa4Umfzjp5nJrLMZ88mDJIJrGTtiuaiN7Xif2wO
	 +tuQ/M8i6ezlOl4oQCoDpwaggDT2okmGbGa6vOyIxdV59pAuRpezPISdNnC5o6BcNN
	 1AQZRH/LGr6nCeiaKjPv8iCstmTiUJsFIYJkql3SvDdLCREgK+u2Aj+bYPybBQwW34
	 99J60nWxE6GZAsv84WkR+/aGV1OAF3RW1UhUih5URCHUPFb51BXK+uAUjuPp1fcMrB
	 nO8WvbzYc+ws159OVCyl5YAGnHCVkADVDaj8aNSW2JPGBhNGnaPR0l9HwTk/ZSuLh3
	 Xi6QIzNpzbqnw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b6f04cae6so1660636e87.2
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 05:23:39 -0800 (PST)
X-Gm-Message-State: AOJu0Ywstin/SWR2pfU8vXhkDSHNfzqOQ3TnpCzhyEVnOwGCy01w/TyI
	pBMfSlOrO+CmfmYgIaoK0j7kzV4K3aCytnFqW8YumjsXcS8zcdrH5AKKk3f7bmf1yalLyvadjvb
	RkbC2UoZq7vzozTV9vAGLfEo5I6zYqKnOTWXDttfz6A==
X-Google-Smtp-Source: AGHT+IF1DpptA4OTHU5XkDs4QBBLXeLim/j482m62b24s771RAQT9uNANFIx67liV08AFdh2MVosBoRHiTKv8zeAf8g=
X-Received: by 2002:a05:6512:318f:b0:59b:7c0d:14d7 with SMTP id
 2adb3069b0e04-59b7c0d3c11mr41150e87.52.1767878617868; Thu, 08 Jan 2026
 05:23:37 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jan 2026 05:23:36 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jan 2026 05:23:36 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260108100721.43777-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108100721.43777-2-krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 05:23:36 -0800
X-Gmail-Original-Message-ID: <CAMRc=Mf6hBOYkq=qyp-A=GdvFs+DB5QGANB3N158Tdzn4doFkw@mail.gmail.com>
X-Gm-Features: AQt7F2rOkxYItL7jhScjBqqwemmAm_zECSTzfc62p8N4_bbRkpCJhLIpsDoKOm4
Message-ID: <CAMRc=Mf6hBOYkq=qyp-A=GdvFs+DB5QGANB3N158Tdzn4doFkw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sm8350-lpass-lpi: Merge with SC7280 to fix
 I2S2 and SWR TX pins
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jan 2026 11:07:22 +0100, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> said:
> Qualcomm SC7280 and SM8350 SoCs have slightly different LPASS audio
> blocks (v9.4.5 and v9.2), however the LPASS LPI pin controllers are
> exactly the same.  The driver for SM8350 has two issues, which can be
> fixed by simply moving over to SC7280 driver which has them correct:
>
> 1. "i2s2_data_groups" listed twice GPIO12, but should have both GPIO12
>    and GPIO13,
>
> 2. "swr_tx_data_groups" contained GPIO5 for "swr_tx_data2" function, but
>    that function is also available on GPIO14, thus listing it twice is
>    not necessary.  OTOH, GPIO5 has also "swr_rx_data1", so selecting
>    swr_rx_data function should not block  the TX one.
>
> Fixes: be9f6d56381d ("pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS TLMM")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

