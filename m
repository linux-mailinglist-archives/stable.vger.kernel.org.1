Return-Path: <stable+bounces-221134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J3vHs9No2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3103A1C8356
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AF9C3239838
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6DC372239;
	Sat, 28 Feb 2026 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1QOMWMf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D5372231;
	Sat, 28 Feb 2026 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301487; cv=none; b=eSOGZvFiz8nrXWeoYKH07QgczDxwjzsTC+EZz/f7HP5FR+vg0eiIvKotlsOiIeqA1OCgMZup5JUV4QLN9ZRB8T6d1s56977URHRMrwQuvGfcCgB2+erBaSXuBhV+P0XVoP5vmsf4KqmSC4hm0NuP0uiI0czEifCDOf5MrCPW5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301487; c=relaxed/simple;
	bh=brWEGKFHYTDj7z0hOhO6F1iJ08IknFAmGoEN4PhnrK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJTN6+4fCfP4TG5451C8iADrh9x/DjY4mvMQJCXwyyK1hgUDXpTpBHIgEngTruXvkrr5QirfAHppRkS4DeXqQGd/+HrVBL1NebdSJ23G9CddsR15pMmr2DeHkzTGzyzo5csy4PcyDAKxzMBg2v5K3Hvnc4t3nYMWUksL8Q+kN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1QOMWMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F05AC19425;
	Sat, 28 Feb 2026 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301486;
	bh=brWEGKFHYTDj7z0hOhO6F1iJ08IknFAmGoEN4PhnrK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1QOMWMfRmWcQBxPzXG+h4Lci9dIZCRgin3nvql1TEaQsAVKuBSy8djq8CxFmd6Wu
	 iRNJT+KVuYw6YqreOt+igiqC/XcYQUEydDOcQDZ3HOC54/R7unPplGRy8z6OotREFp
	 BqWVGY5zG+e602zoV7z19x/Oy0yBmqAocl1EMqxyB/v+l9eIXmcgIiSJg0fQf8sZ8M
	 bK7c4WlQdCjl9X+0Kl0vhReYtoFFIql9JmTwMwoetR5q1VgWx05D3n9m0/GdUsJIoO
	 De7IysEHtTa3ro7EXclfFJTg7wI8pgbto+0Nh9XrJFlbeYkx4dbhfnkw/byOAYRw2e
	 RPKvBPFeYHgmA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Kevin Hao <haokexin@gmail.com>,
	stable@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 672/752] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Sat, 28 Feb 2026 12:46:23 -0500
Message-ID: <20260228174750.1542406-672-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221134-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3103A1C8356
X-Rspamd-Action: no action

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 9d724b34fbe13b71865ad0906a4be97571f19cf5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_new.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 4d763e571cfa9..fd3931d667021 100644
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


