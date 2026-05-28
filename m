Return-Path: <stable+bounces-256234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPJpGjCrGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:53:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE605F9C49
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6683310B459
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F08318B9D;
	Thu, 28 May 2026 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wGWpibkg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1523394D;
	Thu, 28 May 2026 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001132; cv=none; b=iyfUxRVZRcNBOBhGh0ZYZ2M5md6EccFk8M5O+kFOQTJXONAgBkso5HuOgjXLQxQiJ3AoBa18gZAdV7UoRm8mbHjw4OVIUhehIx0nhjF/98vpDfAIIGaLFS3BVwRZr/CIbh4tXwdATzC9CfczuvqNv8nCqLVD7752OpdI3N1BAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001132; c=relaxed/simple;
	bh=udNkUWk06BdbEJcdrmruoew4HWf3SiIfkWBz6oBnECU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMbwnbBnBWmHg2V03imArsYoekbdhfZtTNImA0YZP9l32OBlngVXPumZN61hxlVQK5ZavRN+IyBHSsDkiSSvtiugKxKItsEcA0caFvp5SpHUtGt9GkXD9AChxBsbmO3iMqKHsD1OfqVJNgs4OqOt9DLGfgfNzQmD5fAQcchMqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wGWpibkg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B81F000E9;
	Thu, 28 May 2026 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001131;
	bh=b5Qkk3N5y520gf526ffn+YEHhvc/71/LgPMw+VbMvW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wGWpibkgDMBTWSpOlXNcFcToAqFYAUWI6O94vexzdKmcKsE8VhWXCvVRwUV1ay/YB
	 yY6/aXKkOKRUX9Hv+HKECiMbrzQMdl35aFgol/O950PuLOSNu4pEjC61LQOOXnZooq
	 GWJRO+pXGPir47g67JRMgQUOvRpN1HSeRFyZ+oVk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/186] Revert "s390/cio: Update purge function to unregister the unused subchannels"
Date: Thu, 28 May 2026 21:48:19 +0200
Message-ID: <20260528194929.474769081@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256234-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1CE605F9C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit c34b09cbd6fc06f0f234182e462a1b010d13a5a6.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/device.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 93307ca75c10b..e623359862ea2 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1318,34 +1318,23 @@ void ccw_device_schedule_recovery(void)
 	spin_unlock_irqrestore(&recovery_lock, flags);
 }
 
-static int purge_fn(struct subchannel *sch, void *data)
+static int purge_fn(struct device *dev, void *data)
 {
-	struct ccw_device *cdev;
-
-	spin_lock_irq(sch->lock);
-	if (sch->st != SUBCHANNEL_TYPE_IO || !sch->schib.pmcw.dnv)
-		goto unlock;
-
-	if (!is_blacklisted(sch->schid.ssid, sch->schib.pmcw.dev))
-		goto unlock;
-
-	cdev = sch_get_cdev(sch);
-	if (cdev) {
-		if (cdev->private->state != DEV_STATE_OFFLINE)
-			goto unlock;
+	struct ccw_device *cdev = to_ccwdev(dev);
+	struct ccw_dev_id *id = &cdev->private->dev_id;
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 
-		if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
-			goto unlock;
+	spin_lock_irq(cdev->ccwlock);
+	if (is_blacklisted(id->ssid, id->devno) &&
+	    (cdev->private->state == DEV_STATE_OFFLINE) &&
+	    (atomic_cmpxchg(&cdev->private->onoff, 0, 1) == 0)) {
+		CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", id->ssid,
+			      id->devno);
 		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
+		css_sched_sch_todo(sch, SCH_TODO_UNREG);
 		atomic_set(&cdev->private->onoff, 0);
 	}
-
-	css_sched_sch_todo(sch, SCH_TODO_UNREG);
-	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x%s\n", sch->schid.ssid,
-		      sch->schib.pmcw.dev, cdev ? "" : " (no cdev)");
-
-unlock:
-	spin_unlock_irq(sch->lock);
+	spin_unlock_irq(cdev->ccwlock);
 	/* Abort loop in case of pending signal. */
 	if (signal_pending(current))
 		return -EINTR;
@@ -1361,7 +1350,7 @@ static int purge_fn(struct subchannel *sch, void *data)
 int ccw_purge_blacklisted(void)
 {
 	CIO_MSG_EVENT(2, "ccw: purging blacklisted devices\n");
-	for_each_subchannel_staged(purge_fn, NULL, NULL);
+	bus_for_each_dev(&ccw_bus_type, NULL, NULL, purge_fn);
 	return 0;
 }
 
-- 
2.53.0




