Return-Path: <stable+bounces-185990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817D9BE2632
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5014252E9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCD3090CB;
	Thu, 16 Oct 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brUCB2aH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6752FF669
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606939; cv=none; b=J5VG3Fv97DPsdBBHjoJN8STOztRRfOFYmxlfgOuXrRS7NGzmbn7huJo9Ouf5tWxQC5pEyIpdQYnR9VigQk+1jtzmWXjtPc8nzY6K8xje2gVWkVhno4b6LEOBx+7bKGnZB2/jyodEIT2U4czYqREGA87obiPEzI/uYq81UbFwK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606939; c=relaxed/simple;
	bh=f+OKV2vSVmoI+aW+xm+a21oxxcAOK5t/l+bOyl71xjw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e4lq0cjPHCu9ur9fHrTkvN8tsoBHa63oYtrI8cP3XEAOtaoNZupQ0E4/j/1sKGlVUmGo8XLXKse42T7HluQfelZA6Ljdw4HhPnVS7G/Uq4honp9GKrmCLuCrGvXdrQIkemg/wE5VXgppC7hA85+trb3O5NUEwjRqO4JXWku4Ryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brUCB2aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7078BC4CEF1;
	Thu, 16 Oct 2025 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760606938;
	bh=f+OKV2vSVmoI+aW+xm+a21oxxcAOK5t/l+bOyl71xjw=;
	h=Subject:To:Cc:From:Date:From;
	b=brUCB2aHwg8aTKL4KfHyfFpncX541vmtp279C5n6vXJPt6TIuLuzqNqmI5d4AzyJk
	 f+yZcsfmmAOzEVVDCBKiewW/9koMmkIBbJhSdoWQQBHBTBxLC+R1z+lgKPcUPFL6rt
	 tSzB045KJZKKo+P6t7yuyP0y8xCdqF91DDkJ3HB4=
Subject: FAILED: patch "[PATCH] drm/rcar-du: dsi: Fix 1/2/3 lane support" failed to apply to 5.15-stable tree
To: marek.vasut+renesas@mailbox.org,tomi.valkeinen+renesas@ideasonboard.com,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:28:48 +0200
Message-ID: <2025101648-foyer-lapping-1bf6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d83f1d19c898ac1b54ae64d1c950f5beff801982
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101648-foyer-lapping-1bf6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d83f1d19c898ac1b54ae64d1c950f5beff801982 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date: Wed, 13 Aug 2025 23:08:13 +0200
Subject: [PATCH] drm/rcar-du: dsi: Fix 1/2/3 lane support

Remove fixed PPI lane count setup. The R-Car DSI host is capable
of operating in 1..4 DSI lane mode. Remove the hard-coded 4-lane
configuration from PPI register settings and instead configure
the PPI lane count according to lane count information already
obtained by this driver instance.

Configure TXSETR register to match PPI lane count. The R-Car V4H
Reference Manual R19UH0186EJ0121 Rev.1.21 section 67.2.2.3 Tx Set
Register (TXSETR), field LANECNT description indicates that the
TXSETR register LANECNT bitfield lane count must be configured
such, that it matches lane count configuration in PPISETR register
DLEN bitfield. Make sure the LANECNT and DLEN bitfields are
configured to match.

Fixes: 155358310f01 ("drm: rcar-du: Add R-Car DSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20250813210840.97621-1-marek.vasut+renesas@mailbox.org
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index 1af4c73f7a88..952c3efb74da 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
@@ -576,7 +576,10 @@ static int rcar_mipi_dsi_startup(struct rcar_mipi_dsi *dsi,
 	udelay(10);
 	rcar_mipi_dsi_clr(dsi, CLOCKSET1, CLOCKSET1_UPDATEPLL);
 
-	ppisetr = PPISETR_DLEN_3 | PPISETR_CLEN;
+	rcar_mipi_dsi_clr(dsi, TXSETR, TXSETR_LANECNT_MASK);
+	rcar_mipi_dsi_set(dsi, TXSETR, dsi->lanes - 1);
+
+	ppisetr = ((BIT(dsi->lanes) - 1) & PPISETR_DLEN_MASK) | PPISETR_CLEN;
 	rcar_mipi_dsi_write(dsi, PPISETR, ppisetr);
 
 	rcar_mipi_dsi_set(dsi, PHYSETUP, PHYSETUP_SHUTDOWNZ);
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
index a6b276f1d6ee..a54c7eb4113b 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
@@ -12,6 +12,9 @@
 #define LINKSR_LPBUSY			(1 << 1)
 #define LINKSR_HSBUSY			(1 << 0)
 
+#define TXSETR				0x100
+#define TXSETR_LANECNT_MASK		(0x3 << 0)
+
 /*
  * Video Mode Register
  */
@@ -80,10 +83,7 @@
  * PHY-Protocol Interface (PPI) Registers
  */
 #define PPISETR				0x700
-#define PPISETR_DLEN_0			(0x1 << 0)
-#define PPISETR_DLEN_1			(0x3 << 0)
-#define PPISETR_DLEN_2			(0x7 << 0)
-#define PPISETR_DLEN_3			(0xf << 0)
+#define PPISETR_DLEN_MASK		(0xf << 0)
 #define PPISETR_CLEN			(1 << 8)
 
 #define PPICLCR				0x710


