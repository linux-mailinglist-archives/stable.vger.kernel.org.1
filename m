Return-Path: <stable+bounces-8780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187308204D8
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFB61F21850
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051179EE;
	Sat, 30 Dec 2023 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQiOgXNA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61479DC;
	Sat, 30 Dec 2023 12:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558C7C433C8;
	Sat, 30 Dec 2023 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937743;
	bh=1K1ykQTX/QsrFhMaNX5vzX9GkHF9rWhMU7Rxp9gT4FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQiOgXNA+jy5n1lXmT2F+X7FIMJvxyT5EarN07oqbdm+RqGK0k4XlxDTf1xao+KW0
	 cpK5QmUALealbH3IYei1D7KpkjyIUu/eOrTSKN0mWoliafAwX8hHRuh2uXBJ9vGEWr
	 ivFkVjQ9YlMgF/3SVYR/NDwl2Ju3nYzEiBppMXzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 045/156] net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and above
Date: Sat, 30 Dec 2023 11:58:19 +0000
Message-ID: <20231230115813.827600320@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 70f010da00f90415296f93fb47a561977eae41cb ]

The typo from ocelot_port_rmon_stats_cb() was also carried over to
ocelot_port_pmac_rmon_stats_cb() as well, leading to incorrect TX RMON
stats for the pMAC too.

Fixes: ab3f97a9610a ("net: mscc: ocelot: export ethtool MAC Merge stats for Felix VSC9959")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20231214000902.545625-2-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot_stats.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
index f29fa37263dae..c018783757fb2 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -610,10 +610,10 @@ static void ocelot_port_pmac_rmon_stats_cb(struct ocelot *ocelot, int port,
 	rmon_stats->hist_tx[0] = s[OCELOT_STAT_TX_PMAC_64];
 	rmon_stats->hist_tx[1] = s[OCELOT_STAT_TX_PMAC_65_127];
 	rmon_stats->hist_tx[2] = s[OCELOT_STAT_TX_PMAC_128_255];
-	rmon_stats->hist_tx[3] = s[OCELOT_STAT_TX_PMAC_128_255];
-	rmon_stats->hist_tx[4] = s[OCELOT_STAT_TX_PMAC_256_511];
-	rmon_stats->hist_tx[5] = s[OCELOT_STAT_TX_PMAC_512_1023];
-	rmon_stats->hist_tx[6] = s[OCELOT_STAT_TX_PMAC_1024_1526];
+	rmon_stats->hist_tx[3] = s[OCELOT_STAT_TX_PMAC_256_511];
+	rmon_stats->hist_tx[4] = s[OCELOT_STAT_TX_PMAC_512_1023];
+	rmon_stats->hist_tx[5] = s[OCELOT_STAT_TX_PMAC_1024_1526];
+	rmon_stats->hist_tx[6] = s[OCELOT_STAT_TX_PMAC_1527_MAX];
 }
 
 void ocelot_port_get_rmon_stats(struct ocelot *ocelot, int port,
-- 
2.43.0




