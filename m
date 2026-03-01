Return-Path: <stable+bounces-221790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDXFJMKZo2kwIAUAu9opvQ
	(envelope-from <stable+bounces-221790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:43:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF71CB77E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B65F3011C9F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774D2C15B0;
	Sun,  1 Mar 2026 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju3lO7OF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11C2C1788;
	Sun,  1 Mar 2026 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329145; cv=none; b=li3rWKATEVQkglVw57Y298W1N/x07u0rZYr0QXG0FOLY9U2GP4nrPBHjKEEdSZDpmNLtEPy+vzjsszGZdSH4kg59n88S3aIrncRD+dlLNUXZx4dI1G2Brxcppa0p86Bg74Vil9ZIa0OSSTCNTaDTdzEP9U1Pk38rzfLsE7CEqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329145; c=relaxed/simple;
	bh=JonG/qMH9Q57J8+kvxbjBX/A0ocJ9k9CFxmIeKIKX5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjaT2TgXT9sP2FR/A6jOObSwNxgyi2c4g/ORSZEHV1j/+QoYUI5KncMJeAkd4BL2X8pJeu7lev0T4SpkorZdn0sPzOEZhhowu5NMN5SdWV4itwhyzj2cDc2SfsnmG67brR2MpOCOhhKk5Ux9NK/OonankGCfm4OhiL6vgkjnCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju3lO7OF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5E8C19421;
	Sun,  1 Mar 2026 01:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329145;
	bh=JonG/qMH9Q57J8+kvxbjBX/A0ocJ9k9CFxmIeKIKX5s=;
	h=From:To:Cc:Subject:Date:From;
	b=Ju3lO7OFIquGpd4XGNsMu2oYaUS/uu2hflEPUA49S1Z2Guuks5k9fpaAZPoJlMB5u
	 VyKM2qA8FqYOwmy1EMU9xUoVk4Yv+qWxA6GXAZdSI35KkLlOjKwKW240YlUWII5ege
	 JY7YlzblF1pSq+YPU0YAoPtPXBk94TM3weQ1gMS+MJZG04hCSKJgWt5dODx8RvT79Z
	 OKXkLtHw5wR7ngT+J8t1+DDxi+/jPFJGFKskYgveEHJdlcR+hCY/IcMr0greALNb7m
	 KF7FWhSZVhMsGkNJwtJmauEfOWDmtC0jcgXRSeT9+/bYhwPTSv9WPMGWrChAeohItm
	 bfXidXZhHjLcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: Helge Deller <deller@gmx.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbdev: vt8500lcdfb: fix missing dma_free_coherent()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:03 -0500
Message-ID: <20260301013903.1699892-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221790-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 31DF71CB77E
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





