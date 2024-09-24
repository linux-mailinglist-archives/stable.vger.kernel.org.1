Return-Path: <stable+bounces-76967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F769840C7
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BCC1F22114
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02014F10F;
	Tue, 24 Sep 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fuWmuzzr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iG8F2L+6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m+SbjWVk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aprqwMmQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB014EC4A
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167357; cv=none; b=peCvgzrcxiJLu3/7iJTpHGeYYS2z15Jm9wAxDCVp1JQ2cXs1qXgylzSc29cwizSjbDyKJtZs2pUlkua2VRMEYoxodfWH3m9VU9nEXRmZJPX5v7+/1T+2mR18xc8gchadBYIOH3+3xG/vTVR1+xYj8j2Vkmsa71x2pMuOl2ylSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167357; c=relaxed/simple;
	bh=mJYtW+0KNxbdsxhua6gg7Ubk2AzkcfDJxEpAXIkpUuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwtsYvT5YzuEPc5Cl+mPjdMuYu/iYG2s534ZHkaMNXaDY6SqvcJooMrTXTvbp7WXZo0plJsAbyDc50WalmJsXkf2ryVzA8DjQ9Qh2vGy+5xFwYX41zlE03Muk/1E5XM0A/T394LITxMtv2iTA3uAgratSA/lu5TPUcvvG/xbyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fuWmuzzr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iG8F2L+6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m+SbjWVk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aprqwMmQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B84721BBC;
	Tue, 24 Sep 2024 08:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727167353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jq1ZSekyMg3r/5R/q9kgdjIL9cU1H9bO/eAhO1BJS8k=;
	b=fuWmuzzreCquePvWvUOnjY20YwN2vpU5TGih956hmQ47qDrxYI3dOeNNKrfZ/Qicwv/6bj
	ZqjzUT71vJWRv30qQBQWRA/Mro5QnxLJO1bd9IKecaYM3iL4JQG0AR0HaDrKron+Ct/znn
	ti6oFMON1iHT2GffxqiTqDX+2QNFPeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727167353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jq1ZSekyMg3r/5R/q9kgdjIL9cU1H9bO/eAhO1BJS8k=;
	b=iG8F2L+6NbVIUufp5mX/uu34tnqOtRz4T5wQBwXsAb2r1zjve2LrEX/gINs0hJFdT5VE7K
	tCIC1CoNqIaRiPBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727167352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jq1ZSekyMg3r/5R/q9kgdjIL9cU1H9bO/eAhO1BJS8k=;
	b=m+SbjWVkqiBzyHYwxl/Qo+oKaokaTs0PtmFcNQQXBpLlCDvxL9ug3imMTMUx0GryVOraqM
	TMqDpZp5a+qA5BzzcX5qGkf6+yuFXp1oXvtahq48+8KWDr6jFWQzzmqCTZ3gc6pMdTn0Ln
	0fNnp9/D68mO7xyYj/9kQpNpQgQarGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727167352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jq1ZSekyMg3r/5R/q9kgdjIL9cU1H9bO/eAhO1BJS8k=;
	b=aprqwMmQ2vlCX5GNE3eM1+8XRuRUae9dVSxWzCVJQxA/tFqXI/0XbhLf8Rqokw5ThQIUby
	vz5DFo2jHhahFbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 055F01386E;
	Tue, 24 Sep 2024 08:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nAgmO3d78mYsewAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Sep 2024 08:42:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	alexander.deucher@amd.com,
	chaitanya.kumar.borah@intel.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	stable@vger.kernel.org
Subject: [PATCH] firmware/sysfb: Disable sysfb for firmware buffers with unknown parent
Date: Tue, 24 Sep 2024 10:41:03 +0200
Message-ID: <20240924084227.262271-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,suse.de,gmx.de,ravnborg.org,ffwll.ch,leemhuis.info,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Level: 

The sysfb framebuffer handling only operates on graphics devices
that provide the system's firmware framebuffer. If that device is
not known, assume that any graphics device has been initialized by
firmware.

Fixes a problem on i915 where sysfb does not release the firmware
framebuffer after the native graphics driver loaded.

Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/dri-devel/SJ1PR11MB6129EFB8CE63D1EF6D932F94B96F2@SJ1PR11MB6129.namprd11.prod.outlook.com/
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12160
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: b49420d6a1ae ("video/aperture: optionally match the device in sysfb_disable()")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
Cc: <stable@vger.kernel.org> # v6.11+
---
 drivers/firmware/sysfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 02a07d3d0d40..a3df782fa687 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -67,9 +67,11 @@ static bool sysfb_unregister(void)
 void sysfb_disable(struct device *dev)
 {
 	struct screen_info *si = &screen_info;
+	struct device *parent;
 
 	mutex_lock(&disable_lock);
-	if (!dev || dev == sysfb_parent_dev(si)) {
+	parent = sysfb_parent_dev(si);
+	if (!dev || !parent || dev == parent) {
 		sysfb_unregister();
 		disabled = true;
 	}
-- 
2.46.0


