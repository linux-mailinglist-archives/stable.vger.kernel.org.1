Return-Path: <stable+bounces-47518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858148D1057
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 00:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EB41C21229
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C5B169382;
	Mon, 27 May 2024 22:42:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B0169368;
	Mon, 27 May 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849753; cv=none; b=VSOOZCVA1QmEmB3cgZnCbzLgqsJrB+WhqWXZF/1cv6A94zZrQx0rITmg8yY52NKdFzuOjN29ZELiixHVmFVqZAdD6ARaN6buF3n3VmkGD4nGh5AsZpCHHpaWSvXmCPCYVT3bmAUDOIrmdwJXfDnKYH0pqXT1jZ1a3WfenuGIYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849753; c=relaxed/simple;
	bh=VyOQIWPEbtuHOC1cQJVCNYPzGlSZqGH9Wpc+QOwHASY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG3utdnZVGXkPHl5xFoGZ2ZFOzEMs33h/aOw1dzIc94TepJumY4/Vt4fI8BeyTW205yWy4fvI1JnVUkOTEa2yaZjD1JEZW/Z0WLpQ0rPJ9oRIPg7jb69i8SOLjPGGdO6bYf/t0l84yHE/JexdpeUH3gqItsGmsp48HYlGzEj6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193d.versanet.de ([94.134.25.61] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBj2q-0005Os-ED; Tue, 28 May 2024 00:42:20 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	robh+dt@kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on Quartz64 Model B
Date: Tue, 28 May 2024 00:42:15 +0200
Message-Id: <171684956152.1783037.2786989707792820997.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
References: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 20 May 2024 19:20:28 +0200, Dragan Simic wrote:
> Correct the specified regulator-min-microvolt value for the buck DCDC_REG2
> regulator, which is part of the Rockchip RK809 PMIC, in the Pine64 Quartz64
> Model B board dts.  According to the RK809 datasheet, version 1.01, this
> regulator is capable of producing voltages as low as 0.5 V on its output,
> instead of going down to 0.9 V only, which is additionally confirmed by the
> regulator-min-microvolt values found in the board dts files for the other
> supported boards that use the same RK809 PMIC.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on Quartz64 Model B
      commit: d201c92bff90f3d3d0b079fc955378c15c0483cc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

