Return-Path: <stable+bounces-119843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D9A47F52
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3C53AC51D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B02309B2;
	Thu, 27 Feb 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aZ3vtivB"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B43230270;
	Thu, 27 Feb 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663500; cv=none; b=S2gwUIS8pohRhdsivTtWj+qYIjmZ5b/wk48VeAtigUEEesg2faBR1S2x7NiNaL2YrX/HTkgtdTBQ5cocAiDG4wOrj57JjQRTu/WD+mpx4bNaEz4SZvEVNcRj9s6SlauhXy/HAbE+do2C63Pn9el/Q1AnRAloFJ0ZEk/eQwoq09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663500; c=relaxed/simple;
	bh=EsEeX41R/kuDMpcraSoN/TEa/qCoi4DYBmM3YbkgWNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kr9a/AzZTGmjGLfwcb8p34efSj5q4SRGKM8OL/5xOpvKf46SqO7qQ3U3uyGGYtl/MVDj2Jm/gV+du1XsVZyV88uvkH7cksZTmhp2z2BPAR17bsHxWSYFGbIv/ZDdsp9rMnLRUJXQzZ0JSWW/z7jIdP61ocEG+SL1/8kMXwXhoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aZ3vtivB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EqrpVcukWiPJHZAYarKFFVSdPnEDo55grdH2sUNNyGU=; b=aZ3vtivB+XgSXInEOjW01ujZzv
	L5CT2fPsvG8DkgwlFzHlgNaCpePMzTvbxuvMSP4LvayGKg8k0dh0aCmGnqkM4XCGtiZEcVfjgREiv
	xZRQPa/vXFQ/MX4SLyKHr6lAGrDJCcA28V3g7xNW1jhuPgzw8FMnKV0lFs+9xnlHfVirfCqflteRW
	PQo7XyklEH5JkHwFqT+gNB+vAkA2spnvszkITg6J4R+PavD5t3zxiVrb+hhk+PUdINu3SN2+/ZWPA
	Rthh9I/Imy7oNe+TycnWKm1U4I7Dxz2M0nYUyWLbbedGa5RL4bQgqvBKS66C77FQVyoZkPdJhhmie
	+9WcH+8g==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tne5a-00018T-D8; Thu, 27 Feb 2025 14:38:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Tianling Shen <cnsztl@gmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Justin Klaassen <justin@tidylabs.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Thu, 27 Feb 2025 14:37:55 +0100
Message-ID: <174066344876.4164500.4889326027410145249.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225170420.3898-1-justin@tidylabs.net>
References: <48c705e65cc8e8d4716b41a4a87170e3@manjaro.org> <20250225170420.3898-1-justin@tidylabs.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 25 Feb 2025 17:03:58 +0000, Justin Klaassen wrote:
> The u2phy1_host should always have the same status as usb_host1_ehci
> and usb_host1_ohci, otherwise the EHCI and OHCI drivers may be
> initialized for a disabled usb port.
> 
> Per the NanoPi R4S schematic, the phy-supply for u2phy1_host is set to
> the vdd_5v regulator.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
      commit: 38f4aa34a5f737ea8588dac320d884cc2e762c03

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

