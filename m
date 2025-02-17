Return-Path: <stable+bounces-115744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D5A345E6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897123B5128
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D74156237;
	Thu, 13 Feb 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oSbD/Y89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894726B087;
	Thu, 13 Feb 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459099; cv=none; b=lNHONaXTNuEgGwdWQlcaWDVe4eD4NjcYr52eBY/HK2Lvdzt/yGqG1vr6UoVTDdDTszeNc/kaYigBVVoX/PUFMZKp6EFGkDMjDmAZ402EJbbvKbhqUSLthSWsbGv9ANpmjhBqhquIqRlENegxiFoL34SCvbv4qqYjSTzpFznC7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459099; c=relaxed/simple;
	bh=KcrvqXIzIHbukt2v6yKSCn4hOI6FJiCvcBfyTv4iMy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9GAqaTvvfj/k6N+hWeZ2dRDARDq9cboz68XkPTi0xJpzfJiphixZAtL0FHnmyLpGizy5hOmKyL2lJUU38+XAV/pub4qcFiQboMtA1lg3bb32GgzI0N8953jC+qqWjws3zVTKDGYqTHnYH3faULW0I+T6UCgZIuhRAqbynJCDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oSbD/Y89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCE5C4CED1;
	Thu, 13 Feb 2025 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459099;
	bh=KcrvqXIzIHbukt2v6yKSCn4hOI6FJiCvcBfyTv4iMy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSbD/Y893pREOF2eFVLm4Cs1BK7tQ3aZEy/xbdp0BZHOrPNJgCjcTH7jMix+lfZ1i
	 ZW8o8ePSTHjmuVbSBrdqj+TWzUQM3AUrYiJ1ZcpJIEtfKNZjxNGIumCbHp19BiOGHO
	 QpOWjM38kI0YMAc3mA+F7Ff4jeca+g/hSAg4rgYg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.13 166/443] arm64: dts: rockchip: increase gmac rx_delay on rk3399-puma
Date: Thu, 13 Feb 2025 15:25:31 +0100
Message-ID: <20250213142447.005365430@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakob Unterwurzacher <jakobunt@gmail.com>

commit 9d241b06802c6c2176ae7aa4f9f17f8a577ed337 upstream.

During mass manufacturing, we noticed the mmc_rx_crc_error counter,
as reported by "ethtool -S eth0 | grep mmc_rx_crc_error", to increase
above zero during nuttcp speedtests. Most of the time, this did not
affect the achieved speed, but it prompted this investigation.

Cycling through the rx_delay range on six boards (see table below) of
various ages shows that there is a large good region from 0x12 to 0x35
where we see zero crc errors on all tested boards.

The old rx_delay value (0x10) seems to have always been on the edge for
the KSZ9031RNX that is usually placed on Puma.

Choose "rx_delay = 0x23" to put us smack in the middle of the good
region. This works fine as well with the KSZ9131RNX PHY that was used
for a small number of boards during the COVID chip shortages.

	Board S/N        PHY        rx_delay good region
	---------        ---        --------------------
	Puma TT0069903   KSZ9031RNX 0x11 0x35
	Puma TT0157733   KSZ9031RNX 0x11 0x35
	Puma TT0681551   KSZ9031RNX 0x12 0x37
	Puma TT0681156   KSZ9031RNX 0x10 0x38
	Puma 17496030079 KSZ9031RNX 0x10 0x37 (Puma v1.2 from 2017)
	Puma TT0681720   KSZ9131RNX 0x02 0x39 (alternative PHY used in very few boards)

	Intersection of good regions = 0x12 0x35
	Middle of good region = 0x23

Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Cc: stable@vger.kernel.org
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # Puma v2.1 and v2.3 with KSZ9031
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Link: https://lore.kernel.org/r/20241213-puma_rx_delay-v4-1-8e8e11cc6ed7@cherry.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -182,7 +182,7 @@
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-	rx_delay = <0x10>;
+	rx_delay = <0x23>;
 	status = "okay";
 };
 



