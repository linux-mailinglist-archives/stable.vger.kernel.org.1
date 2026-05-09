Return-Path: <stable+bounces-244970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RrspNBlc/2mQ5QAAu9opvQ
	(envelope-from <stable+bounces-244970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:08:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 443445006D9
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D2FC3010B9B
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EFD2D0617;
	Sat,  9 May 2026 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpCW2R6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A8282F3F
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342932; cv=none; b=af6PFs00KuNtCpkaXktbwirHraxSXUhIMviiPw0OXTAOh7trhrRMowD0tFRjqbYzxtI8F1pgo3l7NgOQ6fp6pNfnl4ggyJ971AeOu7Nn92tQ7I1bCi5rUrDS9PWL0BqHPTJcBPXPo2xiHMRoovbnuz23vZ7JkTp8XeAWfHi4P9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342932; c=relaxed/simple;
	bh=e6mGxAGp2jGPFUSyH0hKA1xBOBNqPy9grdPlsl3dLGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdgchlKjIM3NlEGo9KyqQi+rT3IzFLsypPIplvR7iqbM+pGg6zGYYnvNn931gKcCBzOgkkHfTGH/Pu8LxKjlKedTD6VVIqnO8Zo8HOO4rDFkEsF7gUgZF+9lgEUSfHj5yCadCG2a6oY1NAMB3dXJJxhKBp0nm8e+5WulRxbdQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpCW2R6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FA6C2BCB2;
	Sat,  9 May 2026 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342932;
	bh=e6mGxAGp2jGPFUSyH0hKA1xBOBNqPy9grdPlsl3dLGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpCW2R6dd5OeuLs9i6se3DvnMPvcL0LfeamMfBNW1bPOLZSX1CwdN0Ju6VetGZfDg
	 GwtAXs4bVgYtS0DZjgQFPysGGnmEQtBlPN9mwgJ92aTlLkDh8J0wap3FpTDuIC8LKo
	 7/eL8G0jnb7UxRVxTEQuCFxqRYsAoO/FwXbsoD5LtE/I1EgbpRx8t+e03MtYJFKjYt
	 0TQtChORbqfnokfuuddFS/Bt7mOqr2vi/jV0f/TXMvedJEBpG7Pl0zi4ZdFMiguazX
	 JyCfPgqCrPS1eqIqaaR5DDAngGT1GIc/KM+jTskTffGOhkhrvLU3ytrUVjbI3eXwP5
	 e5kMrYoMdGJqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Dan Williams <dan.j.williams@intel.com>,
	Hannes Reinecke <hare@suse.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Martin Kepplinger <martin.kepplinger@puri.sm>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] scsi: core: pm: Rely on the device driver core for async power management
Date: Sat,  9 May 2026 12:08:46 -0400
Message-ID: <20260509160849.3584738-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050456-overview-shaking-6135@gregkh>
References: <2026050456-overview-shaking-6135@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 443445006D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244970-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,suse.com:email,intel.com:email,acm.org:email,harvard.edu:email]
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit a19a93e4c6a98c9c0f2f5a6db76846f10d7d1f85 ]

Instead of implementing asynchronous resume support in the SCSI core, rely
on the device driver core for resuming SCSI devices asynchronously.
Instead of only supporting asynchronous resumes, also support asynchronous
suspends.

