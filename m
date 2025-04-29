Return-Path: <stable+bounces-138999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44BAA3D8A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24E23AFD4E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D3289E35;
	Tue, 29 Apr 2025 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuUoF3v1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323E259CB4;
	Tue, 29 Apr 2025 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970693; cv=none; b=UIZc9HFcgjSK7nQpKVzfwP4MlDQFfJaO6NFzM9gM9VXmpai3kGmo4cSUPsbjAe7nLJfAgEQUQ48DkvmCAEURuTYwL5lGvOoZdU0PnuTDjx0OWV9ljrxpDN/2Odjn0oE6J3IYWyLUqXRjzWGvm9ryNMWUU+ckk/EF1Zg8ZMz2ud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970693; c=relaxed/simple;
	bh=0thmh35gHKznLtBJJ5aw6yD6qUAMVfJjzOHdFZiBDRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5EVCk6/zkL5Mj5+nBT5R2hPi+kzortptbKh3TeXqtDSkG3naxJnmsSXFBXz2dsYo4qdS3iG5Z70xREzpnjIVpgIViGGeCwb+5WFHLQUy58H/cfI17mTDEPMt99ZfadhvBe91asSPPVxOWaNe7LBG5gOS3Nve4UF4vhA16sIncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuUoF3v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4275AC4CEE3;
	Tue, 29 Apr 2025 23:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970692;
	bh=0thmh35gHKznLtBJJ5aw6yD6qUAMVfJjzOHdFZiBDRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MuUoF3v1lUlHdwKFk7VSN4B6fgFZBtc113i82oiHKErnXFvVYQWgpxv7XR32h7A0z
	 Apvh+eUbtTfMUMgWAwe5BP+Mw33hhKMUj+fyJF5Gstl2m5zGfZc12QJVj8DnKIP71S
	 zCymqo2ts3E4woYAFIJQrSH9O80fO/2LNRyIKi3ZSAxB6Z1A+hO5HfiI5mp6bX/TR9
	 zzPuZaBYwsZmB9uWJbHuYAGULTvxPlKkEY+rBNPFy4bXYKeRKwP71qed50YuydtZB1
	 KKk34Nou4NTbYuLM35AiugVIHfg15r4HLJC9wbu0nKVBf6DQtF0D3lO5Opv/WbEQKR
	 h0tb0fBKYNMhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	srini@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 04/37] nvmem: rockchip-otp: add rk3576 variant data
Date: Tue, 29 Apr 2025 19:50:49 -0400
Message-Id: <20250429235122.537321-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 50d75a13a9ce880a5ef07a4ccc63ba561cc2e69a ]

The variant works very similar to the rk3588, just with a different
read-offset and size.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20250411112251.68002-5-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/rockchip-otp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 3edfbfc2d7220..d88f12c532426 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -274,6 +274,14 @@ static const struct rockchip_data px30_data = {
 	.reg_read = px30_otp_read,
 };
 
+static const struct rockchip_data rk3576_data = {
+	.size = 0x100,
+	.read_offset = 0x700,
+	.clks = px30_otp_clocks,
+	.num_clks = ARRAY_SIZE(px30_otp_clocks),
+	.reg_read = rk3588_otp_read,
+};
+
 static const char * const rk3588_otp_clocks[] = {
 	"otp", "apb_pclk", "phy", "arb",
 };
@@ -295,6 +303,10 @@ static const struct of_device_id rockchip_otp_match[] = {
 		.compatible = "rockchip,rk3308-otp",
 		.data = &px30_data,
 	},
+	{
+		.compatible = "rockchip,rk3576-otp",
+		.data = &rk3576_data,
+	},
 	{
 		.compatible = "rockchip,rk3588-otp",
 		.data = &rk3588_data,
-- 
2.39.5


