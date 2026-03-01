Return-Path: <stable+bounces-222205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNamIVKeo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:02:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6837C1CCB73
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A297C3037051
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34242C21F7;
	Sun,  1 Mar 2026 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+gZLC3q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521221ABB9;
	Sun,  1 Mar 2026 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330302; cv=none; b=sR9V5J0PKRGGOCB9wikWUEiY2QPz3D/rlcAPYYudNsnjmidRMppzTcsu0nl2/uZtwHfkp5mNXZ8GRcTG32GtSzF+aW/07Vee2jeamoNP1eJN29ASudPRTYcit8pTYme7HEPduV7JdhvXgJYn25ivI5Lk2Ca+vh7SyIZtVg3RVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330302; c=relaxed/simple;
	bh=SxLvl1psNeYgb85A6rqfTbSyIxTw8V3MFIueb/QNoIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zd+eWrVzacjB6Ld6KDBYIwBetAp1fH0awx9T8cb95LsXknifaSoFlrr2Z3/VYXbSqyYrtXN7VzBNeRQxcv8xrNPALoMbR5O4xFL7YoPHpI7MggbJL+ba/kGDqy+twMvHFL8CRx7UIgY3iuxWwoxRsbpsB4zsUBfYW80kQtVnvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+gZLC3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C101C19424;
	Sun,  1 Mar 2026 01:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330302;
	bh=SxLvl1psNeYgb85A6rqfTbSyIxTw8V3MFIueb/QNoIA=;
	h=From:To:Cc:Subject:Date:From;
	b=T+gZLC3q6feZvr2kG3r0tKbV5mm/uSoNni6fFegEpaIkUr1vKwK43/QWg4SbUzbHX
	 9UPd7fA3JimVqBHLmmEbWSXG1MHUAgRSOJBZ9mt/ya6/RRDc9DTIxpVimpftjwNR2o
	 q7lO0pTp1gP8sOzy8mdiWGox8+nDiD8qbR1el/SWbXpIXZfVuN+dEeWxarfHpGJw8H
	 IJBMwHLHTcqVljWCIt/GWf+P1ZHQy/pVZEWrAE/vS5rnirvzcNm5CwmX3hrf9/eIpu
	 rL3ByzQhSVdOhTs58jtkejmCTrYv2Qd7RzOzGGoZo8KqBFClwjH7E+PMJR/HPpa8ho
	 z4i9tvSSNx/4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: Helge Deller <deller@gmx.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbdev: vt8500lcdfb: fix missing dma_free_coherent()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:58:20 -0500
Message-ID: <20260301015820.1723769-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222205-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,lists.infradead.org,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 6837C1CCB73
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 88b3b9924337336a31cefbe99a22ed09401be74a Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Mon, 12 Jan 2026 15:00:27 +0100
Subject: [PATCH] fbdev: vt8500lcdfb: fix missing dma_free_coherent()

fbi->fb.screen_buffer is allocated with dma_alloc_coherent() but is not
freed if the error path is reached.

Fixes: e7b995371fe1 ("video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/vt8500lcdfb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index b08a6fdc53fd2..85c7a99a7d648 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -369,7 +369,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 	if (fbi->palette_cpu == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate palette buffer\n");
 		ret = -ENOMEM;
-		goto failed_free_io;
+		goto failed_free_mem_virt;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -432,6 +432,9 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 failed_free_palette:
 	dma_free_coherent(&pdev->dev, fbi->palette_size,
 			  fbi->palette_cpu, fbi->palette_phys);
+failed_free_mem_virt:
+	dma_free_coherent(&pdev->dev, fbi->fb.fix.smem_len,
+			  fbi->fb.screen_buffer, fbi->fb.fix.smem_start);
 failed_free_io:
 	iounmap(fbi->regbase);
 failed_free_res:
-- 
2.51.0





