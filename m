Return-Path: <stable+bounces-3013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D30F7FC741
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0097B257B9
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3A46B91;
	Tue, 28 Nov 2023 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB2EN7Bi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34A3527B;
	Tue, 28 Nov 2023 21:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2A9C433AB;
	Tue, 28 Nov 2023 21:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205728;
	bh=zcdYStEUpmRxbAcMjYM+CYDwsomQ5pvUQxhpmLyKi/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jB2EN7BiKX3jWtIjfcH6DqztJl1+RMoeyE2wDBB3MAeqmVD86dOWWH2ZYUMlFqUoh
	 big41RJq7zhRUplGx4bSf9UkBOSPoi0x4ljTVyhSkMxLcpJnZ5bOJNa/VNwdmLKhqL
	 yGuMYM5gdpTzBFK01nO3xCPsWo+krzFj5gLnSGlZ+UUxJxBZEpuv1yKGMxLTYRAv4a
	 uCUkmZccd1fyZ8gZFFB+Q7fQoRPmlkLhQDo1afd3xS9x+z3nwuccAkGtXI2c4a+aTl
	 4/v6tFT4tIrehYAsfs/50+HzozLPiBj2b0hTHyh1q71GuMSLbP/q6CiUTMKldrWSrS
	 5AupO/rkChWvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 02/15] stmmac: dwmac-loongson: Add architecture dependency
Date: Tue, 28 Nov 2023 16:08:23 -0500
Message-ID: <20231128210843.876493-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210843.876493-1-sashal@kernel.org>
References: <20231128210843.876493-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.140
Content-Transfer-Encoding: 8bit

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit 7fbd5fc2b35a8f559a6b380dfa9bcd964a758186 ]

Only present the DWMAC_LOONGSON option on architectures where it can
actually be used.

This follows the same logic as the DWMAC_INTEL option.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 929cfc22cd0cf..d19844be9fe50 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -253,7 +253,7 @@ config DWMAC_INTEL
 config DWMAC_LOONGSON
 	tristate "Loongson PCI DWMAC support"
 	default MACH_LOONGSON64
-	depends on STMMAC_ETH && PCI
+	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
 	depends on COMMON_CLK
 	help
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
-- 
2.42.0


