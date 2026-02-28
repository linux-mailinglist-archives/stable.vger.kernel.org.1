Return-Path: <stable+bounces-220691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIKwIog/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DBE1C6CFC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E90C3098B21
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276243F8AED;
	Sat, 28 Feb 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAg++FY4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9C3F8AE6;
	Sat, 28 Feb 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300571; cv=none; b=EXMXLiKvatVb1krmswBsFb6/9ZslrsJ+uOKIX+fuOhlBFYhXAc5qf6RkkvxEPTkz1+iDEIWaRjWFfRxgPuRrndV/bzZVWvlsUd+N9t5/tLcfbadwNoK8vvM4Fbiw5Sh5UvqfoeYQRzkLjtOSXJ0fZPVliY/QYKCk1/R6LIgqEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300571; c=relaxed/simple;
	bh=9urgeHaNSPRzjUKogr5ACw2JNEW7dKjz9dZ2baWpE3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrivbqDb8KQmAgWUV0cEb66J6AyuTMVteKFjSNJEWLBp4NMhui2bSrmQ0Bh8mQqSZZ1ag9MdWEDtMe0hNUDaKLs+JAHbhuJYbtc29wJUDrctiLgBsB2IeogH1fHXFIo6W6Zr22UpkrlSN2u7FtUcPTuIicRDvtilpHkjxgIRd3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAg++FY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088AEC116D0;
	Sat, 28 Feb 2026 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300571;
	bh=9urgeHaNSPRzjUKogr5ACw2JNEW7dKjz9dZ2baWpE3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAg++FY42SHNcU+hZdgkwdj2bFHvrPmZILK6I0djb9YiHUQoyQKy9Ankr3BhXY4L5
	 X81NjUiMD0mJ8ZbPlv1hDeokrytmqRU/MDoE6RYhXPVJEpjzehD2wUee3kpBsbF+mf
	 puCOa6UfKIvgwib3o1MMgHIc/0es/f7zuvkihRhQPBoa41iGTQ9Wf+Xq/Pk6hjGSzm
	 bvgPw72I94Lrg0+VO7UrOfqBcs2mcZqVdfKFhFoM9QkMLXmEVHV/S04golakNI6hoX
	 bu3MNcJSaFjDXXaIX35fJDbGqc7kUOCmTtPYXUeRUGmgRI16nBjETo/vHkxZzXorLn
	 OSo2vC5T2RbQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 612/844] soc: rockchip: grf: Support multiple grf to be handled
Date: Sat, 28 Feb 2026 12:28:45 -0500
Message-ID: <20260228173244.1509663-613-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
	FREEMAIL_CC(0.00)[rock-chips.com,collabora.com,gmail.com,sntech.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220691-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sntech.de:email]
X-Rspamd-Queue-Id: 67DBE1C6CFC
X-Rspamd-Action: no action

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 75fb63ae031211e9264ac888fabc2ca9cd3fcccf ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


