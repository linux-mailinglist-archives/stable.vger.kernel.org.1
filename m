Return-Path: <stable+bounces-213063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCegBSaNgGkl+wIAu9opvQ
	(envelope-from <stable+bounces-213063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:40:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A5CBD58
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453D9307B203
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA88536214D;
	Mon,  2 Feb 2026 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePycUsjR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B073624CC
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031972; cv=none; b=qdwarLQs3PU1cDzS3nEDkot6oKpofbPORI1oe+x9wKsoiBEOIbkiSSDJP7FTHCHFUkJWK/gCj/73R7HGvayi/eNJen0rS5hkLXWDnWmLaCpBICxrRj7vX7rk95BDphmICgHslPdCkyY0DUsMkE6PcHjJ+cdE8NtcuvP6UfuhALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031972; c=relaxed/simple;
	bh=bnB73CudNO/ibm5Iqjxo8bfSR2hjaY2bLMkBRovZU7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dj6ka6rvQ1uGUl/pHoBbD3LQdSyZ7jNUjFFORd+JwjZ6KF8UcltsDkecHcEzpyMDxLd8adth5HeP4qJDyAvAx2tj4scCLaonT+fyhJK8pF1QCKVwN36Uk5kX/r/Jh8uTvLUBScvDgHK8IfBCvnA3xE7AkqBja39s5jZxowx0JCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePycUsjR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f47610542so2363051b3a.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 03:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770031970; x=1770636770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiX6sc+bte0/E+dFVuNXwgpx22zYYyWdASCMsSYGK9c=;
        b=ePycUsjR/pFvvLPWnrRlkEcsf4C79k5532Op1A733jWgYOBfXEkiVZaWyAXUTwWzuu
         LNfdmVCLaNPcIYAZrQVEAjSPLDGE2TGsAI/P8P7GnOlXb/QM7tSYIZ90tHrDkS5NCsrH
         OnjJAQS1tx6ym8djw6inHLNJDkrcw/13fHWGW9dRKgSPZ9/a3FhE4mgU6dNBKRGzEv4z
         lzBGgWlqpRIlM0bAO8onOlN3Lzzn0IB7NJgL8zUJNu5Jm5J406LUe8NeP7pv0+gc2QOq
         3SZ8RTijf+k9LJEPa0h1IlA27QNdQ/f7T4bYdytbg4rWuA12Hrl7+uNj09wbpkg/Es/W
         EqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770031970; x=1770636770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NiX6sc+bte0/E+dFVuNXwgpx22zYYyWdASCMsSYGK9c=;
        b=adDUq09jnXK+FmLJ4ho9AB5K6f6qWvMba7QrcyFbkMMm3vN/9TU1f1CiSwni1l6cQu
         pgWURWVYjmdrgWpLikYHwThpdIshr1seR6pfaQRUe9My9g2Ea46ngHEhWcF+qTI9tChy
         r7nogR0bXk61RfdjjTyF8qx9vTSnuAMnEWUgg9w5NfqotBiAOkeVPfm4Og9m1AgT12A3
         q+hiL/tkSE0jV3Ym+rAiPvpkyGcRVaiNRvKautnVQKg7Mrf0Dv7fkZnHewG+Hgyc2hlD
         AiQXEPbZGdCSHdJccJxwsfmHwzyjFTvSt774s7jX9TenY14OgFNvpGAK0RqQyf6mqHYt
         jh1A==
X-Forwarded-Encrypted: i=1; AJvYcCWxvFUDfcRw3WK8JG/KZJLaub3dhkUv7GK4J66bu5B4SmtTDnHHat+T1i4f5pRiOb4v2BV4GOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jZwmEsvZPCdh4j/J1DHz8S9MVkjtyBeX7/9PDSdeonqGr8GJ
	/3OHX4rY1WgX26sp2KrrDYEl6OY40Y4+DEQd72XhBheD51sMlrgjrF1Z
X-Gm-Gg: AZuq6aIV0J5XmLCnNXuQxevP9AEGHIeilPPCEXQ99qLayaWL0WNDrNzCDznzEdbIfl+
	MwQx3s4AcnAe+p11ShmONQLdSs78uIRYFyW3vgjv3ggdAnzE8z5t0QNV4FjyL+LIjv3tymiicwi
	k2HzfhGvv5omTXHVIAIs+030RyaFR8AF8rLyTE0cowfWx3SDK6CHaVtWRKY5BGIIMLAYIFzCE6J
	G/siObq3kpvSAWuYrort5PmHr9JKDyzy7/TdcreYUOCrahk8xJheR292clgO2MQpi+S9EkocxVE
	DL8Sf3cAT+Ht6d3c1GYHvkvwy0BwNzYAvyPU6cMMHVCvMG4TTeOK/BEDzygiz2FBaJErehTcQlb
	C5z6FxjIYOHNtwgPA+50APoJul84TwEKR2lffh4xiQBDcIxHOwRyOr4PxGVXWrYB7C+0cDvFClG
	FzlNvNpReYW47ATn8T4qqZj64oMIcqgC3VpG+36A==
X-Received: by 2002:a05:6a21:483:b0:366:19c9:b6b6 with SMTP id adf61e73a8af0-392e0000539mr10085643637.11.1770031970541;
        Mon, 02 Feb 2026 03:32:50 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f539dsm13743190a12.26.2026.02.02.03.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:32:50 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 3/3 v2] drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free
