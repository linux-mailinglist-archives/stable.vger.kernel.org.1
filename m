Return-Path: <stable+bounces-266122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cXH2Gy2YMWrmngUAu9opvQ
	(envelope-from <stable+bounces-266122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:38:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C77806944B1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:38:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NUnHGt5i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266122-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266122-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDDDD31AA80D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FCB3D8902;
	Tue, 16 Jun 2026 18:33:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3613DA7E1;
	Tue, 16 Jun 2026 18:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634780; cv=none; b=KgvYq4pjvGPXfZ6eTj1VICnrUzyAvvg5FxLyp941YfEUTVNP2QKCZtkg7LdoshDSmYblBtmeIQpXtx1wHSUhdQwFJ0Ti0N9P4txeskqP1Tv9dgN8xjE+KTvbpkVKS4ou8jO29DeCieQmynuJE8R5bx0ej0hj8ytpyXNe95BE6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634780; c=relaxed/simple;
	bh=kt/sYcQN8of6srmzCJ+rRO8oVMUMK5NyH8jLyGJEvyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDGA1AaONLK5iX5S1Fz2gOS4pogwDW1goUrxFYhcWD0I/n/zk4ZNPn4hzciMhMRqltB3/Go9j+XX9tjhZpolgSPV6Gpmt1SS7sWwoLBaASeNZjVp+NQMQnQ1H4wuCCadUgSDHepoc1PjfsvIyXUfGFxL7yFyFx+AVE2bLq4Gy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NUnHGt5i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48001F000E9;
	Tue, 16 Jun 2026 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634778;
	bh=hgbntu6jrw+l54ltMeMunnNKhrbd1aAK3JfptAKp17I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NUnHGt5ia9f0gg8J1sTVfrFUUcvYuDo6lxC93P68GB+Ym1Wz2r68XWbfUYDH7zINK
	 2VPUgcuW055u6iFcDJwqCuQQJOGXr0ZKbB35XCmgE9CvdycZcSLIhUoHu+HdSX8zsM
	 RqcB7YB7+UMzX11DPMh12vqk7Od/l5VYJj8QMxlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 297/411] sd: rename the scsi_disk.dev field
Date: Tue, 16 Jun 2026 20:28:55 +0530
Message-ID: <20260616145116.943119013@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266122-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:hch@lst.de,m:bvanassche@acm.org,m:kch@nvidia.com,m:ming.lei@redhat.com,m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,nvidia.com:email,oracle.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel.dk:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,acm.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C77806944B1

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit fad45c3007a18064da759b4dba35eb722bc64e97 ]

dev is very hard to grep for.  Give the field a more descriptive name and
documents its purpose.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20220308055200.735835-5-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 1e111c4b3a72 ("scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sd.c |   22 +++++++++++-----------
 drivers/scsi/sd.h |    9 +++++++--
 2 files changed, 18 insertions(+), 13 deletions(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -674,7 +674,7 @@ static struct scsi_disk *scsi_disk_get(s
 	if (disk->private_data) {
 		sdkp = scsi_disk(disk);
 		if (scsi_device_get(sdkp->device) == 0)
-			get_device(&sdkp->dev);
+			get_device(&sdkp->disk_dev);
 		else
 			sdkp = NULL;
 	}
@@ -687,7 +687,7 @@ static void scsi_disk_put(struct scsi_di
 	struct scsi_device *sdev = sdkp->device;
 
 	mutex_lock(&sd_ref_mutex);
-	put_device(&sdkp->dev);
+	put_device(&sdkp->disk_dev);
 	scsi_device_put(sdev);
 	mutex_unlock(&sd_ref_mutex);
 }
@@ -3412,14 +3412,14 @@ static int sd_probe(struct device *dev)
 					     SD_MOD_TIMEOUT);
 	}
 
-	device_initialize(&sdkp->dev);
-	sdkp->dev.parent = get_device(dev);
-	sdkp->dev.class = &sd_disk_class;
-	dev_set_name(&sdkp->dev, "%s", dev_name(dev));
+	device_initialize(&sdkp->disk_dev);
+	sdkp->disk_dev.parent = get_device(dev);
+	sdkp->disk_dev.class = &sd_disk_class;
+	dev_set_name(&sdkp->disk_dev, "%s", dev_name(dev));
 
-	error = device_add(&sdkp->dev);
+	error = device_add(&sdkp->disk_dev);
 	if (error) {
-		put_device(&sdkp->dev);
+		put_device(&sdkp->disk_dev);
 		goto out;
 	}
 
@@ -3461,7 +3461,7 @@ static int sd_probe(struct device *dev)
 
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
-		put_device(&sdkp->dev);
+		put_device(&sdkp->disk_dev);
 		goto out;
 	}
 
@@ -3511,7 +3511,7 @@ static int sd_remove(struct device *dev)
 	sdkp = dev_get_drvdata(dev);
 	scsi_autopm_get_device(sdkp->device);
 
-	device_del(&sdkp->dev);
+	device_del(&sdkp->disk_dev);
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
 
@@ -3519,7 +3519,7 @@ static int sd_remove(struct device *dev)
 
 	mutex_lock(&sd_ref_mutex);
 	dev_set_drvdata(dev, NULL);
-	put_device(&sdkp->dev);
+	put_device(&sdkp->disk_dev);
 	mutex_unlock(&sd_ref_mutex);
 
 	return 0;
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -70,7 +70,12 @@ enum {
 struct scsi_disk {
 	struct scsi_driver *driver;	/* always &sd_template */
 	struct scsi_device *device;
-	struct device	dev;
+
+	/*
+	 * disk_dev is used to show attributes in /sys/class/scsi_disk/,
+	 * but otherwise not really needed.  Do not use for refcounting.
+	 */
+	struct device	disk_dev;
 	struct gendisk	*disk;
 	struct opal_dev *opal_dev;
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -126,7 +131,7 @@ struct scsi_disk {
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
 };
-#define to_scsi_disk(obj) container_of(obj,struct scsi_disk,dev)
+#define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 
 static inline struct scsi_disk *scsi_disk(struct gendisk *disk)
 {



