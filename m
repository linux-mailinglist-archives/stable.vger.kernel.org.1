Return-Path: <stable+bounces-197682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99814C9544F
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 21:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FD094E04DF
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A52C0F9A;
	Sun, 30 Nov 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhkaSzJN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3421A2C0B;
	Sun, 30 Nov 2025 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764533151; cv=none; b=j6cRZfH2TpbBdTtZohjENt8oL0Cd5I7HV4rvQyFzuRMFZgf+TNIlvwkFtranWR688eplKVKj9xh3APW10LsIM/teGOXSzs6dauW2hgNOwjzD9naM0Wn+Z/ncMPowQEn6YpS0MqBVEmPMjHSk//79Mc/L/SqAqCyqMx4xNaG3NJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764533151; c=relaxed/simple;
	bh=jJCS9wlLw4UB8FtixB8FqLAkmkUo2UgjkrCC0YVQ0a4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=gKj9v4n8ole7CqFN9phwUOOW/sI50NAJ3m99QNuAo62mp/+BwPVMv9ohk7iUKPGfrIYZbGYYLiNqEME+r2sYwm62ys1IJmJ5OisEUZFXpqYXhGe3pnpUlb3YxvwovdOhL+A+bR0I9tVSf1MAuASa/YlX79ffXUWByQ1UeNWvGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhkaSzJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39982C4CEF8;
	Sun, 30 Nov 2025 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764533150;
	bh=jJCS9wlLw4UB8FtixB8FqLAkmkUo2UgjkrCC0YVQ0a4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bhkaSzJNE7LNi9mjx0TgHMvGlz1XV83bd+o64F8d7KUrspBZXtsroElpCoBwbOAa4
	 PRPQqlZcejr5imxwHP7TDmDIctcaGgvcH9R4yhwOjbFgvL4xwAhqpG8ps16M3cr/D5
	 oa4thjMmNZ40ngCoj7nTcGrNQ5YmKlK3YtC0vwYWASjKy7dsVnqaITc/ZKnyxFU3J3
	 T+wGbqmIqoeqwr6xiECB1eyfCXfbNIEtQgLwK03g5AFDAP4SubNdKN1SFpUbLUeIIZ
	 O1fk2Jy+muM7qyu30sJVullO5MXUYeABZZgUm5VG+KVeZPtj11kNxMs7rMHdhB7spM
	 TvRvJGu6ev71Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251127134243.1486-1-johan@kernel.org>
References: <20251127134243.1486-1-johan@kernel.org>
Subject: Re: [PATCH] clk: keystone: syscon-clk: fix regmap leak on probe failure
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Andrew Davis <afd@ti.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Date: Sun, 30 Nov 2025 12:05:48 -0800
Message-ID: <176453314828.11952.16559693437296196826@lazor>
User-Agent: alot/0.11

Quoting Johan Hovold (2025-11-27 05:42:43)
> The mmio regmap allocated during probe is never freed.
>=20
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
>=20
> Fixes: a250cd4c1901 ("clk: keystone: syscon-clk: Do not use syscon helper=
 to build regmap")
> Cc: stable@vger.kernel.org      # 6.15
> Cc: Andrew Davis <afd@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Applied to clk-next

