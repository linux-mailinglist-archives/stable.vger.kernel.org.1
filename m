Return-Path: <stable+bounces-222201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKKiB3qto2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:07:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BFE1CE3CA
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 764FB3063D5C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AB2BD5BD;
	Sun,  1 Mar 2026 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrEMMNke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597A1E4AF;
	Sun,  1 Mar 2026 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330293; cv=none; b=jdZ2qTKr9MlVkSPLJBm4fPwIXY06LIBH1DUtuwwfbVK13TC2fbkMMyEdiL7QaHR6ASONA6C6ZlL1TC1wszEmr+3vlTWt54dhJcSdKXiQBlX8/spuo4ITOQKaXqrFsYQ0XzXx7vapw530LHzQge+XI+iPNl+XfhtfRfA28g60LBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330293; c=relaxed/simple;
	bh=FwMN8wkS7r66nHonUOtpzcdNeY1TZLlQ/khHZEWSn18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sRJO0qq2xxq043k/udYzK9RvHdd0VUQ5Vv46Dlesl5eW5IDlwyqWWY+6sD40undiCigLZ8Hjh1bCB4eR276YMMyVIh+RjTbQs35ZgzfxAR3H1UfXR0VeDHA83SE80G3l/PkRRyLHnG21STEln1Dg6/RZVIk0T0dPLigq0KuS5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrEMMNke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC98C19421;
	Sun,  1 Mar 2026 01:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330293;
	bh=FwMN8wkS7r66nHonUOtpzcdNeY1TZLlQ/khHZEWSn18=;
	h=From:To:Cc:Subject:Date:From;
	b=BrEMMNkekFwS0OnT6BmKpfxjcah2va1qrS5vcM+hZErxuvdatiB1inFw3TCohXGnQ
	 zsAuPUAkVa+ZBmcLAUnb2JGY3dSwqLQRjYn8nXFDJVfPIIzeFYYDmzzs3uKLlD3jqk
	 up3hAv7pls9xnP3dWri74igINVsk9ZjYs/VTCwSJyKXavBfCV5o5j2RZhd4PV58GTn
	 oLo6Z2ol7H7LDaUqNeBkAYRmu/fg6BY6OKNKtsbmVAruQhlwPqbNtzf5prLeTcurVw
	 eYKgAKb7JC3ML9wV/lKFU4/lgX1Ru+aTW070yBQtf1pIf0DHKnOE35XxKWBdTO7Mqi
	 bmsrdUD3NJrnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rene@exactco.de
Cc: stable@kernel.org,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbdev: ffb: fix corrupted video output on Sun FFB1" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:48 -0500
Message-ID: <20260301015811.1723144-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-222201-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[instagram.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1e:email,exactco.de:email]
X-Rspamd-Queue-Id: 69BFE1CE3CA
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b28da0d092461ac239ff034a8ac3129320177ba3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>
Date: Thu, 5 Feb 2026 16:49:58 +0100
Subject: [PATCH] fbdev: ffb: fix corrupted video output on Sun FFB1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix Sun FFB1 corrupted video out ([1] and [2]) by disabling overlay and
initializing window mode to a known state. The issue never appeared on
my FFB2+/vertical nor Elite3D/M6. It could also depend on the PROM
version.

/SUNW,ffb@1e,0: FFB at 000001fc00000000, type 11, DAC pnum[236c] rev[10] manuf_rev[4]
X (II) /dev/fb0: Detected FFB1, Z-buffer, Single-buffered.
X (II) /dev/fb0: BT9068 (PAC1) ramdac detected (with normal cursor control)
X (II) /dev/fb0: Detected Creator/Creator3D

[1] https://www.instagram.com/p/DUTcSmSjSem/
[2] https://chaos.social/@ReneRebe/116023241660154102

Signed-off-by: René Rebe <rene@exactco.de>
Cc: stable@kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/ffb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
index 34b6abff9493e..da531b4cb4513 100644
--- a/drivers/video/fbdev/ffb.c
+++ b/drivers/video/fbdev/ffb.c
@@ -335,6 +335,9 @@ struct ffb_dac {
 };
 
 #define FFB_DAC_UCTRL		0x1001 /* User Control */
+#define FFB_DAC_UCTRL_OVENAB	0x00000008 /* Overlay Enable */
+#define FFB_DAC_UCTRL_WMODE	0x00000030 /* Window Mode */
+#define FFB_DAC_UCTRL_WM_COMB	0x00000000 /* Window Mode = Combined */
 #define FFB_DAC_UCTRL_MANREV	0x00000f00 /* 4-bit Manufacturing Revision */
 #define FFB_DAC_UCTRL_MANREV_SHIFT 8
 #define FFB_DAC_TGEN		0x6000 /* Timing Generator */
@@ -425,7 +428,7 @@ static void ffb_switch_from_graph(struct ffb_par *par)
 {
 	struct ffb_fbc __iomem *fbc = par->fbc;
 	struct ffb_dac __iomem *dac = par->dac;
-	unsigned long flags;
+	unsigned long flags, uctrl;
 
 	spin_lock_irqsave(&par->lock, flags);
 	FFBWait(par);
@@ -450,6 +453,15 @@ static void ffb_switch_from_graph(struct ffb_par *par)
 		upa_writel((FFB_DAC_CUR_CTRL_P0 |
 			    FFB_DAC_CUR_CTRL_P1), &dac->value2);
 
+	/* Disable overlay and window modes. */
+	upa_writel(FFB_DAC_UCTRL, &dac->type);
+	uctrl = upa_readl(&dac->value);
+	uctrl &= ~FFB_DAC_UCTRL_WMODE;
+	uctrl |= FFB_DAC_UCTRL_WM_COMB;
+	uctrl &= ~FFB_DAC_UCTRL_OVENAB;
+	upa_writel(FFB_DAC_UCTRL, &dac->type);
+	upa_writel(uctrl, &dac->value);
+
 	spin_unlock_irqrestore(&par->lock, flags);
 }
 
-- 
2.51.0





