Return-Path: <stable+bounces-183691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD6BC905D
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D614353174
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A22E62B5;
	Thu,  9 Oct 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5y7qG0A"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64CE2E5B36
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013034; cv=none; b=g2e/wUR5j/59441Jwz19MhCAXmPgYt1JMK+pC8nTTDjwo8zLRkeQfUGb850R8FrG2LuDVGVSTQoo3Z9DG2MCrKSAYHciRXzcHWQNX1gmjZL3KDSmiaxNiB1xWnYY/RG6ORiio2fv1GOrO+d2PhpnbP9tIchs2X8V5F/TxV9zyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013034; c=relaxed/simple;
	bh=gUEahKKYOUH2kVxO/lDajkAlCzV30k4qOuQ5Yr4X7sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJCscdzzfyPEgFQv7HRX1vUlwFlK1HJFym/V1FN4SnXj7sgdRyeO+eqQKL0r0cpsKg2LLvewr3nGTFJvvxJArmqb/BwdhdvtTm+IEupH3h/ZzDOP1h27Tj1/eJ+4+HyNpcCofLrFftbAN2bMeRvnoHZkTpeg/OyC/6cEhpuzjSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5y7qG0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760013030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSDCPJnmMxBRqtQR+6ffqI3zTDae1cNcYyEpjejHE4g=;
	b=G5y7qG0A3QtiAyKT312mhzKMV0XyPZMxKagPND455Z0Va1ULaAwgGpKagjIKb7BokLP3av
	4E0/YhktRS8NjzTrq6HVKqKk3b9DfDnutJDSjg61fbnkZ0yh4UKT85TERwugKnR22lwta/
	TCzY6b4rFXEM7QO4lJiJrywumPkzax0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-_mRjGOe-N1COQ5vjhdKE7A-1; Thu,
 09 Oct 2025 08:30:27 -0400
X-MC-Unique: _mRjGOe-N1COQ5vjhdKE7A-1
X-Mimecast-MFC-AGG-ID: _mRjGOe-N1COQ5vjhdKE7A_1760013026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AF7519560BB;
	Thu,  9 Oct 2025 12:30:26 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B92191800982;
	Thu,  9 Oct 2025 12:30:22 +0000 (UTC)
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
Subject: [PATCH 3/6] drm/panic: Fix qr_code, ensure vmargin is positive
Date: Thu,  9 Oct 2025 14:24:50 +0200
Message-ID: <20251009122955.562888-4-jfalempe@redhat.com>
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

Depending on qr_code size and screen size, the vertical margin can
be negative, that means there is not enough room to draw the qr_code.

So abort early, to avoid a segfault by trying to draw at negative
coordinates.

Fixes: cb5164ac43d0f ("drm/panic: Add a QR code panic screen")
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 179cbf21f22d..281bb2dabf81 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -736,7 +736,10 @@ static int _draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
 	pr_debug("QR width %d and scale %d\n", qr_width, scale);
 	r_qr_canvas = DRM_RECT_INIT(0, 0, qr_canvas_width * scale, qr_canvas_width * scale);
 
-	v_margin = (sb->height - drm_rect_height(&r_qr_canvas) - drm_rect_height(&r_msg)) / 5;
+	v_margin = sb->height - drm_rect_height(&r_qr_canvas) - drm_rect_height(&r_msg);
+	if (v_margin < 0)
+		return -ENOSPC;
+	v_margin /= 5;
 
 	drm_rect_translate(&r_qr_canvas, (sb->width - r_qr_canvas.x2) / 2, 2 * v_margin);
 	r_qr = DRM_RECT_INIT(r_qr_canvas.x1 + QR_MARGIN * scale, r_qr_canvas.y1 + QR_MARGIN * scale,
-- 
2.51.0


