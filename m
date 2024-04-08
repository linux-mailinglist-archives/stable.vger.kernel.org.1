Return-Path: <stable+bounces-36306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2777989B5ED
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 04:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5835281693
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 02:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC90515C9;
	Mon,  8 Apr 2024 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZEBXz/GS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CB15C3
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543290; cv=none; b=TjA6xh9D4wI8fYm3s9UxB393UPSbQ14TR7MVOQzOJKTlbH20EQxh21tzxk8dEvK8w5QmTWx9J2qUfWN853nId8IrIjOENnL2zHJQqnf7X0W3P6uObYf731Uen1Gxg30kMeep0fr0eSWnGYamhR2dcSXRNbntPwcQmAqCgFQNL48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543290; c=relaxed/simple;
	bh=B1Hpyz4lUJHvybHSHC4hQtBEQLMqG6s34DbYXR9w238=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLeFCYTTerwwjD2tkQx4NbE7P0Hd+QhqDzCsR2aULoK1f6yB2EW7vtHa8f9+72mH6Ktvwk5hj9sTvEoQv7wUHDTwQdiyBO2ELg0goJjaez9gc/etPJ5Y7SHDrD/I2By2ebxp3noOpunRcBDjUiqljub3YYGOeIsb88GqhxrnumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZEBXz/GS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso452844b3a.1
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 19:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712543288; x=1713148088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UyEnRJ7Sv6c5TCjCFpEabTDcdegfRiMpEIjLnwomgc=;
        b=ZEBXz/GSvzCv014FAuwNNCwmCQXxqG8q9ulX4MI9qT/XSh0hqimOhk1g9eSlK6+BWx
         wEOoTc0UBPI4kHkb4raTVjR2DHoJGYwJFaYKiwH4AaDtc3j3vU5yr452WfQV+rQvT4ZI
         /D1x1gcWptJcQ7rrmlsl/M3DYEikO7BOHnp8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712543288; x=1713148088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UyEnRJ7Sv6c5TCjCFpEabTDcdegfRiMpEIjLnwomgc=;
        b=U7aAWjxgn0/vW/A67JE36lypsjOpnszTFrhoKZL364Pu2u+zT1iwqjagtf8nhSYKIa
         iobq18nVc4ItiVdgq+sZcqIXTX+4tFT9kbIJ8tqnlQfJUNrWihbNJgz4555wekpc7sl6
         eWXJAtQxOa8Inqsv/p/tFlPXsVS9zuLViYZddG9AOXhMK3/kwftko/IG0swieqAlyHo+
         yN3pCDrEKU4CIldYZe8TGnh6s5UdryNWMEk5vHsrhN1qk8Gag+cE+x0X67mNPzJhla2O
         n7qCUdM536Rf64H5Oa2Slh6taEyo4ZuNxZ6mYf06zxxu9Q6B2CXDUq9HNazN0USWpzR9
         vksg==
X-Forwarded-Encrypted: i=1; AJvYcCXEDBmc4fVvfaT7+IVzjZfmzPMtrP/rAIO1fesrTk4bSM8pWww0X7nnVrZjOoUuDeE2KCWKLwTHVqr2bbEvtwKUGe80XWNv
X-Gm-Message-State: AOJu0YwXsRsdBSw3P39GM7CWEmMwRI+VmWsvm/WgjHvy9YvuEMYMQdNT
	ODVdOu4YuqlXVifqDvnN2E7vEAjh9js3aujfobDYrgSB/bd42VVRlBVExJT59Q==
X-Google-Smtp-Source: AGHT+IHsec30tzs8cC+COVqHUQmcffu/WcMahAp9hT1R4C3+zSwQKOi2Xw1G1u9gMiLXW5aJNbPZhQ==
X-Received: by 2002:a05:6a20:da81:b0:1a7:6a4a:a663 with SMTP id iy1-20020a056a20da8100b001a76a4aa663mr2345789pzb.17.1712543288342;
        Sun, 07 Apr 2024 19:28:08 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id fa12-20020a056a002d0c00b006e694719fa0sm3477159pfb.147.2024.04.07.19.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 19:28:08 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	Ye Li <ye.li@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Enable DMA mappings with SEV
Date: Sun,  7 Apr 2024 22:28:02 -0400
Message-Id: <20240408022802.358641-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable DMA mappings in vmwgfx after TTM has been fixed in commit
3bf3710e3718 ("drm/ttm: Add a generic TTM memcpy move for page-based iomem")

This enables full guest-backed memory support and in particular allows
usage of screen targets as the presentation mechanism.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Reported-by: Ye Li <ye.li@broadcom.com>
Tested-by: Ye Li <ye.li@broadcom.com>
Fixes: 3b0d6458c705 ("drm/vmwgfx: Refuse DMA operation when SEV encryption is active")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.6+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 41ad13e45554..bdad93864b98 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -667,11 +667,12 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_map_populate] = "Caching DMA mappings.",
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
 
-	/* TTM currently doesn't fully support SEV encryption. */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return -EINVAL;
-
-	if (vmw_force_coherent)
+	/*
+	 * When running with SEV we always want dma mappings, because
+	 * otherwise ttm tt pool pages will bounce through swiotlb running
+	 * out of available space.
+	 */
+	if (vmw_force_coherent || cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		dev_priv->map_mode = vmw_dma_alloc_coherent;
 	else if (vmw_restrict_iommu)
 		dev_priv->map_mode = vmw_dma_map_bind;
-- 
2.40.1


