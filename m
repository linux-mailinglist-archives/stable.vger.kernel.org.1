Return-Path: <stable+bounces-45226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0A8C6CAD
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 21:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2011F22463
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C25159598;
	Wed, 15 May 2024 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DwXOaEWw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAAC1591EC
	for <stable@vger.kernel.org>; Wed, 15 May 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800576; cv=none; b=H4J7b0IjQviYl5j7orGBYDwIpfb5TQtzknWTrTmUhWtkfmmIlrlY32QSEa98VtDCkeV2L/4zVqGZTsuqGCfqlvo9uHvbOBTlz3xWNGq8AtK4fTeiv/lXxyI9TewuGKr88iPHbT26ZBSX57XgRmRQ++H6ptFcL7AQTPJ2rUqJ2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800576; c=relaxed/simple;
	bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGccvT2+EvzvSXQdpts5NcK6l/TMz1XBctS5+1DpJzeNcwi5vTfGP/7nXVc/hhhj6EnINYsA/EOZ4dAZlaxZQCAgNI8ATKXKq4b6cshRaz1MvU1j1T2OZtHbVXdL+dbWd5L1xdn5FS267l9c9dczHerEFaTmppkJWK1SMDC2rPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DwXOaEWw; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61be4b986aaso81151357b3.3
        for <stable@vger.kernel.org>; Wed, 15 May 2024 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715800574; x=1716405374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
        b=DwXOaEWwek0SnPySO1ARVc0A/4OgrkGiKRT5mcLRlWNxBKGu93kvckwdGoev7VXqes
         8oP0wLbVNorcM7UTp5kFPZa+XHNMpTbKO8gCHBsFl1m9nbc0iln2Gz4tJdmEwV1i7nK/
         1YYuF5S2eQ7VOUG9MD8cQooIgx5qll6LjsBPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800574; x=1716405374;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP5LyQsEGquqKItcS87RpeQ08Gmx+s5LG2B/J1Ts8Iw=;
        b=EYi+xp/SKbvQqG5HB09q+vpgnf+aA6YyG9I6KkVAJL1rby+4d5gAvHEQWQEia3mW86
         7k4hOH8+snBYIezyH3/0sJjK/P4p3kuOLxI9Kgjom/ttug3MyLjgYBmwT+e+2RV1mPgI
         I+5ulNoEoZZY0T7ivy51o0E/b4DqxCMfkK0iNhwczU9GLfbLUAnFBShyZF1sGjcitzuj
         bseA3NcPEk10M05iDbtf3PscfLhProojSC4r9sOzPzFfr08fnFCoGZ0e03/Ncm8qYlzJ
         +dM7ntBKq6uSUi2WQwzeJ0ZlCXGJ79kbsTQ+Nwe8khQ9CwLT0+MmNH7sqK3df1Qpba30
         x7kw==
X-Forwarded-Encrypted: i=1; AJvYcCVSbHyhMwsm3Tzy9UNmU+HzsTC4HFTu/89x50GXM3lW4p5gEVYPPxaIMlj7pVUCeGL9eMv64bWF3B+9dGv0h8odYOQpJFN4
X-Gm-Message-State: AOJu0Yyqms3b6CBRdGYYQm403aNN89Te6RV0CXeccTfSd/xuaK1gntA2
	CAHMs6+KUEqHGMTzHfuXxHSTlwQ/Eamd1vZeNvQ0G8toIqkjp2Vu4x5pUcRlN+0Q6rWQECoVf1g
	+oibbu7DaHxws2djKquAPV7M+SXlgsE7jp+IN
X-Google-Smtp-Source: AGHT+IEZFVp0/9J3vEYY3DeetifpNlyI7Reu7bida3ovANfhBvDsm0gF8xGPrJXaQaXknjiNqesUsWMhYeDWThoRIkM=
X-Received: by 2002:a25:6b41:0:b0:de5:568a:9a9 with SMTP id
 3f1490d57ef6-dee4f2f7f74mr14602381276.38.1715800572793; Wed, 15 May 2024
 12:16:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 May 2024 12:16:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
References: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 15 May 2024 12:16:11 -0700
Message-ID: <CAE-0n52ptoRRQEL1G9vTZ7ExemrUSmV2Km=uts_E7wBeoz_GcA@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Rakesh Pillai <quic_pillair@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-05-11 03:49:59)
> If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
> modules, compilation fails with:
>
> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_init':
> drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qcom_register_ssr_notifier'
> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_deinit':
> drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qcom_unregister_ssr_notifier'
>
> Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
> built as module if QCOM_RPROC_COMMON is built as module too.
>
> Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as crashes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

