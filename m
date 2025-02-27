Return-Path: <stable+bounces-119842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0BEA47F4E
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 14:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704063A96FD
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD622FE05;
	Thu, 27 Feb 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hLOyH1Az"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90022206AC;
	Thu, 27 Feb 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663497; cv=none; b=CgE+PmiqQ1xwaa2bsh4k59nMb34y1dyO6Bb68fTRRv+D6LUPAli44CPvWr9f1/DfXsQisoE9PWEG4NXN+Zarhrg8G0MtYQagbkh9QBV7ZQQbnw2pkWgTF4L33aG8cGrVTqpxEhi1Cz7OZH63L31kfhjDerhyOp24oXZs4P/4zGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663497; c=relaxed/simple;
	bh=GoGIx0y0QIsWlsoPTEiEb5OWZb/coqE1PmOfG35RZOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAT9GPhO+ennMbiD1YPRehz8Ltb+ZnxUd5g0MHHH1UXWPgfsUDw8BM1MoxrtI/03+m2ADT+I8l4OkNnSkQmG9XHokcnCI0PKEIkPhiPoStuHFDDbULR5Kyp1apv9ZfwwwDO04oVIozMnaYgwqQUfxhWJVFSMCnqEaTdoX4uGIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hLOyH1Az; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sKbx/cqIDw+mrJ09vJ4uQbWUy/6eW7Ss2IOLFOIIZiQ=; b=hLOyH1AzsaVOtJabG8mG67QlJ6
	7l0t367OmRHtPWZTs0hRlXKULI9VKDLR/i1TDZ55QKzF5o4KlIUQVeZq4HIt9tO28kcapCIoh7ODN
	QhmNVhr68L9PH34GxdT16pqLriYXJbRUPSXHe2q4nSHn+n3Tm95wCeIYZcdg+yN2Qy8WcDgRPw2Ep
	uHZp+VrMbJ3eR8Tgh4X8pFunfLNvyffpj8+BrSapZNPU1bsjmi5//Ou/Eu3klI2Afio4V0lMvJvS/
	FhJ7NyzwF1Q//cvMyXCwtwgujbdEMvEpEs+EjW2t25ssCn8kMb6TEZYqsoEGAEjc4jb6o5FHj2nn9
	NATY2wRw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tne5Z-00018T-DE; Thu, 27 Feb 2025 14:38:09 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: rockchip: pinmux fixes for PX30 Ringneck
Date: Thu, 27 Feb 2025 14:37:53 +0100
Message-ID: <174066344878.4164500.4996137094609435540.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225-ringneck-dtbos-v3-0-853a9a6dd597@cherry.de>
References: <20250225-ringneck-dtbos-v3-0-853a9a6dd597@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 25 Feb 2025 12:53:28 +0100, Quentin Schulz wrote:
> This fixes incorrect pinmux on UART0 and UART5 for PX30 Ringneck on
> Haikou.
> 
> 

Applied, thanks!

[1/2] arm64: dts: rockchip: fix pinmux of UART0 for PX30 Ringneck on Haikou
      commit: 2db7d29c7b1629ced3cbab3de242511eb3c22066
[2/2] arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck on Haikou
      commit: 55de171bba1b8c0e3dd18b800955ac4b46a63d4b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

