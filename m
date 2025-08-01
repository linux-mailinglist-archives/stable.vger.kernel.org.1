Return-Path: <stable+bounces-165725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB96B18016
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C4E1C804D7
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 10:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F623370F;
	Fri,  1 Aug 2025 10:21:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328041C7013;
	Fri,  1 Aug 2025 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043714; cv=none; b=fOxGBjJHA/tIjK8EQ4xitecChSRJLzIDyrtO2wvXNTXZ7EnQlSTzCEUtMWnBrpakE9lDgZkRWJj5HgNOs4jgLcKYAMNjDUxWemvBJX6hxjKtLTRL6V4trbvRfRJfaXOJyJsZXt2AnwF4Vbc022NzyYJc2bRncpBZoA/tGJktNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043714; c=relaxed/simple;
	bh=GDW5QDcpPb9JU3npIpVzC1ayE0pLOff4rJNdsgJIbxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDSMLIuo8xI16PIFnaTFlpM+OtrbIIRPNoJivyZ7RoLtJe/bNhjLBZXj4Kq5PTu5/IEwH1/e4ZnVRs+8Ut7fHcb979UH+1Znis4/nedfwJx0F1SAN3yIRh+W7Bh0rRmK15zkqXoDsuExj3UmP3bmNNF20O7rL3E1rBi6idTw5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id DAE6C3F116;
	Fri,  1 Aug 2025 12:21:40 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: thomas.hellstrom@linux.intel.com,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	stable@vger.kernel.org
Subject: [PATCH v3] Mark xe driver as BROKEN if kernel page size is not 4kB
Date: Fri,  1 Aug 2025 19:19:13 +0900
Message-ID: <20250801102130.2644-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <460b95285cdf23dc6723972ba69ee726b3b3cfba.camel@linux.intel.com>
References: <460b95285cdf23dc6723972ba69ee726b3b3cfba.camel@linux.intel.com>
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
index 2bb2bc052120..ea12ff033439 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_XE
 	tristate "Intel Xe2 Graphics"
-	depends on DRM && PCI
+	depends on DRM && PCI && (PAGE_SIZE_4KB || COMPILE_TEST || BROKEN)
 	depends on KUNIT || !KUNIT
 	depends on INTEL_VSEC || !INTEL_VSEC
 	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
-- 
2.47.2


