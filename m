Return-Path: <stable+bounces-43247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC68BF08D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7E1282126
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265785650;
	Tue,  7 May 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVZqsKqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD27F7D9;
	Tue,  7 May 2024 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122801; cv=none; b=AgBP+5G/DzW+tVCHjoZOKbt7t+Ag1UNI5qgW/BdnBGmseRnFDomOxPsjPygcSmNHj2Abcsdi3LYQEAxhh09K0XsagB6RxW8zzuLi/V1mfF97REEMSvGo7F+EoCho8E3/SGJV/z/fAKvWrBE/D7MYJ3sbrtS4hXF0aT1GDB9kVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122801; c=relaxed/simple;
	bh=HlhvlycC8BrhmgA7a7fniCtJoAtPnqD+b3bHZuUb0vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSK9uyypc1eyO9oCa6X2VENZsfGT3APh5czZz+o2kWsz2xczk/EcQQdezG86V9PtX5esISA+hpFtsGBO7ImM/wBGFO6L5DSgUPihUZ0KLEnZmEsEk6XLkfb1rYfkTXSuaIBMzhmfx+cl0hsJZr0N9yUgM3qofnXNQ6zf0jA8ADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVZqsKqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2937C3277B;
	Tue,  7 May 2024 22:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122801;
	bh=HlhvlycC8BrhmgA7a7fniCtJoAtPnqD+b3bHZuUb0vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVZqsKqV00Zdg1TPspNlrZBTHrKumTUPllp1bReyURfD/8ykPKXNeXiDpsvtVaS4/
	 Xk4NDNhLQ3XtcHsz6dKnXjaK8BRztaEXQYmPQ81FHqw0qjZs8Fkyo4ROz5ximJZBSf
	 /eqxxHH/dxcFU7p2oQeEyKG1bRapDWK2YK3vo/ulYxOacIqeFi7hRyRwUYVPQvusV8
	 6XNfMgz0/xICMMIfASpoEfz77Masf5UNzhn5STPm623lC9MYrN033nfOxws+tYUyzp
	 gMtYNv/cppzE0LilNhLaNmNEhOACMhp9BGLmR5xfJAcQOlGwfi5wncc3jdf6qeK3Nv
	 cVnYFbyC1YYqA==
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
Subject: [PATCH AUTOSEL 6.6 14/19] Revert "net: txgbe: fix clk_name exceed MAX_DEV_ID limits"
Date: Tue,  7 May 2024 18:58:36 -0400
Message-ID: <20240507225910.390914-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index e457ac9ae6d88..4159c84035fdc 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -551,7 +551,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
+	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
 		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
-- 
2.43.0


