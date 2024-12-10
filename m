Return-Path: <stable+bounces-100309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0AA9EAAAF
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF14188AC17
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB342327B2;
	Tue, 10 Dec 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="luwUgV1I"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72923278B;
	Tue, 10 Dec 2024 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819310; cv=none; b=p+fz1EAuKWrkuca8tB3BtyfBGdp018n62bFstFu11flTIIvncHrPgIXbU4+2Dmyf47QIn/pTX6MZYsbrLNl9x/3/fz+ogqwEzZKiC4xWsXP2m7O+4HfjPHhkH6aSspYLRSHJXnLalahyl/7IFkoKpyLXjKQ+xjIMh0L+XgxED98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819310; c=relaxed/simple;
	bh=Rc87LvBvn6+J4XVasrmH2iHJ/nSwY3ZpEvgbszBWm5s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q8BU5Xz72V8GSaByLRszTilSx4dmm4QqdLv2b/T+Kw1spVATfg23JvkY08KXGTVoMe+yyT7Bi8EQs2Mwg4ceRKrWUDLxRIghzNBewCquOSEOMtjrK3jDL0pYZ9dLg2f6oWt3vikVew0dxN511diVA4mqiCnIMSpDFXUeHn0sEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=luwUgV1I; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819304;
	bh=Rc87LvBvn6+J4XVasrmH2iHJ/nSwY3ZpEvgbszBWm5s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=luwUgV1I0OyRSDuufyJArvmnaBDpvVsqrH8oscCnggoaRWgC0c+A/jWP5lHuyo22V
	 BoaKphfBRvsuwYk+eHlzrgPHILUXJyOc11RxCpNoSbITftd74xrnLuKRHo0HJswQjl
	 uDcjCEg4efQigcqjRWSeRAHUXFb9IW9Qej/GyaP+r7/tovZdYmeAitRefxlXJWt51O
	 IhOP166+Gs3DpBbpBikKfWSh52UCWeedGlu3O+inju+saNcnmO7Vs4LfqNb+aSMGT6
	 YYI6SgiI27gRRWC6a0LxBy4dbvFI+ZT4bVdxtYVYqsHzJT803U1aQsONTpWw3bxftp
	 0P5EzU/VHdR7w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 712D717E1574;
	Tue, 10 Dec 2024 09:28:24 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241025075630.3917458-1-wenst@chromium.org>
References: <20241025075630.3917458-1-wenst@chromium.org>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8183: Disable DPI display
 output by default
Message-Id: <173381930438.18469.15845444123528821647.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 09:28:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 25 Oct 2024 15:56:27 +0800, Chen-Yu Tsai wrote:
> This reverts commit 377548f05bd0905db52a1d50e5b328b9b4eb049d.
> 
> Most SoC dtsi files have the display output interfaces disabled by
> default, and only enabled on boards that utilize them. The MT8183
> has it backwards: the display outputs are left enabled by default,
> and only disabled at the board level.
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[1/2] arm64: dts: mediatek: mt8183: Disable DPI display output by default
      commit: 93a680af46436780fd64f4e856a4cfa8b393be6e
[2/2] arm64: dts: mediatek: mt8183: Disable DSI display output by default
      commit: 26f6e91fa29a58fdc76b47f94f8f6027944a490c

Cheers,
Angelo



