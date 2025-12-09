Return-Path: <stable+bounces-200464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80ECB0636
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 16:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C386830080FB
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2822DF13E;
	Tue,  9 Dec 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="FP0ZEAaJ"
X-Original-To: stable@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C62D1F61
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765293775; cv=none; b=SZCSoL+T+ZhK+zdTzbbV9ANPqqjYN0ICrzq8xt7QKXvh/WetaPq0UE5MUc1UpGoyyB01wvIIO5pqaIQ85XH67iQYz3hxYWK4D3ITrhYQl/cnOri3pqgxA8f8gPaFzIhGRSa7HRtGhjTmgU8O9wutzo/o50SewFRkyTZ2/gmJY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765293775; c=relaxed/simple;
	bh=TpBR6UngkEpzlvmNtau/oYGa2aWfBUU+yiZ7AlBxeZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTbUwCb7vbzkZgfSY4gd6vcHh6edKcYF/ZRbepokGrW3At42VWaehCgx14crZyPEceZDAosWmA+YixqOZIZaFLpNXV3Z571BNiHt4IGTf/zYKiLg3+LJZQ35Zg74el4ydIUvvgn5hATxmqXLwqtSEtbZh3nHwaebNArywvUOaqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=FP0ZEAaJ; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1765293206;
	bh=TpBR6UngkEpzlvmNtau/oYGa2aWfBUU+yiZ7AlBxeZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=FP0ZEAaJ4rl2eCKjcosqX0e0/t8sbL+glc59ycNp+REIBgLxBzYUOj4DvVsSbVG5P
	 Mtt0a5PntJtUv5eww6eDDpRyud9mMVTbtN6WsaKSvD6cunB9gipsPJf408QM0hchbH
	 Y02o40zk4q5mK5LGCJLH3Rs5Mz8uTAppFnUGKRIOSDqDFD1nb5IvQxgTiIRV+1USa/
	 B15/+yRuW+35k4KboKOGAMxnsiWLf5ZOxK4hswhStUCsARevU8glScHVhPDSZaavl2
	 Pu684VCud9h42yG8vzAPqyKV1m8DcGBePRE3L8Khs2jRb+LMVoCFil3VgRICJ76Nu4
	 QraIEMCKI4GNg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe: Use generic_handle_irq_safe inside heci gsc irq handler
Date: Tue,  9 Dec 2025 16:13:20 +0100
Message-ID: <20251209151319.494640-3-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the irq handler safe on PREEMPT-RT too.
This is similar to the i915 commit 8cadce97bf26 ("drm/i915/gsc: mei
interrupt top half should be in irq disabled context").

Fixes: 87a4c85d3a3e ("drm/xe/gsc: add gsc device support")
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/xe_heci_gsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
index 2b3d49dd394c0..495cdd4f948d5 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -223,7 +223,7 @@ void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir)
 	if (xe->heci_gsc.irq < 0)
 		return;
 
-	ret = generic_handle_irq(xe->heci_gsc.irq);
+	ret = generic_handle_irq_safe(xe->heci_gsc.irq);
 	if (ret)
 		drm_err_ratelimited(&xe->drm, "error handling GSC irq: %d\n", ret);
 }
@@ -243,7 +243,7 @@ void xe_heci_csc_irq_handler(struct xe_device *xe, u32 iir)
 	if (xe->heci_gsc.irq < 0)
 		return;
 
-	ret = generic_handle_irq(xe->heci_gsc.irq);
+	ret = generic_handle_irq_safe(xe->heci_gsc.irq);
 	if (ret)
 		drm_err_ratelimited(&xe->drm, "error handling GSC irq: %d\n", ret);
 }
-- 
2.51.0


