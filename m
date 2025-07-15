Return-Path: <stable+bounces-162997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37301B063BD
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83828581691
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72A245038;
	Tue, 15 Jul 2025 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JGLxR8MR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qWMAUg0b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JGLxR8MR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qWMAUg0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F261EA7D2
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595370; cv=none; b=L8rgKcnlOlZM3978yozr+NjIBuSS+JMaV+/TMsWIwOofgyn7oB5vKHQByMGimiDDvI8KdnrjUPSCpi8Yz+mz0moQLtB5e65g1YxUVUi5b1oj7ngeSCcOs62ECHLgRk4NFHgnsveC0JiphcFYJZ7gAFgJB0m7UqP8T32XzUCnAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595370; c=relaxed/simple;
	bh=kR/pSQvUnSIDPIlu7vjFNbOirz7yWE1VaFZ//eJCvcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAhtTYKdPO6RVItmqio3LiVNzCxty0qKm9Pdqo2oSde+6shgr1S7ZRmdJgqKy8szg4ymJn9xXkj0vHM8zxfLpDFTIXeRl3MKC7jmNIr7yO+uXiER16tBtjsriCFjEcAnOU3xZV3qpY39GPzrwNbnJcKGx7RfuxRSiBoEKdyuD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JGLxR8MR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qWMAUg0b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JGLxR8MR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qWMAUg0b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 670252119A;
	Tue, 15 Jul 2025 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752595367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfYjzuoxmyYeg6JjBAYw8VrD5CmAOs+t8N63zQx23+E=;
	b=JGLxR8MRJgnQbYq+YTrtsf7IkbYIeTF15u3/o3/xSIM3S+mARhDtemYXX4YQLnjxT3SI2r
	i2OWsBItrP8RnI3Y3oZbtk8Tr+eSL8lDbqZZE6ozsjt96lnKTsnDUSQQffFtT2tAxhcnV0
	N1LNMVPe21Z1YqBccSuAQsMr+kchadQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752595367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfYjzuoxmyYeg6JjBAYw8VrD5CmAOs+t8N63zQx23+E=;
	b=qWMAUg0b+eiGkAWFWj4s9bdcdJD+o8XWj/0JqE5oq2PK3gvt0dREnljsC/dGEX78CvQyRv
	vLbvvwlnkJtBK8AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JGLxR8MR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qWMAUg0b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752595367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfYjzuoxmyYeg6JjBAYw8VrD5CmAOs+t8N63zQx23+E=;
	b=JGLxR8MRJgnQbYq+YTrtsf7IkbYIeTF15u3/o3/xSIM3S+mARhDtemYXX4YQLnjxT3SI2r
	i2OWsBItrP8RnI3Y3oZbtk8Tr+eSL8lDbqZZE6ozsjt96lnKTsnDUSQQffFtT2tAxhcnV0
	N1LNMVPe21Z1YqBccSuAQsMr+kchadQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752595367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfYjzuoxmyYeg6JjBAYw8VrD5CmAOs+t8N63zQx23+E=;
	b=qWMAUg0b+eiGkAWFWj4s9bdcdJD+o8XWj/0JqE5oq2PK3gvt0dREnljsC/dGEX78CvQyRv
	vLbvvwlnkJtBK8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD5413A6C;
	Tue, 15 Jul 2025 16:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gDHrMKZ7dmiFaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 16:02:46 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	airlied@gmail.com,
	christian.koenig@amd.com,
	torvalds@linux-foundation.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	l.stach@pengutronix.de,
	linux+etnaviv@armlinux.org.uk,
	kraxel@redhat.com,
	christian.gmeiner@gmail.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	stable@vger.kernel.org
Subject: [PATCH v3 5/7] Revert "drm/gem-framebuffer: Use dma_buf from GEM object instance"
Date: Tue, 15 Jul 2025 17:58:15 +0200
Message-ID: <20250715155934.150656-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715155934.150656-1-tzimmermann@suse.de>
References: <20250715155934.150656-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,amd.com,linux-foundation.org,linux.intel.com,kernel.org,pengutronix.de,armlinux.org.uk,redhat.com,collabora.com,chromium.org,broadcom.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[etnaviv];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLau4tukfh38qp3nirdnk14qe9)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 670252119A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

This reverts commit cce16fcd7446dcff7480cd9d2b6417075ed81065.

The dma_buf field in struct drm_gem_object is not stable over the
object instance's lifetime. The field becomes NULL when user space
releases the final GEM handle on the buffer object. This resulted
in a NULL-pointer deref.

Workarounds in commit 5307dce878d4 ("drm/gem: Acquire references on
GEM handles for framebuffers") and commit f6bfc9afc751 ("drm/framebuffer:
Acquire internal references on GEM handles") only solved the problem
partially. They especially don't work for buffer objects without a DRM
framebuffer associated.

Hence, this revert to going back to using .import_attach->dmabuf.

v3:
- cc stable

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Acked-by: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org> # v6.15+
---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 618ce725cd75..fefb2a0f6b40 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -420,6 +420,7 @@ EXPORT_SYMBOL(drm_gem_fb_vunmap);
 static void __drm_gem_fb_end_cpu_access(struct drm_framebuffer *fb, enum dma_data_direction dir,
 					unsigned int num_planes)
 {
+	struct dma_buf_attachment *import_attach;
 	struct drm_gem_object *obj;
 	int ret;
 
@@ -428,9 +429,10 @@ static void __drm_gem_fb_end_cpu_access(struct drm_framebuffer *fb, enum dma_dat
 		obj = drm_gem_fb_get_obj(fb, num_planes);
 		if (!obj)
 			continue;
+		import_attach = obj->import_attach;
 		if (!drm_gem_is_imported(obj))
 			continue;
-		ret = dma_buf_end_cpu_access(obj->dma_buf, dir);
+		ret = dma_buf_end_cpu_access(import_attach->dmabuf, dir);
 		if (ret)
 			drm_err(fb->dev, "dma_buf_end_cpu_access(%u, %d) failed: %d\n",
 				ret, num_planes, dir);
@@ -453,6 +455,7 @@ static void __drm_gem_fb_end_cpu_access(struct drm_framebuffer *fb, enum dma_dat
  */
 int drm_gem_fb_begin_cpu_access(struct drm_framebuffer *fb, enum dma_data_direction dir)
 {
+	struct dma_buf_attachment *import_attach;
 	struct drm_gem_object *obj;
 	unsigned int i;
 	int ret;
@@ -463,9 +466,10 @@ int drm_gem_fb_begin_cpu_access(struct drm_framebuffer *fb, enum dma_data_direct
 			ret = -EINVAL;
 			goto err___drm_gem_fb_end_cpu_access;
 		}
+		import_attach = obj->import_attach;
 		if (!drm_gem_is_imported(obj))
 			continue;
-		ret = dma_buf_begin_cpu_access(obj->dma_buf, dir);
+		ret = dma_buf_begin_cpu_access(import_attach->dmabuf, dir);
 		if (ret)
 			goto err___drm_gem_fb_end_cpu_access;
 	}
-- 
2.50.0


