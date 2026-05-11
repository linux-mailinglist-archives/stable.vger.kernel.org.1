Return-Path: <stable+bounces-245179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBG3AlbEAWqSjgEAu9opvQ
	(envelope-from <stable+bounces-245179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:58:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AEF50D370
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7AB303A8D8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29BB377031;
	Mon, 11 May 2026 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vJo6Hoz/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jpLrsP5Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vJo6Hoz/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jpLrsP5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16371374187
	for <stable@vger.kernel.org>; Mon, 11 May 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500547; cv=none; b=hvC1SFtc6H+ujZaZK51IiSyAFTn7WxAlzbrpVmhPykrE2O/uU61JTt2YVt+D7vUTDPXTjaRPYTLDPhv7Y6nCiaWdsdW/o4HqTXHwydqJ5UvRx5ygIROPT9YyNgwbn+17Tkr05gHAuWS/S0tfeVgEmmJqJH0FQHYt6gZzTrGwulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500547; c=relaxed/simple;
	bh=uwia3rlf0Boz6lTCKVhiaHp/seSlsYrM6oyDDAO3RQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRgi4FKp+UbAO/WmEamheXDTX8kExR5NQTrbDniDN5xXVrlzXp5ZGAxatJ+xvGx/cVQAyA+Vbz0BkN4WpX1RGOfz9Ok45bmGfdvxa08Sh9pW5P/ewzFA98NIJrEVoWPSbfccrRerNLQql8XfvbYcEZOp3V+kvFBBFmgt5bz9qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vJo6Hoz/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jpLrsP5Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vJo6Hoz/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jpLrsP5Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 618DC75A8D;
	Mon, 11 May 2026 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778500543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzR/0cV+87qdDOowZhG+TluF31kQyuNXdGczJSJzyMs=;
	b=vJo6Hoz/NkP1JnlKZwLQ9lmaO2f8JqfEsIcxkRa0JSujx/8fkYfiUFvvoEe4BANAMa86PT
	VV1mP3D1SsLMyyNcKWvNZlOJyMU5xhFt/AbxZOX9kQzqv33oFlkbb+0nsDAhSG5MBqyOxl
	a/CDCcg9E+eQmZtI0NFH9JdrMlNfxPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778500543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzR/0cV+87qdDOowZhG+TluF31kQyuNXdGczJSJzyMs=;
	b=jpLrsP5QtEKkYHV6Zo7pAp/nC6KxKYyAR/MlRyVYTXAcgj40JOM+HkpN86OaPEm1+NJBM+
	YYd8UrZStegxcJDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778500543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzR/0cV+87qdDOowZhG+TluF31kQyuNXdGczJSJzyMs=;
	b=vJo6Hoz/NkP1JnlKZwLQ9lmaO2f8JqfEsIcxkRa0JSujx/8fkYfiUFvvoEe4BANAMa86PT
	VV1mP3D1SsLMyyNcKWvNZlOJyMU5xhFt/AbxZOX9kQzqv33oFlkbb+0nsDAhSG5MBqyOxl
	a/CDCcg9E+eQmZtI0NFH9JdrMlNfxPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778500543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzR/0cV+87qdDOowZhG+TluF31kQyuNXdGczJSJzyMs=;
	b=jpLrsP5QtEKkYHV6Zo7pAp/nC6KxKYyAR/MlRyVYTXAcgj40JOM+HkpN86OaPEm1+NJBM+
	YYd8UrZStegxcJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11DD4593A9;
	Mon, 11 May 2026 11:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOgaA7/DAWoERgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 11:55:43 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	m.szyprowski@samsung.com,
	wens@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] drm/exynos: fbdev: Remove offset into screen_buffer
Date: Mon, 11 May 2026 13:54:31 +0200
Message-ID: <20260511115538.57884-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511115538.57884-1-tzimmermann@suse.de>
References: <20260511115538.57884-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 48AEF50D370
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-245179-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[samsung.com,kernel.org,gmail.com,ffwll.ch];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim,infradead.org:email,samsung.com:email]
X-Rspamd-Action: no action

The screen_buffer field in struct fb_info contains the kernel address
of the first byte of framebuffer memory. Do not add the display offset.
This offset only describes scrolling during scanout.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 19c8b8343d9c ("drm/exynos: fixed overlay data updating.")
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.2+
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 637927818dfe..d283ded266d5 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -61,17 +61,13 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
 	struct fb_info *fbi = helper->info;
 	struct drm_framebuffer *fb = helper->fb;
 	unsigned int size = fb->width * fb->height * fb->format->cpp[0];
-	unsigned long offset;
 
 	fbi->fbops = &exynos_drm_fb_ops;
 
 	drm_fb_helper_fill_info(fbi, helper, sizes);
 
-	offset = fbi->var.xoffset * fb->format->cpp[0];
-	offset += fbi->var.yoffset * fb->pitches[0];
-
 	fbi->flags |= FBINFO_VIRTFB;
-	fbi->screen_buffer = exynos_gem->kvaddr + offset;
+	fbi->screen_buffer = exynos_gem->kvaddr;
 	fbi->screen_size = size;
 	fbi->fix.smem_len = size;
 
-- 
2.54.0


