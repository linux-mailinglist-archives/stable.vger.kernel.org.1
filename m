Return-Path: <stable+bounces-43433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B84C8BF2BD
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00621F22C24
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000613A878;
	Tue,  7 May 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/S2XvUi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58801A1A6B;
	Tue,  7 May 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123682; cv=none; b=uQs+goO6B1hXn41J4UwL75ARpOCMLZvUGKzRFeGNS+8j8zPGiTzZq+wAjrLo2TWSy8rLWM7r36NoGpTa50q1iXylb6pZV9cPrFZZLWoOf0eLrvxMgZAIpwWWBUn023YWeL98CA2VqwQGPtnLPcRlMVV7n0SansHK6fnheHkKBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123682; c=relaxed/simple;
	bh=DLyN2r9encUr8sDr7IL9hDMF/WiK1le1ynlyYCtHKX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UENzs6DU1FX1M7MHMBW18Mc4tXJTwSs5eLQ44nb+yyTAl2CXQrWvB5RPO+gn8hjIDB1Pglk6Hc7FpwHyNOU+zrz3fxJXVMDnaMGWQeY5OgzqZQv8Q65SFmxsFdlivpCK09X4vMIc79+BxLpzHl3dKGARnOHKbt84eQDHh/PaVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/S2XvUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F49DC2BBFC;
	Tue,  7 May 2024 23:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123680;
	bh=DLyN2r9encUr8sDr7IL9hDMF/WiK1le1ynlyYCtHKX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/S2XvUiXZRGqerf52Cx2Tu1sEVaI3Z1TponUbRGu2Vh2TdihZXzAc8xrYs6DEoWr
	 QRYglVyr01ImRWHlgv0a2XvPk5/81IHlrbaLTB1dD7cgskW4hGS3Eh9q5O7fBjatlM
	 716OSumw8NffAevtlGXdBtEeZtXS/j2hs8UQgbb/nh4zgUwKd0zoS46+kX/3LgvAZ5
	 eIGC2oK7pyh2So1w2ERz0Sr1rnBbxEBuFb5FqPGvtfN64sh8t2oNYIqouCKeNue/IE
	 wA6NUp9CkOB6wHLFjYh/oXXTFx5cUNLe7MzN6dHSsiarYoPvlTJ/CqjbRnkQReLK9r
	 sHAd684E5P8yQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Derek Fang <derek.fang@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/4] ASoC: dt-bindings: rt5645: add cbj sleeve gpio property
Date: Tue,  7 May 2024 19:14:33 -0400
Message-ID: <20240507231436.395448-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231436.395448-1-sashal@kernel.org>
References: <20240507231436.395448-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.313
Content-Transfer-Encoding: 8bit

From: Derek Fang <derek.fang@realtek.com>

[ Upstream commit 306b38e3fa727d22454a148a364123709e356600 ]

Add an optional gpio property to control external CBJ circuits
to avoid some electric noise caused by sleeve/ring2 contacts floating.

Signed-off-by: Derek Fang <derek.fang@realtek.com>

Link: https://msgid.link/r/20240408091057.14165-2-derek.fang@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5645.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index a03f9a872a716..bfb2217a9a658 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -16,6 +16,11 @@ Optional properties:
   a GPIO spec for the external headphone detect pin. If jd-mode = 0,
   we will get the JD status by getting the value of hp-detect-gpios.
 
+- cbj-sleeve-gpios:
+  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
+  contacts to the ground or floating. It could avoid some electric noise from the
+  active speaker jacks.
+
 - realtek,in2-differential
   Boolean. Indicate MIC2 input are differential, rather than single-ended.
 
@@ -64,6 +69,7 @@ codec: rt5650@1a {
 	compatible = "realtek,rt5650";
 	reg = <0x1a>;
 	hp-detect-gpios = <&gpio 19 0>;
+	cbj-sleeve-gpios = <&gpio 20 0>;
 	interrupt-parent = <&gpio>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 	realtek,dmic-en = "true";
-- 
2.43.0


