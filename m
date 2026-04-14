Return-Path: <stable+bounces-237792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PuMEK8d3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:57:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E153F904B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AE6B303EE83
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EBF3D7D7B;
	Tue, 14 Apr 2026 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp3AmOSE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419C395D9D
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164148; cv=none; b=e0Rk+qw8kyuVbrh6pyG0mRKsPV94AQaCPc4nSx2NNldvSjbqrmD+KQIMNjWd4G2KDgP5pObqtHz+Rh3bUDTNvm2p0X8VvWUziT0R+oB5joIwH5IyHBGVJjrn4rtNAO7j5BJBhUcPX4kJusJPVY9YbftjtsvZKOx8l1ZkUu2LMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164148; c=relaxed/simple;
	bh=iNWhPNItulE/yamjmhuZz6amkOuetrKt/LOC7KGreC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Na0q6aZupc65znXbC2iVjbBg+v3qkrJ84gloDvhQE2DPfwDZF3gEjOFUDDNdbFR9HP30URw/WJjGD2hsG9h6JZssWmDTHTJaZ+Y+DNPNWTW8gMNwxzlsBSB4FIfKXX8K0p/sIqBbsQqBmqV4vuRUshxdlgQyAIiBrNNrepWqlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp3AmOSE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a283c44478so8364901e87.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776164143; x=1776768943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W12ofF4X1Wo2C6qvMXRei9SFctcqIrL5xbkSvEXmBW4=;
        b=Xp3AmOSENn2xzKZ0offYhz0mllghwUuvSAFLPxIIziuhb4GkgAazS5jnKASLs4CfDb
         82mo1NWlijrfFzASR/ti3Al718dn4J7mflBJkMK8E8DO7UIHbGR31GWxC5co5/edM/Hu
         5w+E4nX25y48xE0gtIIwTTXz37VscMsVwQrn7+8zJi7orI3UUZngNRB077Kq5mhC8hHE
         Evt1deb0aiSyKUX9DCxc58VCBqdhCIq05q5Z2vCl91tSNaHG8zDAEd+TqyaPUI4nSe+T
         oB6Io7yX5PULNG5awaN0jVttJKsCgIYYZxXKX23vojOparSnThT7tI8hqIVu0o7efCGR
         Q1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164143; x=1776768943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W12ofF4X1Wo2C6qvMXRei9SFctcqIrL5xbkSvEXmBW4=;
        b=eZWo2rcVHvYRVr0FHgH3zFth0E4zZbdIRr56EGGFC2doutX0DANsdFv5XfcKe+Sh3d
         aM6H8Y1EYWctbgeAOImUdzsIkGRYTgURh9taAmS9eYChE/Ssd84Q4hiZczTlviM456JS
         +cE1DErKdIAQmMg0vNXkdYST70VbtThvSvGjSv6ZzIbHQGah7NYH1dm5O2Jqpr3AN1a4
         b20pX1knnbFBqY4lkgeE8c7c1yrWyAvKgv7Zzgu/ukQh23UAqymmdiNPgyFqBtKpt0GF
         cm+EewCrViVidYW7Mt5CXup21Giue9IYzKby+eXMtmSTTG5EpRa7beynGOnJOqlQNbQy
         kRyA==
X-Forwarded-Encrypted: i=1; AFNElJ8iz3hDdLfNCiXE/Bori5FmbPnmV60KYSyppYP7tOF1GyobwFTVmw9XNTYkrbTt9ItsbVIbbYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHikj4CBDitvF5Xp5ZT1u13dxSXLYcel0ldS/zAFvtLK1EN5XG
	hTwOt5jeGj7xf/G5aqptSsU/0cAFEShmldvfDOPEwn5qJINqhUWgELLa
