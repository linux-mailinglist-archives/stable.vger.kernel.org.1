Return-Path: <stable+bounces-221898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA2sIgWbo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:48:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 417181CBDC1
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FA06304A566
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFC32D7DD4;
	Sun,  1 Mar 2026 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoK+6agm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210D145A1F;
	Sun,  1 Mar 2026 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329403; cv=none; b=IUJ7rpTgQo6kdSV4SqNRu1milVRzu3MLJ8CEZgVeZ6je8coEmPSCd+KWTeKAoOsqXfSPRlAwXIhtCaRWcm9gZGchPEdeJ+lK4/SkGyRaelaK9fewo4vta44zSbbiTiTL9DJLrY2gwHyMNw3Ot29GRwVh2BteprAySinU9ehrfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329403; c=relaxed/simple;
	bh=/F/ToFn6UCh1yw1eEivyu0FetzvXUx4TUhqrueZDDgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuw1DMkl6uKPaDc6kP8x4CjJ2PFImRV62zwkZyGtoS+nA2C+/WG57sBtPFky9O5mQchxnzT4EVdxfc+ej4GHdOWCdv4zPMuCKHqYDM1lDgWDG81/lA6xWkB0L1i5/UbrbDzXW0fc3Z1FnH699xNqdTTZME/b1zDLHOs87Lvtm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoK+6agm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A325BC19424;
	Sun,  1 Mar 2026 01:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329403;
	bh=/F/ToFn6UCh1yw1eEivyu0FetzvXUx4TUhqrueZDDgg=;
	h=From:To:Cc:Subject:Date:From;
	b=KoK+6agmh4MNQXfEWxa5UvtWG6XyUoDmfI6yq7g5SUsqswdoufFtTfE1YKpKXO5H2
	 TGbtuOGm+0oQTWokcIQVthmm9ii4O61pVG+njCRzs18lYOZI5MHslcl5saezeU/qTL
	 Qo8znMYUz0EcLR8wP3hP0DtFeZuUUzg/BGHhOXFpyCLsZvUTvcThDhwNxRmrxNhR1p
	 jfI0cQ9D1TQG1jlJDgSLZc9l3L4py18ZXu0KvZvwcUrY6DJfc8DU16fIOnzdYFAA0u
	 iDDJEclabUCapA6VnlJ1Gg9IiikIZcU9KaZDx1dNk4gE+VRebXEXMwlZg2vZ5PZ79X
	 zLHWK/eDJdOEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: FAILED: Patch "clk: tegra: tegra124-emc: fix device leak on set_rate()" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:43:21 -0500
Message-ID: <20260301014321.1705438-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221898-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 417181CBDC1
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





