Return-Path: <stable+bounces-110382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D84A1B7A3
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 15:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8087A2502
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA04EB48;
	Fri, 24 Jan 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAltIYKe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1D82D98
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727916; cv=none; b=ISNca/uH28Jgml4qx0ZlAfdAuXmlNQc00p/J3KlhE0nfm4/7jeVET6pFX6AB2cKvzgudNmskjT6AJ/AhkCu3aae+1Hq82AkBRtMNXjeFl93C2KHH8mKCNZwFsy4Dnd6F94Fg11YLUVufZG30s2MEo7Ti4yN9YJa2a0xK7J55tTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727916; c=relaxed/simple;
	bh=VdtKZQBkxO7tZUx9UiwHnwjq3NKxNqUPrRMq/E4Yx2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rycolo3M5La80Bg8UhY6dINirrLK+Vikm564KwkdPHQqq1ppQx+1UPfUDft5FMDZ/MKpkAw8LczpMfD2QZaTMEs8EJgO3XMv9Co2XqocCxw07AMCgin13z/BD0jP6Zwz4Is/tPJIhNTF6h/3uS6ZcKfotkEGnCFzD8Fj9fJV5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAltIYKe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737727913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zb3gGiD6zuZPuIs92MRj+WLBlMtNhGlUskbMa7ld43k=;
	b=GAltIYKeSJCb/a2QGseMsBtThKV92CWMffANEjbph9lVEdpAeS9VfWfBH1I2Ae3NsXXd1X
	VKMBu9SAlN6TXnXlYjlU74QPNWrvFKeicSjhKzIB1ADfGzZeVz/oX4XhrjA+fwHbaUqZ/L
	M2o4ZdHerHkFi91mK9oBy5p6cNLc5gc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-4uq-4AjrP3GZAATjc0K1bQ-1; Fri,
 24 Jan 2025 09:11:50 -0500
X-MC-Unique: 4uq-4AjrP3GZAATjc0K1bQ-1
X-Mimecast-MFC-AGG-ID: 4uq-4AjrP3GZAATjc0K1bQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA5AB1801F1A;
	Fri, 24 Jan 2025 14:11:48 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BF561800348;
	Fri, 24 Jan 2025 14:11:46 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Dave Airlie <airlied@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] drm/ast: Fix ast_dp connection status
Date: Fri, 24 Jan 2025 15:11:31 +0100
Message-ID: <20250124141142.2434138-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

ast_dp_is_connected() used to also check for link training success
to report the DP connector as connected. Without this check, the
physical_status is always connected. So if no monitor is present, it
will fail to read the EDID and set the default resolution to 640x480
instead of 1024x768.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Fixes: 2281475168d2 ("drm/ast: astdp: Perform link training during atomic_enable")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/ast/ast_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 0e282b7b167c..30aad5c0112a 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -17,6 +17,12 @@ static bool ast_astdp_is_connected(struct ast_device *ast)
 {
 	if (!ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xDF, AST_IO_VGACRDF_HPD))
 		return false;
+	/*
+	 * HPD might be set even if no monitor is connected, so also check that
+	 * the link training was successful.
+	 */
+	if (!ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xDC, AST_IO_VGACRDC_LINK_SUCCESS))
+		return false;
 	return true;
 }
 

base-commit: 798047e63ac970f105c49c22e6d44df901c486b2
-- 
2.47.1


