Return-Path: <stable+bounces-220833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PlvOhlZo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:07:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1301C8C8A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4203135B3F2F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3047415639;
	Sat, 28 Feb 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNlbQTBh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE81415630;
	Sat, 28 Feb 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300718; cv=none; b=AYFSp5uE1pjQkk+7Gez0bpL4G/IJMIcSwBKRk4VKELblknFWCXui3E4E+Y80oeJVbSOg9tzwtbYw2wimepJ3kBPL8Kc5EfncA3hRhKnY48JE4XKzKz+t405r6lcqL3sX9sTOIihnfdNoDEXyjs2ftMjrXwnct5kZ6IIdjxDHsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300718; c=relaxed/simple;
	bh=qpdXrmbJfQtvHDWmIsEsHq8t7y6haRxrCyfoQdXZkXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK8aR/0PZU92bjroblin2COLbXzO9bdUvJkb4LWauEurdR3UY48vodUhEnmirQjeaAplSAntbHCajZsDDHyTNzEAz32PvYP802wTmJOoG+SVYRGoD6XD7txnaH6e3uAlNxyTx+fG+l/ZpObRmrefQ1yadFVoOgYMqXeztdU9Cxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNlbQTBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D822CC19423;
	Sat, 28 Feb 2026 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300718;
	bh=qpdXrmbJfQtvHDWmIsEsHq8t7y6haRxrCyfoQdXZkXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNlbQTBh+pKCfJAhhHtth7TzRlnxfUGyIEVQYOh9kY2T311+Fj3BvyrU8PHmWGO6N
	 TQ8nixs4sV4Hx4Rsij2PVUzLhibra/b/AEwsyn+qR8EFw1gA/JEmVio72YHwRcg3op
	 d2EDJb0Z05aB2Jle9GvcWPMcKPAMUwFgUqmEzSaf5+8cCZwpk8kSZUeO4wfygmyphe
	 QQoXdVV6l8pvvRb77wZ+nFCZ28wLQFfcU+pJupvrVoTD94otMm5HLXVQAKRbtVlR5O
	 QTmwrooIcR0i7RPdOtFZy54R5sPpw8xfRI+9IyydYnz9enl9GFJD0aUQdAGgDuCLdi
	 sT5UkpPmW+lYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 754/844] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Sat, 28 Feb 2026 12:31:07 -0500
Message-ID: <20260228173244.1509663-755-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220833-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4D1301C8C8A
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


