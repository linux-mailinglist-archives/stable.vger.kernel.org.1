Return-Path: <stable+bounces-183555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5E0BC29D8
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 22:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B9E3C49A8
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B411F23BF9B;
	Tue,  7 Oct 2025 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhVGKHs7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8EE221D87
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868334; cv=none; b=ZE4S4o5yKJAENEuLDuBLgQ+5CECsIYoviDMnC4RthXV6PI5Xyb2IZfOObmgClZpt6lTav3p08CAyM24j4tinlzTPmTnDr6JiRGLFFJZQbVGPeIhrqgwpxJvXq68kbV7JlTkUQUHPJ/WsDxvvAuxmov+9zEqt+Pw/bG/3+C/K46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868334; c=relaxed/simple;
	bh=t6o7XkzKv+u7CI1UFQteRyBrmLJdqDMJ8YxEK4sFqGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYE2FceQLcXeOOdwe5LMQWu3oblaPAP96uzXasEXSD8oc3zu9FY/8bQ2Oi+8JW1dUsLRPgOsE/clMP5O1e8r1nWHCaILTmUe9hH31kyIlBgk643AihoI2VQEEunD8WaNGUTlNqVDBpiNi79S7v+m61IE/0pGUqISDjXR3VSzCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rhVGKHs7; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-643cd58c678so3778795eaf.3
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759868329; x=1760473129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6o7XkzKv+u7CI1UFQteRyBrmLJdqDMJ8YxEK4sFqGo=;
        b=rhVGKHs7oYTNAYvO3uyvddwiDnsLj1Apvj6uZxAf68G2GxTNh/nADowc85TrHZ0LIm
         /PNT4M4gDH44gt8PFQRRexTGntgKAwc4L1DtvDxDGRtPQu316KHpS2Ui9zKQVRAgcTXs
         7L/7W0ojPdKo7IagQ1HH9lx3fUq+ERvYwNdibuQDlYQRDAJxG3DlK2FiOdq23UJu8EJj
         Zt2i1N2CaOGUXtsADZkJMuGZadm6y/ukulFMnqFr+alfAc6NjOshH4khKASh75FYbCYi
         Dc0aTObxQbeZNnWgI5VZnWOiKk7ZMp7gdiqAOL6jU6aJC8SIYN/pFlnOzF/sdBgOImZF
         tRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868329; x=1760473129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6o7XkzKv+u7CI1UFQteRyBrmLJdqDMJ8YxEK4sFqGo=;
        b=mPM6DY7klu+kjcXDU1PZU0l/zTsMklMsOxyKMNp0Kpy23f2yIEFUO0M1zfSRipnelP
         Sj1LNLl4U9hNrwm1/cLl6Pg8S/zu85oi2jzb39114+4S0idsYrRmAm65z7bhfEIrgigy
         +/+lvBzCMRZab/bGJ78nWk1w+8dqGwd3zsnxaVTNJAZk1NTbxmwhExB4EttDMiVhRalT
         B2NBpelplOeX14gClb9R634Vt4Fv3jK6lPHHqCGNLJ3fBWxqZYnck0hXoCL4f4PuuO80
         Hk98cmEYAHzL56SDaRNVf7Ro3GUYPrlGmb8rgVADwj3LAQqwR1ijRTskZgMobuN0n6oX
         zZjA==
X-Forwarded-Encrypted: i=1; AJvYcCVoJmyjzY3dLb+aYs4jhmE0DtUcvK8NYqfW+M/ngPEZRJZciv6smS4s8lMWvJ78qozPMaxYa8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCV0Q8DdztTKg3oOBvX9eOgxYwgLmAjj+CA4QhqwTB4uTi/pRe
	KnRrRaQHefKAN2QFPk106yVOmxzIir7+bbEavigm33uxpRp5mKZ20msGDB77TPlm4+FbjC6kffn
	ViGV4VqP+C2u9ijC0N3p9etQqHCsaHNd39Ynnr9aimA==
X-Gm-Gg: ASbGnctwN9sWrERzsYlAyz/E8FKK8UiEpUavCvisfYPwtQrTbQ3I/z11WnsFmdbFW7c
	C+GeyNmJSECsJCzwDdSoP23f1ML8UoraEH/K8UchVrj/N9FnCqvIES6sHi62ST5QfKZysg859as
	7Jv/pOxDTaP3frZmmK6fqYxq3Wxkm2oSuD+rdcLR2RdMdHPEjhaDIKvY3k1uBox0ZgCRJK2Lsn9
	bE7a7jJUzRs62w96f4KaPlOdOwlwP171xF15g==
X-Google-Smtp-Source: AGHT+IEL4dmypG8WFgpOU1UIUsrODE8etCKEY8zyKzUkyzhaZJQ8flhaIQqg8X0wJtfFE1WkEjdwwHsi6B9jL21hYVk=
X-Received: by 2002:a05:6820:a10e:b0:63d:bc20:a63f with SMTP id
 006d021491bc7-64fffe6daadmr379683eaf.3.1759868329050; Tue, 07 Oct 2025
 13:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
In-Reply-To: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:18:36 +0100
X-Gm-Features: AS18NWAMBYtEWn2vhviwKZeJuPljrJcOS2KOQNcYCHTnuQAmZAXGTQe_GLqqgoE
Message-ID: <CADrjBPoZpTUN5N_Gh6E0LFmndJs4_nnSpQ0t=XORQHwFn2=BNA@mail.gmail.com>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix clock prepare imbalance
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 09:07, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Commit f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend
> with UDC bound (E850+)") incorrectly added clk_bulk_disable() as the
> inverse of clk_bulk_prepare_enable() while it should have of course
> used clk_bulk_disable_unprepare(). This means incorrect reference
> counts to the CMU driver remain.
>
> Update the code accordingly.
>
> Fixes: f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend wit=
h UDC bound (E850+)")
> CC: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

