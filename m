Return-Path: <stable+bounces-194872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B284EC61864
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65ADD4E77AF
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9630CD81;
	Sun, 16 Nov 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aknmoqcs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6930C60A
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763310043; cv=none; b=OB4mAw4Pn7WWnfm1U0LatqvDRDZJt3HDlp9Ec0QDQIeBf0EKhLCxN1v1lE6MwSrhsB4w+bqP9Qh+Vz9I6+D92CC6XNQOH+ikoqOmmlmoQ2NrOp+yHt3DoWdW/+oZuQ+zygn1/qvsrTM/awxZH9F+S3LCUw+t+HQYVcO9SL6RDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763310043; c=relaxed/simple;
	bh=IcWG0c7Ap4vHQVKjcGsS3wLPIyj8+cOECPrxfy8qqX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJZOX5rrz29N4pVWJNp+aAZ2KcjRhvjyGHnd5dgI4CQNT4jmrUORFlVN8nTSTe0c4Mlm5OguiIzX2NBCn/ylk8XY8GRNwQQ9jeTA76RlkpN22aaftPkafTJUV6KdsRonutKhnQFvJn8TmfDPmXUAdMVg4aTMAW8X1O03VYwVbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aknmoqcs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b735e278fa1so489639666b.0
        for <stable@vger.kernel.org>; Sun, 16 Nov 2025 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763310039; x=1763914839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcWG0c7Ap4vHQVKjcGsS3wLPIyj8+cOECPrxfy8qqX8=;
        b=aknmoqcsJdOe5Kp9laS8fEBxGyp/YzrI9hVWDh+RQ0fJnC32dYSnW20Ed4aUm3EeCH
         ZJB7+FIt2yYtyNoPQ64z4+VpNe3U9wP0Jyfw6xEVKUjPtIv/6xknlpdZG3P7ZAK9f9mu
         cFheUJRrUeJh/86ZI0eGZfXL/wuDRJxEJ6KhMDgMAZo0m5VbqqzIhqJ8Y0hXndkNxqdV
         IG/ir4YRJwZYQzXmz1eDooCV6gAMmw9Q3ZMUKme0ToU8rHjcO2Z/BbmUywkN+Ficesk7
         UXnQxPdD9sAl5OpCGibBNdCNj5Lde0PBTv1EIOHzmHMqgkHJvPocDg9tjI7FVjfJ3xGH
         NMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763310039; x=1763914839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IcWG0c7Ap4vHQVKjcGsS3wLPIyj8+cOECPrxfy8qqX8=;
        b=U+s/1rjv+xxqkd7b0NuMdO2vDXGKp0FdXU0EFNtv0m6XeG/oYTw2ObjA6jIsPMYlLo
         YIcH4m/f4dDKyvQyrebirNGunBc/gu/0c9Z79wKTiWEEpY48ArscAZiSvjvMj7PJXNCW
         WDQm163wGQqDeGVz8G07Zgkvgt2H60v0MSQXcDwbG2rh/qFMoy/2UQbHmZNKIHKluCTE
         6z7P0/jX9+kQt8158wOAboiQ1mDmrYWvWU4Qu4gP5Ws3hK3aFTNpkHosWGMAaawhSVPd
         /moCKg4QMpcZCyX+imQYgZ9r4WmwQNJLMeIYCDE+f1cGfq15hvzJt6+HEpxBFFDlxFTR
         SA/g==
X-Forwarded-Encrypted: i=1; AJvYcCUvT8gvsCMdW3zeQ6ovKbaad8JUg7KMCaOtSw6cP6aZbeILbzPnGSta1vF5m/pXlb4krgKisVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/N4LZu8F2P7OkVN+x0LcE8cFm8YnXJMpagzyJ3uvmIGWeb3rM
	mZZvQoEo62KySBI+CLpwQrNqMJ2N9NkaI4r+lYDYYkfzDPgScFFKsNf/
X-Gm-Gg: ASbGncsaUlWN8vxLnnmTAYVbcoclojLNlFzaukqAClE0WrfideKb1XvIa/g7iIEL1Hy
	+JxATICkg2SOU3k97gfuJt1i7Y9PkYh+YGNb45SbXhwfDWu2y1+9ojI2CfLXxd6aqmyeDU5HF0j
	ZsjN3o3Hl06JQZ9S1/T+6N6gBCudbJjz8SVBtw71J5KaQhVKcw4d3xMrnKwq0l8nnLhYcFzrgFq
	DGMa6F5y5M4vUZ//fF8rul5TApQQ+frgmoOolbBxVhun18Z9XKSmtdLEOPqnJThv4dksPIh8qNI
	jltQNFqXjJtAAOj8TI/xYyVRZfMAGJtDGpibCRLBgm1E0kyIfBvtl01XGq4zF/XYM8ccZYjUJWZ
	Jr1t4yhWB7TprhKDe95xNcND61N0abOPHKbd3z+JAKa0FTnpRsmWRSIdtk/sdg0ZgTYMgiEjgvT
	YUCUaLcSGcs88jDn41gFUQBjfw9YAiJn9cDd8vHSt4+cXrxZ1yhcPW7ppKg84A+m7X4YBGfuZoy
	vE/1g==
X-Google-Smtp-Source: AGHT+IGimZSxkgoIOpfCKAWCHgTmcdkmEWm6/VMebPbmR8mxODGAMWNDh5ErsjYw3DRmDL/5wQcxSw==
X-Received: by 2002:a17:907:1c81:b0:b71:2145:dfc8 with SMTP id a640c23a62f3a-b7367962422mr1083057166b.39.1763310038731;
        Sun, 16 Nov 2025 08:20:38 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdae69fsm852257866b.51.2025.11.16.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 08:20:38 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
 Maxime Ripard <mripard@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Thomas =?UTF-8?B?TcO8aGxiYWNoZXI=?= <tmuehlbacher@posteo.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Subject:
 Re: [PATCH can] can: sun4i_can: sun4i_can_interrupt(): fix max irq loop
 handling
Date: Sun, 16 Nov 2025 17:20:37 +0100
Message-ID: <2804881.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de>
References: <20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 16. november 2025 ob 16:55:26 Srednjeevropski standardni =C4=
=8Das je Marc Kleine-Budde napisal(a):
> Reading the interrupt register `SUN4I_REG_INT_ADDR` causes all of its bits
> to be reset. If we ever reach the condition of handling more than
> `SUN4I_CAN_MAX_IRQ` IRQs, we will have read the register and reset all its
> bits but without actually handling the interrupt inside of the loop body.
>=20
> This may, among other issues, cause us to never `netif_wake_queue()` again
> after a transmission interrupt.
>=20
> Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Ker=
nel module")
> Cc: stable@vger.kernel.org
> Co-developed-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> Signed-off-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> I've ported the fix from the sja1000 driver to the sun4i_can, which based
> on the sja1000 driver.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



