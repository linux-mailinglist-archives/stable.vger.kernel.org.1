Return-Path: <stable+bounces-220227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEfVLGQxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7771C5A23
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6310E3134248
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2C64F7981;
	Sat, 28 Feb 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfg/eAEU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8024F7975;
	Sat, 28 Feb 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300132; cv=none; b=OANf57+sveXX4UyJfb1q4SACV/9lJ5RSZxMY7XLFQuEvE+XqSP7BzEfeufUp48lP0FlqA4NLG5bZ2avefUSFJwJkNvXQ9+MVX2YIYRDectQnGknqR4XKSYyZ6dCnWHo02khe9ZZUt5tODAeXe+ZCYUsT8csqNIhWGF8vYJhGa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300132; c=relaxed/simple;
	bh=BPLFLvaqaObh7NzmP5tmu5RVyOXfSPQMHDlcY7mRKAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arjfeok/18oQT7MuYJdYm534huM4CDnIIMpkrwu7QQhwnSXv+aMQE2qWONKDWSmSnO48SPnP2rNKBEkzq9q5eXY8Trstm3mv66RMpv/4ohX1B94lEQzjDZAF1rRXx6fmXMCXtfeQUKXutcSxdEvBRy66dyyPYpnYU8uQK68Has8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfg/eAEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9488C19424;
	Sat, 28 Feb 2026 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300132;
	bh=BPLFLvaqaObh7NzmP5tmu5RVyOXfSPQMHDlcY7mRKAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfg/eAEUhhNcEkN5H7iFqCteje/mj5VND5pqI3QcNuu6sQ0XO2fjq8pJlhs4hpAsa
	 Ku6iv2iLTF8mb/fNXRzVMLz97KAkThEco4PVsgHWp//36xnqbCwQYHqLVruhH1gyKS
	 b/znckuLkY+z8NbjfdzOJe8afGp9uore4mWlSE9kLdm+ZlRCmcArNuizwViT4XevS1
	 woJiPzMJaXoyUXwwk6o0aXWNVI+Ub8Q+vZbujZLlzvb+IwjI+sjyTbcoo4I4d7nrlE
	 CPXDKRozRNz774P0jLVUpNki0AoUAv8jjo6PGK+5U7ymPY2smOQvzq9250R/JYcOIq
	 UgDhfiJE4wQIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 149/844] drm/ast: Swap framebuffer writes on big-endian machines
Date: Sat, 28 Feb 2026 12:21:02 -0500
Message-ID: <20260228173244.1509663-150-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220227-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 2F7771C5A23
X-Rspamd-Action: no action

From: René Rebe <rene@exactco.de>

[ Upstream commit 50c26c301c5176cc8b431044390e10ec862b9b77 ]

Swap the pixel data when writing to framebuffer memory on big-endian
machines. Fixes incorrect output. Aspeed graphics does not appear to
support big-endian framebuffers after AST2400, although the feature
has been documented.

There's a lengthy discussion at [1].

v5:
- avoid restricted cast from __be16 (kernel test robot)

Signed-off-by: René Rebe <rene@exactco.de>
Link: https://lore.kernel.org/dri-devel/20251202.170626.2134482663677806825.rene@exactco.de/ # [1]
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/20251212.210504.1355099120650239629.rene@exactco.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_cursor.c | 11 ++++++++---
 drivers/gpu/drm/ast/ast_mode.c   | 11 +++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
index 2d3ad7610c2e9..7da0a2d463e6c 100644
--- a/drivers/gpu/drm/ast/ast_cursor.c
+++ b/drivers/gpu/drm/ast/ast_cursor.c
@@ -92,12 +92,17 @@ static void ast_set_cursor_image(struct ast_device *ast, const u8 *src,
 				 unsigned int width, unsigned int height)
 {
 	u8 __iomem *dst = ast_plane_vaddr(&ast->cursor_plane.base);
-	u32 csum;
-
-	csum = ast_cursor_calculate_checksum(src, width, height);
+	u32 csum = ast_cursor_calculate_checksum(src, width, height);
 
 	/* write pixel data */
+#if defined(__BIG_ENDIAN)
+	unsigned int i;
+
+	for (i = 0; i < AST_HWC_SIZE; i += 2)
+		writew(swab16(*(const __u16 *)&src[i]), &dst[i]);
+#else
 	memcpy_toio(dst, src, AST_HWC_SIZE);
+#endif
 
 	/* write checksum + signature */
 	dst += AST_HWC_SIZE;
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index cd08990a10f93..57c6fbc3232b0 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -526,12 +526,18 @@ static int ast_primary_plane_helper_atomic_check(struct drm_plane *plane,
 
 static void ast_handle_damage(struct ast_plane *ast_plane, struct iosys_map *src,
 			      struct drm_framebuffer *fb,
-			      const struct drm_rect *clip)
+			      const struct drm_rect *clip,
+			      struct drm_format_conv_state *fmtcnv_state)
 {
 	struct iosys_map dst = IOSYS_MAP_INIT_VADDR_IOMEM(ast_plane_vaddr(ast_plane));
 
 	iosys_map_incr(&dst, drm_fb_clip_offset(fb->pitches[0], fb->format, clip));
+
+#if defined(__BIG_ENDIAN)
+	drm_fb_swab(&dst, fb->pitches, src, fb, clip, !src[0].is_iomem, fmtcnv_state);
+#else
 	drm_fb_memcpy(&dst, fb->pitches, src, fb, clip);
+#endif
 }
 
 static void ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
@@ -561,7 +567,8 @@ static void ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE) == 0) {
 		drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 		drm_atomic_for_each_plane_damage(&iter, &damage) {
-			ast_handle_damage(ast_plane, shadow_plane_state->data, fb, &damage);
+			ast_handle_damage(ast_plane, shadow_plane_state->data, fb, &damage,
+					  &shadow_plane_state->fmtcnv_state);
 		}
 
 		drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
-- 
2.51.0