Date: Mon,  2 Feb 2026 20:32:34 +0900
Message-Id: <20260202113234.183393-4-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202113234.183393-1-aha310510@gmail.com>
References: <20260202113234.183393-1-aha310510@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,kernel.org,samsung.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-213063-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A97A5CBD58
X-Rspamd-Action: no action

Exynos Virtual Display driver performs memory alloc/free operations
without lock protection, which easily causes concurrency problem.

For example, use-after-free can occur in race scenario like this:
```
	CPU0				CPU1				CPU2
	----				----				----
  vidi_connection_ioctl()
    if (vidi->connection) // true
      drm_edid = drm_edid_alloc(); // alloc drm_edid
      ...
      ctx->raw_edid = drm_edid;
      ...
								drm_mode_getconnector()
								  drm_helper_probe_single_connector_modes()
								    vidi_get_modes()
								      if (ctx->raw_edid) // true
								        drm_edid_dup(ctx->raw_edid);
								          if (!drm_edid) // false
								          ...
				vidi_connection_ioctl()
				  if (vidi->connection) // false
				    drm_edid_free(ctx->raw_edid); // free drm_edid
				    ...
								          drm_edid_alloc(drm_edid->edid)
								            kmemdup(edid); // UAF!!
								            ...
```

To prevent these vulns, at least in vidi_context, member variables related
to memory alloc/free should be protected with ctx->lock.

Cc: <stable@vger.kernel.org>
Fixes: b73d12303ecf ("drm/exynos: added virtual display driver.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 38 ++++++++++++++++++++----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 601406b640c7..37733f2ac0e7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -186,29 +186,37 @@ static ssize_t vidi_store_connection(struct device *dev,
 				const char *buf, size_t len)
 {
 	struct vidi_context *ctx = dev_get_drvdata(dev);
-	int ret;
+	int ret, new_connected;
 
-	ret = kstrtoint(buf, 0, &ctx->connected);
+	ret = kstrtoint(buf, 0, &new_connected);
 	if (ret)
 		return ret;
-
-	if (ctx->connected > 1)
+	if (new_connected > 1)
 		return -EINVAL;
 
+	mutex_lock(&ctx->lock);
+
 	/*
 	 * Use fake edid data for test. If raw_edid is set then it can't be
 	 * tested.
 	 */
 	if (ctx->raw_edid) {
 		DRM_DEV_DEBUG_KMS(dev, "edid data is not fake data.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
+	ctx->connected = new_connected;
+	mutex_unlock(&ctx->lock);
+
 	DRM_DEV_DEBUG_KMS(dev, "requested connection.\n");
 
 	drm_helper_hpd_irq_event(ctx->drm_dev);
 
 	return len;
+fail:
+	mutex_unlock(&ctx->lock);
+	return ret;
 }
 
 static DEVICE_ATTR(connection, 0644, vidi_show_connection,
@@ -243,11 +251,14 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 		return -EINVAL;
 	}
 
+	mutex_lock(&ctx->lock);
 	if (ctx->connected == vidi->connection) {
+		mutex_unlock(&ctx->lock);
 		DRM_DEV_DEBUG_KMS(ctx->dev,
 				  "same connection request.\n");
 		return -EINVAL;
 	}
+	mutex_unlock(&ctx->lock);
 
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
@@ -281,14 +292,21 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 					  "edid data is invalid.\n");
 			return -EINVAL;
 		}
+		mutex_lock(&ctx->lock);
 		ctx->raw_edid = drm_edid;
+		mutex_unlock(&ctx->lock);
 	} else {
 		/* with connection = 0, free raw_edid */
+		mutex_lock(&ctx->lock);
 		drm_edid_free(ctx->raw_edid);
 		ctx->raw_edid = NULL;
+		mutex_unlock(&ctx->lock);
 	}
 
+	mutex_lock(&ctx->lock);
 	ctx->connected = vidi->connection;
+	mutex_unlock(&ctx->lock);
+
 	drm_helper_hpd_irq_event(ctx->drm_dev);
 
 	return 0;
@@ -303,7 +321,7 @@ static enum drm_connector_status vidi_detect(struct drm_connector *connector,
 	 * connection request would come from user side
 	 * to do hotplug through specific ioctl.
 	 */
-	return ctx->connected ? connector_status_connected :
+	return READ_ONCE(ctx->connected) ? connector_status_connected :
 			connector_status_disconnected;
 }
 
@@ -326,11 +344,15 @@ static int vidi_get_modes(struct drm_connector *connector)
 	const struct drm_edid *drm_edid;
 	int count;
 
+	mutex_lock(&ctx->lock);
+
 	if (ctx->raw_edid)
 		drm_edid = drm_edid_dup(ctx->raw_edid);
 	else
 		drm_edid = drm_edid_alloc(fake_edid_info, sizeof(fake_edid_info));
 
+	mutex_unlock(&ctx->lock);
+
 	drm_edid_connector_update(connector, drm_edid);
 
 	count = drm_edid_connector_add_modes(connector);
@@ -482,9 +504,13 @@ static void vidi_remove(struct platform_device *pdev)
 {
 	struct vidi_context *ctx = platform_get_drvdata(pdev);
 
+	mutex_lock(&ctx->lock);
+
 	drm_edid_free(ctx->raw_edid);
 	ctx->raw_edid = NULL;
 
+	mutex_unlock(&ctx->lock);
+
 	component_del(&pdev->dev, &vidi_component_ops);
 }
 
--

