Return-Path: <stable+bounces-111987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680BA25431
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E0F164FC2
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDD204C3F;
	Mon,  3 Feb 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oHHYGW0s"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B01FCF44;
	Mon,  3 Feb 2025 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570579; cv=none; b=gfakWs89+gxNerD5kzDAWLUPZRKV5mXAfvnh3nXhCDJ8Ts02391FRTizG19fxeEJ6yWW8/MoW+bXIRnEy+qFOoYz0BSlE3njXgh5WXAxZ2f9gM6m9SQp2zw696R2CV3qH5v6Dkql6xqGBCfxupYhJC5tBMf38Ts03YGynt3aw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570579; c=relaxed/simple;
	bh=ASk+1EUFh/3yGcug6P+8aM8sBlqnk8vvU6roFzb5m7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxX5X/0x2Shw5zDFfoWdSPD5IYrxXsP0fdBPFNh0tlaO078EQqJot040myvp+YOfMezz39CxK+BKzOKXsJM1ct2pCP7TqFfqi/Xuje+COfHsnhBTXvJNiL5tIfhZtHbfVZ9/bsIc+8iyFt/o845S2dvRfP2GEgOHUqkUd+IOiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oHHYGW0s; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sSvbgIR7n2lPQ5jF97vs92quNf19M7v9euIe9lcmFwk=; b=oHHYGW0srNc2mV8G6aLmA1buct
	V8f4DpO36yp8tLTIeAGHhb54c+7wmfDW/I/bCmQp7VCoXcmW5nXb8n7gNS3ehsq03b5xXK7wIJ9+e
	DgOpi/oFxnyo44sqzI0ZoM5TiBxuMazHdLwMCTbMKJRiQt7JMqKsJR7eiFhVSsl9WyU3XP7eDZVKc
	9CcBReE2wPzCFtUcPa7s+F0bYJGvQQRVoxtzy/+G+uXckao2GA7ZM0fThUwoUu0dX7uOKkDvXn9G+
	Nvn6KQMd5lShd583hS83SJZXfiOd+qKaOHT5Rym7ga+qBoF1835ZVhzTyGJ+PxlZ0D1dHLPsEO4sV
	taC4MJYw==;
Received: from i53875b5c.versanet.de ([83.135.91.92] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tercj-0005Vr-Ug; Mon, 03 Feb 2025 09:16:06 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tianling Shen <cnsztl@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
Date: Mon,  3 Feb 2025 09:15:54 +0100
Message-ID: <173857053620.78657.17789947285666303605.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250119091154.1110762-1-cnsztl@gmail.com>
References: <20250119091154.1110762-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 19 Jan 2025 17:11:54 +0800, Tianling Shen wrote:
> In general the delay should be added by the PHY instead of the MAC,
> and this improves network stability on some boards which seem to
> need different delay.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
      commit: a6a7cba17c544fb95d5a29ab9d9ed4503029cb29

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

