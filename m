Return-Path: <stable+bounces-239462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ap3Aqxk5mkKvwEAu9opvQ
	(envelope-from <stable+bounces-239462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:38:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB4431AAA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF56139563C5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9380932E696;
	Mon, 20 Apr 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svDnFk6h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796E244661;
	Mon, 20 Apr 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700315; cv=none; b=A5metzZk5GLViR72f6WJYunSXe0RPf4DUjG2ajQJhHnniVkzO3s1jbhYwyqOtjX3JWj7YkrL6QOXaAOJGQdQklRbzbh/gfvRsKecSRkJLV3GzljY66z9dVzcnq/LJwXfuhXej10PRT9Cfvuhi60pDmoZUPsU/ygoE+OTHI/itNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700315; c=relaxed/simple;
	bh=uECNalsUlnGi5nPYBYwlUE1oGX+AIlrkC8mmezoYvug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8m0vDwB07oW5PLjNd9FmvXfN1rqkwBsq6rM2tDOx1MsqMhIX/wtsOyb9okIFQrFfsezmdROocAQv0b+yDHofMpD47bMZsa9zXqBwSo8p1X6mW9ESuX9j3HKBmJCJUO+tS072oVEnYZ3y66VUwOFr7lySgkgU74EdcjM2HzYSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svDnFk6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81F7C19425;
	Mon, 20 Apr 2026 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700315;
	bh=uECNalsUlnGi5nPYBYwlUE1oGX+AIlrkC8mmezoYvug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svDnFk6hgmY0aC+TXkGaW8GdAvVdCeHD4tsppW2sOakt/4OQzjqLAuzRDPXk+30Ys
	 cryB9OQQMLfkhTZLM8vZY9ZqFiXRgr9cF/raKKKM9o1ejHwuRlJVP009cbW8olvvks
	 gruaWr7u+rVwXqm0I5fzkSGIbQ+O2WS86o7xzTKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 124/220] net: mdio: realtek-rtl9300: use scoped device_for_each_child_node loop
Date: Mon, 20 Apr 2026 17:41:05 +0200
Message-ID: <20260420153938.493012471@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-239462-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lunn.ch,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 44BB4431AAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit c09ea768bdb975e828f8e17293c397c3d14ad85d ]

Switch to device_for_each_child_node_scoped() to auto-release fwnode
references on early exit.

Fixes: 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20260405-rtl9300-v1-1-08e4499cf944@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mdio/mdio-realtek-rtl9300.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
index 405a07075dd11..8d5fb014ca06c 100644
--- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -466,7 +466,6 @@ static int rtl9300_mdiobus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rtl9300_mdio_priv *priv;
-	struct fwnode_handle *child;
 	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -487,7 +486,7 @@ static int rtl9300_mdiobus_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		err = rtl9300_mdiobus_probe_one(dev, priv, child);
 		if (err)
 			return err;
-- 
2.53.0




