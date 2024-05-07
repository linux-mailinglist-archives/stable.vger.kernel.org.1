Return-Path: <stable+bounces-43226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C994A8BF052
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5171F25AEB
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9481AB6;
	Tue,  7 May 2024 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT6bHF81"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497181AB2;
	Tue,  7 May 2024 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122701; cv=none; b=NL9Xiehx9EwJ4E1rKGYF/4ScO3sb9hSJiic34NqQkIYpUhlhpkU6aC6fY+vtqMh2LM/b8MTowRGVzNf7+U6WW3LF8WPpt9KZ74EctHgLN5Hx2DKx2rsmY03r1rymqiMnc0YMP0uPHeRQRQURRuLRHeD6wZNRDgDnlyIn/w98ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122701; c=relaxed/simple;
	bh=d/Q00s+rDTzVJSbw78LlcHVSTaOdJicgjn0WFYA08qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFa++4WOpi+G8nUIISitMDYifsTvGa+Z8DJNKwg2CX5fzzIH/RuzgVo2c2CQKwKkYONmaqJ9C65qgqWH2/7TfieYer4/1x+rHKy39D+dndeK2DTSsPvhECnZsQWrhsvsmGwGKwNXSpKP360BSke1x7R6USYr78ubR2tXqVQGIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT6bHF81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D23C2BBFC;
	Tue,  7 May 2024 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122701;
	bh=d/Q00s+rDTzVJSbw78LlcHVSTaOdJicgjn0WFYA08qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eT6bHF81Kcmm/2vx7a+Ru0aP1glUGzrn3Q1EYRSioFwVZSdkb5e51mYTT2QIF3h7F
	 nNr5rdXxqIYtqLgXG6Mxr6WsPaXXTCrPCXvnBP8xoC4sjSAEAT6Q7yx/vRelr5SaRn
	 Q7Tde5I1qvO6ucZF1hMixRhZ6Qcdt4nOfZLTn2+k5PtRWus+9+s3Q3Nl4CjqMx9WcO
	 9g5qX9Jled6Cn9RzoKwUhNEFlMpxUEHG6sm5Zfp6m5uOxdnCL56kMjaboFtQOy4X3S
	 QHSFH8qL60sQcOmkMD+74W5ZvznWY9z5gk95urMtxxYKgPn0H8TLudIOS3DMAj2iE3
	 o5otdKXUUASJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 16/23] Revert "net: txgbe: fix clk_name exceed MAX_DEV_ID limits"
Date: Tue,  7 May 2024 18:56:42 -0400
Message-ID: <20240507225725.390306-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
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

From: Duanqiang Wen <duanqiangwen@net-swift.com>

[ Upstream commit edd2d250fb3bb5d70419ae82c1f9dbb9684dffd3 ]

This reverts commit e30cef001da259e8df354b813015d0e5acc08740.
commit 99f4570cfba1 ("clkdev: Update clkdev id usage to allow
for longer names") can fix clk_name exceed MAX_DEV_ID limits,
so this commit is meaningless.

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20240422084109.3201-2-duanqiangwen@net-swift.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 29997e4b2d6ca..1b84d495d14e8 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -556,7 +556,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
+	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
 		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
-- 
2.43.0


