Return-Path: <stable+bounces-183690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF1BC9078
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B5D3C0DCA
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ACB2E7166;
	Thu,  9 Oct 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeLlqpXF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152E2E2644
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013032; cv=none; b=kr7SFllqXHsRjuotE6mXajS0ghh4GTMW6nvgQfaw2A+kGcqApWoVQ9Fc5psrsFgGDEpe4+LxkEOZv8eBTn0+csGde+XUMAK28Xy9JVVmRs1pJQrquUa+wHXhUpeXKASRYjzYnbUad+c1O/3WXNH1zqN91QOjSNXwWF6X7xC8Wys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013032; c=relaxed/simple;
	bh=43F5c+zaUZG6YJN+thQRVnYCUYyJL65rXk0RmVSUeQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP1UlARz2bgBx4VRPURqQ56LJSE3uKipNLzvsB/YEqH37+Sps1HSMCkI+2DxrqbiGlDBKP4R4zi+4sXbevb2piDyZlfKD3DwRtnRbdWvGc+MzalAemPngbZC2c1D8zsq07DiptlMDxaXN2heAQFPs5glTGkQcbQS2d5pJf/YqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeLlqpXF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760013028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jU6y3U31OtGeGVZmCu0gO04BJwFhkS/aeWCbYDaXik=;
	b=YeLlqpXFYNKOHHioPIvVSyFte/7YIy1VzNyczaa/UkvI2ARTfKysWPwnhqQbKhNL79D7WB
	xciPyvCLuUtcx9eiqqMLwHbcVKctHsHLVUsHx1a1T48okrKf2Bp2ZaB4DdvhlutAifUgDO
	DVBBLQPCZLU6zzuRopXWy9BDQKgTFbA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-q1Xljwk-N8-wwzTwoFRdAg-1; Thu,
 09 Oct 2025 08:30:23 -0400
X-MC-Unique: q1Xljwk-N8-wwzTwoFRdAg-1
X-Mimecast-MFC-AGG-ID: q1Xljwk-N8-wwzTwoFRdAg_1760013022
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 357A6180048E;
	Thu,  9 Oct 2025 12:30:22 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD2E318004D8;
	Thu,  9 Oct 2025 12:30:18 +0000 (UTC)
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
Subject: [PATCH 2/6] drm/panic: Fix overlap between qr code and logo
Date: Thu,  9 Oct 2025 14:24:49 +0200
Message-ID: <20251009122955.562888-3-jfalempe@redhat.com>
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

The borders of the qr code was not taken into account to check if it
overlap with the logo, leading to the logo being partially covered.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 23ba791c6131..179cbf21f22d 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -749,7 +749,7 @@ static int _draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
 	/* Fill with the background color, and draw text on top */
 	drm_panic_fill(sb, &r_screen, bg_color);
 
-	if (!drm_rect_overlap(&r_logo, &r_msg) && !drm_rect_overlap(&r_logo, &r_qr))
+	if (!drm_rect_overlap(&r_logo, &r_msg) && !drm_rect_overlap(&r_logo, &r_qr_canvas))
 		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
 
 	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, fg_color);
-- 
2.51.0


