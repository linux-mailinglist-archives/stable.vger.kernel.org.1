Return-Path: <stable+bounces-116781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DBBA39E3C
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9F03A3C31
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5AA146A60;
	Tue, 18 Feb 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NcP87OyK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFB243361
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887361; cv=none; b=qHhAOJO6H1dXWFWZ8OF3YqSvH2OWqya29dvm7g0Yuhe5R9xG5iuPfZom8BPr3Ru6INhnaJlJXVQAt7+9bqKxKgIvbJ3n9Kn0ZKdJFg2vRsJfcgZivF4YbMsIyGZoDvJc7qd5rJel4QKddk+mJr7CW/0POKHRd7Eg7TGWgGmAwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887361; c=relaxed/simple;
	bh=JFs+MOm4mAWg7azgRcpuyW8x112xYLBE0YXgWujIIaw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jg8k7hcBrAqiiXX0ChD3wKD8veAhpZ9+U43i9x+H9t/OoxdkXWjAngvJhVzrUbT1l8PgR4eCg9vHIoxq2cUYW//pY2E2Vs2ycBRLCXPLgm8VnhcCxwz9I4kAZwFMX0Sq9DjMCtpfQ7fjAO2qH/42EIZo7TAL/UgbB2TGxqzUbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NcP87OyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C476C4CEE2;
	Tue, 18 Feb 2025 14:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739887360;
	bh=JFs+MOm4mAWg7azgRcpuyW8x112xYLBE0YXgWujIIaw=;
	h=Subject:To:Cc:From:Date:From;
	b=NcP87OyKJnxhmCvdn9ZobcVtTbF6K85b3JV9pQw5mzSu89sgq0ZKGN7LlmFDCnrtW
	 7C4AGpSGn9CulnirJlEH6sLSlOEEI2N72Pg76sSXIrBHfPcMfqqi4DaLZ852/Uwd7l
	 +3gujQLvlD6dUXZxjnD2MpTMwEPZ7e+D6Tc8mDTA=
Subject: FAILED: patch "[PATCH] drm/rcar-du: dsi: Fix PHY lock bit check" failed to apply to 6.1-stable tree
To: tomi.valkeinen+renesas@ideasonboard.com,geert+renesas@glider.be,laurent.pinchart+renesas@ideasonboard.com,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 15:02:37 +0100
Message-ID: <2025021837-entree-estrogen-6751@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6389e616fae8a101ce00068f7690461ab57b29d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021837-entree-estrogen-6751@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6389e616fae8a101ce00068f7690461ab57b29d8 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Tue, 17 Dec 2024 07:31:35 +0200
Subject: [PATCH] drm/rcar-du: dsi: Fix PHY lock bit check

The driver checks for bit 16 (using CLOCKSET1_LOCK define) in CLOCKSET1
register when waiting for the PPI clock. However, the right bit to check
is bit 17 (CLOCKSET1_LOCK_PHY define). Not only that, but there's
nothing in the documents for bit 16 for V3U nor V4H.

So, fix the check to use bit 17, and drop the define for bit 16.

Fixes: 155358310f01 ("drm: rcar-du: Add R-Car DSI driver")
Fixes: 11696c5e8924 ("drm: Place Renesas drivers in a separate dir")
Cc: stable@vger.kernel.org
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241217-rcar-gh-dsi-v5-1-e77421093c05@ideasonboard.com

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index 8180625d5866..be4ffc0ab14f 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
@@ -587,7 +587,7 @@ static int rcar_mipi_dsi_startup(struct rcar_mipi_dsi *dsi,
 	for (timeout = 10; timeout > 0; --timeout) {
 		if ((rcar_mipi_dsi_read(dsi, PPICLSR) & PPICLSR_STPST) &&
 		    (rcar_mipi_dsi_read(dsi, PPIDLSR) & PPIDLSR_STPST) &&
-		    (rcar_mipi_dsi_read(dsi, CLOCKSET1) & CLOCKSET1_LOCK))
+		    (rcar_mipi_dsi_read(dsi, CLOCKSET1) & CLOCKSET1_LOCK_PHY))
 			break;
 
 		usleep_range(1000, 2000);
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
index f8114d11f2d1..a6b276f1d6ee 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
@@ -142,7 +142,6 @@
 
 #define CLOCKSET1			0x101c
 #define CLOCKSET1_LOCK_PHY		(1 << 17)
-#define CLOCKSET1_LOCK			(1 << 16)
 #define CLOCKSET1_CLKSEL		(1 << 8)
 #define CLOCKSET1_CLKINSEL_EXTAL	(0 << 2)
 #define CLOCKSET1_CLKINSEL_DIG		(1 << 2)


