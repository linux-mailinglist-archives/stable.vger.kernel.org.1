Return-Path: <stable+bounces-57182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E2B925B4F
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57131C210B2
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B219CCF1;
	Wed,  3 Jul 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P1xVutVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD019CD00;
	Wed,  3 Jul 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004101; cv=none; b=b0qb+m4zW0e8cOT0jEqWFedTWLm8hlHxgoAhYOHV1ZttD7B9X9aejtEGyMAqF95CGVvN1MLQkWGy9BxAEBkGJl14dhPCWptiT8n1vTNaOMBGSNFi42dlW1zOFRlqxvOhHFjUMXXQ55LSUf7PprPkqyqG9cpUTmQw+0Iyqc1eCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004101; c=relaxed/simple;
	bh=HFdfS5Z3OlNYvWhmgr8QGBFcYGhzxzg328iSWCBomz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGkPb2q8zLSa6rFpR7PyJ95hJCdySmfJn7thBlFWtcjds9XK8L5Tho5S2wxXDxOJkaIy7O5zw65MrTxGwjp+d5/wKyz7spGXYRPBEDjqaPDQQ6lflZGuEkgUdDMvzhALZIvAHO+jHj9dxuNboV79YWmL7CLC1jvJdmCscTdzaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P1xVutVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA456C2BD10;
	Wed,  3 Jul 2024 10:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004101;
	bh=HFdfS5Z3OlNYvWhmgr8QGBFcYGhzxzg328iSWCBomz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1xVutVk+tTBSuQG47E7SbJpr5c5YiBdaF3iQ9MOeIgQhqPgPxq+TxU9lWLkkUX9b
	 N2kxtCXKgVpyk7mpq8Cs0EqqSD8DfjQNivNTwzZCVjhNLSrrYa/u5e9hjB1ZSqW5vz
	 d+GMMbOHYWSc7Co7YCpv9BIVBMQvJk4zhDJ6qDuc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 121/189] ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
Date: Wed,  3 Jul 2024 12:39:42 +0200
Message-ID: <20240703102846.062555600@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 88208d3cd79821117fd3fb80d9bcab618467d37b ]

Although the Samsung SoC keypad binding defined
linux,keypad-no-autorepeat property, Linux driver never implemented it
and always used linux,input-no-autorepeat.  Correct the DTS to use
property actually implemented.

This also fixes dtbs_check errors like:

  exynos4412-origen.dtb: keypad@100a0000: 'linux,keypad-no-autorepeat' does not match any of the regexes: '^key-[0-9a-z]+$', 'pinctrl-[0-9]+'

Cc: <stable@vger.kernel.org>
Fixes: bd08f6277e44 ("ARM: dts: Add keypad entries to Exynos4412 based Origen")
Link: https://lore.kernel.org/r/20240312183105.715735-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos4412-origen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index c6678c120cbd1..7b2dceb47c44c 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -431,7 +431,7 @@ buck9_reg: BUCK9 {
 &keypad {
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <2>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
-- 
2.43.0




