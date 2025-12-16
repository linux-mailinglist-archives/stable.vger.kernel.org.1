Return-Path: <stable+bounces-201638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D3ECC391A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84081309CBD3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742E34D3B2;
	Tue, 16 Dec 2025 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgkmfIjx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BF34D3A8;
	Tue, 16 Dec 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885299; cv=none; b=ssTC/6xTldBiliDXOJ9jNHqPASwB/zAe9o2apFHsZiqdskUyPKYU0XnQABA7Flmvndqu73emYEN+fTnRTGbJOsQ8vbhXWDTAX/uIJiC/U8lbjt/prHbupC6BhUx8UI1MkE6nv4V+Lvm8VXfSy3UY6YIjf2+dM5+/scKWkHaeFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885299; c=relaxed/simple;
	bh=3/hNln1eZ7Xsrego9GqeNhWN8CItHp6LT1b42NqM+mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfzAexNvBTiFv3NbfgI4ZZaEENwZ2lN2VcexOJgdSPJRfG6ft6sSjuvLO0aJDgDUf9SpHm+EVdwZSko3Ru4Ewq7sI0WIvDcC8xcFUKeWaYZ7rzvWG7GHF6gqM/c/kgQWZZ0VgWKJtVe5Wy6xOFVrte1Xaae0FfgmdvYEgyYheG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgkmfIjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ADDC4CEF1;
	Tue, 16 Dec 2025 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885298;
	bh=3/hNln1eZ7Xsrego9GqeNhWN8CItHp6LT1b42NqM+mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgkmfIjxXGNTvyQNlVtFzwa/HNZ/KRzRq5gWznXm1x/pF6FOz3tgyFrt1CW9zpKQ/
	 1o0Sfhbe2E8gwczh+6GxeLIFPrxEXVjVMn4/NzyGBT7ilW+zV7OpqF9M6DW96DZ5F0
	 y2MFn9Ggoyqj6JF6A9n7T5zqQar05AaphdfBEOpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joy Zou <joy.zou@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 064/507] arm64: dts: imx95-15x15-evk: add fan-supply property for pwm-fan
Date: Tue, 16 Dec 2025 12:08:25 +0100
Message-ID: <20251216111347.861653448@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

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
index 46f6e0fbf2b09..29630b666d54a 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -44,6 +44,7 @@ chosen {
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
+		fan-supply = <&reg_vcc_12v>;
 		#cooling-cells = <2>;
 		cooling-levels = <64 128 192 255>;
 		pwms = <&tpm6 0 4000000 PWM_POLARITY_INVERTED>;
-- 
2.51.0




