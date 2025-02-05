Return-Path: <stable+bounces-113213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E85A2907D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B567A12C1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A8155747;
	Wed,  5 Feb 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mFlO5GoH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E31151988;
	Wed,  5 Feb 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766200; cv=none; b=QMnrnQav/BuTP/CHMwqTaBdNXIE8u0m4fbu83NXG+OMpMR8y0cecShXAmS6A/qMq4CfLiUW3hrasXO1sASr2Kgvzs2DqDa4FL007dEjjD9xuEwKNg6XFpn3rZGpPn9ILwZEgCTHysuED/3hIV5OdCUYxB4z62bP4MzfJP+rElTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766200; c=relaxed/simple;
	bh=JrRji7G0N/OpZHIsA+LW7AC8hw9+DxETMhDx65MzCsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYa4tHSylHWCjLKFXAndwimf/ztXipsbIA97bZqMJEOu0W/BqP3gq7Qx/Mwxbuapk4L1NN71h+YzLhBJKggdoJTOHqALG4wBoEqbSjme08M60Sknyxw1XxuGLWpi2E5UFliz5Fx0PQw04EgngwmQRZaHYPqB3MyCgXYt6XBicpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mFlO5GoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0663C4CED1;
	Wed,  5 Feb 2025 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766200;
	bh=JrRji7G0N/OpZHIsA+LW7AC8hw9+DxETMhDx65MzCsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFlO5GoHpsXr+lpnQub2SD2fwCMANPGv6cAGN5OFgsf5zNpIard7OPaYjJ/I4Q5X5
	 qR5W4ssrvZQ+KozOkPppGMomqAwSowa+KJB80IskE5guZyOCDPDRk5SDcLrCNmQ57/
	 GS9Z1UYrEFFoFD9H3CZNvSa6zSk0pRjp/vf1EAL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 339/393] PM: sleep: core: Synchronize runtime PM status of parents and children
Date: Wed,  5 Feb 2025 14:44:18 +0100
Message-ID: <20250205134433.280694460@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 3775fc538f535a7c5adaf11990c7932a0bd1f9eb ]

Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
resume phase") overlooked the case in which the parent of a device with
DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime-
suspended before a transition into a system-wide sleep state.  In that
case, if the child is resumed during the subsequent transition from
that state into the working state, its runtime PM status will be set to
RPM_ACTIVE, but the runtime PM status of the parent will not be updated
accordingly, even though the parent will be resumed too, because of the
dev_pm_skip_suspend() check in device_resume_noirq().

Address this problem by tracking the need to set the runtime PM status
to RPM_ACTIVE during system-wide resume transitions for devices with
DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them.

Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsulting.com/
Reported-by: Johan Hovold <johan@kernel.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://patch.msgid.link/12619233.O9o76ZdvQC@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/main.c | 29 ++++++++++++++++++++---------
 include/linux/pm.h        |  1 +
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index fadcd0379dc2d..fd2d975de536f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -614,13 +614,15 @@ static void device_resume_noirq(struct device *dev, pm_message_t state, bool asy
 	 * so change its status accordingly.
 	 *
 	 * Otherwise, the device is going to be resumed, so set its PM-runtime
-	 * status to "active", but do that only if DPM_FLAG_SMART_SUSPEND is set
-	 * to avoid confusing drivers that don't use it.
+	 * status to "active" unless its power.set_active flag is clear, in
+	 * which case it is not necessary to update its PM-runtime status.
 	 */
-	if (skip_resume)
+	if (skip_resume) {
 		pm_runtime_set_suspended(dev);
-	else if (dev_pm_skip_suspend(dev))
+	} else if (dev->power.set_active) {
 		pm_runtime_set_active(dev);
+		dev->power.set_active = false;
+	}
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -1170,18 +1172,24 @@ static pm_message_t resume_event(pm_message_t sleep_state)
 	return PMSG_ON;
 }
 
-static void dpm_superior_set_must_resume(struct device *dev)
+static void dpm_superior_set_must_resume(struct device *dev, bool set_active)
 {
 	struct device_link *link;
 	int idx;
 
-	if (dev->parent)
+	if (dev->parent) {
 		dev->parent->power.must_resume = true;
+		if (set_active)
+			dev->parent->power.set_active = true;
+	}
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
 		link->supplier->power.must_resume = true;
+		if (set_active)
+			link->supplier->power.set_active = true;
+	}
 
 	device_links_read_unlock(idx);
 }
@@ -1257,8 +1265,11 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	      dev->power.may_skip_resume))
 		dev->power.must_resume = true;
 
-	if (dev->power.must_resume)
-		dpm_superior_set_must_resume(dev);
+	if (dev->power.must_resume) {
+		dev->power.set_active = dev->power.set_active ||
+			dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
+		dpm_superior_set_must_resume(dev, dev->power.set_active);
+	}
 
 Complete:
 	complete_all(&dev->power.completion);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 9e1c60cd60e5a..1ad57c98264af 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -683,6 +683,7 @@ struct dev_pm_info {
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
 	bool			async_in_progress:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
+	bool			set_active:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
 #else
 	bool			should_wakeup:1;
-- 
2.39.5




