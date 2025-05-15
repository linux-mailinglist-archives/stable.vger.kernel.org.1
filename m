Return-Path: <stable+bounces-144528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B6AB86F8
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 14:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F027B1D98
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BC29B226;
	Thu, 15 May 2025 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lQdljp3l"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2529ACEE;
	Thu, 15 May 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313467; cv=none; b=uPVpsmgPK4xaSoiDxExvzIrZgYAzhLtznQ9KoEe6a9WYCuU7djtw0dNt49wVCsLsm8eJ4T7iQrmxN9eItCo26vTpX3fAVeUkiv4a82+HB83SISZHaw9vwXQinY8E4jLG4wrGI6SJ9WwGfkNpAbTD2XTjr3Mx/zqU13Rn+7EWCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313467; c=relaxed/simple;
	bh=3QC4ffM1Aa1pxu9uvJFwWx/DFJiMYK2jTahWSrSwVns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHZApsHIM8ylfhOKykrlHqe9tZSbymba9kWGDzZ/bAh6Mv6YxZ3aVHHeBEpa7OQuFU61bSpPgSCDhW87ECujWX+eIhno98C+FJngIe6pbuWJskaDV+JFmD4vkq1t9yqxOAdwW1qVhjLrdBp7OGDXn7obtvyB4/5jSi5DuvbgvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lQdljp3l; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2dhwvLZ3lMVhmKEnca5rP7c57gf2pJHeBmKdCsIIeL0=; b=lQdljp3lEee35nVJq5VsP15Ac0
	G3TV1N3nN47hq4ycpzthNv2Y4tRkox9fkOdp6bOQY2CT728MLhVqQ8ALawdPWo3zPOhO0XO42KSUm
	u0Riq4EB4PdDqO/6oTdXb2W3TjmhWZBJFRHSvhgqrCzn7wvC8bwBl2NWXDHAm7jzX9IZyqrvUpVJE
	IUxjNlLkgeGgWQHyM6lalXF0QKD3i098rkQ2mbjAytZ1/eSwkuKC+aJzeMBzKQi0fwYxbSQYXozwM
	C2EY9zh7h9BMdHlQcxj8rDlfIBCz/yntxH9AKv6tinjh1F+NsRfbKbZSCvoErHVZLA1e3rzo9LekK
	TvpW1NZQ==;
Received: from i53875a50.versanet.de ([83.135.90.80] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uFY39-0004ph-BC; Thu, 15 May 2025 14:50:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Matthias Kaehlcke <mka@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Klaus Goger <klaus.goger@theobroma-systems.com>,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: (subset) [PATCH v2 0/5] Fix onboard USB hub instability on RK3399 Puma SoM
Date: Thu, 15 May 2025 14:50:45 +0200
Message-ID: <174731343062.2524804.11565347943974455778.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
References: <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 25 Apr 2025 17:18:05 +0200, Lukasz Czechowski wrote:
> The RK3399 Puma SoM contains the internal Cypress CYUSB3304 USB
> hub, that shows instability due to improper reset pin configuration.
> Currently reset pin is modeled as a vcc5v0_host regulator, that
> might result in too short reset pulse duration.
> Starting with the v6.6, the Onboard USB hub driver (later renamed
> to Onboard USB dev) contains support for Cypress HX3 hub family.
> It can be now used to correctly model the RK3399 Puma SoM hardware.
> 
> [...]

Applied, thanks!

[2/5] dt-bindings: usb: cypress,hx3: Add support for all variants
      commit: 1ad4b5a7de16806afc1aeaf012337e62af04e001
[3/5] arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma
      commit: d7cc532df95f7f159e40595440e4e4b99481457b
[4/5] arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      commit: 3373af1d76bacd054b37f3e10266dd335ce425f8
[5/5] arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou
      commit: febd8c6ab52c683b447fe22fc740918c86feae43

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

