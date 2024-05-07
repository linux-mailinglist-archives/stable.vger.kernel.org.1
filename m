Return-Path: <stable+bounces-43289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B288BF164
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB42C1C2306B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FB13172B;
	Tue,  7 May 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEjavXHz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D61311BA;
	Tue,  7 May 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123301; cv=none; b=NFKhU2OGQHiDp2NJKrE/UZKZIlYtay+tLr0paHf6VsMKeJaZ+n12wPO1+/2TMqnFJAKhgwl6gDjxC2IkRJllsfzgRdqP82oLV60bbIcx7Sg/nqef/SfbZfWZMwzAuPpPu1TqJMhY45xcaEeTlQXVNbyhtzSieCyYnYla6ypAv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123301; c=relaxed/simple;
	bh=V9xwPCi2BbHqvXbn+HBOTFHYtgRml7I7/V1s2BHN2qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6gx6hsHnRQOYsalPlv3lyiRixe9OQlu/qPuYzBIlgNBJ1/u08TH202QTlGtBhUQmecM4WniavZMuabdz7g8MYiWQ6VAK8c+bs+RtPLQM1TEtQfi9vvU0HjWzTq2LQISOwPWgz/8SEq8J5GtQ+M/5ul/mKvvJCep4mlHPPsO3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEjavXHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5832C3277B;
	Tue,  7 May 2024 23:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123301;
	bh=V9xwPCi2BbHqvXbn+HBOTFHYtgRml7I7/V1s2BHN2qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEjavXHz+8lHS0DmRyyrHOEcB19RMa1gH8wbacYO+OCwApKlczbXWva1qqQ4wnenI
	 F56u6xWy9XnA9E0cyun/uhrFdQwfLnEcUeu48GUUbnMRz8w8axMKe+GNwLFx+2Wsw+
	 DY/NYh8UywrdJZBoehjQYNtNtEgy1A8JuMDQf443Qvllg+tv2CT9jQCFPAoC3g0S2c
	 8sTrLfkOtN8u/j/O9g/AdDMZN1yyk9u+IGGbQ9oRXJpo6jm4KCN5i/YOO7m6xaClMv
	 hj41sO9QI9yupgA6WFWwHZknE+3gnd/DKyHnbccX5rXTTHPcpCOoV5XFwAhSiSuJ1F
	 xAQdCjBrwSjNA==
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
Subject: [PATCH AUTOSEL 6.8 10/52] ASoC: dt-bindings: rt5645: add cbj sleeve gpio property
Date: Tue,  7 May 2024 19:06:36 -0400
Message-ID: <20240507230800.392128-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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


