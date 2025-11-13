Return-Path: <stable+bounces-194756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FAC5A80A
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 00:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B60A2354D92
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7D328249;
	Thu, 13 Nov 2025 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jPv47wxR"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9273271E2;
	Thu, 13 Nov 2025 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075908; cv=none; b=YdqXajzrJkXkK2jIryo8b7smDzGB6fQE6uPUBRzRF6VgjPB8K3tR6z8Ulvk4SlUq9Ub9AyoTxwSd7jQBuzyGuHLeSVNQQYNb43+ZRBwU1w3mHJn0g77TPuf/bwPZ684YtBUHX17CtHDjH9e3WTNgcGJg9H/CxxVhDBM08l0OnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075908; c=relaxed/simple;
	bh=p3mdxSTOHle18hqQBkRL6hSu5jldPR5TNMgqGLNhNl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdI2FmrJzMhCKskW2iINC2qAjIMia3jTEta1BjgdLroxIdZCh3HhqpoZSi7PKn1uGseeOaJvwkzrcZWV5eZa5kLwCG0Zm0tFRFKJD+2t95bsKc4UdxUXjiS6SUfEoD7GP/+sovOYr+Y6Rinnr7FUGtH7ichlXXVxST+Yx/hs/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jPv47wxR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=riHuRM1k/DFvdlBRjwWTjBhHifAxIVebtaf9zUqQz1Y=; b=jPv47wxRaXGpcY/WjPo6mTDh5l
	bN0pYUxMKtxtkmR3YaArdlw0XH9vswzuGChcKl+nFt1L3oyQS6/RuFaU8fvEItmEc+G0xJDxreKGZ
	4S8qZcWy2SWIhf5iF93rd6C53lqibF2w1W7vaeKXmEUIfG7lpaJCNtQuML9wWl1uPPu2/5AJR/jfg
	bju0WS6vz2Ho9/meXy2Tt4vwPFJhcb2mlAsqJ254Qt5nnCaO7IDG5mPA8fqz4PDMOVQkCTlnLpczn
	u2aOiO67F3dEU9lnbJQnRFPqCkcQuTAcGpXCPzFeNIEvK6cuoEJnt+AT73z/JA1j6IrbqAwqLHTzD
	bRBn8qxA==;
Received: from i53875a11.versanet.de ([83.135.90.17] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJga3-0005lz-FO; Fri, 14 Nov 2025 00:18:19 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Michael Riesch <michael.riesch@collabora.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Muhammed Efe Cetin <efectn@6tel.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mykola Kvach <xakep.amatop@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator voltage
Date: Fri, 14 Nov 2025 00:18:16 +0100
Message-ID: <176307584246.496508.12079514999315183214.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cf6e08dfdfbf1c540685d12388baab1326f95d2c.1762165324.git.xakep.amatop@gmail.com>
References: <cf6e08dfdfbf1c540685d12388baab1326f95d2c.1762165324.git.xakep.amatop@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 03 Nov 2025 12:27:40 +0200, Mykola Kvach wrote:
> The vcc3v3_pcie20 fixed regulator powers the PCIe device-side 3.3V rail
> for pcie2x1l2 via vpcie3v3-supply. The DTS mistakenly set its
> regulator-min/max-microvolt to 1800000 (1.8 V). Correct both to 3300000
> (3.3 V) to match the rail name, the PCIe/M.2 power requirement, and the
> actual hardware wiring on Orange Pi 5.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator voltage
      commit: b5414520793e68d266fdd97a84989d9831156aad

Please start new threads when sending version x+1 and don't append
that new patch to the old thread (less confusing for tooling like b4).

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

