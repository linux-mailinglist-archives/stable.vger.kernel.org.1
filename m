Return-Path: <stable+bounces-189202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC6C04C0A
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 725114F9623
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D572E7192;
	Fri, 24 Oct 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D6tVIy6S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JOHy3KUp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VLE31Yl/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hqI9aCE7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDC2E6CC3
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291411; cv=none; b=HzxmmAWsFBcQ/LXyK5KYIuQUNHcjPkomzaQihCsp1kxgJpG5yJsT3hNimp9F9rIIByP8zcqbiriUa+GKLqctprnGqBJ5SeQfN9rJV2vJZjFXGB1udzIjn/nGDwDe+AoFJFu65WA10SXzvHIlXmCHkNpN6//Aq6uW5TtYBUpzIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291411; c=relaxed/simple;
	bh=xMwlcDFBTJfGSYctV6imgNJz6FPebb8n/LfgAtUigyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glEd3g1IpUPoI6HCoXFnQJPaekntTJ4Ov0dpRmiiw7s82vEFpPi/fMgTPQXao03dc+g4RHPQPPQPmg5q8ECCCC+LEyJ3uGTM2w4b+ga9NfEkAFQZPtXN10f/nPJioVx6EAC1IZH/9ACg3xf1A+gMoxm3MYngaI+WHG+zRBCa4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D6tVIy6S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JOHy3KUp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VLE31Yl/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hqI9aCE7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73A8B211F4;
	Fri, 24 Oct 2025 07:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761291397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IIjyVjTsKmTM3DyV9c7Fg0rxyqu0hiuVFiYvD0dfXfE=;
	b=D6tVIy6Sl+g47+arCAzMfoRHzEfFWsyPJlxy4xiJ7Nfxvx3HlAjZMxiD8f6k0/+0Sr3nz0
	L4EVvMxUys6n6k5VypDIiHoz+ASwssnWsyyMxiu1oHOD60zwWUFZtiTl663xNyAm1+VJrp
	UeiZy7h847B2I6oredjgWnJAVlPsZgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761291397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IIjyVjTsKmTM3DyV9c7Fg0rxyqu0hiuVFiYvD0dfXfE=;
	b=JOHy3KUp8++ANrU0aEgAIxgK/MY4CBMahUtgAxF2G9OETtpqAVTSJ9SBClr6rc1/Hxn1xE
	+VOy3BuQYkOMgKAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761291393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IIjyVjTsKmTM3DyV9c7Fg0rxyqu0hiuVFiYvD0dfXfE=;
	b=VLE31Yl/kUlNOdiCjxZQStbPyH9O9liLRgV66WFO3wI24Y1uDW8/IZhTGFEqOzx6AqiS6D
	Goesecw+rQOxTPX+udBNvOHE6YSqX+hMJdj3uiepNAs24i662npBFUVpK5FlFehmsuRpHi
	Il9TsudFwR+k10OJrV+39yZxTGaogRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761291393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IIjyVjTsKmTM3DyV9c7Fg0rxyqu0hiuVFiYvD0dfXfE=;
	b=hqI9aCE7EEJplAXT4QORlZWHB9EbJggX2anJ866UAz7Np2Bv4cSWOJ1+InX5g/Vxp5Z+GW
	HDokJdrR4xa3ZUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D625132C2;
	Fri, 24 Oct 2025 07:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rizmCYEs+2iAIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 24 Oct 2025 07:36:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	jfalempe@redhat.com,
	pschneider1968@googlemail.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nick Bowler <nbowler@draconx.ca>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/ast: Clear preserved bits from register output value
Date: Fri, 24 Oct 2025 09:35:53 +0200
Message-ID: <20251024073626.129032-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,googlemail.com,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,lists.freedesktop.org:email,draconx.ca:email,chromium.org:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,googlemail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Preserve the I/O register bits in __ast_write8_i_masked() as specified
by preserve_mask. Accidentally OR-ing the output value into these will
overwrite the register's previous settings.

Fixes display output on the AST2300, where the screen can go blank at
boot. The driver's original commit 312fec1405dd ("drm: Initial KMS
driver for AST (ASpeed Technologies) 2000 series (v2)") already added
the broken code. Commit 6f719373b943 ("drm/ast: Blank with VGACR17 sync
enable, always clear VGACRB6 sync off") triggered the bug.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Peter Schneider <pschneider1968@googlemail.com>
Closes: https://lore.kernel.org/dri-devel/a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com/
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Fixes: 6f719373b943 ("drm/ast: Blank with VGACR17 sync enable, always clear VGACRB6 sync off")
Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Nick Bowler <nbowler@draconx.ca>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.5+
---
 drivers/gpu/drm/ast/ast_drv.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 7be36a358e74..787e38c6c17d 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -298,13 +298,13 @@ static inline void __ast_write8_i(void __iomem *addr, u32 reg, u8 index, u8 val)
 	__ast_write8(addr, reg + 1, val);
 }
 
-static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index, u8 read_mask,
+static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index, u8 preserve_mask,
 					 u8 val)
 {
-	u8 tmp = __ast_read8_i_masked(addr, reg, index, read_mask);
+	u8 tmp = __ast_read8_i_masked(addr, reg, index, preserve_mask);
 
-	tmp |= val;
-	__ast_write8_i(addr, reg, index, tmp);
+	val &= ~preserve_mask;
+	__ast_write8_i(addr, reg, index, tmp | val);
 }
 
 static inline u32 ast_read32(struct ast_device *ast, u32 reg)
-- 
2.51.0


