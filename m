Return-Path: <stable+bounces-195439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61907C76E24
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3E1692ABC1
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889FE4204E;
	Fri, 21 Nov 2025 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6uML97L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3BE555
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689546; cv=none; b=JnnoRVUI4pevH/AcWBMnd6iiT3JO0I/4wv8Vmyq3uPuopYkpUzwH1WGRH4rlx9+lVKKJ1s/3u8kImdnWZ/cmwYbnKosjS0u6u/AnGjX7etDkXVGmRhoFUd1iqM6z3+chEyohsxn93RKWG+P+MI8MIFxkXWuzYfK5q/1hqmsWQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689546; c=relaxed/simple;
	bh=BlbMG2wiIO6D/ySe1pjjd75LScZ7VG9OxV3RQylKv2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVPciMA0Gp0l49nXHCXdSeImbGPTjYOaER3NtK7EPQxVoHBZxiXh3NviOMiX00bCnUzPas2C4gDE4HTW/eAGlh4jI6uJmtxABGoe9Zxd+2zXvSFe6xkuA4ZJnhqGTCAHxzSeB/onMGu0oq3ckKEEO7dXpDNpQnet96qxqz5OwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6uML97L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29270C4CEF1;
	Fri, 21 Nov 2025 01:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763689545;
	bh=BlbMG2wiIO6D/ySe1pjjd75LScZ7VG9OxV3RQylKv2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6uML97L5vumUNdErG9B0XHWrMttXSfLSw5x69IiCZ3SedQsKC20kpPPsBcEbNczS
	 fCutv+CH3tsa0vxMoak+EOGX0qDY10eIs2qSwvzhNiPf8D1Wp7frq1uZQeLyrw8Yus
	 Q3tjlOk4E65Q0FGN1oZjybHkul3caMvtDBqdjRv6nWnttEg/cKpEsRzl1TVF/wYU5R
	 tkuctb5lYcJ8MBrWi1RLA9Gf1pNKIw8At2rlOxwGsekb0Q5KFYzv/F3ePYz7BDhuWP
	 yQ71lX6klaDKrSz4i23liwBKaXNxWhSJMb5rK8llJ+IJbRWsT4qsrKIH6ihChb2/ly
	 +LmqsPuLqApzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT to 0x4
Date: Thu, 20 Nov 2025 20:45:42 -0500
Message-ID: <20251121014542.2332865-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112055-suspense-expiring-db69@gregkh>
References: <2025112055-suspense-expiring-db69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit a28352cf2d2f8380e7aca8cb61682396dca7a991 ]

strbin signal delay under 0x8 configuration is not stable after massive
test. The recommandation of it should be 0x4.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Alexey Charkov <alchark@gmail.com>
Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>
Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 335c88fd849c4..eb7213a8b5ea8 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -49,7 +49,7 @@
 #define DWCMSHC_EMMC_DLL_INC		8
 #define DWCMSHC_EMMC_DLL_DLYENA		BIT(27)
 #define DLL_TXCLK_TAPNUM_DEFAULT	0x8
-#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
+#define DLL_STRBIN_TAPNUM_DEFAULT	0x4
 #define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
 #define DLL_RXCLK_NO_INVERTER		1
 #define DLL_RXCLK_INVERTER		0
-- 
2.51.0


