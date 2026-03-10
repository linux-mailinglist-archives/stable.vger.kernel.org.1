Return-Path: <stable+bounces-223916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBAWKtz9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1446A24A519
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35F0C30457F6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3157371067;
	Tue, 10 Mar 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNC1VVRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3D248F73;
	Tue, 10 Mar 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141052; cv=none; b=lGtLVMB8HoIzCigAIH87xrSPneFa3qzih2usiAYzgZLQ3fD0Hx68AqdoVovcxYPY7yfIwmOijDZBKuJ4q5BC8xzJQtV4VOA34CnA80vjD1McgbBqSe35RD4IPZOuaqHUIpHXJGaTHGKli8Z2LG3dnx1AgUl30N/nVfG+jnvDYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141052; c=relaxed/simple;
	bh=IyWDwr0YumqQypt5Xl2HqYQaca+Tw0R6OD7rBO0PYqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdPpAjX3/BUVHIr2UiGGxnRe0wvRaMvdrJ2ZDzKYkc7aX9NWD50BA74SJ613F3EKABrGwFxtmYPmQHFOMro6ORTEoPglFcJ2uFzXLeizJ0brYU2vl0dnRn9sLa1jbBMfdfBxzTbBaXWd1lSVGdI3lB1J4v0I3GQIL91Cn62SKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNC1VVRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A02C2BCAF;
	Tue, 10 Mar 2026 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141052;
	bh=IyWDwr0YumqQypt5Xl2HqYQaca+Tw0R6OD7rBO0PYqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNC1VVRZwXJOd1Vrguelz9HAd6kwd08Tx5ksxNUodqFrsQVMRWSUHjVF6wKhzmlHW
	 SPAlcD3HhasmZsKkkaTYZj7jQjwJkxN2b0ZnJHsOkCLD++569ealVxXUTS/BnfdyRe
	 mwGeLWhVB0xr0rBw80Sw6hS530TpKs2aK/fe9haG2REZ2jBrRx4FLV1wqnu8goe+7g
	 V7KHdCR6LUXvRfMVFYpJYQBrMcXbesDVlKx87xWsdA2r7BYb+kO+2V4MwJ8LClZARH
	 FdYuB0QOaW1xT7YZ7vG1bzXrHkSWResKRHAkRYmaF3Y9occ+XbmAAUdIcmi7wIm1Ti
	 YUfB1hZsSD6gw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Gu <ustc.gu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 051/311] regulator: bq257xx: Fix device node reference leak in bq257xx_reg_dt_parse_gpio()
Date: Tue, 10 Mar 2026 07:01:38 -0400
Message-ID: <2aa3e50c33afed715a765f1f58cc645a5ebd4dd9.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1446A24A519
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223916-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 4baaddaa44af01cd4ce239493060738fd0881835 ]

In bq257xx_reg_dt_parse_gpio(), if fails to get subchild, it returns
without calling of_node_put(child), causing the device node reference
leak.

Fixes: 981dd162b635 ("regulator: bq257xx: Add bq257xx boost regulator driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260224-bq257-v1-1-8ebbc731c1c3@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/bq257xx-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index fc1ccede44688..dab8f1ab44503 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -115,11 +115,10 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 		return;
 
 	subchild = of_get_child_by_name(child, pdata->desc.of_match);
+	of_node_put(child);
 	if (!subchild)
 		return;
 
-	of_node_put(child);
-
 	pdata->otg_en_gpio = devm_fwnode_gpiod_get_index(&pdev->dev,
 							 of_fwnode_handle(subchild),
 							 "enable", 0,
-- 
2.51.0


