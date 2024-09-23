Return-Path: <stable+bounces-76891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6471B97E855
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99ADB21007
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10119194A67;
	Mon, 23 Sep 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXcTn7ju"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA53E194123
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082918; cv=none; b=g3OymVgXgST9+RioTRf3qgV6pfl+XAejFTuHRIKYnBOjfBG2KCvrTwdiifWccfOBD5KMHWOUEUGOUhTkFHmgtzPKioqTfEZHQqQnR+kJ2NI2ow2I3jUU2i7yYyIMiWotMs5Q9egrnV/plLxndZfdJGb+WKCVs67hY1zGCctrioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082918; c=relaxed/simple;
	bh=l9Bx3i72WLmyjAwVDpDo7xamY2Wn7yIoE8/sEWQgZJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0ESP9rmYtMFOmyZAqP73lB06qoifrKjI1MQoD9h0N1h8yDVzlst8yq/VSZgCNAoXvmibvP5S+BcQVVCJ1DaOjQP1fSE+3GPlXROlGU2hkXFXKv9Z/zwtIGWlOawOZkxdtKF7+xVQMu+vv8jtjBMQRYQL+dhEYd2Lpv96kq/40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JXcTn7ju; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so4288594e87.3
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 02:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727082914; x=1727687714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9Bx3i72WLmyjAwVDpDo7xamY2Wn7yIoE8/sEWQgZJU=;
        b=JXcTn7juDE92YK21naA9GWkCsBWZNWTMkpcd8eJWQmuiDJukEHs7l+G4eZz8GIC4P4
         jz+NTJN4zNyAx6XNWiQbkKGhVev2RFMG0nuQq36jrNmkdxMQ10PtIx2FmuUqaXftqPtp
         nqdbcd9s+czeGZp/3x+rEwxYiDPrYOeo9f2C1b3Y71poDI5zcrXpF9veg2ZBuENuJ8xp
         v9enfyVTI8j7l5XhVeeV0HqeHI+Jdq4Q46ZyUjsTPyiOoWl+h5w9yZVX8a5tDrP7gFBF
         QAYgD0gsGXFyn/kUd7Ykjcwrv6K9z+IOWpZCHfBZvg3Pt0BM0ctFccxG6FDu6iNZN96J
         Q1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082914; x=1727687714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9Bx3i72WLmyjAwVDpDo7xamY2Wn7yIoE8/sEWQgZJU=;
        b=sXuFzw/rK7t/3CcQva8Yoqfx29EzhUESAhs8qamdu2ixDQw4ZKP+OWrRKLzi+XgEEo
         aW0SwSIsFUh6f/zPrFZiHCXUl7m41pY0CL+lmYT9qBEEdsKXAjN5qVBzg5vxdgX4B0qz
         wDGU+hiQRoisYB905zkRSTtK24nHdfi4syxcxvpraHkqo26TtigRKPS5XpuMTCiDQkyf
         zL1WoGqHXfidJZE3+cTUmEz0Bx00vU2qg7C/UVwoD/CV+IqRuBz2ihYew62kiPrbcxl5
         MQs0VqKSkInYIE1HV1ZraN3sNw9Az20cTYSSKw6JPVmeJjX2/8K/lZPUixk9hWtVXuYE
         HD9w==
X-Forwarded-Encrypted: i=1; AJvYcCUnba7Yth9eJkXSrJVi5HbScokgDw1FkP2OiwGMS5GyA7aGJiRVabzwieWAoei2g2PTLTjNXEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq55dJcEj1U75MWKJ1KsuHBPljSFh75iBhn3cq+H4B1Y1XLZ/L
	U95LVGTDLCM3ctUQIPCwDP/T+tFx+axIgrz4/kVyRZiYRsTzdHNiDf7pCKfPH1Ql9i+Z0IqKhmm
	mFo31xtopdxFc8oxYPZwzwdNYeyDnOUxkhxJQZw==
X-Google-Smtp-Source: AGHT+IGm9GYGA96TsHIKMdbS8Ksl+Y69UudH4mPSC68ZSc5eoQB7wn4Q3RxtR+3CXYd3V8oySBmv3CffJB4G3FFeKZ8=
X-Received: by 2002:a05:6512:10cb:b0:536:2337:7de6 with SMTP id
 2adb3069b0e04-536ac2f5b22mr4443437e87.34.1727082913853; Mon, 23 Sep 2024
 02:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906100326.624445-1-make24@iscas.ac.cn>
In-Reply-To: <20240906100326.624445-1-make24@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2024 11:15:03 +0200
Message-ID: <CACRpkdYEH+xEeD+pCpe_LPotaWp95X38NHouP4746bww3-hzXQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: stm32: check devm_kasprintf() returned value
To: Ma Ke <make24@iscas.ac.cn>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	bartosz.golaszewski@linaro.org, patrice.chotard@foss.st.com, 
	antonio.borneo@foss.st.com, s.shtylyov@omp.ru, valentin.caron@foss.st.com, 
	peng.fan@nxp.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:03=E2=80=AFPM Ma Ke <make24@iscas.ac.cn> wrote:

> devm_kasprintf() can return a NULL pointer on failure but this returned
> value is not checked. Fix this lack and check the returned value.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 32c170ff15b0 ("pinctrl: stm32: set default gpio line names using p=
in names")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Patch applied for fixes.

Thanks for working on these malloc details, much appreciated!

Yours,
Linus Walleij

