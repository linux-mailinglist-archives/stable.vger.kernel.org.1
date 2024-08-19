Return-Path: <stable+bounces-69589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B686956C22
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0381C227B9
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A18154C19;
	Mon, 19 Aug 2024 13:31:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0951DFE1
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074303; cv=none; b=E7vG+lOpJaBv8bAKryOt87Z9NWLWvy+QgrtQVMd1yERWutbN1jLFO3NTbgKyvefzn45EdYHxtj26OoUGaF5P+6d2NOJD+BJFtIShmc9+/MOm5VQ8E555rY2/6sPwOihRvnxYTo5TFpKf+bNB5Yzh8kdAso14emlVPmOpYnJRPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074303; c=relaxed/simple;
	bh=fDXFibMyD3zQzU3UOZ96iYkq4VnTPFxaQ/ZPJzDskvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpEXshoLQTdaek/qePXOOtDdEhig3QurbGjqAcRRjlP5hJpCrItX5Z+CSc6Ve77QJWFO2ei3p+DgCABvdlouf5XYfFlTM3sM3EWVvk72Ygocjgct3/GTNr/CnVVY9CHRHuAgZma/Wu9ELVxGchyh21YJss0v6vP/pfG908rzrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/xe: Read out rawclk_freq for display
Date: Mon, 19 Aug 2024 15:31:35 +0200
Message-ID: <20240819133138.147511-2-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819133138.147511-1-maarten.lankhorst@linux.intel.com>
References: <20240819133138.147511-1-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failing to read out rawclk makes it impossible to read out backlight,
which results in backlight not working when the backlight is off during
boot, or when reloading the module.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/display/xe_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 30dfdac9f6fa9..79add15c6c4c7 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -159,6 +159,9 @@ int xe_display_init_noirq(struct xe_device *xe)
 
 	intel_display_device_info_runtime_init(xe);
 
+	RUNTIME_INFO(xe)->rawclk_freq = intel_read_rawclk(xe);
+	drm_dbg(&xe->drm, "rawclk rate: %d kHz\n", RUNTIME_INFO(xe)->rawclk_freq);
+
 	err = intel_display_driver_probe_noirq(xe);
 	if (err) {
 		intel_opregion_cleanup(display);
-- 
2.45.2


