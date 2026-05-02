Return-Path: <stable+bounces-242571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEjmL3Nd9Wm+KgIAu9opvQ
	(envelope-from <stable+bounces-242571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:12:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A64B0A86
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F79301980C
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8522701B6;
	Sat,  2 May 2026 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDal4dfX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3926ED25
	for <stable@vger.kernel.org>; Sat,  2 May 2026 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777687917; cv=none; b=sJNTRImSNQdQTsjkgzPNcHNItilWGdg5VEIPZyc0tAk/BkHddRbg4APiJioF3jZukX0qV/P5k8C2zEBkvl/8zKYiqhS/GZEdV3BsKI3j46iPQIMlpRoo9RHdu5Ht/LNP+sSC1lJOBjI2J7J7/e6z9Ukl+Jlc0in/4dqJ9i8J9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777687917; c=relaxed/simple;
	bh=ZwXLNp0caj8GJl+nFxLluHb3JwEeOu9hbGbxa818x+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSIqPuRseToSv+Qhs2tGEBoyzdTSdXT9oUXoeaiCIW8W8q1mIwRUj7JTJUopWKC1RbIliD3MM3ZGgrk7gCa2EqOFEKKKCgYIF53xmA9xiQYtgZGI5zR1HHQZYJrzTfUd+1eMzYIPx0DGVL5s44S0ZnyNcoP+av3RtvuUl1nGK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDal4dfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C36C2BCC4;
	Sat,  2 May 2026 02:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777687917;
	bh=ZwXLNp0caj8GJl+nFxLluHb3JwEeOu9hbGbxa818x+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDal4dfX4UxHqjKv+4KJ7dvnr9UJCMjNlBvPXAWOvjYE9h+aMDYRYkHXjtd051+UG
	 xPCMk7jS1JeZDHoK5ascV0fF6hF7sm1Fd7pjpLgbnWGEweAS4Y5dyiQsM+o3DHjv87
	 avW4z2T2f9o8L9zDZ4lM1s5+F5v0l4U+mbCDAuhdnCEgYO0IzhbR8WXCsHGPdvO+Dg
	 fYN3JV10CZaapD7TIYIcyOiq4GDx8EFp/veELRYqItP2V0m2pNNvAT3bcvRl1Zf/37
	 Jeop6XpjKIp6RBLq+XiyXlOxPIcLtUbEP9rItWasTEdmsf2xIk+XN8ItWwi0aOaQbk
	 dB3nkp/Bqg9gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Kim <james010kim@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mtd: docg3: fix use-after-free in docg3_release()
Date: Fri,  1 May 2026 22:11:54 -0400
Message-ID: <20260502021154.4166366-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502021154.4166366-1-sashal@kernel.org>
References: <2026050109-regular-masculine-854d@gregkh>
 <20260502021154.4166366-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 544A64B0A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242571-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: James Kim <james010kim@gmail.com>

[ Upstream commit ca19808bc6fac7e29420d8508df569b346b3e339 ]

In docg3_release(), the docg3 pointer is obtained from
cascade->floors[0]->priv before the loop that calls
doc_release_device() on each floor. doc_release_device() frees the
docg3 struct via kfree(docg3) at line 1881. After the loop,
docg3->cascade->bch dereferences the already-freed pointer.

Fix this by accessing cascade->bch directly, which is equivalent
since docg3->cascade points back to the same cascade struct, and
is already available as a local variable. This also removes the
now-unused docg3 local variable.

Fixes: c8ae3f744ddc ("lib/bch: Rework a little bit the exported function names")
Cc: stable@vger.kernel.org
Signed-off-by: James Kim <james010kim@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/docg3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 25a7df6448028..7de576404b14f 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -2041,7 +2041,6 @@ static int __init docg3_probe(struct platform_device *pdev)
 static void docg3_release(struct platform_device *pdev)
 {
 	struct docg3_cascade *cascade = platform_get_drvdata(pdev);
-	struct docg3 *docg3 = cascade->floors[0]->priv;
 	int floor;
 
 	doc_unregister_sysfs(pdev, cascade);
@@ -2049,7 +2048,7 @@ static void docg3_release(struct platform_device *pdev)
 		if (cascade->floors[floor])
 			doc_release_device(cascade->floors[floor]);
 
-	bch_free(docg3->cascade->bch);
+	bch_free(cascade->bch);
 }
 
 #ifdef CONFIG_OF
-- 
2.53.0


