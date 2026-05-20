Return-Path: <stable+bounces-251948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC9yHzX2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A8595017
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE8613055AF9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA913F4DC0;
	Wed, 20 May 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RF7wMFkA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C33F20FA;
	Wed, 20 May 2026 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299349; cv=none; b=kvKo7zpLcErU4q62GqOl4oF7FEt5k6kWyhKAXbDObjIPYYpyLUOlWmu2ucdcfRSKTELuU41s8kheJ1zBrTBRwyDbbA1rEkxPBAZEsIv/pOu+nmtCOhZhFSaK7vO74pOptSb4yQtPNrT7W6gIAtbYiMJv/9vVytZSle1PaaOGNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299349; c=relaxed/simple;
	bh=/egC5AV5pQm8I84vuP4J3+fBvIfseKy/ezeX5BLtZ3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6HCzZvoV6gNuY/3ZGEuK+o9/Qf3Qf47uybVxl8PY6xj6YiTEoB6Gjafr84FYs+A4CStKBfeGaWTzrr0+bcCLmLidTORZmD4E4HFYCiYQf8y6yYxLd0GFN7pZH1FSHC90ddkWm1CHEMCXYxUw1u5J1RiAMoV2LFeMlXUzed4VPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RF7wMFkA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705F31F00893;
	Wed, 20 May 2026 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299347;
	bh=4E3xp3EXro9SqvsT4piSMn2t5pSMWUUoLMSJ4WFn578=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RF7wMFkAEEY6sTfFqjt+xUo0I835pDdNWV+HyR56bCk+EILBSyVj+AJBs036b9+Ll
	 d/VqxfX8nlLGPad/mh/ZgsdaBX/1IswsFUau9+dKWgQMOgQ95bbhAUUdYpuV9XJBJJ
	 Rn/9sUv9x2nB9jDJWFiASwR2FFtT9Nrvgq6dJqXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 737/957] mailbox: mailbox-test: dont free the reused channel
Date: Wed, 20 May 2026 18:20:20 +0200
Message-ID: <20260520162150.543575526@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-251948-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,sang-engineering.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,sang-engineering.com:email]
X-Rspamd-Queue-Id: 4F3A8595017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 88ebadbf0deefdaccdab868b44ff70a0a257f473 ]

The RX channel can be aliased to the TX channel if it has a different
MMIO. This special case needs to be handled when freeing the channels
otherwise a double-free occurs.

Fixes: 8ea4484d0c2b ("mailbox: Add generic mechanism for testing Mailbox Controllers")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 197cad7b3d401..210f6077f475c 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -422,7 +422,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 err_free_chans:
 	if (tdev->tx_channel)
 		mbox_free_channel(tdev->tx_channel);
-	if (tdev->rx_channel)
+	if (tdev->rx_channel && tdev->rx_channel != tdev->tx_channel)
 		mbox_free_channel(tdev->rx_channel);
 	return ret;
 }
@@ -435,7 +435,7 @@ static void mbox_test_remove(struct platform_device *pdev)
 
 	if (tdev->tx_channel)
 		mbox_free_channel(tdev->tx_channel);
-	if (tdev->rx_channel)
+	if (tdev->rx_channel && tdev->rx_channel != tdev->tx_channel)
 		mbox_free_channel(tdev->rx_channel);
 }
 
-- 
2.53.0