X-Gm-Gg: AeBDievXqLBC5O/MHNVvCP7CxxHBJRA5B2guQHns5fO+hJ96CQdLO2gmMRfmz1HSSIT
	blRSpqL6ZRVeF40btc7SsoAGfiVSkslNnfSaHgayjMh3mqwz4PR78+4N3Mz2m6Vzy4Vdr9zcNun
	gfKSPdZCj7fNPIWhrMa24Dh30c9Uk82kF1/ZZ5mKB7gDr7COOcTaKiRatMuExxYEYoltJIhaswQ
	Vzf6Jm4oqadtCJyqvjpJrqFDWRNZWo4zuZx2Ncz+hqnWUo9c7QTTyfWOCb61YW8SSMEAu9Xfbnx
	E/eInux8zYd0/FXeKq0KvWYSoSFxLBdfBpw7htbJX1nWfhy0wuzfyod4UxRtKqQ8QHShnFZ0kCz
	V48hag4A7CFlGQt5QHH4bbAfH/ntTw7J79Cdu8pLaKBOCF2vvRktes6/QXQ9NkVaFlYtphGIlZT
	QWoWSNKcfr/UqctuTP+izcinfWl3LxI1JoZzZEMb3ZAxajoxoCTVOkUxuuwQ==
X-Received: by 2002:a05:6512:a94:b0:5a2:bf05:be77 with SMTP id 2adb3069b0e04-5a3efb283fbmr5981911e87.23.1776164142993;
        Tue, 14 Apr 2026 03:55:42 -0700 (PDT)
Received: from ghost-mint-vmk.cs.msu.ru (wifi.cs.msu.ru. [188.44.42.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eeee12fesm3177645e87.40.2026.04.14.03.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:55:42 -0700 (PDT)
From: popov.nkv@gmail.com
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Vladimir Popov <popov.nkv@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Deepak Rawat <drawat@vmware.com>,
	Sinclair Yeh <syeh@vmware.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 15901/15901] drm/vmwgfx: fix NULL pointer dereference in vmw_validation_bo_fence()
Date: Tue, 14 Apr 2026 13:55:27 +0300
Message-ID: <20260414105529.9883-1-popov.nkv@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,amd.com,vmware.com,lists.freedesktop.org,vger.kernel.org,lists.linaro.org,linuxtesting.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-237792-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[popovnkv@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url]
X-Rspamd-Queue-Id: D8E153F904B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vladimir Popov <popov.nkv@gmail.com>

If vmw_execbuf_fence_commands() call fails in
vmw_kms_helper_validation_finish(), it sets *p_fence = NULL. If 
ctx->bo_list is not empty, the caller, vmw_kms_helper_validation_finish(),
passes the fence through a chain of functions to dma_fence_is_array(),
which causes a NULL pointer dereference in dma_fence_is_array():

vmw_kms_helper_validation_finish() // pass NULL fence
  vmw_validation_done()
    vmw_validation_bo_fence()
      ttm_eu_fence_buffer_objects() // pass NULL fence
        dma_resv_add_fence()
          dma_fence_is_container()
            dma_fence_is_array() // NULL deref

Fix this by adding a NULL check in vmw_validation_bo_fence(): if the fence
is NULL, fall back to ttm_eu_backoff_reservation()to safely release
the buffer object reservations without attempting to add a NULL fence to
dma_resv. This is safe because when fence is NULL, vmw_fallback_wait()
has already been called inside vmw_execbuf_fence_commands() to synchronize
the GPU.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 038ecc503236 ("drm/vmwgfx: Add a validation module v2")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Popov <popov.nkv@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
index 353d837907d8..fc04555ca505 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
@@ -127,16 +127,23 @@ vmw_validation_bo_reserve(struct vmw_validation_context *ctx,
  * vmw_validation_bo_fence - Unreserve and fence buffer objects registered
  * with a validation context
  * @ctx: The validation context
+ * @fence: Fence with which to fence all buffer objects taking part in the
+ * command submission.
  *
  * This function unreserves the buffer objects previously reserved using
- * vmw_validation_bo_reserve, and fences them with a fence object.
+ * vmw_validation_bo_reserve, and fences them with a fence object if the
+ * given fence object is not NULL.
  */
 static inline void
 vmw_validation_bo_fence(struct vmw_validation_context *ctx,
 			struct vmw_fence_obj *fence)
 {
-	ttm_eu_fence_buffer_objects(&ctx->ticket, &ctx->bo_list,
-				    (void *) fence);
+	/* fence is able to be NULL if vmw_execbuf_fence_commands() fails */
+	if (fence)
+		ttm_eu_fence_buffer_objects(&ctx->ticket, &ctx->bo_list,
+					    (void *)fence);
+	else
+		ttm_eu_backoff_reservation(&ctx->ticket, &ctx->bo_list);
 }
 
 /**
-- 
2.43.0


