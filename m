Return-Path: <stable+bounces-108137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FD8A07E2A
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D23716738E
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0E18C933;
	Thu,  9 Jan 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2ljEwoeD"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588918732B;
	Thu,  9 Jan 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441739; cv=none; b=YG1abgMjLKyihjSSDiy8ABsbeXv33th4L8bJzZjspisxxCmTLBHI3IdHwtc3R92soFmh4JYJL7W9GA7zO3iCvqIM4jD1MykXzR34AbGcGzzAQcK+0vtwLlxzIJ81dLeF45DJ/EBNGqzWYBwQa8DcOiDVYNaHr0doJZ4WDjpqfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441739; c=relaxed/simple;
	bh=SHxGHbh8BaNUt5C8a9BczwXGI+m12aIy6i7S+FOo3F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVC82D4rsQjkgk08rEXWL7TIQIUe03OS9Wum1MP3fEvsfan7hODLkmcjeQVFEYQJkugvoIspXrxHYZlGR4CUEz9wNq7WTSxc9ATbNYCyEs2jrTVFV6fR8y+TVPHX9Zr04ihRnJt8fAqbrxs/s5VcyxPiAflRF6VK+LxN2o2+fG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2ljEwoeD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AEiKFjkzgKWigijgMZ+BYkH9wSj7Ws/rYW5aY2RQxSw=; b=2ljEwoeDxNVWPLF+XZ8grBMuGb
	9eH8SI7UJKrKfbVC4315nZWMV0MgWyIixymPkH3BOmLdAS4LtaV7JWoNPM4S+wi7Ly7ZtTnsVF0aN
	Oc/XaDofnwoFYm7ytgKOwOm6vtgXEa4RtvMTlCC/ATZWgy3o6QMzfs11F8lBoglPccHMlaYPgxFaH
	5ZhHRL9SfIl2BJxgDAkhwaNft1/VagNohieqevar/WU1LxCDtW9r08otorj0b8UDjC/4GuTAXWkYS
	9N1I9vSB8jsNiNvyaWx/fpbB52zyI00uYagjNpsjrJClo6BKh4n/IqP0KgARL1VfbvU/MUswfEQfO
	qW7nM8Fg==;
Received: from i5e860d05.versanet.de ([94.134.13.5] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tVvoi-0003hx-Eh; Thu, 09 Jan 2025 17:55:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Klaus Goger <klaus.goger@theobroma-systems.com>,
	Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: Re: [PATCH v4] arm64: dts: rockchip: increase gmac rx_delay on rk3399-puma
Date: Thu,  9 Jan 2025 17:55:18 +0100
Message-ID: <173644170629.2899934.9406584209909558440.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213-puma_rx_delay-v4-1-8e8e11cc6ed7@cherry.de>
References: <20241213-puma_rx_delay-v4-1-8e8e11cc6ed7@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 13 Dec 2024 10:54:58 +0100, Jakob Unterwurzacher wrote:
> During mass manufacturing, we noticed the mmc_rx_crc_error counter,
> as reported by "ethtool -S eth0 | grep mmc_rx_crc_error", to increase
> above zero during nuttcp speedtests. Most of the time, this did not
> affect the achieved speed, but it prompted this investigation.
> 
> Cycling through the rx_delay range on six boards (see table below) of
> various ages shows that there is a large good region from 0x12 to 0x35
> where we see zero crc errors on all tested boards.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: increase gmac rx_delay on rk3399-puma
      commit: 9d241b06802c6c2176ae7aa4f9f17f8a577ed337

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

