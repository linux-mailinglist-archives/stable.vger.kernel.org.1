Return-Path: <stable+bounces-204392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C849CEC9A8
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BAC4301028B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392591E5B7A;
	Wed, 31 Dec 2025 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSki7CzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EE154BF5
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767217552; cv=none; b=apcgJKbQR1kloRt+1ULMIplH3To2ppns5malU7p1eY5njPa6QANgPSe6DBHCXj0PT78rMiWnX/jpkFarJOFq/VME4kyk2gLOY+t7uB+G7ezmtc5iAdg2xVEsuU0rMm5Klp3L11dcbhJ1uRCUwwRFvDas3kZNMMdLpLuQpITcp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767217552; c=relaxed/simple;
	bh=nhc5HTSzr7Ox4vfUcojIDAEtv5yQfWNva/ya6wKSDZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6aqcmSw84ulWKEf3TAzRpkvyRcaFCtgqQRkvgd+kFmtswwV3UyU+bcMBlp7Ttn3eabE/7SqAVjw5eGvcCZMly7BgS7w13Q9lKqhK9XtwMCZtry8hoCka9z7iKT5H1qkTSj8psCZo1SIhu7U/Ufj4BQ/jzklDUAErfN+nKRax6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSki7CzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2622C2BC86
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 21:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767217551;
	bh=nhc5HTSzr7Ox4vfUcojIDAEtv5yQfWNva/ya6wKSDZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XSki7CzGqxR32voe46Tto9rfuFLZ+/ddejqp0JHA0n025VqVk9rNETry8Ljw3G5+8
	 panL1BnmbCKM1I+LEga7iu2+BGSIb5gi+kI8sHGI4gAbpibIdw5znazkYRz9o5zeKw
	 DF+Rkl72riKgLq4Jypabk/lfSwN4A8Ui0nl7TSa06xCdge29//1Fto6Ytaw+wf7FHp
	 FyTQuZzdwDLob9n9h2dvBJb0fHDWSyj9qEApShzaP4MJO0PDs3kzp//VQEQxVQSOJY
	 WbMKJEbCtKCZ78nNBHF7Di8Nxv/2/t+mYUz0/laVwU69ssMHDNySZkeHHCVHWBMwaM
	 GlanD5wP2HPFA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-787da30c50fso99620367b3.3
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 13:45:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYL34a6/W+x63Y/8y0zjjo3EUdXIVq/LdPRSURkKEBVVvKaeAaGlOlXxfj54PgxhH0SWZUatA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybvA5jLTK1Bnc8+ZEs1HrdnpOA72wR7I9OsH/IknrxWTzn7u0N
	GJd3vAJ/QajGTUa3UbQ/hF7QB6Yw61F+J0Z6++xQFjAQQdA9amQjoAkkkLNLVRGFV0KO4LmP84J
	CnH4Ji/IojVo7ADjxQqIJZGka1uhgJNE=
X-Google-Smtp-Source: AGHT+IFxAbQIxeGevbze8OQVhXJ9wP64YDl4RYXJREXnTkP1gMcNq1jCShGAq320jcyM5otpjkE1BmRtePLq5bx5pqU=
X-Received: by 2002:a05:690c:3803:b0:78f:984b:4bb5 with SMTP id
 00721157ae682-78fb40c5f09mr590261177b3.64.1767217551063; Wed, 31 Dec 2025
 13:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211123345.2392065-1-linmq006@gmail.com>
In-Reply-To: <20251211123345.2392065-1-linmq006@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 31 Dec 2025 22:45:40 +0100
X-Gmail-Original-Message-ID: <CAD++jLk8DJRjwDW6MH+CFXOQFhP9S0NNZJ4TKDZ2+t6W84qb-g@mail.gmail.com>
X-Gm-Features: AQt7F2rlCQNyCYzrC5L2nUkzSaWVFHq97H9Hsr63d209d6TO0zHz9GSEAX5mn_0
Message-ID: <CAD++jLk8DJRjwDW6MH+CFXOQFhP9S0NNZJ4TKDZ2+t6W84qb-g@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: Fix error handling in pl111_amba_probe
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tom Cooksey <tom.cooksey@arm.com>, Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 1:34=E2=80=AFPM Miaoqian Lin <linmq006@gmail.com> w=
rote:

> Jump to the existing dev_put label when devm_request_irq() fails
> so drm_dev_put() and of_reserved_mem_device_release() run
> instead of returning early and leaking resources.
>
> Found via static analysis and code review.
>
> Fixes: bed41005e617 ("drm/pl111: Initial drm/kms driver for pl111")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied to drm-misc-fixes, thanks for fixing this
obvious bug!

Yours,
Linus Walleij

