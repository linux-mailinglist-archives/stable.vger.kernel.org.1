Return-Path: <stable+bounces-48290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE78FE556
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34BEFB22F53
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1901957F8;
	Thu,  6 Jun 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="RvioBviE"
X-Original-To: stable@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BB160865;
	Thu,  6 Jun 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673318; cv=none; b=TORUG4qoNz+DpCq3ekr6I4lVri41QPyvoMa6Dl6pbhJUZLLYUN3CbJ/S6KI4ryHda1t2WnQ3h7k4CNWaTISGpKDiYGYA0qsKvjw+6TDUx26iE4Cs83FaEWfXAFsQG/JCfV6vBzG9JC+pJ0+aScNHGoISIXdOGGl8QkcXZ8ZBoxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673318; c=relaxed/simple;
	bh=gIl6IhooRxWV/OGWzJJqPd4ige0klHOlGYjha2TB8Xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJeaRkMDjcP3EhA5mNe82SMkVJv052iphQ+4GID7zoKdY7DCegTFg7536IQCHArCt6kA7fKtopviH6G6G0NtCHroeC4i6Kz0V3A8npqCu/qYmJa3ntBm1ormX7BcdlhVfCBDlpbsOErhdQoGagRUNrfyE34qMt1H7WCXw3M38jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=RvioBviE; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 0068E100006;
	Thu,  6 Jun 2024 14:28:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717673297; bh=Y62XYCO9ZGwrKOdoymHIyR+uuZurw3es96f2p0GzfTU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RvioBviEr2YiQMxGSertLCwx7lkbgeocMcF9gg+ah3oOiKCrLBwgeAx4r96WK8r1R
	 xXxvEqjbA8SHm1l2P0BTzopyh5rTtLkrutsGhNc+uRPTwIzgELJ/qWurL4PdJb5xhQ
	 6f+VduTzpFPL03pjGBKtPnK/ONPugkqQk0fjxaDTpNDP2XHX6UXYFV1DXQ5xUi5hG3
	 LnOvdfTVX35k3ZzKmiqtF7kYzY/CfYJGJljc139GBbyiq/EzIKXf1L2b2ldDcsP2Uu
	 W85DkeevmzxZQ2OJBg783pyh8ddo4y6hxkn5nYFeU/CvSduT3ZvF4IvSWHLgGHmj8Q
	 8AhA/oTyw5yDw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu,  6 Jun 2024 14:26:57 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 14:26:37 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Weiyi Lu <weiyi.lu@mediatek.com>, <stable@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Sasha Levin <sashal@kernel.org>, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15/6.1 v2] clk: mediatek: Add memory allocation fail handling in clk_mt2712_top_init_early()
Date: Thu, 6 Jun 2024 14:26:30 +0300
Message-ID: <20240606112630.35682-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240606110955.35313-1-amishin@t-argos.ru>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185766 [Jun 06 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/06 10:23:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/06 10:36:00 #25485870
X-KSMG-AntiVirus-Status: Clean, skipped

No upstream commit exists for this commit.

The issue was introduced with commit e2f744a82d72 ("clk: mediatek:
Add MT2712 clock support")

In case of memory allocation fail in clk_mt2712_top_init_early()
'top_clk_data' will be set to NULL and later dereferenced without check.
Fix this bug by adding NULL-return check.

Upstream branch code has been significantly refactored and can't be
backported directly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e2f744a82d72 ("clk: mediatek: Add MT2712 clock support")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Add "Fixes:" tag

 drivers/clk/mediatek/clk-mt2712.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index a0f0c9ed48d1..1830bae661dc 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1277,6 +1277,11 @@ static void clk_mt2712_top_init_early(struct device_node *node)
 
 	if (!top_clk_data) {
 		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+		if (!top_clk_data) {
+			pr_err("%s(): could not register clock provider: %d\n",
+				__func__, -ENOMEM);
+			return;
+		}
 
 		for (i = 0; i < CLK_TOP_NR_CLK; i++)
 			top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
-- 
2.30.2


