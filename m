Return-Path: <stable+bounces-247667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNZ/CW8KB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:58:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A479F54EEDE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64CB310B84C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD323859DF;
	Fri, 15 May 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvIM34E5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D138425D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844715; cv=none; b=Fzl7O9SlEwJzGUZeKROkY4SOx/sv6yFkbBQG2TwvLlY8dj6RqQ9a5Ze8/7q9fKq6IJ+BAUTkumNPq8ZvqGg1V8/7bIJkzKs3NuOQAvD/qhpX/gSv3VHEmLLGQfcvpwDaffXcqM5NZd4ogUA5t1EOCfcmn1rYrOvbT1TUahKaX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844715; c=relaxed/simple;
	bh=P1hRDeMeydZmmdM1gM2Cjp0BdD4Jd50OHMDrpYrWZok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LogGXSH6iI50JHz2vUrEx7231NnmhsbU6njbK5BFVXXGPhumAkGH2qfQAtzSdM8G9rqrskzOnWwe2oHQzROC10P6dCZxgoBH62JHjPI6+QGtpaQBj7uz4yVlakVB5wYHRSFcxZhcrYb5xNXExzvM2E+0J4qsXbyB3d+9n92Sxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvIM34E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A15C2BCB0;
	Fri, 15 May 2026 11:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844715;
	bh=P1hRDeMeydZmmdM1gM2Cjp0BdD4Jd50OHMDrpYrWZok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MvIM34E5DfNOS+9Hi5NbNFAmhkA5h14ye69qiskWN7n160Bbf6FbOuRh6qVjGF0Hw
	 GDv1dgV1ShFEzkwF1UthFHoetc0dtjYUHTb+tRwqCp0BxzAF+rOZhHDDR6jepARoU1
	 ZI1xBWyBMYFNiqCo3hlMpjWHtBDMRPQcO7CGczKuleLWfJttBpnyCbRqr6OLzBQOB4
	 0OsvlIngYZsXNSDytIlqPA4QJNsxSCJqmHiAsgB1nKNs7YVjN9FgYjGxW9iFzD2R0x
	 OwGXyq2RIUajU0qSeTTW7Dd1IlDGlDq7nf6d+dQ00ykQOXhwtAQ4QpG14csZAw3a8J
	 FzNIC4JTSR59A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] spi: topcliff-pch: fix controller deregistration
Date: Fri, 15 May 2026 07:31:52 -0400
Message-ID: <20260515113152.2965674-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515113152.2965674-1-sashal@kernel.org>
References: <2026051239-idealize-clanking-104d@gregkh>
 <20260515113152.2965674-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A479F54EEDE
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
	TAGGED_FROM(0.00)[bounces-247667-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 5d6f477d6fc0767c57c5e1e6f55a1662820eef87 ]

Make sure to deregister the controller before disabling and releasing
underlying resources like interrupts and DMA during driver unbind.

Fixes: e8b17b5b3f30 ("spi/topcliff: Add topcliff platform controller hub (PCH) spi bus driver")
Cc: stable@vger.kernel.org	# 2.6.37
Cc: Masayuki Ohtake <masa-korg@dsn.okisemi.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-8-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 271f3e7f834be..1a85b92e9eaa3 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1406,6 +1406,10 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
 		__func__, plat_dev->id, board_dat->pdev->irq);
 
+	spi_controller_get(data->host);
+
+	spi_unregister_controller(data->host);
+
 	if (use_dma)
 		pch_free_dma_buf(board_dat, data);
 
@@ -1433,7 +1437,8 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	}
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_controller(data->host);
+
+	spi_controller_put(data->host);
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
-- 
2.53.0


