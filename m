Return-Path: <stable+bounces-149904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8BACB4F0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA20C4A513F
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CF221558;
	Mon,  2 Jun 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="peqoNXc3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4421882B;
	Mon,  2 Jun 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875409; cv=none; b=b3+isYF9tkyeOPrah+Nz4uh6F+5UDefgsK0S5DvHsjvsqsV9PhOOAhXnfC0LJnigu57Trv6bopOwKjYBl7Xq9BzxPPQwsNA6LXs9Bm+mw8wwRzLOWVvEysHsjzKbwxTgHpNekuiaWclPueADcHWt526vO3f920uo0TtkIZp8zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875409; c=relaxed/simple;
	bh=b6CIUczlOfyb/rETqZIV53ED6g2OOMW9r/3I7cCltIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtf8+0QGd6CZeAZPejGtcltJ1lXzAKnAfaJSNbCnch8KPoQecXvGNzxxdT1mwH8jyCpyjdZYhCnmfiuGW0WNWohUhUawcc6NiGoaSVJP/x4kOr42AJtM4q1d4P4fuPlhgYGWySUdxfqMmrWdZPb6dLIDMAQFWRowh49G3dk6dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=peqoNXc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C79C4CEEB;
	Mon,  2 Jun 2025 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875409;
	bh=b6CIUczlOfyb/rETqZIV53ED6g2OOMW9r/3I7cCltIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=peqoNXc3ez/67fntOU8R+3Fylb+jLw8EjuzXPdZStGWoZS3UXo2b/ueWzl1Rdx0e6
	 57eG7HVlv3EaYS9uTNKXBLGotz0G3fOyrd27rgjytYpYnLDSITL2q/Cyq41iHDinB8
	 qS2MRm7ETvdSmJ9ZNBcHhOht/lgKFIezN+7obymA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 124/270] fbdev: core: tileblit: Implement missing margin clearing for tileblit
Date: Mon,  2 Jun 2025 15:46:49 +0200
Message-ID: <20250602134312.302544054@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 82e43e82f488e..ef20824e9c7b4 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -75,7 +75,42 @@ static void tile_putcs(struct vc_data *vc, struct fb_info *info,
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




