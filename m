Return-Path: <stable+bounces-219910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA/FIwcloWlNqgQAu9opvQ
	(envelope-from <stable+bounces-219910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:00:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A51B2CB0
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE15E31195BD
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D1362125;
	Fri, 27 Feb 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzLtuleo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437A36212D
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772168405; cv=none; b=fbwa7oXEDYHyRhUeiiTya70jlQ1doApoSx5IMs/fehlC+glQ5tS88pvSWVuvypRAJdS2uxIGMqqw2Spgj8PUSXXGJeWoqmPYF2QduXmCuVH6ivrW/MvkI+MIFVxBUMqfk5yuwNKhdy/r41JdMwMQMScrOpWC2MYOPNfa6w/H8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772168405; c=relaxed/simple;
	bh=0V9TfcF0jCfymmrv79UOCNsFP+ZBkFqnn+Tpw8wkDGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNNSypdLL6RNNtFiLHbgqLIivQjDHAOBxLreE3XFpBwulVJuDU2MNZ8DCUbSlXEzMxTfT2zb/lyzJKxxBZ+CJ7dDsbdqzk7R5P4kpqNk8x2qRNi4pi98WEvkV4FJ84NG8tnaz/e0ntYViUEqW72cfd9Ptm8+d7jaKWSVroazREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzLtuleo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824adc96ad2so1696568b3a.3
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 21:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772168404; x=1772773204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqIhYcF+CYSjiR8zV9a6G8BIYgFMg1pnmFFZ2FA8I4I=;
        b=lzLtuleopx7xWpjGSSkGs48wbvj/CLTwwV1DhHSnp2+qOi5lSlaMZ2/GdU1rEod/BC
         TXx3LGDEQp5hYKmYoq2Naz4H2EVM/6lUWA/DJ8Ibe8LfHi87QcGXvJzm+547VYizz2+5
         5JbtGc8YoxLvDpf0Efl3UA/18Jas2j3iXLfiC6XlvZbx8mGbmTRhFjObNmPLLjb8Mr1p
         mxIwW1gP6EEEN1gIoGnDj+zjbIS4qN72TYd8IyQ4py5Iu5pqxqZcux16Jtdy8WODcTdT
         e6Hjdxs+24GsQ5jIuPfNpG953biPxaansl7pJXVwCgK5iiFvVBxxlj+mxzStKlt3+p3C
         LOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772168404; x=1772773204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TqIhYcF+CYSjiR8zV9a6G8BIYgFMg1pnmFFZ2FA8I4I=;
        b=IF/KmrZTICq7vKkrJ+vU8/5DW6Am5+9PDURcaWKFM7oqW7aW5ICnOnGWrNG3Kt/r7i
         cVkP4gGXb1PyH7ieObrLaHMJL5xwc9URz0rMH5BhnQyP+Y8/DCp7a3S+KKDrOyRb/xDO
         c7RbhTWLQqa0sFUrWQkDWljiaKTSAsa0JWj8FnlTeqQHH3PUa6ga3bBskHpRae4eopqf
         v2rtRC25DpD6miIiBORAkc7CZgj/M5FcergZA2vslnJ5fSPR9VH8awIOaEaVJ5v7Lw2Q
         7W8cQgMoL+cX/FZ9Ut0yXWwraImI882yVDHdJL0p8qKcHcEmBMd+3jwSTktZTD41i/bU
         +m4A==
X-Gm-Message-State: AOJu0Yye7IgXbCic7s0Nt+isljV+1ShKyd+C07XdW00lbk60c6KO64wX
	c4yFpFAsbkEKffqxD/NB2LxMN4Zp7VMiGBDh2pimDIc4U7xRQZ9culGvujD7gw==
X-Gm-Gg: ATEYQzy4nAvhZ/SAv17FvBlJkeWUr0NMh2ArpE4DGcHMQNzBJvhvscLNFsiTZXxtBJ7
	Qp5FMRk2XISb+tGfLjoF97C+//a6b9DmQ0l9mi8tfON27WR6yBQusUnxi7ChUa+4vMNzvT+MImA
	h0vOkHivRhu/j9EC7fzlHD3XSBZ/uJaFQQUEo2XKbqSeX5QmxeZVDOrrKE0s9krrwRqNsDHEdY/
	OYd8Ud7ulqFwjAHa+v7Ozb/++PxP6GUdnsA9Ba+Sa2AaBDS4hZFgrUvF2KpexRFSFgQtJi3YPmA
	CeUPH9blTeSDmTiUVWxjgU59OJjQoyRL4+knCe+ZbMkDmq1xmDxPap3xUTmaYsieWbaEi+3NuIf
	KmdTfCsNU/rVJKzJCnwQudKgww3lDXFZs5tYUubKW+7ER4kBEySu680/0rFxpCQIil01+rHoVQu
	3otJuy5MYGcGqF3PL5tWLCkMYrA+XD7nBYo7BpQqYuFY/rajm/QA==
X-Received: by 2002:a05:6a00:1a0b:b0:827:2c11:f137 with SMTP id d2e1a72fcca58-8274da7a4f0mr1480551b3a.62.1772168403587;
        Thu, 26 Feb 2026 21:00:03 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([175.201.112.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d94de6sm3966543b3a.24.2026.02.26.21.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:00:03 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.6.y 2/3] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Fri, 27 Feb 2026 13:59:52 +0900
Message-Id: <20260227045953.165751-3-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227045953.165751-1-aha310510@gmail.com>
References: <20260227045953.165751-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: EC6A51B2CB0
X-Rspamd-Action: no action

[ Upstream commit d4c98c077c7fb2dfdece7d605e694b5ea2665085 ]

In vidi_connection_ioctl(), vidi->edid(user pointer) is directly
dereferenced in the kernel.

This allows arbitrary kernel memory access from the user space, so instead
of directly accessing the user pointer in the kernel, we should modify it
to copy edid to kernel memory using copy_from_user() and use it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index d0e394397eca..576d79ebe9a8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -252,19 +252,26 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 	if (vidi->connection) {
 		struct edid *raw_edid;
+		struct edid edid_buf;
+		void *edid_userptr = u64_to_user_ptr(vidi->edid);
 
-		raw_edid = (struct edid *)(unsigned long)vidi->edid;
-		if (!drm_edid_is_valid(raw_edid)) {
+		if (copy_from_user(&edid_buf, edid_userptr, sizeof(struct edid)))
+			return -EFAULT;
+
+		if (!drm_edid_is_valid(&edid_buf)) {
 			DRM_DEV_DEBUG_KMS(ctx->dev,
 					  "edid data is invalid.\n");
 			return -EINVAL;
 		}
-		ctx->raw_edid = drm_edid_duplicate(raw_edid);
-		if (!ctx->raw_edid) {
+
+		raw_edid = drm_edid_duplicate(&edid_buf);
+
+		if (!raw_edid) {
 			DRM_DEV_DEBUG_KMS(ctx->dev,
 					  "failed to allocate raw_edid.\n");
 			return -ENOMEM;
 		}
+		ctx->raw_edid = raw_edid;
 	} else {
 		/*
 		 * with connection = 0, free raw_edid
--

