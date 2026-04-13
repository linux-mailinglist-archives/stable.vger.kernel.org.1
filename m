Return-Path: <stable+bounces-235964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIydBK2u3GnfVAkAu9opvQ
	(envelope-from <stable+bounces-235964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:51:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B91CD3E95F5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F1993027362
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7763AD53E;
	Mon, 13 Apr 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2USwD/Aj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HBtmxuIE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2USwD/Aj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HBtmxuIE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9773AC0E7
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070246; cv=none; b=Eovd6mMkrFB1pJR4KYhTq8slex27dHRsFiVbuVMpz+3yeVXR7JtH+0EQNgZ9ZqA+KXRadk+pXBXDkOcjq/VYqd5dZIclbd6yLiIb3F8VeGCsxWjv9JPUvmgZQt1lTYKLYpEa+cggpY+EKiTWQ6ReBQHlTdtbT4DRbE6yeePesrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070246; c=relaxed/simple;
	bh=+8zVc7XeCmEWCG9iS/1CHIBIFysf8UoUorNJE+/jk3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkMZZ+syd8cmQJJrroTPmq5Ril9xI2iKmaPUK2JyZY1g+sFXSAL6LjJZ6ybPWRxw8snPMS9Hq8IxokywkUoiZndGMKV0Ho0rARZBF9x/Jh6r/u2h+V+OOcUn++JRi61CNkj/Rdek14BPMRKIuamT56Zn4sF5LqlPrvJ921O3uAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2USwD/Aj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HBtmxuIE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2USwD/Aj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HBtmxuIE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C1555BE58;
	Mon, 13 Apr 2026 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776070243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGwd68U7oimqTpcMpaDZUodLNkki910FwX/D8rzBTVA=;
	b=2USwD/Ajd0NM724jWYI+Ku8guMhqcsfx5D0Tg+9Br/r55aKYafifaij3fH3abrtGhYqH+9
	HLu9pRMMoN8mldXze6YsAVOxKgnnaZfSgm10kjilYQIwIOjhFM4jNmfLrGrz0YHob2Tykx
	QsJmssObAL0E6xi9RESjmv0XXRw3p7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776070243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGwd68U7oimqTpcMpaDZUodLNkki910FwX/D8rzBTVA=;
	b=HBtmxuIEbJGZWGoy3BBw5nwWB77Pn16fE5fOkJwcW+G1Vj3dhYIxJn3/Rys9iu3y4PVH35
	Ibnxb4AUuzWJ0pCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776070243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGwd68U7oimqTpcMpaDZUodLNkki910FwX/D8rzBTVA=;
	b=2USwD/Ajd0NM724jWYI+Ku8guMhqcsfx5D0Tg+9Br/r55aKYafifaij3fH3abrtGhYqH+9
	HLu9pRMMoN8mldXze6YsAVOxKgnnaZfSgm10kjilYQIwIOjhFM4jNmfLrGrz0YHob2Tykx
	QsJmssObAL0E6xi9RESjmv0XXRw3p7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776070243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGwd68U7oimqTpcMpaDZUodLNkki910FwX/D8rzBTVA=;
	b=HBtmxuIEbJGZWGoy3BBw5nwWB77Pn16fE5fOkJwcW+G1Vj3dhYIxJn3/Rys9iu3y4PVH35
	Ibnxb4AUuzWJ0pCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90B664ADCF;
	Mon, 13 Apr 2026 08:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4AslIWKu3GkfKAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 13 Apr 2026 08:50:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: xinliang.liu@linaro.org,
	tiantao6@hisilicon.com,
	kong.kongxinwei@hisilicon.com,
	sumit.semwal@linaro.org,
	yongqin.liu@linaro.org,
	jstultz@google.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rongrong Zou <zourongrong@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Yongbang Shi <shiyongbang@huawei.com>,
	Baihan Li <libaihan@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] drm/hibmc: Fix list of formats on the primary plane
Date: Mon, 13 Apr 2026 10:40:02 +0200
Message-ID: <20260413085037.17491-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413085037.17491-1-tzimmermann@suse.de>
References: <20260413085037.17491-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,suse.de,gmail.com,chromium.org,kernel.org,huawei.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235964-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,chromium.org:email]
X-Rspamd-Queue-Id: B91CD3E95F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove all formats from the primary plane that are unsupported for
various reasons.

* Formats with alpha channel: planes should not announce alpha channels
unless they support transparency. There's no transparency support in
the primary plane's implementation.

* Formats with BGR order. The common format is in RGB channel order.
There's no BGR support in the primary plane's implementation.

* RGB888: atomic_update programs the format from cpp[0] * 8 / 16. For
RGB888's cpp value of 3 this returns 1.5; rounded to 1. Programming
the value of 1 to HIBMC_CRT_DISP_CTL_FORMAT sets up RGB565. Hence, the
output is distorted. This can be tested by booting with video=1024x768-24.

Removing all unsupported formats leaves XRGB8888 and RGB565. Both of
which are supported and work correctly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Yongbang Shi <shiyongbang@huawei.com>
Cc: Baihan Li <libaihan@huawei.com>
Cc: <stable@vger.kernel.org> # v4.10+
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 8fa2a95bcdd1..c4f9ebd9250d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -118,10 +118,8 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
 }
 
 static const u32 channel_formats1[] = {
-	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
-	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_ABGR8888
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_RGB565,
 };
 
 static const struct drm_plane_funcs hibmc_plane_funcs = {
-- 
2.53.0


