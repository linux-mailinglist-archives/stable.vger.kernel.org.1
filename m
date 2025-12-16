Return-Path: <stable+bounces-202131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FACC2A5C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBBEF30287FE
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2445035504A;
	Tue, 16 Dec 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxKsi34r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BA35502E;
	Tue, 16 Dec 2025 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886915; cv=none; b=dJdB7vYzBOIAw4nBOlQnU3ahrkt8ACtS8Vdd5jp0aHeKim2JX/s0hpQeKa9TShko+4aTKj+xX5qjLHUjUiMcxu2rP5xjT/0opArMNmU3k4WgzF9PoF/QOQYJxvlE3oxcOfnk0Z5kvlIU3IIdkgnzlymjTaput5Ul2fy+3bq+fpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886915; c=relaxed/simple;
	bh=sVkEMVqsO1EQnjsKMZzYQaNjQH9Q2VnzAo2AI4jXR+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKlYG7/9Cb7EeJehqYCvCMQOQ2OQekbgdt9KVhEhm7AOr0h5rN3UkyrHl45Hjqe0sik2HWVHXFuaJgqP6Rz9z5W5hWkZTaQ7cXc9Wwz76P9zudv23T4OhHfPRwkwGtfRpnrqYpu+X17SCPuQRpkP3+C7YthMUWgDborXnF60yJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxKsi34r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FD5C4CEF1;
	Tue, 16 Dec 2025 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886915;
	bh=sVkEMVqsO1EQnjsKMZzYQaNjQH9Q2VnzAo2AI4jXR+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxKsi34rthlkbBFiMBGRErWeD4vKZ+p+XrfZkbUe3x6LEJS1eRnWQvRkXMblWusmC
	 PqyfvUbDU1o6s596bhy1q0SBKtbgswosVrDAVzuusXnZuylE00vQsG/AoPn1wEOZht
	 koTBbptwo/cxONQTdSd8Y059URm2xWc+hWMR5ou0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joy Zou <joy.zou@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 072/614] arm64: dts: imx95-15x15-evk: add fan-supply property for pwm-fan
Date: Tue, 16 Dec 2025 12:07:19 +0100
Message-ID: <20251216111403.923477451@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joy Zou <joy.zou@nxp.com>

[ Upstream commit 93b2fac5cdaf0d501d04c9a4b0e5024632a6af7c ]

Add fan-supply regulator to pwm-fan node to specify power source.

Fixes: e3e8b199aff8 ("arm64: dts: imx95: Add imx95-15x15-evk support")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4a..0953c25ef5576 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -61,6 +61,7 @@ chosen {
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
+		fan-supply = <&reg_vcc_12v>;
 		#cooling-cells = <2>;
 		cooling-levels = <64 128 192 255>;
 		pwms = <&tpm6 0 4000000 PWM_POLARITY_INVERTED>;
-- 
2.51.0




