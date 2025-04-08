Return-Path: <stable+bounces-129052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43CA7FE4A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B73A9B21
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652B26A0AC;
	Tue,  8 Apr 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HxjjHK3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231A26A0C1;
	Tue,  8 Apr 2025 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109983; cv=none; b=O1bcwvIHnr4LcZKS+nw7jP4bryaRYGm/lQdzH4Xwi6S7Nl+JXxrF4YCNGniHvSXpriMFLVUCIXA27Bx/nbhpUPMTTdV+yb8sekQUvQmbasGpshGukzJx/vlBV1Lf1e3TxBL7uAVYVStkkOTqD5v3P9uYAYV4G0AqmtqC4Ni5Ass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109983; c=relaxed/simple;
	bh=/UeYBSYKDJcmTIvDRqMPFFo6Df6NEpxTeQth3jlSg+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/x3LzSieB65PdJ0+8thS7im32hZj59CI2wWZQZSBGVr57FEngXSx17pvGekIztI/bAeJtRaSMo4WjT69Gm+TOjX3Y5H9xTstAF87ENSEMsgvDMOWSAIroQLSOVSAC1h5WLwaaNlkJXj+Jo2p+NCtFtiC74UD1tuaamlAJevgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HxjjHK3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839ABC4CEE5;
	Tue,  8 Apr 2025 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109982;
	bh=/UeYBSYKDJcmTIvDRqMPFFo6Df6NEpxTeQth3jlSg+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxjjHK3h0r2hokvHYnqhpgb3ITEjeSbwf/aHu6qsJBv6K+yfUuX+UXObevaVTxJXb
	 iQwr4x987tdj6R03LgePpAaGMss+iXb710/MnPGZtwfOKJx1xfFgJXdOwwubr52nAH
	 ARrOKF49zB/QwyO0y/GmdP31cMZVd1YptVQVXYaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 123/227] PM: sleep: Fix handling devices with direct_complete set on errors
Date: Tue,  8 Apr 2025 12:48:21 +0200
Message-ID: <20250408104824.026121129@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 03f1444016b71feffa1dfb8a51f15ba592f94b13 ]

When dpm_suspend() fails, some devices with power.direct_complete set
may not have been handled by device_suspend() yet, so runtime PM has
not been disabled for them yet even though power.direct_complete is set.

Since device_resume() expects that runtime PM has been disabled for all
devices with power.direct_complete set, it will attempt to reenable
runtime PM for the devices that have not been processed by device_suspend()
which does not make sense.  Had those devices had runtime PM disabled
before device_suspend() had run, device_resume() would have inadvertently
enable runtime PM for them, but this is not expected to happen because
it would require ->prepare() callbacks to return positive values for
devices with runtime PM disabled, which would be invalid.

In practice, this issue is most likely benign because pm_runtime_enable()
will not allow the "disable depth" counter to underflow, but it causes a
warning message to be printed for each affected device.

To allow device_resume() to distinguish the "direct complete" devices
that have been processed by device_suspend() from those which have not
been handled by it, make device_suspend() set power.is_suspended for
"direct complete" devices.

Next, move the power.is_suspended check in device_resume() before the
power.direct_complete check in it to make it skip the "direct complete"
devices that have not been handled by device_suspend().

This change is based on a preliminary patch from Saravana Kannan.

Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily")
Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-2-saravanak@google.com/
Reported-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Saravana Kannan <saravanak@google.com>
Link: https://patch.msgid.link/12627587.O9o76ZdvQC@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 34f1969dab73b..00a0bdcbb4aa8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -900,6 +900,9 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	if (!dev->power.is_suspended)
+		goto Complete;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -918,9 +921,6 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	 */
 	dev->power.is_prepared = false;
 
-	if (!dev->power.is_suspended)
-		goto Unlock;
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
@@ -960,7 +960,6 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_suspended = false;
 
- Unlock:
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
 
@@ -1645,6 +1644,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 			pm_runtime_disable(dev);
 			if (pm_runtime_status_suspended(dev)) {
 				pm_dev_dbg(dev, state, "direct-complete ");
+				dev->power.is_suspended = true;
 				goto Complete;
 			}
 
-- 
2.39.5




