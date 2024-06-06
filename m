Return-Path: <stable+bounces-48289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F348FE543
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56768B22364
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6681957E5;
	Thu,  6 Jun 2024 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="I9EZ7Y/l"
X-Original-To: stable@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775D160865;
	Thu,  6 Jun 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672927; cv=none; b=BX//T9PCLVP8kW3jqQxrfjc/WzHMwYTYLLDXqfAZEixe7OvHtsKSoQDHQb+TItq8ttC3KuWyfnOXlem/C/hk6HPta8naD9uXw9LAJAVL7ARFhmzyWYhwh3iWzfSRv/4uVqEhRuU2UdVKQTqg7FE5o1+HtLZDS2s9OYc9nZeYSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672927; c=relaxed/simple;
	bh=QHITYfArNAu5Rk8S7h7iCcXXlTjF5EYR3au8v/kNbmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD0aDi5xDsZdgqcE3cgSOn8Qh/C7EVCw705GebYZ/yUpwVIfjL93XGWV9gE2YFQDje1+QQ7jos/IRhK6cBPo0OcWNOIeFeDtV6zSRkpwOF5OfsFmgPvRM31kE9PpR4XNQiOsbVQIZHikq46cHKEqrp03KPoRHSDFDJKdhi4jbVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=I9EZ7Y/l; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 8FD82100003;
	Thu,  6 Jun 2024 14:21:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717672904; bh=Vp9npdqLFP/lcQh3A2I1pzb9L/b0Qc1VzUDSRtwXlK8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=I9EZ7Y/l/fjO6n/oAcRH/YOp5FUAKQyMzKWX+LTTJMsXGwxuQjYQ1qUGOWSZSTzes
	 l3iSthS/hc3gv8HsAJaN4tLLFfopdY/rRrzesP14Oj7hwuWp/OndPfqtTXq/Z5/ES7
	 2Ijx2Sz1wGJp5yE618CIyQgfrKSyw23egjnhzQ97nlQAXJqhLt8ecPIVJzH2Qol0xd
	 y67kxhwIS0h+TUm+R0BPb/CQVhKkXiQeMb8aoNodpOcwI1Te5JnrGap55OD73uBMiD
	 lE1J9ivBcvMqOThMDe4fR20stniW5V1Ka1i429sQyp0tEyPru7m49DOTjekWC2UHTV
	 MZDc/BRNO2NCg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu,  6 Jun 2024 14:20:24 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 14:20:03 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Weiyi Lu <weiyi.lu@mediatek.com>, <stable@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Sasha Levin <sashal@kernel.org>, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15/6.1 v2] clk: mediatek: mt8183: Add memory allocation fail handling in clk_mt8183_top_init_early()
Date: Thu, 6 Jun 2024 14:19:49 +0300
Message-ID: <20240606111949.35502-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240606103402.23912-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/06 10:23:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/06 10:36:00 #25485870
X-KSMG-AntiVirus-Status: Clean, skipped

No upstream commit exists for this commit.

The issue was introduced with commit c93d059a8045 ("clk: mediatek: mt8183:
Register 13MHz clock earlier for clocksource")

In case of memory allocation fail in clk_mt8183_top_init_early()
'top_clk_data' will be set to NULL and later dereferenced without check.
Fix this bug by adding NULL-return check.

Upstream branch code has been significantly refactored and can't be
backported directly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c93d059a8045 ("clk: mediatek: mt8183: Register 13MHz clock earlier for clocksource")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Add "Fixes:" tag, fix subject misspell

 drivers/clk/mediatek/clk-mt8183.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 78620244144e..8377a877d9e3 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1185,6 +1185,11 @@ static void clk_mt8183_top_init_early(struct device_node *node)
 	int i;
 
 	top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!top_clk_data) {
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, -ENOMEM);
+		return;
+	}
 
 	for (i = 0; i < CLK_TOP_NR_CLK; i++)
 		top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
-- 
2.30.2


