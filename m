Return-Path: <stable+bounces-144171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E7AB561C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 15:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A240F4A5E7A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547C2920AC;
	Tue, 13 May 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAt8weXh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358B428F936
	for <stable@vger.kernel.org>; Tue, 13 May 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143139; cv=none; b=HYVqT3tgftmlHMxfJXPj3uLm1fyI9aBsRLjwjHWTGYcxGWDQj/Bp+Fa1eO8MWzPQ89zw/EKCYu6DBfENXDDTa6qgz6qu8dNj/D3cDpV8UCruMsovrrKdq31LgkQcx9s9ATq7rg5diLB9O2f7mO9hmDv6GCUGJti36DiCp8vlRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143139; c=relaxed/simple;
	bh=DolSbnwhb7CK4zMm/bekFzKF/EXyrPh2OwEX9Ve2GUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imy703fEifsTyFI4wi2qg2ZgeltGJM3ERAeJosV/44tpVmzQeZON/00cGVw7853/MX2D+pEfjN96CdMoSMkJoVEw3QvTCKdygu2+FkQ4eCOH/5ppxefHGNbSZcal4PTTbAt9Q+zA95rqBVYo8Wu1KUrxbNelT2hRObRFf7LO0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAt8weXh; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7b391ba504so106689276.2
        for <stable@vger.kernel.org>; Tue, 13 May 2025 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747143135; x=1747747935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DolSbnwhb7CK4zMm/bekFzKF/EXyrPh2OwEX9Ve2GUk=;
        b=dAt8weXh0arOJtMNnoYiywf0sJy528l/UCJBJNqlL+htWtGJvosdcJ6rUaezvoRt0j
         x7bVBI2LxC6szHZgs8a8/xtjD3NXt4ZYxD8SsBIouGHsrWapfcp3CPSQFtWjwiR3lybK
         1OAnBozcYoZ35pQEO/oobXMxHqs98GHDFhCtpgw1IsrjG1VysLdrpjQAm3lH5ZABdSXQ
         RRPuKx+wtQs54lzZbgEusD/pvsxL8kkqyMHuy33aNRXKuWO1Av6PcdeX3wHatlKemzKs
         vuODq6t75u+v+frXUxexB5ejwe/Z5jLbNoKCchiCvRuIjXF1zZ7/vlYYfdr1KOSQ5goc
         Bcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747143135; x=1747747935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DolSbnwhb7CK4zMm/bekFzKF/EXyrPh2OwEX9Ve2GUk=;
        b=bhu7oVo7tL6sc0R2MccNT4hwW4X7e0ZGWjpV/HddWzxwonYraz5TtHhtMZi0/s85+u
         i94MT2ohs3l/lYjSRTXj05yT//idHe7MduNRqQyQj2FSNm3H6XqHakCMsWefyzmxKakM
         3Qsvi0DkXbtCV3I9o9A1EXB43RtWxDZjQDvxtrmBkDl1sTGNXz09kIh645EbP0IQDdxb
         EGK7ZaWD3DRaDBmDWfsg2Ly8PcfZisuVqsck8yqv+0rh2JXLarjwZwp5zs4X8LrL7Id+
         YFcq2k+HDhrDGd2UtfDRYJEqfyFgYwNgfY/w+O7b8IeSc7B+SIDYOge5NrOCJLhCjPA+
         zSkg==
X-Forwarded-Encrypted: i=1; AJvYcCVqkYfYvDUxotskiwdRF520fpRlIOiKN6QOKV7jSf/c+EAickC0K8bWGiJ4vYBz5tUtmoKwYJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KJQm91B6yfPVlIj/L0r5ly2b11GFQK5ZNJYZP/cLWAqUwX+U
	UVCZLxZkrzbXPuY7aMl2UtGLeksELxeuzYX0a68l+ueH6PM+8gYuuGDwSE4g0Iv8ZOtaMkqzgBj
	HYshxXEy61VMyb/Ws5YjQo9od6+hTkSm+fM+jRg==
X-Gm-Gg: ASbGncuMOeoSWXlZ8FPgVwUzboAZzIFORLWcjcYF3pFt7ymNpfvrNCxmMIpDBdyGZky
	z94+Rfpn+cmIfxFVSKXQs7exSFqDj+w8zVZNWTdeT9OlfPqtEzKHF6GgckC8WvSTnIolHdZVYTu
	lGL34xWV7MwBsYcxNCaoIh/5hmWn/EwQLe
X-Google-Smtp-Source: AGHT+IGiybJfQ+z5Jn7pmSBhMFaRx94JyxJ/gdqDm6nzTQPskCAu2xeEpG8J7Rdc9VcKIJc2nXp+xlFh+U2qXZzoTJ8=
X-Received: by 2002:a25:a063:0:b0:e75:607f:434e with SMTP id
 3f1490d57ef6-e78fdd2ddc1mr16588046276.36.1747143135013; Tue, 13 May 2025
 06:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511-i2c-pxa-fix-i2c-communication-v1-0-e9097d09a015@gmail.com>
 <20250511-i2c-pxa-fix-i2c-communication-v1-1-e9097d09a015@gmail.com>
In-Reply-To: <20250511-i2c-pxa-fix-i2c-communication-v1-1-e9097d09a015@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 15:32:01 +0200
X-Gm-Features: AX0GCFtjrC7TvruGjGxJFmXvhSkIZU0U-gCg7r4ao7poGNibGwZebdwuLG5fs_4
Message-ID: <CACRpkdYB6sjp4PwHumkj1kj48oUzSZOUFQTX1i==P8V2DJBx1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] i2c: add init_recovery() callback
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Imre Kaloz <kaloz@openwrt.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sz=C3=ADa Gabor,

k=C3=B6sz=C3=B6n=C3=B6m a patch-et!

On Sun, May 11, 2025 at 3:31=E2=80=AFPM Gabor Juhos <j4g8y7@gmail.com> wrot=
e:

> Add a new init_recovery() callback to struct 'i2c_bus_recovery_info'
> and modify the i2c_init_recovery() function to call that if specified
> instead of the generic i2c_gpio_init_recovery() function.
>
> This allows controller drivers to skip calling the generic code by
> implementing a dummy callback function, or alternatively to run a
> fine tuned custom implementation.
>
> This is needed for the 'i2c-pxa' driver in order to be able to fix
> a long standing bug for which the fix will be implemented in a
> followup patch.
>
> Cc: stable@vger.kernel.org # 6.3+
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

Clearly, since the same problems keeps appearing on other
platforms as well, this is the right way to go!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

