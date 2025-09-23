Return-Path: <stable+bounces-181515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E8B967FE
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CC218850F8
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3227255222;
	Tue, 23 Sep 2025 15:07:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE74246BB4;
	Tue, 23 Sep 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640059; cv=none; b=vBEfjfN3RHK3haxj02HnwP/0F1bK+zniEhlQoMzbxcdjiPIWNgHSEgEjnbFBX5IWig65z4Y8UAOHLAgJnJWld2Hq1vMmKpcuIm+QV25gBzDT6rKfQAQzOSyZHfFDpxQyXX9YECX/5rRFK9rrS1uZe5/ey0mfw2dMO9il4dSaQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640059; c=relaxed/simple;
	bh=Ev8ok5cn/l8aR83oLAKn5J8yEAs/ij6LJ1LuS7Vhgts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOtkY1ybqkYKjAtoPflKmqgi5OxGWuB4t3xZXy8bGaHMo4LXXjYzLzPFg5UgXvpZEaeBSJi9YmeRJMO0Ypho34Gop6GcOsTWxOLBhB6mffAG4l7iptaW2LbP1lLevCer1G/JQFMBxGTdOrpWMsM6CmD3THiKSmvVs7yLpG2eoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 1FA9C3F116;
	Tue, 23 Sep 2025 17:07:24 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	stable <stable@vger.kernel.org>
Subject: [PATCH] fbcon: fix buffer overflow in fbcon_set_font
Date: Wed, 24 Sep 2025 00:06:28 +0900
Message-ID: <20250923150642.2441-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1a194e6c8e1ee745e914b0b7f50fa86c89ed13fe introduced overflow
checking for the font allocation size calculation, but in doing so moved
the addition of the size for font housekeeping data out of the kmalloc
call.

As a result, the calculated size now includes those extra bytes, which
marks the same number of bytes beyond the allocation as valid font data.

The crc32() call and the later memcmp() in fbcon_set_font() already perform
an out-of-bounds read, the latter is flagged on ppc64el:

    memcmp: detected buffer overflow: 4112 byte read of buffer size 4096

when loading Lat15-Fixed16.psf.gz.

Since the addition of the extra size should only go into the kmalloc()
call, calculate this size in a separate variable.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
Fixes: 1a194e6c8e1e ("fbcon: fix integer overflow in fbcon_do_set_font")
Cc: stable <stable@vger.kernel.org> #v5.9+
---
 drivers/video/fbdev/core/fbcon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5fade44931b8..a3fbf42c57d9 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2518,7 +2518,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size;
+	int size, allocsize;
 	int i, csum;
 	u8 *new_data, *data = font->data;
 	int pitch = PITCH(font->width);
@@ -2551,10 +2551,10 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 		return -EINVAL;
 
 	/* Check for overflow in allocation size calculation */
-	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &size))
+	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &allocsize))
 		return -EINVAL;
 
-	new_data = kmalloc(size, GFP_USER);
+	new_data = kmalloc(allocsize, GFP_USER);
 
 	if (!new_data)
 		return -ENOMEM;
-- 
2.47.3


