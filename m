Return-Path: <stable+bounces-267055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3jtgCZixM2qVFAYAu9opvQ
	(envelope-from <stable+bounces-267055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:51:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC469E9A7
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:51:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lygreDiy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BsTbgjrr;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lygreDiy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BsTbgjrr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267055-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267055-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B76D300F608
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24B73B3895;
	Thu, 18 Jun 2026 08:43:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29039E175
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772221; cv=none; b=CNEpYMrfHWffwgl7KFna5IN8C4YXgNm1y5y7nEK8bDVBI/07Ra7Y069sX6n5zgqGx6981GzN40tm7kQhPEkZA8iB8zw5D8YVjVi4SdD0WfMcHed8lWntqctZBCLsuI4i7F2vmqLAl4sJ5ZZqaQjbzQsgJmf+6FYsRu7VZtYOvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772221; c=relaxed/simple;
	bh=jIubFMu4gnwA4D1vFfzREWI19E2lrBN0ETx2qxV+gbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBkHMqZlNJ12Znv/6CdGyw0oPy5zH6TUSOqxSkHGHskZd5NRRIofjOLOTgYUHisGyb6uQ+tafZ7IhKGwtj4M32zUOmXpjieDsVGKyBBH3vqXFMwR4QjhMFlY9Sb7K5bsOIjoOiZfDu58d+Hq1oO8DzE2opJC/s6zpYaYuSMlims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lygreDiy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BsTbgjrr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lygreDiy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BsTbgjrr; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3792175EE5;
	Thu, 18 Jun 2026 08:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781772213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJEldl8us0bMrqKR0SkZjeCHFhLfEtvx/KYBtRZ8xY=;
	b=lygreDiyVwOoCmF97Qbw+pOUZrrULwHag8/EknnwTTwzAU9p0a6aUABQ4udA3UKLCztyJ1
	JB/KDItBPQ37+tSYMrP0ioGkMP33vnCgRFONAGFx8Jq7181irYktpWCwNnAm+KI4GR6TFQ
	P5BGZe6w5jt7YNU8YVj0FZf65KBfK4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781772213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJEldl8us0bMrqKR0SkZjeCHFhLfEtvx/KYBtRZ8xY=;
	b=BsTbgjrriOWJDl/ABLO54B4coz+faCqS8ZNjCmONSrC0i/3oPc6GkP/W6hXw1tOV1wqd7r
	JEM89RlFbuvVAqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781772213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJEldl8us0bMrqKR0SkZjeCHFhLfEtvx/KYBtRZ8xY=;
	b=lygreDiyVwOoCmF97Qbw+pOUZrrULwHag8/EknnwTTwzAU9p0a6aUABQ4udA3UKLCztyJ1
	JB/KDItBPQ37+tSYMrP0ioGkMP33vnCgRFONAGFx8Jq7181irYktpWCwNnAm+KI4GR6TFQ
	P5BGZe6w5jt7YNU8YVj0FZf65KBfK4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781772213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJEldl8us0bMrqKR0SkZjeCHFhLfEtvx/KYBtRZ8xY=;
	b=BsTbgjrriOWJDl/ABLO54B4coz+faCqS8ZNjCmONSrC0i/3oPc6GkP/W6hXw1tOV1wqd7r
	JEM89RlFbuvVAqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E09F3779A8;
	Thu, 18 Jun 2026 08:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2FqhNbSvM2pAPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 18 Jun 2026 08:43:32 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm/sysfb: Avoid possible truncation with calculating visible size
Date: Thu, 18 Jun 2026 10:41:58 +0200
Message-ID: <20260618084327.46567-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618084327.46567-1-tzimmermann@suse.de>
References: <20260618084327.46567-1-tzimmermann@suse.de>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267055-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:javierm@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:sashiko-reviews@lists.linux.dev,m:tzimmermann@suse.de,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22BC469E9A7

Calculating the visible size of the system framebuffer can result in
truncation of the result. The calculation uses 32-bit arithmetics,
which can overflow if the values for height and stride are large. Fix
the issue by multiplying with mul_u32_u32().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260617114027.1F2A71F000E9@smtp.kernel.org/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
I've added Reported-by and Closes tags because this is a pre-existing issue.
---
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
index 361b7233600c..8b14eaa304c0 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -2,6 +2,7 @@
 
 #include <linux/export.h>
 #include <linux/limits.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/screen_info.h>
 
@@ -67,7 +68,7 @@ EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size)
 {
-	u64 vsize = height * stride;
+	u64 vsize = mul_u32_u32(height, stride);
 
 	return drm_sysfb_get_validated_size0(dev, "visible size", vsize, size);
 }
-- 
2.54.0


