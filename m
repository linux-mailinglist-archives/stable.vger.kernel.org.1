Return-Path: <stable+bounces-105064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083B9F577B
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A918B188F47B
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74831F9431;
	Tue, 17 Dec 2024 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW1KnDvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011F1F75AD;
	Tue, 17 Dec 2024 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466623; cv=none; b=WoBgnVjDUd+zjUU6b3ahy+e7qISM4Y1tDA4al5JPi39jLbDDQoEl1TxE9eHxnL4tLHaWmr3oEDiyUZrYNTXB4T2tyCGd559EfWJgy/ow8KpEZyj8aSmbR0+fcyLWWXYlAFd5Rnei/NMr0HOYChl+3XpZLYkirsngdnnTItWCDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466623; c=relaxed/simple;
	bh=nfCqAdaT7JKP/gVcpsVgJ6pvah+60OP5bkL61BKY/qY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=rmQcRLWwbIjGTruNv9GUdxhkUnr7FOLWfI+O4q3kGYAXYRf0+gZPmg2RMBMmRaVfx6xRn97x4DJobL7kiBVAtmEMFi1FJFYYCkXChofrtHqz5PIkv8hXYN2TWfn6KOkAFO0kPZ1JvKMB/I7ruiZNGJiDi4dUgwNn6LHl2Vc0ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW1KnDvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C07C4CED7;
	Tue, 17 Dec 2024 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734466622;
	bh=nfCqAdaT7JKP/gVcpsVgJ6pvah+60OP5bkL61BKY/qY=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=gW1KnDvvapk26xhTxQAuYjC/xy4yiGrkWF1PAkO0p1jyn5yYMvoPNrJCAv5MUWHzf
	 M3SXODkntTvxJD3QAnSWtFlmnL+gOcpS4lY1MnDrJjBxKCBQMxSC0LZRy/6AlAUatp
	 rS8AV+wmp89LyUDwTPmkYNy2DxbD+fwtKeurLXJ6kVOARoDBVN8+lGCUZUiM3ODOeR
	 lb/wIC1J+KOyo51oJUWCFdZ0GxbpeoycE4298PFOV7ao/jIVQQyZ7jz92QNSupPTIf
	 Lfcx5kia4cLewCCKSp5BDKwruvDCfYoBcSmpDLyIWwkFBw6Jw0YoRV+RF7oL8AMzKr
	 VdkbJGj3LQQTg==
Message-ID: <2c3885eb1bbaca8a939b9233fb593ace.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d677486a5c563fe5c47aa995841adc2aaa183b8a.1734300668.git.daniel@makrotopia.org>
References: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org> <d677486a5c563fe5c47aa995841adc2aaa183b8a.1734300668.git.daniel@makrotopia.org>
Subject: Re: [PATCH 5/5] clk: mediatek: mt2701-img: add missing dummy clk
From: Stephen Boyd <sboyd@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Geert Uytterhoeven <geert+renesas@glider.be>, John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miles Chen <miles.chen@mediatek.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Date: Tue, 17 Dec 2024 12:16:59 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Daniel Golle (2024-12-15 14:14:48)
> Add dummy clk for index 0 which was missed during the conversion to
> mtk_clk_simple_probe().
>=20
> Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to =
simplify driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next

