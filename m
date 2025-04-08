Return-Path: <stable+bounces-129502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E663FA80041
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF75117A018
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F810268685;
	Tue,  8 Apr 2025 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fXADrAqT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0922264A76;
	Tue,  8 Apr 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111202; cv=none; b=o4IriRjl8ctRVDpYNt+SfSGkFCgcFNRbz0unpJAOdNRqTTqbMXOPLRqvRca1z4ZrPymSPwaIizNEq/SAKURDoNUKtzGcAo8fjvmTZPYhlP9V6yVc6wQiOTHh9aNA6pL73uPMRuIUV4WDcpksZEvlUItkE3UZdpJtw8f8yiUqCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111202; c=relaxed/simple;
	bh=EaX8PabDqSNbDhW3qACyGi8qU72hU45leX63lrNeYHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCU3EEXZfU8x1iqrE4UVNDDGX0LBMhLehK50R0FnNWDNWTN+az5GGApTucWfuodaxsLcqL3999X/n6vno1s5WNJP+tTS+g5jshn66okn8mFpDStLvLVAKcm6GC/RAjGxYD2SD/nhjGJ0qf3LacZWG+1cYnqdG+c3zMpnbPLpFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fXADrAqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB41C4CEE7;
	Tue,  8 Apr 2025 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111202;
	bh=EaX8PabDqSNbDhW3qACyGi8qU72hU45leX63lrNeYHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fXADrAqTrAH5rE/TIN45ahpMp01GQf1db2WfM4kKYDZHPeBe0l7w/bssBzFKI4StD
	 BMJoccZf/srHvWEbo4xGEGWisiiC9QiIQ2MiDPTgWFjshvJkcEVHix3gV3xVnfMKzw
	 acNBV2iPenWkQ89nvb80Diy0tW6dcdV8KGmXJMxU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Elfring <elfring@users.sourceforge.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 347/731] fbdev: au1100fb: Move a variable assignment behind a null pointer check
Date: Tue,  8 Apr 2025 12:44:04 +0200
Message-ID: <20250408104922.346316828@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 2df2c0caaecfd869b49e14f2b8df822397c5dd7f ]

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function “au1100fb_setmode”.

This issue was detected by using the Coccinelle software.

Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/au1100fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 840f221607635..6251a6b07b3a1 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -137,13 +137,15 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 	 */
 int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
-	struct fb_info *info = &fbdev->info;
+	struct fb_info *info;
 	u32 words;
 	int index;
 
 	if (!fbdev)
 		return -EINVAL;
 
+	info = &fbdev->info;
+
 	/* Update var-dependent FB info */
 	if (panel_is_active(fbdev->panel) || panel_is_color(fbdev->panel)) {
 		if (info->var.bits_per_pixel <= 8) {
-- 
2.39.5




