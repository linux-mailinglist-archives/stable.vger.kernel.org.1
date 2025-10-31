Return-Path: <stable+bounces-191972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C1C27271
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 23:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33F23BB3E7
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 22:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ADD30E856;
	Fri, 31 Oct 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Jd9gO7t/"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7153195FC;
	Fri, 31 Oct 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951241; cv=none; b=XZBGwQdcNvvIisWh15gabSWAIS+/KoWcton2kK2F/8KP+ZOo1zFsNtGHbHnT6KCNaLzLaLwcgU7WY0SF3s17xKiDg9Nt6gjCW+3+flGSVocrLN7iS8HU++GTjgPd4S3j2ubatd4Oy1Uy49M8GvfMI+PTE4BtZVRtKoTsyHlmZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951241; c=relaxed/simple;
	bh=Yj29WDgxlLEedqCZR5eWBVpXmXjp2WjWbd056crVc3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpF6adzq6Zgsfhzj8hH1emwjqTxQj3tntlagTcAQsbOPQNMXnR8HEprxzhJb44riohoPzMrkvEvJHX3STXWL/Q04+ngYr7dxjlTETIufcimGi/1dKFRHHV9A36cChhMJWN5NClu7pAqBgBS8myzDVWF3L7xwthK88EVHCHmiv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Jd9gO7t/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=LGBstjIM281caVG9Z8ocydbe7tTH0iKKYoIgQmU9WDU=; b=Jd9gO7t//aDutiqNxMCy5TNTnw
	POsexLObduMMmCI60KIHom/r3TjiUJE3YP/U8Tvjyj2PnrlL2m9CkrOzvRvEuPFpSBfH21B4OUf31
	1SJ7by5B74ZRSwSMtMsg0iqtZXhcYyG3W+tHO0M1+JdH05hqbLmO4dyrNRH9hBNYYcuDZeeRUcCWX
	X9Daz2MeA8XrTzF46JqX1CeP9LXz33EhXjuQHaQUnLcqua+y5WOvxkyb0B3zFk6DqFNdOOamRurPw
	a6RwFblrmti9wzFr0d/Pvc9ZYaM3y8t9zC8HkkdFXrOywk+2+Yi+AT1WLWbt27Gu3wnUPQnMyreQw
	LDSUtU+w==;
Received: from i53875bca.versanet.de ([83.135.91.202] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vExzq-0004vM-LN; Fri, 31 Oct 2025 23:53:26 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <diederik@cknow-tech.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix vccio4-supply on rk3566-pinetab2
Date: Fri, 31 Oct 2025 23:53:19 +0100
Message-ID: <176195118799.233084.13663178557562820227.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251027155724.138096-1-diederik@cknow-tech.com>
References: <20251027155724.138096-1-diederik@cknow-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Oct 2025 16:54:28 +0100, Diederik de Haas wrote:
> Page 13 of the PineTab2 v2 schematic dd 20230417 shows VCCIO4's power
> source is VCCIO_WL. Page 19 shows that VCCIO_WL is connected to
> VCCA1V8_PMU, so fix the PineTab2 dtsi to reflect that.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix vccio4-supply on rk3566-pinetab2
      commit: 03c7e964a02e388ee168c804add7404eda23908c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

