Return-Path: <stable+bounces-104282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91C9F248E
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 16:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 111107A0FDE
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE8192593;
	Sun, 15 Dec 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C1SQVUIU"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C3190674;
	Sun, 15 Dec 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734275735; cv=none; b=e5KUCNHCqCsGdA87p6TvRlDYhDrJJu61y8mY/iYN0v8dlw1vS1+U2P045V92dqeuxWPKTw4L3oI2Pj30SuY1RGyGblAF1kc3yUD7NJVuYLIRmKycwJXTRWowe17ws/USQXvKPC9cxg+EYpqzPbKJVrBszXkXb92/1jR/UrejNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734275735; c=relaxed/simple;
	bh=l8v0K6EgV9Pof7Es2dXxC+hC3jDa2lWcOg0k1aPIngM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=glw0MFR8q98Tg8JDS8bgXTYV+hO3Ohpw8AM+RJ4U41qPuB6UG8thSHqcJsTqSkYeHu6NyJEzc6otei/zCKdQy6TiNFzCqKWo4OXnAK1wgTE5EqjVTiAu4JFLCcTAwz8SpnKuVl9fe2Wq6xwscwg4Ob6Qq2m8TaIzPl2OcMHURz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=C1SQVUIU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734275730;
	bh=l8v0K6EgV9Pof7Es2dXxC+hC3jDa2lWcOg0k1aPIngM=;
	h=From:Date:Subject:To:Cc:From;
	b=C1SQVUIUJyT6+MoeQKs0VpFs8aQPrqZsUEW8jLMWqBgMj5cwNqRFQLzIWgl47U0uh
	 StqSBvKdrsmw4x1LaL+Z0cDts1bBUPGrcJjPwRQKMp+JIaaa4vEqwc94+yhGU0GnnP
	 CvgqVwA98gSwADsW76RVB8r/UY1aRbmyqv9HYKQE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 16:15:21 +0100
Subject: [PATCH] fbdev/udlfb: Remove world-writability from EDID attribute
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-udlfb-perms-v1-1-2d1f8c96b1ab@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIjyXmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0NT3dKUnLQk3YLUotxi3aQks9QUI3ODtMTkNCWgjoKi1LTMCrBp0bG
 1tQCtWVrdXQAAAA==
X-Change-ID: 20241215-udlfb-perms-bb6ed270facf
To: Bernie Thompson <bernie@plugable.com>, Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734275729; l=1213;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=l8v0K6EgV9Pof7Es2dXxC+hC3jDa2lWcOg0k1aPIngM=;
 b=7bTT4KHzbC+9GZPr4wRIw5/OMEXrR2T3SlEtOAfkRzjYmGDvyHWpa5VH4dS42jxKDP0D3d+Ok
 WbKQVF2WowxCc6VS30+DYCj81RVkYkGQo9MHVHQGjqIVHLsHkeqzGhz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

It should not be possible for every user to override the EDID.
Limit it to the system administrator.

Fixes: 8ef8cc4fca4a ("staging: udlfb: support for writing backup EDID to sysfs file")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
The EDID passed through sysfs is only used as a fallback if the hardware
does not provide one. To me it still feels incorrect to have this
world-writable.
---
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 71ac9e36f67c68aa7a54dce32323047a2a9a48bf..391bdb71197549caa839d862f0ce7456dc7bf9ec 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1480,7 +1480,7 @@ static ssize_t metrics_reset_store(struct device *fbdev,
 
 static const struct bin_attribute edid_attr = {
 	.attr.name = "edid",
-	.attr.mode = 0666,
+	.attr.mode = 0644,
 	.size = EDID_LENGTH,
 	.read = edid_show,
 	.write = edid_store

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-udlfb-perms-bb6ed270facf

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


