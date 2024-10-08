Return-Path: <stable+bounces-81595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957C0994810
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B16B25CC5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0B61D90A9;
	Tue,  8 Oct 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VnOIH8iq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v6CvucHF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VnOIH8iq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v6CvucHF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F6320F
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389220; cv=none; b=UMfnQviOyWI9t2bSCqgEnPw2+LlYJFhZY9BrvphK3jE1GxuJ7nO9J+eMULqQmKod3Z9DtWKsWNrBCIfP5kfUyZiWEpCDuVidyNGcni3FkTHx0a9rprGVWZq5ud9mQapUI1/4RS7nFls+pcmm4bMlcAt+M49Gu/7Rh87dicf0JQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389220; c=relaxed/simple;
	bh=cDRBoARuMeT4IUbabQzv+bDboMR4/JIK34pzzs3squQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EE1OH42JfX7bjmMPyPQ42bEWABpXtE79pVvQ2EJyrAEEnjz/09yzDrEOYkfksUvyc5AeUwiE12OfS2xksKNTFUzykL8vJhUYkQQsAyD5ZdYffldyRTMj21LsCs12cE6LbumEsOPSaCSEfgr/i4lKAdypH1Dtxgp02/EOIWKzGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VnOIH8iq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v6CvucHF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VnOIH8iq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v6CvucHF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 595AF21B48;
	Tue,  8 Oct 2024 12:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728389217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23PGrB8uzAtWDgANn2M7nbKmJLyaCxszDckzcfp1teg=;
	b=VnOIH8iqgSgccoUW9cyOxLE3k9DUJ28OUcGr8u7+qcD0IyZIkrbZ7hFpbYvILUvTXKIRju
	lwEqwITllQ3TOw/wV4HfyqJBpIcv/yYSsROFJNu4Axrpwe9pyR9UTMO7359fzyJn9TXYCk
	oQ9GO+2EFM6urHVDKpJV/n14SvH+eA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728389217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23PGrB8uzAtWDgANn2M7nbKmJLyaCxszDckzcfp1teg=;
	b=v6CvucHF+xv0EHSIKDzbvYGfKg+tuyiQ+iJH7s5ibXiMxvGobQNCPCRn8PUOvSnicPGKv8
	7lu2q8eowuO/TVBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728389217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23PGrB8uzAtWDgANn2M7nbKmJLyaCxszDckzcfp1teg=;
	b=VnOIH8iqgSgccoUW9cyOxLE3k9DUJ28OUcGr8u7+qcD0IyZIkrbZ7hFpbYvILUvTXKIRju
	lwEqwITllQ3TOw/wV4HfyqJBpIcv/yYSsROFJNu4Axrpwe9pyR9UTMO7359fzyJn9TXYCk
	oQ9GO+2EFM6urHVDKpJV/n14SvH+eA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728389217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23PGrB8uzAtWDgANn2M7nbKmJLyaCxszDckzcfp1teg=;
	b=v6CvucHF+xv0EHSIKDzbvYGfKg+tuyiQ+iJH7s5ibXiMxvGobQNCPCRn8PUOvSnicPGKv8
	7lu2q8eowuO/TVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE6BE13AA0;
	Tue,  8 Oct 2024 12:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MIDQH2AgBWcCbgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 08 Oct 2024 12:06:56 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	airlied@gmail.com,
	javierm@redhat.com,
	jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	kernel test robot <lkp@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 03/12] drm/fbdev-dma: Select FB_DEFERRED_IO
Date: Tue,  8 Oct 2024 13:59:22 +0200
Message-ID: <20241008120652.159190-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008120652.159190-1-tzimmermann@suse.de>
References: <20241008120652.159190-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Commit 808a40b69468 ("drm/fbdev-dma: Implement damage handling and
deferred I/O") added deferred I/O for fbdev-dma. Also select the
Kconfig symbol FB_DEFERRED_IO (via FB_DMAMEM_HELPERS_DEFERRED). Fixes
build errors about missing fbdefio, such as

drivers/gpu/drm/drm_fbdev_dma.c:218:26: error: 'struct drm_fb_helper' has no member named 'fbdefio'
  218 |                 fb_helper->fbdefio.delay = HZ / 20;
      |                          ^~
drivers/gpu/drm/drm_fbdev_dma.c:219:26: error: 'struct drm_fb_helper' has no member named 'fbdefio'
  219 |                 fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
      |                          ^~
drivers/gpu/drm/drm_fbdev_dma.c:221:21: error: 'struct fb_info' has no member named 'fbdefio'
  221 |                 info->fbdefio = &fb_helper->fbdefio;
      |                     ^~
drivers/gpu/drm/drm_fbdev_dma.c:221:43: error: 'struct drm_fb_helper' has no member named 'fbdefio'
  221 |                 info->fbdefio = &fb_helper->fbdefio;
      |                                           ^~

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410050241.Mox9QRjP-lkp@intel.com/
Fixes: 808a40b69468 ("drm/fbdev-dma: Implement damage handling and deferred I/O")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: <stable@vger.kernel.org> # v6.11+
---
 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1df4e627e3d3..db2e206a117c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -338,7 +338,7 @@ config DRM_TTM_HELPER
 config DRM_GEM_DMA_HELPER
 	tristate
 	depends on DRM
-	select FB_DMAMEM_HELPERS if DRM_FBDEV_EMULATION
+	select FB_DMAMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  Choose this if you need the GEM DMA helper functions
 
-- 
2.46.0


