Return-Path: <stable+bounces-242519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHqeCWoQ9WnIHwIAu9opvQ
	(envelope-from <stable+bounces-242519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:43:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F934AF8FD
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCC630179C6
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA342316D;
	Fri,  1 May 2026 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv7jRP8B"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B13421F1C
	for <stable@vger.kernel.org>; Fri,  1 May 2026 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777668197; cv=none; b=JQLjT+pIt32roHykHjFTYIulIdHhGLJX44DvDoDJ9PmBZt2jLuJFbRsVoxdcNfaST321oxGTq4ZUtgXvR/IZgsyo8OPY/eHuKdCK1PR8o2JOAa5QB3Q9Q8cruuQNB8zry9QJKE0fCeYpxeAlMN6c9cnmupiueMaeXYRsNw/k6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777668197; c=relaxed/simple;
	bh=vj1ylhChRhwpjQEiIxInW6WD3r3rx3cmjVsbBB+sdmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwFBV+9klNjh8+onZpw2l4Cza6kaFCDNtFU5vsozKJXg2gZ1n7cpueJKmyGjtDVd+lAL6zizYtQ7jw5Rcs/vQ2Mx/13Qu8jH2n9RoMgcxIwuunHlf/omtnnobUFbyavJ71evnOnRGXTjc3a9/eKBcTjNVly6MIx0xUn0tsdUKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv7jRP8B; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso34096646d6.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777668195; x=1778272995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5E1HOqyqOzDx9CBzmKmUlb5e5nYghOLHEYeoL69u9Y=;
        b=iv7jRP8BBnScCTRsBux7400E1uE9wPRxLQQLaaoE1/XN9GSl1Q2upUz+bOki0dMzuZ
         dA4PccPdVmo/PjA6kzcOuWGMLNKprT78VYYxWtvmNJ0nL3mkkCyPKizGMvzPlBuMjlOh
         hF7qasx0hWlLra74+7hOwGQ2CeXLLm1iOQ+xyrT49BJAsfQTU9JkduTchD507cfAQVbl
         5Ik7VMjLHO5MRDWwxF2Cr1TmsmZF6J64+pfe/lROBgI18hAvNGGq9Qdgf6cLVGWQ7Qgr
         pV5WhR6hM6JiPMfq9RhyoXj59RV+tNsiAFQ/64fpDYUvBiyl8/P1kJlNJaV7dydk7YcA
         JdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777668195; x=1778272995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5E1HOqyqOzDx9CBzmKmUlb5e5nYghOLHEYeoL69u9Y=;
        b=mXB47xPExxMCE9lTvZEdrB+V6R/eG1VT/jlnrPoXKwW4uaHrddNl6J+fvMV689z+TH
         jpr6qRtfI3V6ANis+vOnP812P7gpIbBJWWE7iQhD54qqYhYDf5XsP3H5Jct3v2lVydNK
         cQP4YdZcZIuRl+n+MlONqvYS5GfwYRi6eVyX6UYa0lkRTrpLPUgr5UCgGDpxZ31/hyV+
         RVPZxmCc7hKna0GNMcL4BTlmKNjSterGG7ubgrmPkpEz8N5N1t+e+NNawBZ5C7+VtrMx
         80U+D0CTMK96Jih0sFxYIsknk2/s39yKFv3EJ51MKzaiHkZs4WpQI27Zl1dkwpcojs1I
         /rYw==
X-Forwarded-Encrypted: i=1; AFNElJ9r30PXw8t7/iTRhiNdrnp52p8Y9HeGwclTD8Ci47MMU7HidncL+nRwk2dKonz15oYa8oILQPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUq6H1k+w5pEX/7UfFoNHEzvrMsHMQZe5+c2zPKrWbTQuh1cOV
	PwAJHcf9lyBcdpH7GRdZJODs9iafWm6MlA1GmodyAI1ea+ee+EpLm+aB
X-Gm-Gg: AeBDievcbgt8qwW3ajoga+HyGiPhdSUIKA8BZAI64Rogj0CgZFzHVVr2YIGx1DDj+cL
	pi4nxCU8wI8nB79xjbsHYVuNdV9k38KvqQtobAGKJznTpBt/at2FH4lJFBOj7NDgA866jR40Rbc
	SGLZLZVh+4ytuPHh41gCOH1E6qtuF7TwQF+XS+FjvBUXpDf4zTxurkardONyj3VeWsdvmqm+YEu
	+lytEl0nL5HPQ+CLCbPfbJTcHHAWzEAEV74W2eN5JWMVr90qJ38O/XkxNB2iQDbe5juEXqxwM1w
	mnc7R6DVhRwjiOAtT2qHCDlyEODA7s/06qNSdm7w5udVZdgZBz9fJ1Y9q1t3cEsZS/Bh+BYb5IZ
	FRdNLBEWN+PYZ9AeF14Q01Nms9XZ73Myg/hN+1+PxuEIZ1RhR7KN/cOcuiJDCZbTxXCZyHYikAG
	FkLcnvjcwdCiE6BMsZj06qSIAqoNW3+OtZDJEGjed+jfNyF5vVM0Of+x9VwKGK1X8+B5Y=
X-Received: by 2002:a0c:f10c:0:b0:89c:de0e:263b with SMTP id 6a1803df08f44-8b6694eb760mr15323986d6.42.1777668195439;
        Fri, 01 May 2026 13:43:15 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5390ec38asm33730096d6.11.2026.05.01.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:43:14 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mike Marciniszyn <mmarcini@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/fbdev-helper: Fix deletion of stub for drm_fb_helper_gem_is_fb()
Date: Fri,  1 May 2026 16:43:13 -0400
Message-ID: <20260501204313.127616-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77F934AF8FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242519-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,amd.com,redhat.com,lunn.ch];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]

From: Mike Marciniszyn <mmarcini@meta.com>

When CONFIG_DRM_FBDEV_EMULATION  is not defined this error results
when building amdgpu_display.c with CONFIG_DRM_AMDGPU:

error: call to undeclared function 'drm_fb_helper_gem_is_fb'; ISO C99 and
later do not support implicit function
declarations [-Wimplicit-function-declaration]

 1777 |  if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {

Cc: stable@vger.kernel.org
Signed-off-by: Mike Marciniszyn <mmarcini@meta.com>
---
 include/drm/drm_fb_helper.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index bf391903443d..7f9ad421af3f 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -273,6 +273,13 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
 int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
 bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
 			     const struct drm_gem_object *obj);
+#else
+static inline bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
+					   const struct drm_gem_object *obj)
+{
+	return false;
+}
+
 #endif

 #endif
--
2.43.0


