Return-Path: <stable+bounces-164852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A7B12DF7
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 09:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203C13BEE7B
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 07:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974DBA3F;
	Sun, 27 Jul 2025 07:04:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800016A95B;
	Sun, 27 Jul 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753599872; cv=none; b=kUm6S/vK2SUDEKojgTG/fEjj0eNHeCtnrfwGL8+j1NEAr7W+SZWrZ5seK9WFRJuSZOpks+vGPyMAj+16I1DPEhCsKAQocLczLmJwMmEg1cezk1vQxfMSKtcn/VyGM6bk+f3WkEyI4lkuSvaHtQiI0ExgNJWpBYItYt2xIoidJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753599872; c=relaxed/simple;
	bh=xwWXR0L61orXz75xHm215sCyS3w70ZQlin1LuR5ZAYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzl0SVQoHyD4uP5ZkwSv0MUGWx7XpQr4oX+4phzwdxqS/r8glNxpvWRYrfHVdeBnAyhZjsCTKc8AYl7oB6n9zqz9TUQdJWzSs1hlUZJSbA4ikMoAKvAJ1dFRiCiltLpdsjELd42x4brSmYUGDGtIPT9Zy/ox550EqAw42HHQQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 203763F116;
	Sun, 27 Jul 2025 09:04:25 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] Mark xe driver as BROKEN if kernel page size is not 4kB
Date: Sun, 27 Jul 2025 16:04:10 +0900
Message-ID: <20250727070413.9743-2-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727070413.9743-1-Simon.Richter@hogyros.de>
References: <20250727070413.9743-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver, for the time being, assumes that the kernel page size is 4kB,
so it fails on loong64 and aarch64 with 16kB pages, and ppc64el with 64kB
pages.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/xe/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 2bb2bc052120..7c9f1de7b35f 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_XE
 	tristate "Intel Xe2 Graphics"
-	depends on DRM && PCI
+	depends on DRM && PCI && (PAGE_SIZE_4KB || BROKEN)
 	depends on KUNIT || !KUNIT
 	depends on INTEL_VSEC || !INTEL_VSEC
 	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
-- 
2.47.2


