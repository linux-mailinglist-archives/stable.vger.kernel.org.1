Return-Path: <stable+bounces-131123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2CBA807CE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949031BA130B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B2E2676C9;
	Tue,  8 Apr 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/4zHhKG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4F265CD3;
	Tue,  8 Apr 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115549; cv=none; b=I24cBR2lIOJsYt20KKzP9Kt+WdXY7UbEytcDS1EO/ktCKitA6gRzaMN8OKRf0+t+YIUsGjiUarqLKDhQOv09DeVVsi0qXPhKB3NXsN32A/WQY3/8FbH+KHdZTz/lmbdUTNMuuhyZJ11s27/6HLg1j6K3Y2RLByc3YTQbWXtS1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115549; c=relaxed/simple;
	bh=iXm7BEZh8CD49K50tx+erJpOSzdkwgnSwWB/kPnKcKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl/2jlHzl01gNpw9A9bSwmtMtesXKmvcfjZSTlqY6fpnTJ6qxy8azc091dbScN8NYAoT4bf3aUzSHGIOHcqkrvF/XiHQ2B6oYdBj5vLfNw2XrRw+YN/5VTJVJEgQdWKqbvqk9UO4x5f4wQe+/leMthihnJUel7SoC96Q3I9kMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/4zHhKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA20C4CEE5;
	Tue,  8 Apr 2025 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115549;
	bh=iXm7BEZh8CD49K50tx+erJpOSzdkwgnSwWB/kPnKcKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/4zHhKGGT8Eiu0opQjfl6ivoXt4/FeNd7q2dxE3BxWBJaciOKAkgdQWyzM5GjHlJ
	 bQZ0cC5CzXwhKG7Qt/xzI+WQiThAMmGlvOGLY1R1oMr8TY3T33KPDpNMXFVHaRhcxm
	 qMXVdejvqaF8Xfr5Fr09bB4TU0e8hnvuBdnpkvKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/204] PM: sleep: Fix handling devices with direct_complete set on errors
Date: Tue,  8 Apr 2025 12:49:07 +0200
Message-ID: <20250408104820.823694985@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 49728cb628c19..343d3c966e7a7 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -894,6 +894,9 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	if (!dev->power.is_suspended)
+		goto Complete;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -912,9 +915,6 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	 */
 	dev->power.is_prepared = false;
 
-	if (!dev->power.is_suspended)
-		goto Unlock;
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
@@ -954,7 +954,6 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_suspended = false;
 
- Unlock:
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
 
@@ -1638,6 +1637,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 			pm_runtime_disable(dev);
 			if (pm_runtime_status_suspended(dev)) {
 				pm_dev_dbg(dev, state, "direct-complete ");
+				dev->power.is_suspended = true;
 				goto Complete;
 			}
 
-- 
2.39.5