Link: https://lore.kernel.org/r/20211006215453.3318929-2-bvanassche@acm.org
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 1e111c4b3a72 ("scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hosts.c      |  1 +
 drivers/scsi/scsi.c       |  8 -------
 drivers/scsi/scsi_pm.c    | 44 ++-------------------------------------
 drivers/scsi/scsi_priv.h  |  4 +---
 drivers/scsi/scsi_scan.c  | 17 +++++++++++++++
 drivers/scsi/scsi_sysfs.c |  1 +
 drivers/scsi/sd.c         |  1 -
 7 files changed, 22 insertions(+), 54 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index cf842c97639a7..c7d85591a192f 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -487,6 +487,7 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
 	shost->shost_gendev.bus = &scsi_bus_type;
 	shost->shost_gendev.type = &scsi_host_type;
+	scsi_enable_async_suspend(&shost->shost_gendev);
 
 	device_initialize(&shost->shost_dev);
 	shost->shost_dev.parent = &shost->shost_gendev;
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index a499a57150720..d031c577d5d32 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -86,14 +86,6 @@ unsigned int scsi_logging_level;
 EXPORT_SYMBOL(scsi_logging_level);
 #endif
 
-/*
- * Domain for asynchronous system resume operations.  It is marked 'exclusive'
- * to avoid being included in the async_synchronize_full() that is invoked by
- * dpm_resume().
- */
-ASYNC_DOMAIN_EXCLUSIVE(scsi_sd_pm_domain);
-EXPORT_SYMBOL(scsi_sd_pm_domain);
-
 #ifdef CONFIG_SCSI_LOGGING
 void scsi_log_send(struct scsi_cmnd *cmd)
 {
diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index e91a0a5bc7a3e..c622e7f812daf 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -56,9 +56,6 @@ static int scsi_dev_type_suspend(struct device *dev,
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int err;
 
-	/* flush pending in-flight resume operations, suspend is synchronous */
-	async_synchronize_full_domain(&scsi_sd_pm_domain);
-
 	err = scsi_device_quiesce(to_scsi_device(dev));
 	if (err == 0) {
 		err = cb(dev, pm);
@@ -123,48 +120,11 @@ scsi_bus_suspend_common(struct device *dev,
 	return err;
 }
 
-static void async_sdev_resume(void *dev, async_cookie_t cookie)
-{
-	scsi_dev_type_resume(dev, do_scsi_resume);
-}
-
-static void async_sdev_thaw(void *dev, async_cookie_t cookie)
-{
-	scsi_dev_type_resume(dev, do_scsi_thaw);
-}
-
-static void async_sdev_restore(void *dev, async_cookie_t cookie)
-{
-	scsi_dev_type_resume(dev, do_scsi_restore);
-}
-
 static int scsi_bus_resume_common(struct device *dev,
 		int (*cb)(struct device *, const struct dev_pm_ops *))
 {
-	async_func_t fn;
-
-	if (!scsi_is_sdev_device(dev))
-		fn = NULL;
-	else if (cb == do_scsi_resume)
-		fn = async_sdev_resume;
-	else if (cb == do_scsi_thaw)
-		fn = async_sdev_thaw;
-	else if (cb == do_scsi_restore)
-		fn = async_sdev_restore;
-	else
-		fn = NULL;
-
-	if (fn) {
-		async_schedule_domain(fn, dev, &scsi_sd_pm_domain);
-
-		/*
-		 * If a user has disabled async probing a likely reason
-		 * is due to a storage enclosure that does not inject
-		 * staggered spin-ups.  For safety, make resume
-		 * synchronous as well in that case.
-		 */
-		if (strncmp(scsi_scan_type, "async", 5) != 0)
-			async_synchronize_full_domain(&scsi_sd_pm_domain);
+	if (scsi_is_sdev_device(dev)) {
+		scsi_dev_type_resume(dev, cb);
 	} else {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index b531dec3d4206..2032db81897be 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -117,7 +117,7 @@ extern void scsi_exit_procfs(void);
 #endif /* CONFIG_PROC_FS */
 
 /* scsi_scan.c */
-extern char scsi_scan_type[];
+void scsi_enable_async_suspend(struct device *dev);
 extern int scsi_complete_async_scans(void);
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
 				   unsigned int, u64, enum scsi_scan_mode);
@@ -171,8 +171,6 @@ static inline int scsi_autopm_get_host(struct Scsi_Host *h) { return 0; }
 static inline void scsi_autopm_put_host(struct Scsi_Host *h) {}
 #endif /* CONFIG_PM */
 
-extern struct async_domain scsi_sd_pm_domain;
-
 /* scsi_dh.c */
 #ifdef CONFIG_SCSI_DH
 void scsi_dh_add_device(struct scsi_device *sdev);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 518aa152849ef..b80dd68d79e9d 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -122,6 +122,22 @@ struct async_scan_data {
 	struct completion prev_finished;
 };
 
+/**
+ * scsi_enable_async_suspend - Enable async suspend and resume
+ */
+void scsi_enable_async_suspend(struct device *dev)
+{
+	/*
+	 * If a user has disabled async probing a likely reason is due to a
+	 * storage enclosure that does not inject staggered spin-ups. For
+	 * safety, make resume synchronous as well in that case.
+	 */
+	if (strncmp(scsi_scan_type, "async", 5) != 0)
+		return;
+	/* Enable asynchronous suspend and resume. */
+	device_enable_async_suspend(dev);
+}
+
 /**
  * scsi_complete_async_scans - Wait for asynchronous scans to complete
  *
@@ -499,6 +515,7 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
 	dev_set_name(dev, "target%d:%d:%d", shost->host_no, channel, id);
 	dev->bus = &scsi_bus_type;
 	dev->type = &scsi_target_type;
+	scsi_enable_async_suspend(dev);
 	starget->id = id;
 	starget->channel = channel;
 	starget->can_queue = 0;
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 7d3cbf4e6bc6e..b761c88f32dfe 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1643,6 +1643,7 @@ void scsi_sysfs_device_initialize(struct scsi_device *sdev)
 	device_initialize(&sdev->sdev_gendev);
 	sdev->sdev_gendev.bus = &scsi_bus_type;
 	sdev->sdev_gendev.type = &scsi_dev_type;
+	scsi_enable_async_suspend(&sdev->sdev_gendev);
 	dev_set_name(&sdev->sdev_gendev, "%d:%d:%d:%llu",
 		     sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 1e887c11e83d0..f06cb6c5615a7 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3505,7 +3505,6 @@ static int sd_remove(struct device *dev)
 	sdkp = dev_get_drvdata(dev);
 	scsi_autopm_get_device(sdkp->device);
 
-	async_synchronize_full_domain(&scsi_sd_pm_domain);
 	device_del(&sdkp->dev);
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
-- 
2.53.0


