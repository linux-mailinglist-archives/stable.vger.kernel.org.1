Return-Path: <stable+bounces-222151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGhALp6eo2lzIgUAu9opvQ
	(envelope-from <stable+bounces-222151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:04:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7E51CCCD7
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C90930FEFE9
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CA63112A1;
	Sun,  1 Mar 2026 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFH2hpik"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF363090C6;
	Sun,  1 Mar 2026 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330027; cv=none; b=BynothtNMcsJ+Fkq2v31cnLAybwYzY+mfhN9uEA6DjHaj9GFzW3vNwm4fFIjDFcWVUujnRSOl4kSPuto3KQt5aKo7m9pkAt4KPO0w+NBhOXqAOeuNxEeMV7DzJTMnoYwNKuEzSzZqdZnGo2/PL7hmJbGrCqI276IP+Oj8JbBLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330027; c=relaxed/simple;
	bh=URnU3M5r1G+SEcTaZ9fURdC5FLEbRbEaJtbMoF2LBkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hd8c76coQRjgSLMJiKG1SYnJGwiNx1bvsHBmBBU8nBEeyKOBCFoYGsqn9eGQAZpONApQNl1dpMgJE+YiAYXoV2VtXS1KT6dWXQ6oeYCc5WocoOZQG7AhBNBckdBsm9HDM39ODt8Dr1gN4XUJ88kic3zIgV0CqcEI5IWN4SszT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFH2hpik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7401C19421;
	Sun,  1 Mar 2026 01:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330027;
	bh=URnU3M5r1G+SEcTaZ9fURdC5FLEbRbEaJtbMoF2LBkw=;
	h=From:To:Cc:Subject:Date:From;
	b=IFH2hpikDcBg0nW5IpAHL+KqICr0Ev0ZHKnH0LJol4cetw5UsynizitbRzQK6E4bb
	 1L1LEoDpw8ycOfd6drCifGkR8D5CSPveZk8jFVMV5Y2TyDL6JouWBrOSJs9MWy9zqo
	 QkEqGBv7oO5HBjsLz2aa851J1sjcKjGsYvRixx1y0UQikpUwxV202npzoygp75PrNL
	 nWDdWKVNRYPvVqFO9v9JwQkBpiQgpvcmk+LlblC6vwujdD/ZyO7tREwQD10y4ztdFx
	 UckJPLjP13yjkzPRMvK8zwgR2HjnqLxa3lvlo3faTJ1VyUUf1AtHrSdaQUr2XaEJr8
	 M//qg5wi7JRyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haokexin@gmail.com
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: cpsw_new: Fix potential unregister of netdev that has not been registered yet" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:45 -0500
Message-ID: <20260301015345.1720608-1-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-222151-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A7E51CCCD7
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9d724b34fbe13b71865ad0906a4be97571f19cf5 Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 5 Feb 2026 10:47:03 +0800
Subject: [PATCH] net: cpsw_new: Fix potential unregister of netdev that has
 not been registered yet

If an error occurs during register_netdev() for the first MAC in
cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
cpsw->slaves[1].ndev would remain unchanged. This could later cause
cpsw_unregister_ports() to attempt unregistering the second MAC.
To address this, add a check for ndev->reg_state before calling
unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
to NULL becomes unnecessary and can be removed accordingly.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_new.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index b9fc31eb06134..7f42f58a4b031 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1472,7 +1472,7 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
 		ndev = cpsw->slaves[i].ndev;
-		if (!ndev)
+		if (!ndev || ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		priv = netdev_priv(ndev);
@@ -1494,7 +1494,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}
-- 
2.51.0





