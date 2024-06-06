Return-Path: <stable+bounces-48285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF4C8FE469
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 12:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19D71F27047
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69B194A74;
	Thu,  6 Jun 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="bUi1VfSv"
X-Original-To: stable@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D713C673;
	Thu,  6 Jun 2024 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670181; cv=none; b=tvVZlZgAsw4xmkp4nvEzaX62M85fDdjjNKfckNP1gGL70Fd82i4ebXN+ZDiXAf0jVGAgnRsbzhzOpqmlZ50WuAP2IxS2l4w0LtpMqecOqXjFZXn9ApWBk99USDmYCAoiTbQTZU/oYYLJ2MRXS3+dlcVBC9Jd0mqwRAlWBsS7O/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670181; c=relaxed/simple;
	bh=LbTHfTiaz8Wa3aiCs77X41Ckl0OGx2RPke2/xDmq5VU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VFh8lcPnIUjklMGvT6Bwqh/5qBw9NHIDWimgGeaXwOlvrS9PCw7/gQvoM7B/t73YccGr8wVl+53ENkdpMC4LnuDsRXjnQpYABwTlEQk3AYmcLSGpZ+43IvUrbQLlzP7n7b80jSqNJ8upS+IzHQv7eYvaKcb1zHTDbOtfrIwcvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=bUi1VfSv; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 09848100003;
	Thu,  6 Jun 2024 13:35:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717670152; bh=BRjCYvyyTZK9/lxCnrrQBIuLJua/61JU5n0x/gTg+ZA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bUi1VfSvb8h6aEDsPxp5NofVUCoT154GJavGxcDqJypy9mIDBA/wfMmhltqXK4X7k
	 fbrtHihqpi/djmHEPT+V1D8OuoNLDxFkw8MjmmP5m7anSr6j/ims71DHilB6DC5TgW
	 BAFH4xROBL8UkI/5Gn6eHzV7LpyWf9BGTXlZnmDriUpkmIU0lUrzsmfmKyRv+Z4prk
	 hNcbUP9Zld0lsK9ZLhj4uKtXbRvjvjWkqqI+gOCD55PcTXxuyZY518s1vQIRSc6Sdr
	 RXmBmdNnq7ExiLqEnTpjZzHMbJTWB+tuekBOzw8NtjUnicTuIK7jjFrynT65naVVqs
	 1tBiYLfJ5E3vA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu,  6 Jun 2024 13:34:30 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 13:34:09 +0300
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
Subject: [PATCH 5.10/5.15/6.1] clk: mediatek: mt8183: Add memory
Date: Thu, 6 Jun 2024 13:34:02 +0300
Message-ID: <20240606103402.23912-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
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
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/06 10:23:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/06 06:58:00 #25471362
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

Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
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


