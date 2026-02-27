Return-Path: <stable+bounces-219898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFZsCRcPoWknqAQAu9opvQ
	(envelope-from <stable+bounces-219898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:27:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE521B23FD
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0328D3101E2E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9797E325700;
	Fri, 27 Feb 2026 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeIveTIS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A2324B3B
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772162787; cv=none; b=Zq3M81pS9LzTxK0c8FEprCxhZGBMkKX0C8eoZ8aJ5JT6icKfMg0de4H1bhJo5+xb0M0W0lpPVAQjFCoTfv7sY6AwFTX16kGu++4Fo63aJ3GR9EbLmdr2XZ7whaSO8/P2Er3MWC2JFX0181FEttD6Rrsz6/vpp5X0DrWdhVjuceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772162787; c=relaxed/simple;
	bh=14tp/ZbiHhc9fo6I3d3q5B/zYDGp7+QSAvy5xrmzM58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsJmn5u0LL5K8WSC1dDn8j0lCG4SAu3bbE5dOO4lYl4vAlrSnhmovS63PR5Co8SzZaSYU70DX4BIg26tP96zKhd6NI01dIr1LcNpNpXIK/GvMxUkwxk/XWBmPdLtlR6Ka8gtxZQYgTAu6iGVYLkf951k5JFwW2k19jD2HW7QMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeIveTIS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3562212b427so672984a91.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 19:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772162785; x=1772767585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SNYtFmJqSV95moRlaJ0QYmUhL+TICukmgmBhi3zA4c=;
        b=DeIveTIS7rZ75TqpGKczy5WPewUBeKiWGUGcO4gSFVW+e6ftPxQLTFrqvClSbtSzu0
         3S0CuPNLLsKoXjsb/1nQ6V6o6ySEsCLWwZVPp2kjeuxXzz0HBdDNCdxtBpl6Wh2d1aMk
         AQFmSE/vtFqihP7Cg7sPrIFyB2sB4vM1rlG9zYUsi9q+FnUmrEbzBREq58sX372UrShE
         rAnjuyvQmOqEu7FyQ1B4ewq6Il9qYtemug5tBeFR3MObJrgNfqlLQ82yXdOSXHfUKY7X
         QbfiPRb37GiytDZ/jVyu91RzZYfpavuDPUdFDcFydh5YtLABlkH2APxilOoP7xiLRxyk
         LLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772162785; x=1772767585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SNYtFmJqSV95moRlaJ0QYmUhL+TICukmgmBhi3zA4c=;
        b=nLe58cJkjfJ0sz9NzQOfuelq0JBrYdNDpoN00xalt6YnO5To9t4lzeKXnDgQYU1kdR
         62pGV3DNxlUZsbAR4RBYiOY+ohpFNseP71E5/Sha0AyzRbTHvBdtVwtZiBk1OGgMhkvW
         Gs9a883AG13gz/kf27Xp7spTZbx+MtiQ0GRdV8yT7Ufjl3e/faDdffpihsCTGZdI5Sq0
         ZXboeF6RmY4XqGMcL6OMrtfpZgwNNNbTeBHYNEWUYBarB12k4Yairai7O6mvNEpnWL7K
         DTS0L53o4vwb2tyvovK+3t4UpVMKaxADSc+CvanduaA2bilc3/FMLVEOz7dciyB6kCHt
         e4Jw==
X-Gm-Message-State: AOJu0YxpaZdSBUDT/LisVWpqo1SgFmkOxls2OlIj3c8yroe6KB9WgqEh
	+eNIozQsariX7UHyP4jQkUijLbw27F26rsVf9pGHjrJMUe0SefWN8eLL7ubYrQ==
X-Gm-Gg: ATEYQzwZW3hGG7O0C4/tvvwI9nitJWRtAoGFi9rxCS+a9gNIG3BpPY3Cms2Hz5VeMqF
	X+N8ULkLMDoFMPEczXc/ydZJeK8wze1dNcTzcGlNhHfHQn5x3Vv3/8cyAFBCFdwb0yKfxeDY/gd
	LSa+qty81DhtDIXPvP6IwAIvhtcsNWeAhqcPzdAmSSfY131yuvCW73W3icJgegLqAgv/e74XUTN
	0BlIhCI3oo59jzmjOHSq6EAfaXgs741tdA5mFKiWWZrRG+h2H26X56n2gpX00Bf27UELMU7/vkL
	y+7mNYRTlGhyvMeAbQp3tUhRW2gnjy9incXRqj6FmqHk6xTCrvjn6FeevykTXfhR/1wXxrNnLle
	M6SMQ/seRXpVl7S4Nqp/DMaVmuRVoAQ+gnw3oc7UjftLKEZVKN2Y8lyDa4TejomZE1Homundurk
	UZwvwrZYxtXRrHy7jDgNElQtcJR21gaQBMfECxXDdLNUB8lDN7ag==
X-Received: by 2002:a17:90b:3dc7:b0:359:28b9:5f64 with SMTP id 98e67ed59e1d1-35965c17095mr1275630a91.6.1772162785515;
        Thu, 26 Feb 2026 19:26:25 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([175.201.112.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fbc363sm4501887a91.2.2026.02.26.19.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 19:26:25 -0800 (PST)
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
Subject: [PATCH 6.12.y 2/3] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Fri, 27 Feb 2026 12:26:14 +0900
Message-Id: <20260227032615.108139-3-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227032615.108139-1-aha310510@gmail.com>
References: <20260227032615.108139-1-aha310510@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-219898-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EE521B23FD
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
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 1fe297d512e7..601406b640c7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -251,13 +251,27 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
-		const struct edid *raw_edid;
+		const void __user *edid_userptr = u64_to_user_ptr(vidi->edid);
+		void *edid_buf;
+		struct edid hdr;
 		size_t size;
 
-		raw_edid = (const struct edid *)(unsigned long)vidi->edid;
-		size = (raw_edid->extensions + 1) * EDID_LENGTH;
+		if (copy_from_user(&hdr, edid_userptr, sizeof(hdr)))
+			return -EFAULT;
 
-		drm_edid = drm_edid_alloc(raw_edid, size);
+		size = (hdr.extensions + 1) * EDID_LENGTH;
+
+		edid_buf = kmalloc(size, GFP_KERNEL);
+		if (!edid_buf)
+			return -ENOMEM;
+
+		if (copy_from_user(edid_buf, edid_userptr, size)) {
+			kfree(edid_buf);
+			return -EFAULT;
+		}
+
+		drm_edid = drm_edid_alloc(edid_buf, size);
+		kfree(edid_buf);
 		if (!drm_edid)
 			return -ENOMEM;
 
--

