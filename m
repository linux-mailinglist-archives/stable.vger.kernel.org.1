Return-Path: <stable+bounces-141589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C441BAAB789
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91763AE784
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18E481A14;
	Tue,  6 May 2025 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL3xnTn3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F22F2C46;
	Mon,  5 May 2025 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486820; cv=none; b=O6y/pmDCsotv3IFlvFaoDaiqB4yEB/92BxZT2kSY1iOYzq5p9uS5lZErYoDgcabMSgOi5hXF38GbdTthZPhAzs9SiPTUxR1nxyc5vyLtn3KkUmaG+XXfuGXWYG5HjUFqIKYtzlLk5iuNPMlQsYQx5p0r9+jd/vaGaMCDdUdni3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486820; c=relaxed/simple;
	bh=qGBraCnsV9M9vOL/SuUmu81wvyQ3isDl/GqO2uTQAXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjb3vE/3ojbEzWWrT3Kcsu1KVDeMQbzopCSG75PwOO5ktTFkCXHkU1wlNd5uD/PSpBmPnjpEciuPwhLfODmg0GI8evmgaj5GJFVNDYQvnZW8VQDtHME440HjxYD7cSdPRzefD+lbMUlhxUPT8JgAGuzS/MQpDdR8wAKNLaFjkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL3xnTn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D351AC4CEE4;
	Mon,  5 May 2025 23:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486820;
	bh=qGBraCnsV9M9vOL/SuUmu81wvyQ3isDl/GqO2uTQAXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uL3xnTn3hZBlA4Kpl2O72pScLYCAwDII/lDbbKKtDad0NSI07rgHdfi5e6dBuFDSp
	 rUTm1aTu39OlMBZYoNe6fVGcuho2gNa3FbPUoccYZqM9k/fpJeP3SPzmP7AtZ+1xWe
	 z5W0tD+P5Rza4W92Yc4ceVu1vICDgGhWVSdmMTjqtXTenN/K3oa4hDhqcM8GN517++
	 +kngpogn5yzyIck/O+ZhDz8RC9C+4yb54rok/O/q+qHDBIESrC4ZV8Xts6rgPaSqNc
	 XmLivT8rG8ZyzDF1yDEOeiI3h+SuOFZmQRPcIcQFGKz+IJovuH+i1WAERdfR63QkJy
	 Oasn/DRnqeexA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	simona@ffwll.ch,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 007/153] fbdev: core: tileblit: Implement missing margin clearing for tileblit
Date: Mon,  5 May 2025 19:10:54 -0400
Message-Id: <20250505231320.2695319-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Zsolt Kajtar <soci@c64.rulez.org>

[ Upstream commit 76d3ca89981354e1f85a3e0ad9ac4217d351cc72 ]

I was wondering why there's garbage at the bottom of the screen when
tile blitting is used with an odd mode like 1080, 600 or 200. Sure there's
only space for half a tile but the same area is clean when the buffer
is bitmap.

Then later I found that it's supposed to be cleaned but that's not
implemented. So I took what's in bitblit and adapted it for tileblit.

This implementation was tested for both the horizontal and vertical case,
and now does the same as what's done for bitmap buffers.

If anyone is interested to reproduce the problem then I could bet that'd
be on a S3 or Ark. Just set up a mode with an odd line count and make
sure that the virtual size covers the complete tile at the bottom. E.g.
for 600 lines that's 608 virtual lines for a 16 tall tile. Then the
bottom area should be cleaned.

For the right side it's more difficult as there the drivers won't let an
odd size happen, unless the code is modified. But once it reports back a
few pixel columns short then fbcon won't use the last column. With the
patch that column is now clean.

Btw. the virtual size should be rounded up by the driver for both axes
(not only the horizontal) so that it's dividable by the tile size.
That's a driver bug but correcting it is not in scope for this patch.

Implement missing margin clearing for tileblit

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/tileblit.c | 37 ++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/core/tileblit.c
index 674ca6a410ec8..b3aa0c6620c7d 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -74,7 +74,42 @@ static void tile_putcs(struct vc_data *vc, struct fb_info *info,
 static void tile_clear_margins(struct vc_data *vc, struct fb_info *info,
 			       int color, int bottom_only)
 {
-	return;
+	unsigned int cw = vc->vc_font.width;
+	unsigned int ch = vc->vc_font.height;
+	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
+	unsigned int bh = info->var.yres - (vc->vc_rows*ch);
+	unsigned int rs = info->var.xres - rw;
+	unsigned int bs = info->var.yres - bh;
+	unsigned int vwt = info->var.xres_virtual / cw;
+	unsigned int vht = info->var.yres_virtual / ch;
+	struct fb_tilerect rect;
+
+	rect.index = vc->vc_video_erase_char &
+		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
+	rect.fg = color;
+	rect.bg = color;
+
+	if ((int) rw > 0 && !bottom_only) {
+		rect.sx = (info->var.xoffset + rs + cw - 1) / cw;
+		rect.sy = 0;
+		rect.width = (rw + cw - 1) / cw;
+		rect.height = vht;
+		if (rect.width + rect.sx > vwt)
+			rect.width = vwt - rect.sx;
+		if (rect.sx < vwt)
+			info->tileops->fb_tilefill(info, &rect);
+	}
+
+	if ((int) bh > 0) {
+		rect.sx = info->var.xoffset / cw;
+		rect.sy = (info->var.yoffset + bs) / ch;
+		rect.width = rs / cw;
+		rect.height = (bh + ch - 1) / ch;
+		if (rect.height + rect.sy > vht)
+			rect.height = vht - rect.sy;
+		if (rect.sy < vht)
+			info->tileops->fb_tilefill(info, &rect);
+	}
 }
 
 static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
-- 
2.39.5


