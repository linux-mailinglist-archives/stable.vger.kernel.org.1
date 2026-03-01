Return-Path: <stable+bounces-221363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDPmLOWUo2n3HQUAu9opvQ
	(envelope-from <stable+bounces-221363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:22:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5004D1CA538
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD3E73021427
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AC278161;
	Sun,  1 Mar 2026 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1CimT4M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF02BD0B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328075; cv=none; b=NnPfp+jWFWPZAiFh7BzL7k9DZnZ1fG96UrGuFh5dUFMyqDbacLjndeknUQ4EnS92BaI7m1B0qanXDI9wgSRD0UHYfK7T00WqEN+S4ntEP25uan+7ximngzU5JS8Cv/eQG6MygqKJw0BKtOV7cueTTROCPDbBDXOcKW89hptVCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328075; c=relaxed/simple;
	bh=gQxXscpsLwQIJ42R6QUu9NjQi7vsh0oFj54D737sPYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJ+vHWTHXEpKb66gW7yLwbrG82Xvimqg58EmPHM4vDkRJ/+3WAu2BL3CBek/Dk9WJ9jjUIyo/BUFSDlA7b/lJDo1QloIQk7m0H1tIb8t64hDrsY1+tsrnJKXffR90q7jj7puJJYod5aZUW4rwETPSyaTameHyW1BkD+n3TLhefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1CimT4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A0FC19421;
	Sun,  1 Mar 2026 01:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328075;
	bh=gQxXscpsLwQIJ42R6QUu9NjQi7vsh0oFj54D737sPYM=;
	h=From:To:Cc:Subject:Date:From;
	b=a1CimT4MLWX63c9m8hAKDX8tNV8hAmHd070SLh3P4vWZS1AhMl8nejYBhOKtWLW/8
	 3PjpSUVxnH8kOZ8LGyN4A/Jdl8BjyRmb3hbgcK0Dej3eDSP8Yrv2dmEkqKDqLTCq6Q
	 tM84TnVZfg17exzO7XFOaCuD672SJ90xhwaZDWVttGEM+NLGVfiA3ubxi9JcqbLb6Q
	 C2u6mzQE5R+ASljoDCIqM1ECHFB144ca8XcTmxgA8g2WDrGiX/8mB5b1Rv4x5mrf22
	 njc5JCIwzWgPpxWIPnh5FIWYZlA+WWNPD8mqPfTnadD+zjlF44gtqQ8YvfAQhRtCVb
	 cKxlNx7Og0R1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shawn.lin@rock-chips.com
Cc: Detlev Casanova <detlev.casanova@collabora.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: FAILED: Patch "soc: rockchip: grf: Support multiple grf to be handled" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:21:13 -0500
Message-ID: <20260301012113.1677090-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,sntech.de,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221363-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rock-chips.com:email,msgid.link:url,sntech.de:email]
X-Rspamd-Queue-Id: 5004D1CA538
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 75fb63ae031211e9264ac888fabc2ca9cd3fcccf Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Fri, 16 Jan 2026 08:55:29 +0800
Subject: [PATCH] soc: rockchip: grf: Support multiple grf to be handled

Currently, only the first matched node will be handled. This leads
to jtag switching broken for RK3576, as rk3576-sys-grf is found before
rk3576-ioc-grf. Change the code to scan all the possible node to fix
the problem.

Fixes: e1aaecacfa13 ("soc: rockchip: grf: Add rk3576 default GRF values")
Cc: stable@vger.kernel.org
Cc: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>
Link: https://patch.msgid.link/1768524932-163929-3-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/soc/rockchip/grf.c | 55 +++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 8974d1c6b35dc..04937c40da471 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -217,34 +217,33 @@ static int __init rockchip_grf_init(void)
 	struct regmap *grf;
 	int ret, i;
 
-	np = of_find_matching_node_and_match(NULL, rockchip_grf_dt_match,
-					     &match);
-	if (!np)
-		return -ENODEV;
-	if (!match || !match->data) {
-		pr_err("%s: missing grf data\n", __func__);
-		of_node_put(np);
-		return -EINVAL;
-	}
-
-	grf_info = match->data;
-
-	grf = syscon_node_to_regmap(np);
-	of_node_put(np);
-	if (IS_ERR(grf)) {
-		pr_err("%s: could not get grf syscon\n", __func__);
-		return PTR_ERR(grf);
-	}
-
-	for (i = 0; i < grf_info->num_values; i++) {
-		const struct rockchip_grf_value *val = &grf_info->values[i];
-
-		pr_debug("%s: adjusting %s in %#6x to %#10x\n", __func__,
-			val->desc, val->reg, val->val);
-		ret = regmap_write(grf, val->reg, val->val);
-		if (ret < 0)
-			pr_err("%s: write to %#6x failed with %d\n",
-			       __func__, val->reg, ret);
+	for_each_matching_node_and_match(np, rockchip_grf_dt_match, &match) {
+		if (!of_device_is_available(np))
+			continue;
+		if (!match || !match->data) {
+			pr_err("%s: missing grf data\n", __func__);
+			of_node_put(np);
+			return -EINVAL;
+		}
+
+		grf_info = match->data;
+
+		grf = syscon_node_to_regmap(np);
+		if (IS_ERR(grf)) {
+			pr_err("%s: could not get grf syscon\n", __func__);
+			return PTR_ERR(grf);
+		}
+
+		for (i = 0; i < grf_info->num_values; i++) {
+			const struct rockchip_grf_value *val = &grf_info->values[i];
+
+			pr_debug("%s: adjusting %s in %#6x to %#10x\n", __func__,
+				val->desc, val->reg, val->val);
+			ret = regmap_write(grf, val->reg, val->val);
+			if (ret < 0)
+				pr_err("%s: write to %#6x failed with %d\n",
+					__func__, val->reg, ret);
+		}
 	}
 
 	return 0;
-- 
2.51.0





