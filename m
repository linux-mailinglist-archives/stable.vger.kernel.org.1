Return-Path: <stable+bounces-222290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOVfAliuo2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:11:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 895891CE4B1
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0907C34F3F94
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13992F6911;
	Sun,  1 Mar 2026 02:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQ9hGwIO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B2259C80;
	Sun,  1 Mar 2026 02:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330507; cv=none; b=hypGQ1a1uKeqc69ksV5ZtGycAFXEt+YD2MHXvHWKCpz+6bKLZUsLRz0XF06xC2Hisb7BRhFhH0e1y5kjp2YFGHIMNPViZu/sLdqLeab93R8awh7/uog/6TYg8OR5jnnlBid5Rd3H7nbL4k4jVPlj83g3S+dVYP7Md+CLGuKjm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330507; c=relaxed/simple;
	bh=MIyWhPSW/rf0+IdLSpVGnEEI82crPdbVtRJCTh+JDJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9FCPkOQ8sG0mflQuTYq8AaDut9O3oesVM8udhJSxRy9xe3s76/e7ji2v2UUp5v2YPKr9frpTBwBmfOkb/AVbkFM6g1R0txTb7r0kyy0dNxTgr5po+hxaxJswq1+v5q899jQnQCgxu/kWBFeGL8vmvbEi0BDRawgtp0ejkrsXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQ9hGwIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF79C19421;
	Sun,  1 Mar 2026 02:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330507;
	bh=MIyWhPSW/rf0+IdLSpVGnEEI82crPdbVtRJCTh+JDJs=;
	h=From:To:Cc:Subject:Date:From;
	b=tQ9hGwIODz+4SIPtWYLYZaahPaC/6hn9b89yHO+Vcb53L4V5BVC30KXgC7dck3rBU
	 V1Q/w/ZGNR7uqcGEDlF5qDYxeAzKwJemxtbiKT7BaH05AOb1m/lLTci3EI6i6vgiLR
	 E+KokeTfIrk0ZVx6nBNSAnMdHhfxQJIq1jLeMHDPQijhmTH2lyBV7BuyUUs1AvL1Zv
	 0Lp0aUuWkj6aZUP89b8oZqvUc83Vw1ogKT5ZYQ7a5Q42L62Yp4lTc2ZnPAhCxCHahB
	 YY2umXnkobrFkZUqu1arcekFEg+Zr2Lu4I2vzg2bGXKsLm6ocU4TWt6Z8lA8Bb28Er
	 yCKkdOxVCz8Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: FAILED: Patch "clk: tegra: tegra124-emc: fix device leak on set_rate()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:01:45 -0500
Message-ID: <20260301020145.1729141-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222290-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 895891CE4B1
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From da61439c63d34ae6503d080a847f144d587e3a48 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 21 Nov 2025 17:40:03 +0100
Subject: [PATCH] clk: tegra: tegra124-emc: fix device leak on set_rate()

Make sure to drop the reference taken when looking up the EMC device and
its driver data on first set_rate().

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
Fixes: 6d6ef58c2470 ("clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver")
Cc: stable@vger.kernel.org	# 4.2: 6d6ef58c2470
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/tegra/clk-tegra124-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 2a6db04342815..2777e70da8b99 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -197,8 +197,8 @@ static struct tegra_emc *emc_ensure_emc_driver(struct tegra_clk_emc *tegra)
 	tegra->emc_node = NULL;
 
 	tegra->emc = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
 	if (!tegra->emc) {
-		put_device(&pdev->dev);
 		pr_err("%s: cannot find EMC driver\n", __func__);
 		return NULL;
 	}
-- 
2.51.0





