Return-Path: <stable+bounces-158881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31151AED843
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597EC3B5396
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63F23B618;
	Mon, 30 Jun 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="M/Dy0kHK"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDB20E032;
	Mon, 30 Jun 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274712; cv=none; b=uCNKEA8T/rOvrd43hCpEcFYljQwsaLscvY3O2ID5n+HJYdNKh/w0QUQhlqQ+Dd2RmfyhZD0uwa4lmkYSJh5dA3qdxw67dMqcm+VhUqMYRugoI/gg4CfgyV/vtTXB00kIe4Rm81iJ4TFLUhphhCkoQwOHxS4OwPgaZqB1v7oVXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274712; c=relaxed/simple;
	bh=CFITM/IHcGcfzhREeTKNUmnvAF3lqIquLdNik1+6vlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8alOZaIpYMoIso8mouQDWUVoCY3bmvmNwD2Niz8wS9eUUpNlR35MJUIXunKLf+V0tVyA//q5s6/NkeY0wYJcsB0rGOumxHrdOB6/EZOleYB5eLoiJSGfsMWnNWdfCEsDtzn6VP2gFvfhY2eZ2KFtwHzCdCn3cX1i07pbji7H1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=M/Dy0kHK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=HYYqwm/0x3s6bT2OIY4EV6VsEmIz3D1C60tQTlTepEM=; b=M/Dy0kHKw0idDPTa3AG1rAYr8m
	CBImeUnTk5Wqc8hXsQ7x9BKHoI2dthy0ZqJ2ObiUSy1NRMf9Lw0VKzvKHSB77GK+2gUFcc9S4Jql+
	W3oFonU0ZnSmA4I/K6IHbyAFVB3RJVk5uv0k29/Coq5M2c2ccC94suObf7K8H7Itz1fLRU7OHu1jG
	+NsUgwEz22e0UUY54z+JYSzXRn0nqFHc6A482NL1/12llqR20nwwDbXGSLOJQ7GFojARe3FT3Idyx
	zBG1CPKAoa7TVO5Ciu5+dlOsgoRUx136wH3YeFvoNbFJg7g1sk5OqlcPoPjLVDBNIBVJVVBm1spWr
	0qnP/V2w==;
Received: from i53875bfd.versanet.de ([83.135.91.253] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uWAY5-00065C-Nn; Mon, 30 Jun 2025 11:11:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Diederik de Haas <didi.debian@cknow.org>,
	Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	stable@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: use cs-gpios for spi1 on ringneck
Date: Mon, 30 Jun 2025 11:11:25 +0200
Message-ID: <175127468078.130313.4898907937836060073.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627131715.1074308-1-jakob.unterwurzacher@cherry.de>
References: <20250627131715.1074308-1-jakob.unterwurzacher@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 27 Jun 2025 15:17:12 +0200, Jakob Unterwurzacher wrote:
> Hardware CS has a very slow rise time of about 6us,
> causing transmission errors when CS does not reach
> high between transaction.
> 
> It looks like it's not driven actively when transitioning
> from low to high but switched to input, so only the CPU
> pull-up pulls it high, slowly. Transitions from high to low
> are fast. On the oscilloscope, CS looks like an irregular sawtooth
> pattern like this:
>                          _____
>               ^         /     |
>       ^      /|        /      |
>      /|     / |       /       |
>     / |    /  |      /        |
> ___/  |___/   |_____/         |___
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: use cs-gpios for spi1 on ringneck
      commit: 53b6445ad08f07b6f4a84f1434f543196009ed89

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

