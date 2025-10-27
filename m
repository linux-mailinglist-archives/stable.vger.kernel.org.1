Return-Path: <stable+bounces-191265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C7C1123A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4B319A2CF8
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFE32A3C5;
	Mon, 27 Oct 2025 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ERhRiCss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739B2EDD62;
	Mon, 27 Oct 2025 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593461; cv=none; b=c9JwuoEHTwjkWodDCpaKiuFzCtPTmQk4YAlnQM5yXB86nJjh5PuEWI3fj2i4FuxpvBfC5wmfb7/rrrWC+PisCZYBL8Moc4mJeKI9+d4PF5OPs/wU6BEloUUeVR71ulSESNsf+bhwtaTIskfZOzhQiYAvYTHWfrtVZ9gqYZwTwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593461; c=relaxed/simple;
	bh=IZ097IDGw9Cy3kAfKPsMM4xF1EqAJATj+BkB4UuMocY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuR/s/fxMBqTbuZty2p2cSXwy9yGDtIYuUOHyhJ1JHqdpWtxuWUXJrlpIWFmSHj+9Q/JMt+owILIYWdwMrhxqX+GJsD2TPZghLkpXzTdIhaMB78Y76OjEA7g/A5Qk1cFv/+/E9HwlPanU6cwfZCUAXZavw9ro1MLFGyRsCWO7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ERhRiCss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9EAC4CEF1;
	Mon, 27 Oct 2025 19:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761593461;
	bh=IZ097IDGw9Cy3kAfKPsMM4xF1EqAJATj+BkB4UuMocY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERhRiCss3MU3GiB9NEg+oWoJSFS/Ud2v2VmERA8Ds5FSqHTBx8pLQMyMpqTZgXn+H
	 l0r80/zv1zId1e6BZd4yxNQVUqEqIHsiRQHOQVVZuGo8yWqmd7U+9iTLuRBjgaWEcJ
	 7lK5qtr1cI3AdYkqnDxh/e5/3UIlx0qaW82XTcEg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 140/184] drm/panic: Fix drawing the logo on a small narrow screen
Date: Mon, 27 Oct 2025 19:37:02 +0100
Message-ID: <20251027183518.714396207@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
References: <20251027183514.934710872@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jocelyn Falempe <jfalempe@redhat.com>

[ Upstream commit 179753aa5b7890b311968c033d08f558f0a7be21 ]

If the logo width is bigger than the framebuffer width, and the
height is big enough to hold the logo and the message, it will draw
at x coordinate that are higher than the width, and ends up in a
corrupted image.

Fixes: 4b570ac2eb54 ("drm/rect: Add drm_rect_overlap()")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://lore.kernel.org/r/20251009122955.562888-2-jfalempe@redhat.com
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 1d6312fa14293..23ba791c6131b 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -429,6 +429,9 @@ static void drm_panic_logo_rect(struct drm_rect *rect, const struct font_desc *f
 static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *rect,
 				const struct font_desc *font, u32 fg_color)
 {
+	if (rect->x2 > sb->width || rect->y2 > sb->height)
+		return;
+
 	if (logo_mono)
 		drm_panic_blit(sb, rect, logo_mono->data,
 			       DIV_ROUND_UP(drm_rect_width(rect), 8), 1, fg_color);
-- 
2.51.0




