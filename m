Return-Path: <stable+bounces-86540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA09A1379
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 22:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAE11F21AB3
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF68B20FA84;
	Wed, 16 Oct 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enF1OaRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820318C323;
	Wed, 16 Oct 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109511; cv=none; b=J7C8cgN+Vpno//69YSPt+N+zgdovSB7Xrl5z88iCa71F6818fibC2puUc5FeXfgGeheJB47/nHpYtqz/B72nMZQgDvIH8Irc7WYfqt8r7OFcSxMog1EM9C46xsJu637+znOh4VQEd1Qsm6Dm7p9l8vPW+gNVEAUHHdO3fq95TgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109511; c=relaxed/simple;
	bh=/oKzWw2ZchUbmSx4FqbycrbLNA28FbIKpIdth/FxkZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwBVYwuNd2WQi/rWvaI7YQAYsaBPZZrgzHGhmF4L3ARWGHpLSw6PCVLrmZuDH5pbVgsu2Vatf1e1CvKpZXUGa5/OD/8e+9cOi88iS0Jw7kE6hLyWYX+Y7vuUb2uCXwq6gPs1U9IQ4HP83rmpQTLwzg6zS0t80LtYCMu9CI2Cvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enF1OaRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64B9C4CECD;
	Wed, 16 Oct 2024 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729109511;
	bh=/oKzWw2ZchUbmSx4FqbycrbLNA28FbIKpIdth/FxkZU=;
	h=From:To:Cc:Subject:Date:From;
	b=enF1OaRAmshe0lg/6tiN+mah5QpoJPjKW5zBn1kYI0+swr65LsDQQlW92iPFhJAZC
	 8SRgAats42h+luFJ76cG0gRmi++uGOS5xpYTQcIhirin0we10bT03PAAa/xB3Yhvoq
	 yJ4ctGJ/r8TMN/Gms0k+psOQ/45yuZZ3Z3rauLbmX+0+/w/HAbZITSMmg7C5/Z3Bc7
	 qkacJL1lNt+22ACyWIJNjcMkpsKbZnkv6UeRulbg/AvGEkZnx0vVCP4chVDwPAnU9z
	 Zyz361q7ibbcHBNi8NoaVFFMtRItcDzQSa6zByV6Xecg1brFXw/3RpV1/pxcbnHo8g
	 9I4zyKTZVGh/w==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Aurelien Jarno <aurelien@aurel32.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: dts: starfive: disable unused csi/camss nodes
Date: Wed, 16 Oct 2024 21:11:15 +0100
Message-ID: <20241016-moonscape-tremor-8d41e6f741ff@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=TA23QI9GhTHMBm0fZ2HR8Y0W1keRXmxZDdgD37cIfRw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkCso82dF42Ed7CmCvqcONVtdMn5qNmDH/uPvV7M1uGc amwaIVbRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbiZMjwi2lSNEPwXIu3lTpT ztzSqOVXnGN5baXA7hfN+2ZHbazhMmP4X9DaJ1e9+8XqnReSheZY2C078rcw+3funWcBNj2tEVW TuQE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Aurelien reported probe failures due to the csi node being enabled
without having a camera attached to it. A camera was in the initial
submissions, but was removed from the dts, as it had not actually been
present on the board, but was from an addon board used by the
developer of the relevant drivers. The non-camera pipeline nodes were
not disabled when this happened and the probe failures are problematic
for Debian. Disable them.

CC: stable@vger.kernel.org
Fixes: 28ecaaa5af192 ("riscv: dts: starfive: jh7110: Add camera subsystem nodes")
Closes: https://lore.kernel.org/all/Zw1-vcN4CoVkfLjU@aurel32.net/
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Emil Renner Berthing <kernel@esmil.dk>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Changhuang Liang <changhuang.liang@starfivetech.com>
CC: devicetree@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index c7771b3b64758..d6c55f1cc96a9 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -128,7 +128,6 @@ &camss {
 	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
 			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
 	assigned-clock-rates = <49500000>, <198000000>;
-	status = "okay";
 
 	ports {
 		#address-cells = <1>;
@@ -151,7 +150,6 @@ camss_from_csi2rx: endpoint {
 &csi2rx {
 	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
 	assigned-clock-rates = <297000000>;
-	status = "okay";
 
 	ports {
 		#address-cells = <1>;
-- 
2.45.2


