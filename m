Return-Path: <stable+bounces-164850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4DB12DC3
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 06:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1B91890C75
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 04:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271819F11F;
	Sun, 27 Jul 2025 04:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00E18CC1D;
	Sun, 27 Jul 2025 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753590549; cv=none; b=J0OWUSkyAPvPHQo10vUP+fdITFxxe106sentKozRcbUMlwnwo3XX8Y6gOvk0W1McjMmccfYKmhN7k3hpKAoE+B1bdhYZztaD52zjK8OfidReZ1OYVa2+LYcXiLkjnf0B491ONT5JQfC+KRawSo26AuQaQbyRo/QkiWIt7RBjvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753590549; c=relaxed/simple;
	bh=dFeiPPUdXJEheHNbfPC1f1feOqHKAmBKPgJp1jMn9i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCizG3KXUuoIngNpsFK6lfc8CjcrOo+nJJdwXoWVgQ+O3Htyo3QT8KOBzCqTLF+6qwZOPOvDrR3Q1NPnueYVdMoiaMlojdmGk/50q6BMtYYHyGNJRF4jKIL7I7fzJgkoLRfvKo4SF5PEbhGKiQyst1sgW8unfIYJarkd7DJpiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 6EAD63F116;
	Sun, 27 Jul 2025 06:28:56 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	1109776@bugs.debian.org
Cc: jeffbai@aosc.io,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 1/1] Mark xe driver as BROKEN if kernel page size is not 4kB
Date: Sun, 27 Jul 2025 13:27:36 +0900
Message-ID: <20250727042825.8560-2-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727042825.8560-1-Simon.Richter@hogyros.de>
References: <20250727042825.8560-1-Simon.Richter@hogyros.de>
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


