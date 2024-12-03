Return-Path: <stable+bounces-98185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADF9E2F47
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 23:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A891636C1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1772E209686;
	Tue,  3 Dec 2024 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXfhp2Qm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B111362;
	Tue,  3 Dec 2024 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266313; cv=none; b=F+tzPKFnPnAoQp5B071Fchi0GzO0tNgNTnHrg7E/j41NpEslycRaiIbMrMl4zazGUGmGXjUDp2PV+6jEyv83MwnBIv5dnXv9eU8E/Xeugup0k0+Qk/mgF8r0kzEfoMC0DgVrK/dvLglRf1UeOQSnjifl23+TyBj+eUDP0S5zVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266313; c=relaxed/simple;
	bh=+fjbAkrVzYde5+w2K06l9ghDnn2UjRQ+8F3dqZ+qLTU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kUti7mytsE3ecC11YVwQaHElH7TGFV2hCTjUsQRtCOx9BRZ/G1+tbbzRXSPvIY2mcQXW8Iu0J0WszTfswLwkjnWCwGIaFxRHAVXDQ9S7gnTYn6ovjwrO0SNmgudPy0yaImDDZyg7Jlki593NMLgPH6Qpcvx/xd1QCnijyiJ40fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXfhp2Qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAD4C4CEDC;
	Tue,  3 Dec 2024 22:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733266313;
	bh=+fjbAkrVzYde5+w2K06l9ghDnn2UjRQ+8F3dqZ+qLTU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UXfhp2QmYJWm6VA30rBw/rmkkSEPSkp3U6NrxQPslV2kpoBGTA/QIjiQljZzlxSyS
	 YeO3IBsamlJWrY8iBeBaB9lH9OkK7Nkb/Vkxo9xEL01wWILQ0aRvXuieAHb3xFl5sX
	 Q00/HdRVqtXVa6uUdMUw/euKZwFidjeXOBZpuzw7PoCXoXMWPKnnH9u8E4ps0Gw2Kq
	 St1GAKeEEwm/agGLGXZkEPAbwO+t7YHH6jD9fWa4RLfRxCRyjiVjRU/DK/4fxp5uKB
	 Bri8Cl4DsiiurwNzqjvQSYncArUtcg4bzC6o1urPNthVD9fwYUiA/C7c4Bm27/g6mg
	 uh56Y3CvkcV+g==
Message-ID: <23defccb1545a66064b02a5ac4b80536.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241116105710.19748-1-ansuelsmth@gmail.com>
References: <20241116105710.19748-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] clk: en7523: Fix wrong BUS clock for EN7581
From: Stephen Boyd <sboyd@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, stable@vger.kernel.org
To: Christian Marangi <ansuelsmth@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, upstream@airoha.com
Date: Tue, 03 Dec 2024 14:51:51 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Christian Marangi (2024-11-16 02:56:53)
> The Documentation for EN7581 had a typo and still referenced the EN7523
> BUS base source frequency. This was in conflict with a different page in
> the Documentration that state that the BUS runs at 300MHz (600MHz source
> with divisor set to 2) and the actual watchdog that tick at half the BUS
> clock (150MHz). This was verified with the watchdog by timing the
> seconds that the system takes to reboot (due too watchdog) and by
> operating on different values of the BUS divisor.
>=20
> The correct values for source of BUS clock are 600MHz and 540MHz.
>=20
> This was also confirmed by Airoha.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 66bc47326ce2 ("clk: en7523: Add EN7581 support")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Applied to clk-next

