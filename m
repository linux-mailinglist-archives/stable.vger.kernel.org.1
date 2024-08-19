Return-Path: <stable+bounces-69577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE8956977
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF44A2817C1
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8B166F0C;
	Mon, 19 Aug 2024 11:38:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649B157A48
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067506; cv=none; b=WDhJKdzXVHPUO6RyAjjzS6LtShnfAWhcFWwXQ45dCIaOTcZ79wRhaRGlXNAsISHFvZMuu4G3Ku4KdCkUIrUlz0VyLxbMPVPbUTM/a86ZMPzYhy9Znwh5pO8QqmnoNyoJCINYMcOX95x7uIw0PmUQopZSKcGIYE4h3cUgGMlRYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067506; c=relaxed/simple;
	bh=Xb9qNF92qF3lXUAVdtq2xwAdLjY5fs5fwlVMMheXiRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXtGpW4RSlYqORghdsOXE9tdDW3r8STyJtxQYmxIfJqMDZ8o9KF4I04EqWUjJozqov5g70qNB7spI/Am5Oojxzax4CF/BAL1RxIbXAzz4vT6K1IbAAKte6HlRw0r3NjOQJuwTMfjxy8FZc1/cM4qYYol0BT2tImZpSJTdI12SHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] drm/xe: Read out rawclk_freq for display
Date: Mon, 19 Aug 2024 13:32:50 +0200
Message-ID: <20240819113254.82286-2-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819113254.82286-1-maarten.lankhorst@linux.intel.com>
References: <20240819113254.82286-1-maarten.lankhorst@linux.intel.com>
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
index ca4468c820788..65d7a5040270e 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -157,6 +157,9 @@ int xe_display_init_noirq(struct xe_device *xe)
 
 	intel_display_device_info_runtime_init(xe);
 
+	RUNTIME_INFO(xe)->rawclk_freq = intel_read_rawclk(xe);
+	drm_dbg(&xe->drm, "rawclk rate: %d kHz\n", RUNTIME_INFO(xe)->rawclk_freq);
+
 	err = intel_display_driver_probe_noirq(xe);
 	if (err) {
 		intel_opregion_cleanup(xe);
-- 
2.45.2


