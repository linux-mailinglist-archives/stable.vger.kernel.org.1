Return-Path: <stable+bounces-125862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B4A6D652
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B91316C8DD
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BD120EB;
	Mon, 24 Mar 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtI2rqTe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9525D20E
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805491; cv=none; b=WiLUXTDMXkNoYmQlP0ze4B4atMobAZkt3DMOpTdbES/E1MGEA9TLxFW25ptjDES0MUVK0byEgboDuqD6j96b4kYQUjz1qVwgyFKFnOalbvdhlPyVTZe7kxvHeiaz1IwaeA98lNWceQG9uHCg071KVcBbM3VV9cGTPwK+P3aOvy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805491; c=relaxed/simple;
	bh=cIeqScoc8TnjpiESoOemnaXYO0IYkkGiTbifdUGfekI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB9ymTJhXMUzLEzO9uZ3LMiate5RA5HIP3Tq+JQ7TkORY+Isg54dJ4HXKxUR2Kud871/Vfl4KX/iqPwsJWGkbO4fBB9U17OlU//p5eYrWfNz9eDIRjvjnv6MVce31cKT2sHkRqqQ7QUHt47Rg14Ezmh5WIWi4xm4LitaFmb8fYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtI2rqTe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39129fc51f8so3254342f8f.0
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 01:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742805488; x=1743410288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI99fnwoye6Q8fICOi58sOTUi88dGA8Wbff6aKoV7EI=;
        b=CtI2rqTe2Acb8LyDZmXiSWD3/c1QG9kFyn5utPgvi4f43UlXbJqmz07mqSsfXY+Qkw
         N65qZdFFYHqEh6R7/pAFSMCTv+COdiZGTwDjym7o6inRC2WNyGOgl4AoF9XNvzgln3y2
         l3FVNnVK8zmgxKtcXt1QVzMN8fo77fWuBXwFNKKOzuhZ7XAVzpGmwlUvefFhCsn5Rn5K
         3Ig2OPyjLfa5FDCRs7BW7OEjPa0GYN4nqHzYrtcqifFyciJG/MAvkyT4Y6o43K0mdoJN
         0GYILaynBBfC52i9UM+L6+MvicGV/dU35W65nf5hKlzQ7KT44OqsLsB/PzqLFtx+xx2H
         ROnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805488; x=1743410288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI99fnwoye6Q8fICOi58sOTUi88dGA8Wbff6aKoV7EI=;
        b=qEHhATCVahyMbYEiv6feMRSZ2qX7zwSaHTREqeI3kIJNSGU87CZKAPml09e2hDMfCM
         iCl5TGaaCBtEfMZOEaHgs6kjKpWjpnCvdp1n+fGkcQoYh0s45Zexx5GWUXSinvj9yd31
         8KpDy/4dD+pLu8XxM/mPRXmqMStDuFp8qnEv1a+wICuo1vQMRWj8n2Ch4H39dY8b2RhY
         ZlzQQR4b9wjWeJ1aZJ02MEsTvM3yoEgdo51TthHK1UR7vTQQsDh8m7CcJF3Oedb0fov4
         SfN9xyNvSyWIjjbO2uiU9qCIWX8vyPOTg6y4paVUF07jXSJD/RpmOJpAysYVFfT8oX/3
         4ueQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdfRpxx1djof+UCa5ZuNUWiMvKnSKuGTMXY3v8IJsp2UvlEjfSMzEbUfZ2/4in+SX50JGID3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNG5h/TvaAfzfEMGo6u84N+wJbxrO+DhoqLPJLTvcmfZRVgB1
	wLEZVMmF70FhtBzFnL3hW+PCbou77OBMHXC8TKC4aBP622x34Djo
X-Gm-Gg: ASbGncsA7FACvfhV9DMTrFDqr/OpZYZKi4Fdfq8vvU3ibZ0Fj9LsmzNBaBeg11wipmP
	UbJz0wspElWdkbNO+ZUjB8yyFWGkmFjcLGjH5IPkZB5b5HZ5uVp5cYPl6/Ow/SeOtvh3RqUy0W+
	CMgdA7eMnmqBuq0V29WBTRyTYAYlkPgrl1yo4QhmH/EkiN3mf2Qc7p4rrMo28HGZQWIWMmk+vSK
	cEU6NPg6EcIbmx6/XFS+JPM93fbwm8n1+Km+ycxGyFDW1+jeSHaPbJMlSrRb6TNa75yYlMOk8hC
	b7kPLHtbdBbKyrh7cuYH/ieZ4mmQ2mXh3xVJG+unH87iOV9N1We5FeC0V1q6Gv3OpX6Fo9tD
X-Google-Smtp-Source: AGHT+IE5dnmZzlumAHOzeYmTNsGGoPkMWQP5cGeN5N9XavHeq3hHLFm7ggnXPVJJElCrQxSW73xyAA==
X-Received: by 2002:a5d:5987:0:b0:391:43cb:43e3 with SMTP id ffacd0b85a97d-3997f940621mr9615494f8f.46.1742805487437;
        Mon, 24 Mar 2025 01:38:07 -0700 (PDT)
Received: from arrakis.kwizart.net (home.kwizart.net. [82.65.38.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3c2csm10078670f8f.46.2025.03.24.01.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:38:06 -0700 (PDT)
From: Nicolas Chauvet <kwizart@gmail.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Nicolas Chauvet <kwizart@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] Revert "drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]"
Date: Mon, 24 Mar 2025 09:30:01 +0100
Message-ID: <20250324083755.12489-2-kwizart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324083755.12489-1-kwizart@gmail.com>
References: <20250324083755.12489-1-kwizart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ea26c96d59b27e878fe61e8ef0fed840d2281a2f.

This fix truncates the OPREGION_SIGNATURE to fit into 16 chars instead of
enlarging the target field, hence only moving the size missmatch to later.

As shown with gcc-15:
drivers/gpu/drm/i915/gvt/opregion.c: In function intel_vgpu_init_opregion:
drivers/gpu/drm/i915/gvt/opregion.c:35:28: error: initializer-string for array of char is too long [-Werror=unterminated-string-initialization]
   35 | #define OPREGION_SIGNATURE "IntelGraphicsMem"
      |                            ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/gvt/opregion.c:225:45: note: in expansion of macro OPREGION_SIGNATURE
  225 |         const char opregion_signature[16] = OPREGION_SIGNATURE;
      |                                             ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Cc: stable@vger.kernel.org
Reported-by: Nicolas Chauvet <kwizart@gmail.com>
Fixes: ea26c96d59 ("drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]")
Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 drivers/gpu/drm/i915/gvt/opregion.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 509f9ccae3a9..9a8ead6039e2 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	u8 *buf;
 	struct opregion_header *header;
 	struct vbt v;
-	const char opregion_signature[16] = OPREGION_SIGNATURE;
 
 	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
 	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
@@ -236,8 +235,8 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	/* emulated opregion with VBT mailbox only */
 	buf = (u8 *)vgpu_opregion(vgpu)->va;
 	header = (struct opregion_header *)buf;
-	memcpy(header->signature, opregion_signature,
-	       sizeof(opregion_signature));
+	memcpy(header->signature, OPREGION_SIGNATURE,
+			sizeof(OPREGION_SIGNATURE));
 	header->size = 0x8;
 	header->opregion_ver = 0x02000000;
 	header->mboxes = MBOX_VBT;
-- 
2.49.0


