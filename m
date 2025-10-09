Return-Path: <stable+bounces-183692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E219CBC9084
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014364FC3A6
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCC2E764C;
	Thu,  9 Oct 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJR/roUI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C22E62DA
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013038; cv=none; b=UX2IrgSR/Md7FXOqUqR7seAMhXIrbUcgndjxBX4HJvTwAioVp8C/5n+wauXK0GrZpSzFEpTEx4dhg1RxrMAvCFgDUtk7agk+s0R9lROSxjEpLtVCVNbMwluKOCklNF5OzO+xrQ9DfN5e9wcAOyp9bsJpnF7XR2M63xl9KbFCqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013038; c=relaxed/simple;
	bh=ahnJZzshkbAzztwY8DP7LLZVcRRjoHIOwAzHXcWnWu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tH8QC+Qcsrz4SAtZFvgqG1OvnrYeaI2wW5ruEa4SXdyiopnSNufcnCWQzNFX+8vnt8fqySkCk7vutVfSmQyacpZ6PvvsliSm8MQ7kMaRimqcXZyi2IUAg3Q08x5QugbyFftqUzO9WPGP3jfubu2xzzxJTB4+wO+wPLR91ZOBAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJR/roUI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760013035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVnWA8siyJ1iu9LLrS4EF3aim8A6hSTw9/7vlialzfo=;
	b=MJR/roUIHhe1vFpraGVpq6w7CjsqXkCoM4lNhIqQUn8DXRnTAH1CyyEnjmC8SyLdXhl56B
	U3STLziwHbydvhnJVUnb36Kkph1Th7Urs6A8p2e9hetcNjszt7pCtbEWuWOgLLgkY6BG+d
	mi199hXSLM2YxRUqZf884DpL4GWEgik=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-UkBmwH_WPS27Jk6hPxG6Gg-1; Thu,
 09 Oct 2025 08:30:31 -0400
X-MC-Unique: UkBmwH_WPS27Jk6hPxG6Gg-1
X-Mimecast-MFC-AGG-ID: UkBmwH_WPS27Jk6hPxG6Gg_1760013030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DE1B19560AA;
	Thu,  9 Oct 2025 12:30:30 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC178180035E;
	Thu,  9 Oct 2025 12:30:26 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4/6] drm/panic: Fix kmsg text drawing rectangle
Date: Thu,  9 Oct 2025 14:24:51 +0200
Message-ID: <20251009122955.562888-5-jfalempe@redhat.com>
In-Reply-To: <20251009122955.562888-1-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The rectangle height was larger than the screen size. This has no
real impact.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 281bb2dabf81..69be9d835ccf 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -480,7 +480,7 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
 			       struct drm_panic_line *line, int yoffset, u32 fg_color)
 {
 	int chars_per_row = sb->width / font->width;
-	struct drm_rect r_txt = DRM_RECT_INIT(0, yoffset, sb->width, sb->height);
+	struct drm_rect r_txt = DRM_RECT_INIT(0, yoffset, sb->width, font->height);
 	struct drm_panic_line line_wrap;
 
 	if (line->len > chars_per_row) {
-- 
2.51.0


