Return-Path: <stable+bounces-179407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEFAB559EB
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 01:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE771D62BFE
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 23:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB8B2737E3;
	Fri, 12 Sep 2025 23:12:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp112.iad3b.emailsrvr.com (smtp112.iad3b.emailsrvr.com [146.20.161.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AFA26C38D
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718720; cv=none; b=njhwHcuMbOa24I1vS4SnQFXaWkZAeoEguTZyNUndd0avw1m230FE514VT90uAUEGfjQOWUYpck5uQiEoGfhUTlc7RKxBkw1ABV3e3YpWuOGU09PkSfEkh+91aPiYvdwAa/dBrQv0n5R+4hfGZHyoSwwoRqP/VMCBwuWEpeax0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718720; c=relaxed/simple;
	bh=hE+fyc17Us+8QSOLwzpmXRK0Fk55uV0gwwS1mmAUMjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTrTCseKqU8AeflpYp8ARTruYoDX2pxLw8iHxxTmjI8kHZkPBUqLxiMs+5glH07WiBJJIKW1zAIcu0jyyViOcxEuIqEmvt276Jv0w1IUV4vh8Nq/mQd+a/nbtJvcq1mq9n9MWDtlDsPUJDxJG5M4ysTJ40W454Qif+YcWpl/n7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whitecape.org; spf=pass smtp.mailfrom=whitecape.org; arc=none smtp.client-ip=146.20.161.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whitecape.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whitecape.org
X-Auth-ID: kenneth@whitecape.org
Received: by smtp23.relay.iad3b.emailsrvr.com (Authenticated sender: kenneth-AT-whitecape.org) with ESMTPSA id D7C1DA0290;
	Fri, 12 Sep 2025 18:32:59 -0400 (EDT)
From: Kenneth Graunke <kenneth@whitecape.org>
To: intel-xe@lists.freedesktop.org
Cc: Kenneth Graunke <kenneth@whitecape.org>,
	stable@vger.kernel.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH] drm/xe: Increase global invalidation timeout to 1000us
Date: Fri, 12 Sep 2025 15:31:45 -0700
Message-ID: <20250912223254.147940-1-kenneth@whitecape.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 0c9dd40c-3302-4f88-900b-9c1781919b47-1-1

The previous timeout of 500us seems to be too small; panning the map in
the Roll20 VTT in Firefox on a KDE/Wayland desktop reliably triggered
timeouts within a few seconds of usage, causing the monitor to freeze
and the following to be printed to dmesg:

[Jul30 13:44] xe 0000:03:00.0: [drm] *ERROR* GT0: Global invalidation timeout
[Jul30 13:48] xe 0000:03:00.0: [drm] *ERROR* [CRTC:82:pipe A] flip_done timed out

I haven't hit a single timeout since increasing it to 1000us even after
several multi-hour testing sessions.

Fixes: c0114fdf6d4a ("drm/xe: Move DSB l2 flush to a more sensible place")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5710
Signed-off-by: Kenneth Graunke <kenneth@whitecape.org>
Cc: stable@vger.kernel.org
Cc: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/xe_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This fixes my desktop which has been broken since 6.15.  Given that
https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6097 was recently
filed and they seem to need a timeout of 2000 (and are having somewhat
different issues), maybe more work's needed here...but I figured I'd
send out the fix for my system and let xe folks figure out what they'd
like to do.  Thanks :)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index a4d12ee7d575..6339b8800914 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1064,7 +1064,7 @@ void xe_device_l2_flush(struct xe_device *xe)
 	spin_lock(&gt->global_invl_lock);
 
 	xe_mmio_write32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1);
-	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0, 500, NULL, true))
+	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0, 1000, NULL, true))
 		xe_gt_err_once(gt, "Global invalidation timeout\n");
 
 	spin_unlock(&gt->global_invl_lock);
-- 
2.51.0


