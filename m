Return-Path: <stable+bounces-31418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE46889CE9
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CEA2C5BE1
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB234C554;
	Mon, 25 Mar 2024 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4fygbJe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BC20371D;
	Sun, 24 Mar 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321455; cv=none; b=S40EJzeIEjbXVfU4BnzIbZG97U69IYjLsjVokjmRlo+q7lS8p89SQod9pCjKwg5kJSjptHJrlCgEnV15n2PtzPuQTW9r/42vDuXH+kNHYK0rkIlmS7UDEK2ppk7U54zs3ONtV+HegBExpg1sgOdjyPVyXZ/kRtBMi3GhM4RjbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321455; c=relaxed/simple;
	bh=wlZaNRduiN50WuUJtWzPVPHyfezdgv5zUJbAbAJbO/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaumcZEmaMO278EeWxRA5R0Ji5e1eMNZlMrjEKmXGRSkIi4TzKf6brgJNREhGtzGACR8H2sXAMNKES2OJr2Az4nMJeYQ2gQwnzmUvBLy59lHOjuUdH6CkbUQtXaWU6DLEqQns0pvyfsqpiPPT6dLl93uO15aDsYBYu/JO2KSNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4fygbJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9479C433F1;
	Sun, 24 Mar 2024 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321455;
	bh=wlZaNRduiN50WuUJtWzPVPHyfezdgv5zUJbAbAJbO/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4fygbJeM+H7vqeeVnm+BF77BTLnUn3RqtrdzGO7SuR6oP5vV9yRw6T00w99PkDp/
	 5QfLgZZGrx95cYUMphKpzGIuPt9yHmPgeJZEp122qF+TV3j3rvX7zOQE6Fe602mx1d
	 rR3yxmdHfTNNhXFe8LdI2yD+WetW2S+0llT5DjECkIzclmFCdgdX/bCfiAeEcstiR+
	 UaYz/03xNwqIhhC1Z3kPWqwu95/fJmQ+jwssns7GT7Nb5KEJWUbMh2qbxAISY9rFWf
	 NTcFeld+Un7PJbFdztIb9z1XIQBIIeP7k607pcaJusqPFEAygKjNpfeLank0kENPLz
	 p2JupE9rf6Ywg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
	Andrew Davis <afd@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 180/638] arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
Date: Sun, 24 Mar 2024 18:53:37 -0400
Message-ID: <20240324230116.1348576-181-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Manorit Chawdhry <m-chawdhry@ti.com>

[ Upstream commit 5ef196ed912e80a1e64936119ced8d7eb5635f0f ]

Fix the power domain device ID for wkup_vtm0 node.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/devices.html
Fixes: d148e3fe52c8 ("arm64: dts: ti: j721s2: Add VTM node")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240201-b4-upstream-j721s2-fix-vtm-devid-v2-1-85fd568b77e3@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 2ddad93185541..71324fec415ae 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -652,7 +652,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0x42040000 0x0 0x350>,
 		      <0x00 0x42050000 0x0 0x350>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
 };
-- 
2.43.0


