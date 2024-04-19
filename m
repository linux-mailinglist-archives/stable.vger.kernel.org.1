Return-Path: <stable+bounces-40260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD98AAA4D
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208321C21F14
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526EA651B6;
	Fri, 19 Apr 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y2UJax0t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q+Sw9bjz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A654FBD;
	Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515621; cv=none; b=Xn/uu2hBnNbUT9dVjOIYG5DvUrEYYIWyQ9f57wPmsokpBx/6V6jPm8zbk3OubthkDgxY/awHBEItnMDDG4OsNnvxK0B8SSjcEgxdS668vIL6D+3rkvKOR1TlyKmggbxIZs0wUWygoQrLEcnvuzrwo/IZH2RSnGM2tLbp0dq0nZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515621; c=relaxed/simple;
	bh=yUTT/BsavEY92mydX2L4Md+rJ16mCVnB3JnE+Z1ZhYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyr2Qlu9bV1ybTVTscRDxqT3gQVfq7bLs6poKtUyJpP68reFPSqND7Sw8ChVdvak5w1XovuqlKpdp9iGSxfH6NMmR2aFYAfOAS5liU7OWWPuhj8J8ohDKokTzjeud2ARCJvTGU9WM5u9TPh0C9XYUgDvy3rJkX4Yk2oM4G3Q4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y2UJax0t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q+Sw9bjz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F5733757B;
	Fri, 19 Apr 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mq/lkQh4x3KA2MtCgwt0aXOtawttZvqhrviIfs7Oow=;
	b=y2UJax0tgcelybXaF7SLCGRGz166/mobyhcC6G89zXMDDI9ktW7MaqVG531snbDizMswpO
	1CkrxHc8PE3WcnmTKnNZ5/Ljy+S0X+VTxv6yT3/3gm2ghxp0WGNWfKEXNSQdLA0qwKUN6O
	I5dUD0CGUk5lgFwvEvtXWGPdAe8I1cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mq/lkQh4x3KA2MtCgwt0aXOtawttZvqhrviIfs7Oow=;
	b=Q+Sw9bjzIOxWGoEnwy7DbDvMrNg5YpHVlBMC2KuTqa04OGuAwJ2aRZo3sOrZ/l4j3V7iHc
	E9Sga0aBiIh+JDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FB931395B;
	Fri, 19 Apr 2024 08:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sEVNEmAsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Zack Rusin <zackr@vmware.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	stable@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v3 01/43] drm/fbdev-generic: Do not set physical framebuffer address
Date: Fri, 19 Apr 2024 10:28:54 +0200
Message-ID: <20240419083331.7761-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419083331.7761-1-tzimmermann@suse.de>
References: <20240419083331.7761-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 9F5733757B

Framebuffer memory is allocated via vzalloc() from non-contiguous
physical pages. The physical framebuffer start address is therefore
meaningless. Do not set it.

The value is not used within the kernel and only exported to userspace
on dedicated ARM configs. No functional change is expected.

v2:
- refer to vzalloc() in commit message (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: <stable@vger.kernel.org> # v6.4+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Tested-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_fbdev_generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index be357f926faec..97e579c33d84a 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -113,7 +113,6 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
 	/* screen */
 	info->flags |= FBINFO_VIRTFB | FBINFO_READS_FAST;
 	info->screen_buffer = screen_buffer;
-	info->fix.smem_start = page_to_phys(vmalloc_to_page(info->screen_buffer));
 	info->fix.smem_len = screen_size;
 
 	/* deferred I/O */
-- 
2.44.0


