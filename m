Return-Path: <stable+bounces-209982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C12BD2A5C0
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 03:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B543020C6B
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829D5341653;
	Fri, 16 Jan 2026 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPUDrH5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC07336ECB;
	Fri, 16 Jan 2026 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531832; cv=none; b=oo2DcqYEYGOrU8YmZxLuMnT2xw1vpqOa/hvgeV4MqSqHXh4gIIgGqoz20sd8BucUTUUqIdof33m55sGPpkQiZoz9yjDsS2+6v+4HtywFYZaXqtjJXFNDj+KNu7FzDRgfbr4APZ5tg7QqRdTCtsQ0E9/nOpO4QtQRKWs5YNIkj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531832; c=relaxed/simple;
	bh=mGq6lq6CX8A0vkqW4EaPcUBUnxO3Dn8wywcn5lCiB9Y=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=JavuwaqBj7I7JYj5v2m15E/SWKnL9yrhN9LQXsTDGTfVzzCdJqJse9rfhHnQ+d2D/Kw9iuWF3d/Y0Ovd5B3Eh8KMnHoIRDuqK1zL0zsZoResdu/z4ZSGlRTi5gqZ3cAWflevwnD8MCanWSvy5cwljZuNoHrc3ITmwlLpwp/Hwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPUDrH5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301A0C116D0;
	Fri, 16 Jan 2026 02:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768531832;
	bh=mGq6lq6CX8A0vkqW4EaPcUBUnxO3Dn8wywcn5lCiB9Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mPUDrH5m/i7VJ8eJhQMRp0aA8plTZVx1lHaXswg5cxrmD2OUAxcoJRNvorM1c3A25
	 r+Ojg6h4Th+dS4YtcNFiVXd7ubnvwxwsvC2Rfw1yh6+nQ5SRDyOO1VZ3G2DjK/IMZB
	 S0ouoLeRU30bhpLpuEf2Cr9msvUMy1HbRFFQJBkuAkT1mcIt2cp8XGagLqpniUbjmb
	 Q4MQGfd9UL7LehymhT+dlg2oQ1iBxdOX1Lbub96dRiDT40svtEicpP012a2jjfydaS
	 0mWI8gAX83RrghFMnTVsx9+jiM9ZHFPrA9K7m1CcqNPNCmLz32Ar3Q1VJmGGNfGFZq
	 I78JHOb4Rcy+g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251231-clk-apple-nco-t8103-base-compat-v1-1-6459e65b6299@jannau.net>
References: <20251231-clk-apple-nco-t8103-base-compat-v1-1-6459e65b6299@jannau.net>
Subject: Re: [PATCH] clk: clk-apple-nco: Add "apple,t8103-nco" compatible
From: Stephen Boyd <sboyd@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Janne Grunau <j@jannau.net>
To: Janne Grunau <j@jannau.net>, Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>, Michael Turquette <mturquette@baylibre.com>, Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Date: Thu, 15 Jan 2026 19:50:30 -0700
Message-ID: <176853183042.4027.16837126295266775570@lazor>
User-Agent: alot/0.11

Quoting Janne Grunau (2025-12-31 05:22:00)
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,nco" anymore [1]. Use
> "apple,t8103-nco" as base compatible as it is the SoC the driver and
> bindings were written for.
>=20
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>=20
> Fixes: 6641057d5dba ("clk: clk-apple-nco: Add driver for Apple NCO")
> Cc: stable@vger.kernel.org
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Applied to clk-next

