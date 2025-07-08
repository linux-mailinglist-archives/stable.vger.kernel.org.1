Return-Path: <stable+bounces-161039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58190AFD2C0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2CF7B0009
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844412E0411;
	Tue,  8 Jul 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P+2a1ydK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41974225414;
	Tue,  8 Jul 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993419; cv=none; b=M6SshSTmeX1+ZLQZK5e8rf3Gsmys384nofEJ3wgZ58P1a0+msqyO8SIdyhFDlGNM0yq8gVO2Gix7dsCnfc8KlLkM2gcxP6aF/sIaKUzGR9DRePyFyddfgj6l3RjQ06XuTcJE6SMp9fN8/67CzuLYZmBSvvI4jVpxHlaesYhVtdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993419; c=relaxed/simple;
	bh=SS/kxkd453EtdTYXwQZhPuJpKCe7i5HZRkFwW6fpLRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHOAeRXc+a303NE6XW12x/vEuHlaW7Eqo4C6c3+j4YPM+u3QrStVHLfumpUzwBrMR8LLJP5CWAomYEsHqLTxtsD1kMGuBHFyTVJ3nMw03Oa2M/Ib0L6i6OVUvON8P8jcBJ38BDmWp9XwXpATChukXIYfYD4TY3sNRE5SfD9NBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P+2a1ydK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB17CC4CEED;
	Tue,  8 Jul 2025 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993419;
	bh=SS/kxkd453EtdTYXwQZhPuJpKCe7i5HZRkFwW6fpLRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+2a1ydKAgShcEdpHPyaWU0E+Amid4Zol8sL60M0AA4HzrmeRd2aLQSeQATULBSco
	 t0BOIo6tf/yE8pZz6DUCb+UOxzYSvhFDP67MOgKetyj0rTLdLUROTOyXb3hnIKer+W
	 P6enBgaN4pSyRsRykkTHYaln4Me9iTurQoeM79oU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Janne Grunau <j@jannau.net>,
	Sven Peter <sven@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 040/178] arm64: dts: apple: Drop {address,size}-cells from SPI NOR
Date: Tue,  8 Jul 2025 18:21:17 +0200
Message-ID: <20250708162237.726548429@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Peter <sven@kernel.org>

[ Upstream commit 811a909978bf59caa25359e0aca4e30500dcff26 ]

Fix the following warning by dropping #{address,size}-cells from the SPI
NOR node which only has a single child node without reg property:

spi1-nvram.dtsi:19.10-38.4: Warning (avoid_unnecessary_addr_size): /soc/spi@235104000/flash@0: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property

Fixes: 3febe9de5ca5 ("arm64: dts: apple: Add SPI NOR nvram partition to all devices")
Reviewed-by: Janne Grunau <j@jannau.net>
Link: https://lore.kernel.org/r/20250610-apple-dts-warnings-v1-1-70b53e8108a0@kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/apple/spi1-nvram.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/spi1-nvram.dtsi b/arch/arm64/boot/dts/apple/spi1-nvram.dtsi
index 3df2fd3993b52..9740fbf200f0b 100644
--- a/arch/arm64/boot/dts/apple/spi1-nvram.dtsi
+++ b/arch/arm64/boot/dts/apple/spi1-nvram.dtsi
@@ -20,8 +20,6 @@ flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-max-frequency = <25000000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.39.5




