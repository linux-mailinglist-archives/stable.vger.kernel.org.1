Return-Path: <stable+bounces-251729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEqpCwD4DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:05:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1426595462
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A2FC30BCD26
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F123A3E9C;
	Wed, 20 May 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MVNd+8zM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D73D7D66;
	Wed, 20 May 2026 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298739; cv=none; b=JBGjkdV91LnoM6xtOl2lnL10f9lblBJaWP2V6WAE2h6LvkEE1zmdgpJOdJ0cTFxQ7ljWH+LzIHpLiRjbla+CrCSooTO0W/kuPDmVwZYdIFhfGkx8JPytmBtPPnaQZ+BcsG04HP5L5SEhwi89W0oXm7vqlAliTomukWSuN0bZ9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298739; c=relaxed/simple;
	bh=CLmM1OGPZ4W2SH6JuJAsGFl4IT5K66IWpYOmJxiAGps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urzk3vqY3e+eTsIWYmXIrnzdBVn18m0tbFMkFSPtNcz+rTROoJWH+zE+GivImDdqPvfSYy5XlyHg4BNXXaNo1TtCA4L7X6OXz4rAtOfA1csgAeYOZ9pnrNsB1SWKSWIAXgBrVfou50ECazn2JSL6VN2MsjO1cof6mvl8f5F+bao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVNd+8zM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5851F00893;
	Wed, 20 May 2026 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298738;
	bh=7klKBQBJZehpcrrvVj+Mi3TaoFTHGF1tqOBlFQxQNlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVNd+8zMJ0sRDH5bPRXUMoavdQ/OvpesUCnGSUbUnWH5kfIuXCbvq/xSizeZ0rPeA
	 H9hg1yk5I1oZdzLda5DvlDUt3vK74dIUOULrYp/7SvwAfS5eXI2OqLfAgPfHaHEi3R
	 Lbeh9ph4r9HFH9UDeumtSXSvvHsqubPSYj9BcHpo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Gu <ustc.gu@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 523/957] i3c: master: dw-i3c: Fix missing reset assertion in remove() callback
Date: Wed, 20 May 2026 18:16:46 +0200
Message-ID: <20260520162145.876848326@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251729-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,pengutronix.de,gmail.com,nxp.com,bootlin.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: E1426595462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit bef1eef667186cedb0bc6d152464acb3c97d5f72 ]

The reset line acquired during probe is currently left deasserted when
the driver is unbound.

Switch to devm_reset_control_get_optional_exclusive_deasserted() to
ensure the reset is automatically re-asserted by the devres core when
the driver is removed.

Fixes: 62fe9d06f570 ("i3c: dw: Add power management support")
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260320-dw-i3c-v3-1-477040c2e3f5@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/dw-i3c-master.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 825eb2d20e9eb..c6cfcacb18106 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1554,13 +1554,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (IS_ERR(master->pclk))
 		return PTR_ERR(master->pclk);
 
-	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
-								    "core_rst");
+	master->core_rst = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
+										"core_rst");
 	if (IS_ERR(master->core_rst))
 		return PTR_ERR(master->core_rst);
 
-	reset_control_deassert(master->core_rst);
-
 	spin_lock_init(&master->xferqueue.lock);
 	INIT_LIST_HEAD(&master->xferqueue.list);
 
@@ -1572,7 +1570,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 			       dw_i3c_master_irq_handler, 0,
 			       dev_name(&pdev->dev), master);
 	if (ret)
-		goto err_assert_rst;
+		return ret;
 
 	platform_set_drvdata(pdev, master);
 
@@ -1610,9 +1608,6 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
-err_assert_rst:
-	reset_control_assert(master->core_rst);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_probe);
-- 
2.53.0




