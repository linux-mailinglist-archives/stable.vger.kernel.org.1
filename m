Return-Path: <stable+bounces-128455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94754A7D57D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B1A1731A4
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C185022B8BC;
	Mon,  7 Apr 2025 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HUC/jHK8"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F322AE68;
	Mon,  7 Apr 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010283; cv=none; b=MFtpy7b1U/E0CR0aZo51QR0VRVNo374MHk2cLyrYFF3CtZsUFM57o/TR331ztpdqat8Zemi47lHz4BKwt8tBcHNd/5qZW3tjHN7+N1OXVaLp5eITXbZkkyx5A3R9UeExL8mO6vee6JreTHJqwS1YIHtmLGzNxckkAtLMoYL6j2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010283; c=relaxed/simple;
	bh=ccE5e48+JeVlXnRwwYcDOPr4CJxZzvtrZbKeQV867vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oyhu8zOsJKL89ckJm0wLbZ+hbdGdJw+Ggy4buKFae2rxToGJ6lPRHUmMCzj56juIAH3DPRR9+2VHtPPo5oUocY8X6M0bpLWb12QjTqqaw9EDj1atXS4tl2nODw/IIL3FKjYKxgMo0e/pIE+SFKJpalndKRsu7yQCAJR1q8WgEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HUC/jHK8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2HsI7Mvqhlkg1D4i/gRhR4oTLdzatJEvGabIM6WMsGo=; b=HUC/jHK8rkiyZZglx3C3N65Ku7
	uc0G3l3HH+hpj8E658nWnEgQLfrXbpASIBJPvqD3lL7KQieTfGwGFT83Y+ugEJ/6F/Shiw/xqV/nW
	nY9sZgww2KpuODcaWifcbE/z0S3yJwUwiMkkElBDEFlXYqllReELfIOhDNeWGchiwbZX8OJV6bmBk
	q7FgijtxRKioiUHymz6yQjTFjfParmu7YxB9LlQnvW14rzaqzpe9YOnnkT0EstyHX/bBY/7uqMbOr
	fDKyXASGegdgpCuzMM8antOk/DWgIg4sdu9svyFDdcWVkeIMyT/jI/l7CcPi0t1Tk1YMPaPbLg+LR
	F4r0LLEg==;
Received: from i53875b95.versanet.de ([83.135.91.149] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1u1gjw-0000tP-3F; Mon, 07 Apr 2025 09:17:52 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	stable@vger.kernel.org,
	Alexey Charkov <alchark@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Remove overdrive-mode OPPs from RK3588J SoC dtsi
Date: Mon,  7 Apr 2025 09:17:41 +0200
Message-ID: <174401024394.372530.11791471652987821644.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <eeec0d30d79b019d111b3f0aa2456e69896b2caa.1742813866.git.dsimic@manjaro.org>
References: <eeec0d30d79b019d111b3f0aa2456e69896b2caa.1742813866.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Mar 2025 12:00:43 +0100, Dragan Simic wrote:
> The differences in the vendor-approved CPU and GPU OPPs for the standard
> Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J variant [2]
> come from the latter, presumably, supporting an extended temperature range
> that's usually associated with industrial applications, despite the two SoC
> variant datasheets specifying the same upper limit for the allowed ambient
> temperature for both variants.  However, the lower temperature limit is
> specified much lower for the RK3588J variant. [1][2]
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Remove overdrive-mode OPPs from RK3588J SoC dtsi
      commit: e0bd7ecf6b2dc71215af699dffbf14bf0bc3d978

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

