Return-Path: <stable+bounces-139970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059F3AAA31E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022731A84EDB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507E2EE4B5;
	Mon,  5 May 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLcB0WVn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6312EE4AA;
	Mon,  5 May 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483800; cv=none; b=mXWwt46BIrG6cMHHhbkFUQm0s1o6bKRtE+y8yPgiqT/pLkhPARAwhEjwQKqrwn1WCebWlBT5kkQdPsheMnKhIyhGx7/G7K6E0oPy5JWjDMN+KlBUR1Ba4dH90xi3W2CyjgmkE25fpTulVleh7qKgEqJhgJxCvMVLi58P+aRqKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483800; c=relaxed/simple;
	bh=xcTwYq2bMsivseQDA5CYNGoPJpwC7m1P/ITeFcI4upU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UT74oWK1FVZjvoCWjfeR+gmr8ZqQZ9ENTSMM2nvXk6fiY4o53nCT3hi8Yv2c0nxVLEsNWJT8bbCW+9lcTMYyHAfZeIOUtnSeCbIE94Q9pGN7yPWJkEgv+LZUWwYtEY2h3zquiEXOCfmTC0eHA6b39im7b6ZS3/UAOi7Zhmpi50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLcB0WVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1868C4CEE4;
	Mon,  5 May 2025 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483800;
	bh=xcTwYq2bMsivseQDA5CYNGoPJpwC7m1P/ITeFcI4upU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLcB0WVna8wWAQG1Kj29n4gS4hwBBQ7zWOAaEqFhiA68WYU1WGFJKccBvznEgyved
	 iSlAIeSXP+NXPqdWvptT+g2IJea4Na9K1YuCg6iV9t+uB66Y0f9uKB6nzX9P7hMlg0
	 3MTn7KKruKqopDMWouNZ/THfE3M7+I4pz5nsmruKZ7AXWPw3SKrKjvZpgzGrBcHh/f
	 +va7vEsvFcmZchzgLnN1mmDL+ri1DbmVrDZrZhYVphrQ2BUQ6jrmwVnP1hk2X1fBhR
	 tCzbsGrXJC6U9mxc1jV8bLcTlRTUNpDElA9H4g1ZaGfqmsNUSEZ7xqG9X+clfJmCV4
	 NuZXOd3Yk8I6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	tmn505@gmail.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 223/642] arm64: tegra: p2597: Fix gpio for vdd-1v8-dis regulator
Date: Mon,  5 May 2025 18:07:19 -0400
Message-Id: <20250505221419.2672473-223-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

[ Upstream commit f34621f31e3be81456c903287f7e4c0609829e29 ]

According to the board schematics the enable pin of this regulator is
connected to gpio line #9 of the first instance of the TCA9539
GPIO expander, so adjust it.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Link: https://lore.kernel.org/r/20250224-diogo-gpio_exp-v1-1-80fb84ac48c6@tecnico.ulisboa.pt
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 63b94a04308e8..38d49d612c0c1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1686,7 +1686,7 @@ vdd_1v8_dis: regulator-vdd-1v8-dis {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
-		gpio = <&exp1 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&exp1 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		vin-supply = <&vdd_1v8>;
 	};
-- 
2.39.5


