Return-Path: <stable+bounces-83393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60649993A9
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 22:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A6FB229D7
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891C1E0495;
	Thu, 10 Oct 2024 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oG3oURYs"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BC19C553;
	Thu, 10 Oct 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592071; cv=none; b=bNBJgCymSx446Rxm2rnqCYYxGafwk05/OiqCerp7auvRF8v/yOlADb7M4XZTX8GVRQOy6LznkOxNVGtks82I6dNfHrE5PoG4CO/ncnwVg41roj5oFhC80cATzP/EQFjMx6eCt2E/k/Fn0LoA0FXM1BaKiQrkra/YqxRjJsm99TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592071; c=relaxed/simple;
	bh=4aVUhPMcFnXsYa4v6FhSoRCef9bQJORiqotQO5K5zvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEl/M7Qxp9mOFzmNkLzFIFm6q35WXUTst+Nu5srSs9pWybMQ0xSSQKnJXnRUXUw1sDyNXkrKL+vLmhvkPfqqI+IGtsAVHZ+rkKM2tb57Xz+kMS6qH7TeoKkEKa5Fv9XccsVrpohiMnJSEuYDY03ZyXVLSXr3x+J4IFsMN6Uu4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oG3oURYs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6BFDLIxR9WZQ3uKsX2doi4YcoFJOtB9dymEl4xDgCKY=; b=oG3oURYslPRZUea9n1SaXowBOr
	vo1i72GboeOY1D3CTjubkqfc98GbwQy8gWl0JcDDQ32K7+jwcQcLBzqrC6TuLE4NlOyiuY7GzbIB+
	4UhDZ4EFRWUK5u+q9xmFkH+t/bcibWV3/STvqmXQRqf3gSKISqjZTv0kQOlugBkH5tJtf8bcPBbwr
	dHbhDesrVpNIAafzAyJXJbSKNegmZw/4NkVxqTFai99xVcJB6ayUsS/zp1VWXJKZO7K4tDOlbWA85
	clfHYz1h6B3peZNGFp55R+SDWKfnGy2C4LdUR4Zg4foYXyghVkM7qptbkB6oVSDcbE30537UezpS8
	cOAf8BqA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1syzlE-0000lb-22; Thu, 10 Oct 2024 22:27:48 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Prevent thermal runaways in RK3308 SoC dtsi
Date: Thu, 10 Oct 2024 22:27:44 +0200
Message-ID: <172859192266.2746127.3378168630215627036.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
References: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 10 Oct 2024 12:19:41 +0200, Dragan Simic wrote:
> Until the TSADC, thermal zones, thermal trips and cooling maps are defined
> in the RK3308 SoC dtsi, none of the CPU OPPs except the slowest one may be
> enabled under any circumstances.  Allowing the DVFS to scale the CPU cores
> up without even just the critical CPU thermal trip in place can rather easily
> result in thermal runaways and damaged SoCs, which is bad.
> 
> Thus, leave only the lowest available CPU OPP enabled for now.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Prevent thermal runaways in RK3308 SoC dtsi
      commit: 864f1a5b390278a4a8d4a6d7425c7022477c6c9f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

