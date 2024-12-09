Return-Path: <stable+bounces-100177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3479E9717
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD16D1889DAB
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4451F1E9B0D;
	Mon,  9 Dec 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5LNn6Qu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68551ACEC0;
	Mon,  9 Dec 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750809; cv=none; b=oGaI3UsQBGHIcT4sGlW1U8XZFKeWaWSfF3vNW6mlNCL7pfo/BZe/u8Ij0S46gw/F/UUgWUaKn9FgRadjs3jiSOWFoI/3NTG/se4h95Dzr8SJ9UDuGaCt62vbDt5f2pmHA3RsY059B8/Zc6eNg1nvDip7+9aXm21kGh1S4BznhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750809; c=relaxed/simple;
	bh=HrxdnU3SHqNfb11C7hkI7FJu/c2hKnEQalteFfFDM+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWp4ud32oBv3p8TS88o5ZrOJJrEtQR+jAQt6oF/HjpmYSpvLQJfw9DsF3jLAhAdTHApAv3TFVdvNGmxbM8Znx/Cc5cSOhhM+n3vT/damvKA6Te/ogDHuYwbTVR80BRnDECSxAiRRvYrqDn0XxptF+mrMeyszC0HYbshah30BAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5LNn6Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D923C4CEE6;
	Mon,  9 Dec 2024 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733750808;
	bh=HrxdnU3SHqNfb11C7hkI7FJu/c2hKnEQalteFfFDM+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E5LNn6QuOyH8zYg3d+MSlaHyvO/ArHWOQlYckRGfbPtFCaCSw6h5zFqK+NUv/5tYg
	 KqJKso4dPdageQF9o7p3KdtLaPBvKDkzKg7BZaHNLwEuJblr6SkStEsFid5qXGaHTi
	 ywQnti0LuiIBilV8ITDpZ5aYTof0UGAiq2i+DprcDk1INxoA5E5W/jgqCuGTKHPcNa
	 ij+/7kAXoh7PC4Rt8nE43bkwXUhruUKDHWYU2xU+JkLzAxZjIiYIJ5vtykA3MI1wvl
	 ZQVNVfI8OHNyVOaSfK4VwqvfZ2LEI9EfQfSX289+OAIehN6t7/vpqGldZY6OcCzEJt
	 MmbLqF6kGDWGw==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e39f43344c5so4308823276.1;
        Mon, 09 Dec 2024 05:26:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVImSjiEpu3YZrYlzMdiyZjBcVizszgaps4PXDVW6ncfiYtfvrbptkYQW8/b8lwS84sFP16ElPy7zcq@vger.kernel.org, AJvYcCVedSngUHihW8WI7H0XPtuWKdexm7CCEAalMeRVPbgCiMLT1NRO3i9r6hCpVw7QHaCEp+QrLZ0P@vger.kernel.org, AJvYcCW3K1s4pGHMPs4+fTLwFk6JAWGsrt3ALXx6ko/tkk0P0jd2HiypQRcp+FItG30U4ZfXaxem+BxF1Gt4hU7w@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFiJ0dxILfZq2jo4ReWutjmBtPH5ulxXKwg4kmbDIk4h3ylOn
	U8wmhebZWiP1cXAzlVWe8G6Y0yZ6MVVBPJOBdGr8hbqQqQEuQaoEP7J9EUxL6NXXboHFw9RJLFv
	ch3BNFjfA9sJh10lKxrWIA+5wBA==
X-Google-Smtp-Source: AGHT+IEuFoUDEMVC4Fc96+M6wpsqZ9pSoqWs9ryP9PAOzxwgyi3vXQId+RgciARGpopRBq57vy6ScMYUwEf1ed9ZI78=
X-Received: by 2002:a05:6902:2202:b0:e39:8cfe:9d36 with SMTP id
 3f1490d57ef6-e3a0b0c8440mr10658612276.20.1733750807729; Mon, 09 Dec 2024
 05:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com> <20241206-of_core_fix-v1-2-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-2-dc28ed56bec3@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Dec 2024 07:26:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPBSJSdSW6F9YERGaRZ5bngbZBy8f5SHKTYnyDuZKk4g@mail.gmail.com>
Message-ID: <CAL_JsqJPBSJSdSW6F9YERGaRZ5bngbZBy8f5SHKTYnyDuZKk4g@mail.gmail.com>
Subject: Re: [PATCH 02/10] of: Correct return value for API of_parse_phandle_with_args_map()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, Leif Lindholm <leif.lindholm@linaro.org>, 
	Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:53=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> @ret is used by of_parse_phandle_with_args_map() to record return value
> and it is preseted with -EINVAL before the outer while loop, but it is
> changed to 0 by below successful operation within the inner loop:
> of_property_read_u32(new, cells_name, &new_size)
>
> So cause 0(success) is returned for all failures which happen after the
> operation, that is obviously wrong.
>
> Fix by restoring @ret with preseted -EINVAL after the operation.

Already have a similar fix queued up.

Rob

