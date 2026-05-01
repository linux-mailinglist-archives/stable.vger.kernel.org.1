Return-Path: <stable+bounces-242562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMMGETo69Wl8JgIAu9opvQ
	(envelope-from <stable+bounces-242562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:41:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52C4B057F
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A32393019F1E
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 23:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002637F723;
	Fri,  1 May 2026 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzWq/kg+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CF6FC5
	for <stable@vger.kernel.org>; Fri,  1 May 2026 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678900; cv=none; b=Fm/yLsEOrtvs7R8DWyWaIt1wvivgfdNNpsbqCwRRd/dSP8BA2Uk9NbX5NxDcvIRn7tNeVfTLBmbx17rAmqxSLxWOdqUyoPp83xLRXRUFVgnk8zSl8n5yWgd/pYGDsiiCmb9FK/Ah22te0uE1mgB65XJFTyYJNyNFLvC3kJ+7n/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678900; c=relaxed/simple;
	bh=Upx0yj9eIsnFAGlxCO0m9YpWDbk6xJwZJCFnSTBe56Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4otmqxKnk0plCQxIJiyDWq0ptWSeG+5V6YM9XjlqXheZPVPR2ByQlw6e5X78jbULRbQEUIBct62ANk2/xztQW8w2RW16461FW0n6XsrmktsTK0vgf6I3UDBdKLk2ULnR7iSsxFcir/liMnehoy98IxcIBXJbmCkTedkYJAgfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzWq/kg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F6BC2BCB8;
	Fri,  1 May 2026 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678899;
	bh=Upx0yj9eIsnFAGlxCO0m9YpWDbk6xJwZJCFnSTBe56Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzWq/kg+otaRcOObuzF/74giZz4CXlqBzpcXK3CF5kCHqUVqIF3odKG1Yc3qvG5X/
	 Xwx9r0iT5wPd+VgPp0bKSfItQAQ+TetSM+88BrbLDxYCSvTQpJ/8NVAYQlm8lB7Nmy
	 Yi4d8PXjzi5rwHm03sLX4MlXLVf+CW6xlP+8QEcPl2MOv4Kfx/xLkm4/TAXAtBi5ym
	 5vZ135q6MT0pwxhD8b77KIHVgRscRM38836Y3j+COUzhpn4reyJdFlhBAYjiRn+oX2
	 76ZKMXcMzuEziFGD6+xz06fj7T/Bbyy2/BEXLmoewK/g78/EdRMX6Z9gFksPBwACgN
	 xdue/UuxIZb1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Kim <james010kim@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mtd: docg3: fix use-after-free in docg3_release()
Date: Fri,  1 May 2026 19:41:36 -0400
Message-ID: <20260501234136.4109063-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501234136.4109063-1-sashal@kernel.org>
References: <2026050108-relative-gimmick-e71d@gregkh>
 <20260501234136.4109063-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A52C4B057F
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
	TAGGED_FROM(0.00)[bounces-242562-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
index 8cb25cfd9c10a..2f82bc7c07931 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -2049,7 +2049,6 @@ static int __init docg3_probe(struct platform_device *pdev)
 static void docg3_release(struct platform_device *pdev)
 {
 	struct docg3_cascade *cascade = platform_get_drvdata(pdev);
-	struct docg3 *docg3 = cascade->floors[0]->priv;
 	int floor;
 
 	doc_unregister_sysfs(pdev, cascade);
@@ -2057,7 +2056,7 @@ static void docg3_release(struct platform_device *pdev)
 		if (cascade->floors[floor])
 			doc_release_device(cascade->floors[floor]);
 
-	bch_free(docg3->cascade->bch);
+	bch_free(cascade->bch);
 }
 
 #ifdef CONFIG_OF
-- 
2.53.0


