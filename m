Return-Path: <stable+bounces-43403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C58BF279
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDE41C2258A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163913A269;
	Tue,  7 May 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDek9ubd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C91201255;
	Tue,  7 May 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123618; cv=none; b=e/Xk9be49LoVbpNywA0dG+YlwzRI3fdtf1t5zqYOUZVTLYjNSosSRT9DxKRGr2pXSHq6E0hRnqt574WULw4CNBEHTVlL2zqfrtUdTQDQwPW/d/xylFqa+cwbDZyDzyzZUi+rIOUYoNaUGKQnDEZxZ7Kg4WNgJUZrmBo3t7j3q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123618; c=relaxed/simple;
	bh=V9xwPCi2BbHqvXbn+HBOTFHYtgRml7I7/V1s2BHN2qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ6kinWwL27WR1b4keY/BaAMZJUVpWRJH5LfmjrzEZh4RxHlyfXZ19nTZEYC+lfhTdi9pxGVhHKGTB0UHoBc9fBYyZhjcUTJFXxkO5Ba1IqWYTjGB0Y6RdFQE1Xo7hwKB43PldJCGo9kMqdldj/nS5kQahLnrPhbxRsCVRUeXcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDek9ubd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECF0C2BBFC;
	Tue,  7 May 2024 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123618;
	bh=V9xwPCi2BbHqvXbn+HBOTFHYtgRml7I7/V1s2BHN2qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDek9ubdtnmpydOIP6XxdPUjEjKpCb+qDPrffLG8OiyC1SgBrBiK/QPM2u56ZoPz9
	 Hr7Z1B8O9JCljGsgiU8yYV1B3tY+UaV907XoevznjeOEcofLwD9TP8BDrBryUVTKeM
	 MydkcixPYA696OET4QvlRtROHKMTbePctaNcjCaAi/hTN6XB1mEEZQj6v5p4zdymL0
	 jVx3mAbCdcYTJuyFJdwXkf8Ug4isHysqtH58t1w+H3Cb4ShkIZQC++Pj3mECnDxrEh
	 iRQtibtaWCfVv7L4kJGlvuCtR5a++t6HXHYxzNI6GYt4/yTvqiJV0Szz+pICFwEBRh
	 ByoQvCYosNDJQ==
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
Subject: [PATCH AUTOSEL 5.15 03/15] ASoC: dt-bindings: rt5645: add cbj sleeve gpio property
Date: Tue,  7 May 2024 19:13:12 -0400
Message-ID: <20240507231333.394765-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index 41a62fd2ae1ff..c1fa379f5f3ea 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -20,6 +20,11 @@ Optional properties:
   a GPIO spec for the external headphone detect pin. If jd-mode = 0,
   we will get the JD status by getting the value of hp-detect-gpios.
 
+- cbj-sleeve-gpios:
+  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
+  contacts to the ground or floating. It could avoid some electric noise from the
+  active speaker jacks.
+
 - realtek,in2-differential
   Boolean. Indicate MIC2 input are differential, rather than single-ended.
 
@@ -68,6 +73,7 @@ codec: rt5650@1a {
 	compatible = "realtek,rt5650";
 	reg = <0x1a>;
 	hp-detect-gpios = <&gpio 19 0>;
+	cbj-sleeve-gpios = <&gpio 20 0>;
 	interrupt-parent = <&gpio>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 	realtek,dmic-en = "true";
-- 
2.43.0


