Return-Path: <stable+bounces-224064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKA/Jmz+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1359424A6A5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B57530B4683
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597938758A;
	Tue, 10 Mar 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDI8zBje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9F352C4F;
	Tue, 10 Mar 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141198; cv=none; b=tVReC6NOgkEgyFTX5c0ddyBNWz0PHZEjwo62zqbtYqG98looavakxADL9VT1s8Fh8/hhJxnS/N3bqLoveXGdQxwePHgbA4XsLDhTTaYWMbdeYHZnmZ+gNg/ZSihKmhiDKHHNmbpGzH8hpYym+oqBWoBoquzLrHwZtzCJffh+J/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141198; c=relaxed/simple;
	bh=W3F0F0CSYYhU2obWczk+nOvIvSoE03/XMUWVsrph3w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTRsCTxvlrGE4heC8VMW7353qgoDTQkDB1WXCk4Ve2bkMH7lsb6wKVke8BWXWQRbwvRX7LnuAZ2ycDAoNvS9uwOrPzWbZMbi9+j/nAh/EJTrIlISPP1Dr9AhKYEyocnxdVwuV5gdPHWnRkjy95/8TdMr5ZyH5s0zgokLVNBXM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDI8zBje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6831C2BCAF;
	Tue, 10 Mar 2026 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141198;
	bh=W3F0F0CSYYhU2obWczk+nOvIvSoE03/XMUWVsrph3w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDI8zBjejEVnSeI4OYHf3bxZNu13jZWnMCBSZEJZdhseE3/a0Uw9R+QFXsvJwlLYX
	 NKQtceTVyDN4SeOvW1zvNcp9GIjz5yn1yt11NSv/a71j363fWIE+lKNBJU/NjuGWCf
	 MJRgPL3sciEaY/xuKd21uWMTtZ8PJ2wEn54QxtFiVEWI5CcMA5ZyBSVCGBB2Wc/vLq
	 HGI7xce4q82T8YXHrkiqaUdKAATwJUuhBCevOoihFILAag/g/EyiAK/MAhGTw5OkMZ
	 3mZAoaCBLn9OJWUknLrpPr+Zrscj3E2UOVLT0aBJgvaQ1JzGjYDzl0TYvtH3dTwY7Z
	 PxiOFAZMO/Juw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Francesco Lavra <flavra@baylibre.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 199/311] drm/solomon: Fix page start when updating rectangle in page addressing mode
Date: Tue, 10 Mar 2026 07:04:06 -0400
Message-ID: <b5bf730783acc2b9bf51bd43f696a017c115df95.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1359424A6A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224064-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baylibre.com:email]
X-Rspamd-Action: no action

From: Francesco Lavra <flavra@baylibre.com>

[ Upstream commit 36d9579fed6c9429aa172f77bd28c58696ce8e2b ]

In page addressing mode, the pixel values of a dirty rectangle must be sent
to the display controller one page at a time. The range of pages
corresponding to a given rectangle is being incorrectly calculated as if
the Y value of the top left coordinate of the rectangle was 0. This can
result in rectangle updates being displayed on wrong parts of the screen.

Fix the above issue by consolidating the start page calculation in a single
place at the beginning of the update_rect function, and using the
calculated value for all addressing modes.

Fixes: b0daaa5cfaa5 ("drm/ssd130x: Support page addressing mode")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patch.msgid.link/20260210180932.736502-1-flavra@baylibre.com
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/solomon/ssd130x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 96cf393201372..33ceed86ed362 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -737,6 +737,7 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 	unsigned int height = drm_rect_height(rect);
 	unsigned int line_length = DIV_ROUND_UP(width, 8);
 	unsigned int page_height = SSD130X_PAGE_HEIGHT;
+	u8 page_start = ssd130x->page_offset + y / page_height;
 	unsigned int pages = DIV_ROUND_UP(height, page_height);
 	struct drm_device *drm = &ssd130x->drm;
 	u32 array_idx = 0;
@@ -774,14 +775,11 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 	 */
 
 	if (!ssd130x->page_address_mode) {
-		u8 page_start;
-
 		/* Set address range for horizontal addressing mode */
 		ret = ssd130x_set_col_range(ssd130x, ssd130x->col_offset + x, width);
 		if (ret < 0)
 			return ret;
 
-		page_start = ssd130x->page_offset + y / page_height;
 		ret = ssd130x_set_page_range(ssd130x, page_start, pages);
 		if (ret < 0)
 			return ret;
@@ -813,7 +811,7 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 		 */
 		if (ssd130x->page_address_mode) {
 			ret = ssd130x_set_page_pos(ssd130x,
-						   ssd130x->page_offset + i,
+						   page_start + i,
 						   ssd130x->col_offset + x);
 			if (ret < 0)
 				return ret;
-- 
2.51.0


