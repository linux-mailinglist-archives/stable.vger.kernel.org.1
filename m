Return-Path: <stable+bounces-48666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 397DF8FE9FA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90861F27088
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67319D073;
	Thu,  6 Jun 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CzGBVhTM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0FB1974EC;
	Thu,  6 Jun 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683087; cv=none; b=FCuz9i6qgSoPYlR7HCsnfb/KVbz5Gh51VU2xPaCZv7KbyCw8xRnCX3d4dSIZp7WRrKIVYEjV6wLrhWlr1lmJPLmnoYAqXTZWQQJtqD2xSU3nG5R8AATDqYF7uZB5CFknbKVY4KjamunRBJZWjj3FHuTsy1x/8qKz/pn7EJZUfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683087; c=relaxed/simple;
	bh=kt3IOSaS6b32Gxy03Tt840TQeGNNbZ5CY8L/Vfe1uek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV+ME4s2KfVlOdzXjyZJo8/XzPQ3N6dIJqv9+fQGTGCO16MZ8Hp2n7lYSa6xFbibp28aV1IXaBJYcHektSu5+3wSXN1ppI0C2DUMxFmoHhxM5iHSutq3ITm/JLAWRAF3AyzYFZBoVg8HAnyn1VMWDAbbgWyWzwch6GhZC/00Mx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CzGBVhTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A59DC32781;
	Thu,  6 Jun 2024 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683087;
	bh=kt3IOSaS6b32Gxy03Tt840TQeGNNbZ5CY8L/Vfe1uek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CzGBVhTMo2cpI/KsQZkveGHvgyPoJJh04P6thQIp1Htlop8gagps0ZNswy3GJqJrh
	 3PctCdFIXR7X3lr8YnHcuEedrvTzozgixcnZfj+iHaaXJYklywy3kuAyoMG83cuOPK
	 agWQErFsV2qJszdalkyCVHlWcvoO3J1ETCY00C/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 359/374] drm/panel: sitronix-st7789v: tweak timing for jt240mhqs_hwt_ek_e3 panel
Date: Thu,  6 Jun 2024 16:05:38 +0200
Message-ID: <20240606131703.909785758@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerald Loacker <gerald.loacker@wolfvision.net>

[ Upstream commit 2ba50582634d0bfe3a333ab7575a7f0122a7cde8 ]

Use the default timing parameters to get a refresh rate of about 60 Hz for
a clock of 6 MHz.

Fixes: 0fbbe96bfa08 ("drm/panel: sitronix-st7789v: add jasonic jt240mhqs-hwt-ek-e3 support")
Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Link: https://lore.kernel.org/r/20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-2-e4821802443d@wolfvision.net
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-2-e4821802443d@wolfvision.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 32e5c03480381..c7e3f1280404d 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -282,9 +282,9 @@ static const struct drm_display_mode et028013dma_mode = {
 static const struct drm_display_mode jt240mhqs_hwt_ek_e3_mode = {
 	.clock = 6000,
 	.hdisplay = 240,
-	.hsync_start = 240 + 28,
-	.hsync_end = 240 + 28 + 10,
-	.htotal = 240 + 28 + 10 + 10,
+	.hsync_start = 240 + 38,
+	.hsync_end = 240 + 38 + 10,
+	.htotal = 240 + 38 + 10 + 10,
 	.vdisplay = 280,
 	.vsync_start = 280 + 48,
 	.vsync_end = 280 + 48 + 4,
-- 
2.43.0




