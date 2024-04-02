Return-Path: <stable+bounces-35652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BBB896020
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 01:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F0F1C244A3
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE434501E;
	Tue,  2 Apr 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aQ1QTKoz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4E446D5
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100508; cv=none; b=ck6dwirxXiEwH/lLWSTc6PVNxPT5tRYuEiB4HP1cZNt5WlVCmWAzqODPs93t3IIzc3FWp4A5EbqBhuyBIdTpCsliPNaPEZauCZKjEgkCO+NCRAjnf7sUtRBBeWBB3ouL1UWPcfXO653I0uzSRz5KlPeD2qWHMydZbXHer67FTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100508; c=relaxed/simple;
	bh=VvlKZd0tJB+agXL0EFl/sE74mtm2guIOinMxaw4wjaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/3gZzPbNUbzhmX0pVsfGkeJPXwEuZVN0OZh7Xaf/Yg6ruiVzLq72dQIy4X62WXr5IS+X4/TNgyDYh/eQcPj57JqwX5g3+TwipKFX8vxPbw0iz1J4oPHp4FcNWmIg71nubpPuYx7RnXoGCPtIbX/i74jJFYJ0XJ3knZEidQQ1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aQ1QTKoz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eaf1a3e917so3010762b3a.2
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712100506; x=1712705306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s1cpFilIcoj0gF+3G7cV47DBqasfVJnJ4p5Ae2MpMg=;
        b=aQ1QTKozfFyuAxxU68o4/chYMnQq3xfc7+I2khARIgp7s7wl0bemRfPSBOK42SORR5
         232A7xhPUdAkdVIoFIEizuws6zt4m/J8CbbH8ADRa927EtgVP/CcKblzF4Q/xRhom+OG
         TNvUXMelVE88A9sW9cBlNcDAfBN27ROm14DLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712100506; x=1712705306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s1cpFilIcoj0gF+3G7cV47DBqasfVJnJ4p5Ae2MpMg=;
        b=h/mHkQupXu80SU6G03gWmkD17qG/ZrfIrnWOJCg031vRqZfbB8moDvZbFqJEcRHn6X
         Ne2vYWMry1a8syQHkJhjlAkxj8qwC6Gvsc32J1LLRENPWnTCuxVx+dtwl/DY8rfYFkx5
         xfCXtFgdmi2LUv7BQwSZCbz7s6Eole7I0QGmhSFh46rGq+WWzNVKhwMY1+IE+t2E516D
         e0eJOYSi2K+j/1g77nRhDV+Evm4MMFniRNgcfSUGWWyVJmfLA5x5aBZ1xn0v2g0mhY/r
         GGZoBwZF0lQaPxHFZF/zaVnmP/qBIbAcq0v525cB/DWu04AvTgN+qJhrE0uWLi9DLFyf
         GR+w==
X-Forwarded-Encrypted: i=1; AJvYcCUGU9Q0VWq85QFfMen5f2+C7nbtZZ9caAABMIgkIRTrR/KBta9OoQnOMjS++FZArXN3/WpLDEl2E96tCZM1+AWpi8j5ZXux
X-Gm-Message-State: AOJu0Yyxw7eHRnxulbxzG5sppsAMQcZ+lNHPb3ODWUAiUkaLQByCKU3k
	rS+I/kLKH4m/zuFSi6srJ5L5ux53TzqN9GgGx5B8p4+hAEIDV31nTaeDXPJKaw==
X-Google-Smtp-Source: AGHT+IHop2T0a57tWh7gMibQ3cT52SkL4Rn41/Fx8f56Akt9jbz4UDuxv4Hg19Nf1ZQNr0U67u1XmQ==
X-Received: by 2002:aa7:888d:0:b0:6eb:27:f27c with SMTP id z13-20020aa7888d000000b006eb0027f27cmr9508200pfe.26.1712100506073;
        Tue, 02 Apr 2024 16:28:26 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b006eaada3860dsm10385121pfo.200.2024.04.02.16.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 16:28:25 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] drm/vmwgfx: Sort primary plane formats by order of preference
Date: Tue,  2 Apr 2024 19:28:13 -0400
Message-Id: <20240402232813.2670131-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402232813.2670131-1-zack.rusin@broadcom.com>
References: <20240402232813.2670131-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table of primary plane formats wasn't sorted at all, leading to
applications picking our least desirable formats by defaults.

Sort the primary plane formats according to our order of preference.
Fixes IGT's kms_atomic plane-invalid-params which assumes that the
preferred format is a 32bpp format.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 36cc79bc9077 ("drm/vmwgfx: Add universal plane support")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.12+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index bf9931e3a728..bf24f2f0dcfc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -233,10 +233,10 @@ struct vmw_framebuffer_bo {
 
 
 static const uint32_t __maybe_unused vmw_primary_plane_formats[] = {
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB1555,
 };
 
 static const uint32_t __maybe_unused vmw_cursor_plane_formats[] = {
-- 
2.40.1


