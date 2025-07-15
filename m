Return-Path: <stable+bounces-162998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7763B063C8
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE834E7E0D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767F22068F;
	Tue, 15 Jul 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="REeiq0BB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="atnnis1r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="REeiq0BB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="atnnis1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61826281
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595377; cv=none; b=t/b7PM4Y9uQxg8Ewe5ifSXljEDxGhf7DNpd48yqYsDhLa+NePTl+CtFNMiUQrzpCZBnhi4BsSoMlg7WDgXcOTHFNmya+WmYTKxQsu2ynilBjMHzj3fEu22/BtTyre9eRqAsyg8NW24G7Af6MtXJg/UKGXoY/y+CQiwpX7x/Vgko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595377; c=relaxed/simple;
	bh=/7fOD4/yqxpHOB4nN4m+nto9ixaajptdXsABGSvcPoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7Ojuw1LptYKm0nXflfbMrRyEdjWjWd/vCWYsM9rKCV6eXAu4BEC4STyBzxtkLrIEdNfbQNt5X+mo2i6oXnSumwtStXkUJ2l96um+mok89pmAx+Qk0CbqxBi+nIpn+l7PlzKTvPFvQoXJM36jPyaQAjAfWA2O69y9WMrJD39i3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=REeiq0BB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=atnnis1r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=REeiq0BB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=atnnis1r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 052DA1F7B7;
	Tue, 15 Jul 2025 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752595368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lM2AxVhwzSz8XJRM3Pr6J68laDEZWkWwoi6bKNHXkwo=;
	b=REeiq0BBpPCLrJsK2chNgCX7z9rrf7d5Zj4KkLsygs7zFoQ8PbGrtqBYSSY6pYCddBs9Tu
	vROEvEiWeomyqqi/sNfqYifzinOaprEmaH7ktFgJlP0MgjsOUjiWa9xZtdwNmQet0vCQGT
	mF1JJe+rLTHHPN/3aIqsUaLVumI1FZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752595368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lM2AxVhwzSz8XJRM3Pr6J68laDEZWkWwoi6bKNHXkwo=;
	b=atnnis1rNSUT5BG1srPcf1eF8bOmtu++hMjmrbPjb3JSSB/DMv2mvf6MzNhNXDY7HBtirX
	h7vfAH1gk6vp+jDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=REeiq0BB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=atnnis1r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752595368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lM2AxVhwzSz8XJRM3Pr6J68laDEZWkWwoi6bKNHXkwo=;
	b=REeiq0BBpPCLrJsK2chNgCX7z9rrf7d5Zj4KkLsygs7zFoQ8PbGrtqBYSSY6pYCddBs9Tu
	vROEvEiWeomyqqi/sNfqYifzinOaprEmaH7ktFgJlP0MgjsOUjiWa9xZtdwNmQet0vCQGT
	mF1JJe+rLTHHPN/3aIqsUaLVumI1FZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752595368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lM2AxVhwzSz8XJRM3Pr6J68laDEZWkWwoi6bKNHXkwo=;
	b=atnnis1rNSUT5BG1srPcf1eF8bOmtu++hMjmrbPjb3JSSB/DMv2mvf6MzNhNXDY7HBtirX
	h7vfAH1gk6vp+jDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E3A213A68;
	Tue, 15 Jul 2025 16:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sNWIGad7dmiFaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 16:02:47 +0000
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
Subject: [PATCH v3 6/7] Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
Date: Tue, 15 Jul 2025 17:58:16 +0200
Message-ID: <20250715155934.150656-7-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 052DA1F7B7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,amd.com,linux-foundation.org,linux.intel.com,kernel.org,pengutronix.de,armlinux.org.uk,redhat.com,collabora.com,chromium.org,broadcom.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[etnaviv];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLau4tukfh38qp3nirdnk14qe9)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.01

This reverts commit 1a148af06000e545e714fe3210af3d77ff903c11.

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
 drivers/gpu/drm/drm_gem_shmem_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8ac0b1fa5287..5d1349c34afd 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -351,7 +351,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 	dma_resv_assert_held(obj->resv);
 
 	if (drm_gem_is_imported(obj)) {
-		ret = dma_buf_vmap(obj->dma_buf, map);
+		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
@@ -413,7 +413,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 	dma_resv_assert_held(obj->resv);
 
 	if (drm_gem_is_imported(obj)) {
-		dma_buf_vunmap(obj->dma_buf, map);
+		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	} else {
 		dma_resv_assert_held(shmem->base.resv);
 
-- 
2.50.0


