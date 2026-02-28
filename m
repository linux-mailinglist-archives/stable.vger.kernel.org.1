Return-Path: <stable+bounces-221133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFhnIZ1co2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:22:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8011C8F4F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7F26317176E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3854B372240;
	Sat, 28 Feb 2026 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpeSIZLr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5F37223E;
	Sat, 28 Feb 2026 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301486; cv=none; b=Z5Rb22mepVbd5p4X+JKaN4rhSwQo+oY0Mzj6NMWl8mpo94R6MWWpIzLLpiJZEpcHE+EBUPQbWUX6/ilGGivWYwyjLIWYBqWOrysDwxcKqEL9Fg3aqUSNCB/ITDF34KbozStDqYYX9V8diX1SlEiYk59hcczQhLjlQ/pctNwiGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301486; c=relaxed/simple;
	bh=uot1YyKgSmj28oBehrCoJ+WZ/AUXBWbO15MCabdNfdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIPPw9YM3E9dvy0UUrjmlfs1WLZ15Rz2T6d1amMd+pKNbm0PXf2lJp2PKTfdE5FYFZdZ4+4ij4m/z8gywTRVOCy/QdIpZ/OTy1NVj1DbLjTJeRf4+xvFqmkevgg+CrpbobxH00UNzN0qCJLbz2JjWBFfsGUes8JXTqiamy6sZn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpeSIZLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333A3C19424;
	Sat, 28 Feb 2026 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301485;
	bh=uot1YyKgSmj28oBehrCoJ+WZ/AUXBWbO15MCabdNfdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpeSIZLrdI2y51ut4cc3sJpk5kMJiwhHOgKuLw7fGGrjbQn995UXNgDUkuXzDXAPU
	 SvHV8UMyItQSrSqP3OsBgbF3g8r8VbcjdKQx2N9e8tDBwh9ANn8e9SdlEXYaAcoBbu
	 0VSCJqOb83IzRFFM1Pap4ciHjiWJ96K1W5QQLdAW/Rayaut8qGmifm5OfJpSmmlt/w
	 /s55fDb3Dr+cfxAzNkq5f/UFNc+yJcr3boVx22mCzfbJagNkJ9GOv+D9AGwYy0SRln
	 r8DkGGP7Kf7H5XubJSS6W0oWwlZxtsjXu51jk21bhgux6mP5zouS5iExeMsGx/JZbc
	 8dUvCNFGL+bxQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Kevin Hao <haokexin@gmail.com>,
	stable@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 671/752] net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path
Date: Sat, 28 Feb 2026 12:46:22 -0500
Message-ID: <20260228174750.1542406-671-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221133-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D8011C8F4F
X-Rspamd-Action: no action

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 62db84b7efa63b78aed9fdbdae90f198771be94c ]

The current error handling in cpsw_probe() has two issues:
- cpsw_unregister_ports() may be called before cpsw_register_ports() has
  been executed.

- cpsw_unregister_ports() is already invoked within cpsw_register_ports()
  in case of a register_netdev() failure, but the error path would call
  it again.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_new.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 371a099ac4e63..4d763e571cfa9 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2001,7 +2001,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	/* setup netdevs */
 	ret = cpsw_create_ports(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
 	 * MISC IRQs which are always kept disabled with this driver so
@@ -2015,14 +2015,14 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	ret = devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interrupt,
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	if (!cpsw->cpts)
@@ -2032,7 +2032,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching misc irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	/* Enable misc CPTS evnt_pend IRQ */
@@ -2041,7 +2041,7 @@ static int cpsw_probe(struct platform_device *pdev)
 skip_cpts:
 	ret = cpsw_register_notifiers(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	ret = cpsw_register_devlink(cpsw);
 	if (ret)
@@ -2063,8 +2063,6 @@ static int cpsw_probe(struct platform_device *pdev)
 
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
-clean_unregister_netdev:
-	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);
-- 
2.51.0


