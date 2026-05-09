Return-Path: <stable+bounces-244972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKptCRtc/2mQ5QAAu9opvQ
	(envelope-from <stable+bounces-244972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:08:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E057D5006E7
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A5F730041F7
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271827CB02;
	Sat,  9 May 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjYULhzi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7B2EA754
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342934; cv=none; b=uXmp4/LGWdfPhVkGWqG6bzjLkcu/vyF/Mj7j2IER40LDNM/6tO7natAJSiJDCbu5f+Wk8iwnCtPOed4OEk7VMl79rRNaEuwFBZfJd0xiyW6ktJyngiILjPPcdNJqulI0bmMJc5/TxT1rc/2RGmTGMVUD+2sfCMx/cup4Ky0GkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342934; c=relaxed/simple;
	bh=q/rFudUdOmpSTne66DEte+tJWtpbs+LFC4OopMBZS9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+XCp0+1VvTY8cTxv7/ieKFa+K+UOvjXa20yN4oGG2DgMog0iFxyqYPocRlnKihk4iWWZvO8MXVTlvOVoTkQpy9C2LxqYi/+XFoZO+gsQ1wpmx2xjeTRrLRJLmvlgG/Rf0f3wuMtyPwE88rlRUPsw5f270h+fVFkqplypeTAGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjYULhzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E93CC2BCB2;
	Sat,  9 May 2026 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342934;
	bh=q/rFudUdOmpSTne66DEte+tJWtpbs+LFC4OopMBZS9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjYULhzircGQGqKL2jxMYYWfZ+djnTtGffDJfLrSyE2J0fwHfzACLFpGp67jMf9nf
	 doRPVON/UYv4LXYbzoaRr0O4vwi6NXIHkbfMRIIPxeGYrJa+l2rpQ4s4pt64Ibc1l0
	 TI/PAgpqYM23L5ApIKJSfcT8kvUqkroCsA1Lzni+9iHWYGxQ4jlXd8RuX0rYJtSS/H
	 IgTjzJu3uO8lVdflCl9jOWEGTJsSwxlZDdSFI2vrdf6WCkYcj44bHR0GxtEl+M0rUv
	 SFzrlb+/5IjBVuSRJ6lRJdgwevMSWQvZtGt3/HP7g28gn5oEBd57PjFrwKzDtQfXP9
	 C8bPYbKVkR/4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] sd: rename the scsi_disk.dev field
Date: Sat,  9 May 2026 12:08:48 -0400
Message-ID: <20260509160849.3584738-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509160849.3584738-1-sashal@kernel.org>
References: <2026050456-overview-shaking-6135@gregkh>
 <20260509160849.3584738-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E057D5006E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244972-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

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
---
 drivers/scsi/sd.c | 22 +++++++++++-----------
 drivers/scsi/sd.h |  9 +++++++--
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 91cbe7d569c05..6c6cca6664c94 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -674,7 +674,7 @@ static struct scsi_disk *scsi_disk_get(struct gendisk *disk)
 	if (disk->private_data) {
 		sdkp = scsi_disk(disk);
 		if (scsi_device_get(sdkp->device) == 0)
-			get_device(&sdkp->dev);
+			get_device(&sdkp->disk_dev);
 		else
 			sdkp = NULL;
 	}
@@ -687,7 +687,7 @@ static void scsi_disk_put(struct scsi_disk *sdkp)
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
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index b59136c4125ba..f97eb3fe045b9 100644
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
-- 
2.53.0


