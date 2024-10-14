Return-Path: <stable+bounces-83752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5099C470
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097D11C225B7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817D5155A5D;
	Mon, 14 Oct 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l+APxzGq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="09iJ4u/N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l+APxzGq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="09iJ4u/N"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B9154BE2
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896270; cv=none; b=OxipxfeAkv/13m831GhcbpYD5otfv/B5JwOHB5QQJ5KS91c3YFc5ZhvhBxTCS2N2mXYjk2H4ldtJhNfZWFnpXTWBJQ61lKoCtFCLu2+4sbXOADBCO7CzXsX45tZcYXmgR7TeHjBJL5PLH4Wm6VhLVqsjGgtuODs1goZLX8shCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896270; c=relaxed/simple;
	bh=k3nxD1M3EKPRQSvzoHBdbfY67rmOzqFO1LnK7ZHxDtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6Bh3TnkpYdJatK2aLNh5OBxPlZ11COYfAIcFLD1c8ilpILbuRWtvaIzC19KmKquH5PluInPC7TmZaAz9pVqJCtZAXPHrmZPeY1BBzIW6nXs2x5bsmEJ+QHxagWlyXDuIEa1C7PcsAbSekWXu98u1q47bxYx6ysV+IlY/qDqV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l+APxzGq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=09iJ4u/N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l+APxzGq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=09iJ4u/N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A010421C2B;
	Mon, 14 Oct 2024 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728896266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwCcgLz6S2p+8e6z9b1FWpbGjw0nwSTC12GpMVcwUJw=;
	b=l+APxzGqyOOOsFX6VZPsHUmQu5a/CZ2nkNAKQ6b2aAIVJLdbuiR4H8/AU8bKw9e4UTYnzp
	8CkRECyt169oea/L2CtleQlppqU3+n2GTSbcBLDNx1PbPU58RDWEdJNLnC1QzU2ZS14W7q
	hGArtfMeZ2++yP2BvF6q9dnYAeQ+Kk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728896266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwCcgLz6S2p+8e6z9b1FWpbGjw0nwSTC12GpMVcwUJw=;
	b=09iJ4u/Nbd2rzEgbtWfKm3gcFzxPuu7Vf0DaVVb5L8EpIGj9xYxxVyTGsi8+S1uDOBuEIy
	oRd+Ali8YCCyBcAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l+APxzGq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="09iJ4u/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728896266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwCcgLz6S2p+8e6z9b1FWpbGjw0nwSTC12GpMVcwUJw=;
	b=l+APxzGqyOOOsFX6VZPsHUmQu5a/CZ2nkNAKQ6b2aAIVJLdbuiR4H8/AU8bKw9e4UTYnzp
	8CkRECyt169oea/L2CtleQlppqU3+n2GTSbcBLDNx1PbPU58RDWEdJNLnC1QzU2ZS14W7q
	hGArtfMeZ2++yP2BvF6q9dnYAeQ+Kk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728896266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwCcgLz6S2p+8e6z9b1FWpbGjw0nwSTC12GpMVcwUJw=;
	b=09iJ4u/Nbd2rzEgbtWfKm3gcFzxPuu7Vf0DaVVb5L8EpIGj9xYxxVyTGsi8+S1uDOBuEIy
	oRd+Ali8YCCyBcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4643913A79;
	Mon, 14 Oct 2024 08:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sHTpDwrdDGfXfAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 14 Oct 2024 08:57:46 +0000
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
	stable@vger.kernel.org,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: [PATCH v4 03/12] drm/fbdev-dma: Select FB_DEFERRED_IO
Date: Mon, 14 Oct 2024 10:55:17 +0200
Message-ID: <20241014085740.582287-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014085740.582287-1-tzimmermann@suse.de>
References: <20241014085740.582287-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A010421C2B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,intel.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
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


