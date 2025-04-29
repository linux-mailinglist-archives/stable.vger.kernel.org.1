Return-Path: <stable+bounces-138961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08815AA3D10
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050863AD912
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B35255F31;
	Tue, 29 Apr 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gncdQYjB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E5255F25;
	Tue, 29 Apr 2025 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970618; cv=none; b=tSSeM20HwOd7WiBckd9oeYeJBiBqg/28emKzzCNgjbU88uF8Uh4Hvnl9UlPeLLONLyx7nbMWJvgzeB83ZlQ1WIG2Ff62UE4k1MrE59xT+pJN+rWwIzewDQzcK2f/6/PtBx9+JjvLc2C+h8QF/NZVhcl19J1dBnVgyTJ+dlMUDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970618; c=relaxed/simple;
	bh=0thmh35gHKznLtBJJ5aw6yD6qUAMVfJjzOHdFZiBDRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMt0sVSoOn5VcXwKswGSEMGs0CKIfx4h8vzvv2etQD/Y7p2FsnSZcXa/BroYUVlurV8vGPAWnREy42rGjSGAG0j20jY7HuPNz8IFyGC7V5wu3M+jkzZ9w142HNrpEyLj6BiRi9cUrvo+Bu4eXfwhiCAhqYmtUgOdA+Da8G6jlaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gncdQYjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B846C4CEED;
	Tue, 29 Apr 2025 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970616;
	bh=0thmh35gHKznLtBJJ5aw6yD6qUAMVfJjzOHdFZiBDRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gncdQYjBoCOnhr3ihOauSMJ1KLR9F33cyxgD+v8ldSeFgscPiU2F0MTy0xJnlsbIL
	 Va4mzkdUSz/U6IG0UfMFdzMWZqsM7tusfmPM+qM8Cl6Gfyhill2MhwydDFlVmI9lKe
	 JFaAUqboe5IA2TIhZWvKeRDucUM3hU4Ta3cmI388nuMq2gKql02MP4BHurtTSy+32B
	 maOiXAyqQ1kXneESJQW4MClBzjHuuXcr6axnHbHVxaPrunxtxg7x4jYz5c9ugJQaAM
	 QbZ+idbxKmdfiBNLiJQR7QhL3uhLi9efyNDVnfzA178j3fVnzKm30Osjz3Utw6ox4W
	 qx+ESsRJ4VOJQ==
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
Subject: [PATCH AUTOSEL 6.14 04/39] nvmem: rockchip-otp: add rk3576 variant data
Date: Tue, 29 Apr 2025 19:49:31 -0400
Message-Id: <20250429235006.536648-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
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


