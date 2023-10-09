Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878A87BDE39
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376972AbjJINRT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376966AbjJINRT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:17:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFECB8F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:17:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0F6C433C8;
        Mon,  9 Oct 2023 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857434;
        bh=1nPAR3Gs4cS5edrA8NxvlQHOMMS7duUMdBlDkL0eY8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEpuVhdRyxbVXVlX96MMmruaPc1/iTvVcfrO/XypD7oZaYSjAlkln1IVFDJdK7Ldi
         p2w5GI+BwcufGXSx6cen1J9vIG5G2A4NPxTWb8lfRm5OHTga2XIwYR8H36Qmel2Q8D
         Nhf0amgrhHjLnyAX9neFN7IGyTeG2jYuAYwkGx4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.g.garry@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 018/162] scsi: core: Improve type safety of scsi_rescan_device()
Date:   Mon,  9 Oct 2023 14:59:59 +0200
Message-ID: <20231009130123.449902536@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 79519528a180c64a90863db2ce70887de6c49d16 ]

Most callers of scsi_rescan_device() have the scsi_device pointer readily
available. Pass a struct scsi_device pointer to scsi_rescan_device()
instead of a struct device pointer. This change prevents that a pointer to
another struct device would be passed accidentally to scsi_rescan_device().

Remove the scsi_rescan_device() declaration from the scsi_priv.h header
file since it duplicates the declaration in <scsi/scsi_host.h>.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230822153043.4046244-1-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 8b4d9469d0b0 ("ata: libata-scsi: Fix delayed scsi_rescan_device() execution")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c             | 2 +-
 drivers/scsi/aacraid/commsup.c        | 2 +-
 drivers/scsi/mvumi.c                  | 2 +-
 drivers/scsi/scsi_lib.c               | 2 +-
 drivers/scsi/scsi_priv.h              | 1 -
 drivers/scsi/scsi_scan.c              | 4 ++--
 drivers/scsi/scsi_sysfs.c             | 4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 drivers/scsi/storvsc_drv.c            | 2 +-
 drivers/scsi/virtio_scsi.c            | 2 +-
 include/scsi/scsi_host.h              | 2 +-
 11 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8cc8268327f0c..b348f77b91231 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4678,7 +4678,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			}
 
 			spin_unlock_irqrestore(ap->lock, flags);
-			scsi_rescan_device(&(sdev->sdev_gendev));
+			scsi_rescan_device(sdev);
 			scsi_device_put(sdev);
 			spin_lock_irqsave(ap->lock, flags);
 		}
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 3f062e4013ab6..013a9a334972e 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1451,7 +1451,7 @@ static void aac_handle_aif(struct aac_dev * dev, struct fib * fibptr)
 #endif
 				break;
 			}
-			scsi_rescan_device(&device->sdev_gendev);
+			scsi_rescan_device(device);
 			break;
 
 		default:
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 05d3ce9b72dba..c4acf65379d20 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1500,7 +1500,7 @@ static void mvumi_rescan_devices(struct mvumi_hba *mhba, int id)
 
 	sdev = scsi_device_lookup(mhba->shost, 0, id, 0);
 	if (sdev) {
-		scsi_rescan_device(&sdev->sdev_gendev);
+		scsi_rescan_device(sdev);
 		scsi_device_put(sdev);
 	}
 }
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index fb6e9a7a7f58b..d25e1c2472538 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2445,7 +2445,7 @@ static void scsi_evt_emit(struct scsi_device *sdev, struct scsi_event *evt)
 		envp[idx++] = "SDEV_MEDIA_CHANGE=1";
 		break;
 	case SDEV_EVT_INQUIRY_CHANGE_REPORTED:
-		scsi_rescan_device(&sdev->sdev_gendev);
+		scsi_rescan_device(sdev);
 		envp[idx++] = "SDEV_UA=INQUIRY_DATA_HAS_CHANGED";
 		break;
 	case SDEV_EVT_CAPACITY_CHANGE_REPORTED:
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index c52de9a973e46..b14545acb40f5 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -132,7 +132,6 @@ extern int scsi_complete_async_scans(void);
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
 				   unsigned int, u64, enum scsi_scan_mode);
 extern void scsi_forget_host(struct Scsi_Host *);
-extern void scsi_rescan_device(struct device *);
 
 /* scsi_sysctl.c */
 #ifdef CONFIG_SYSCTL
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index d12f2dcb4040a..445989f44d3f2 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1611,9 +1611,9 @@ int scsi_add_device(struct Scsi_Host *host, uint channel,
 }
 EXPORT_SYMBOL(scsi_add_device);
 
-void scsi_rescan_device(struct device *dev)
+void scsi_rescan_device(struct scsi_device *sdev)
 {
-	struct scsi_device *sdev = to_scsi_device(dev);
+	struct device *dev = &sdev->sdev_gendev;
 
 	device_lock(dev);
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index cac7c902cf70a..1f531063d6331 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -762,7 +762,7 @@ static ssize_t
 store_rescan_field (struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	scsi_rescan_device(dev);
+	scsi_rescan_device(to_scsi_device(dev));
 	return count;
 }
 static DEVICE_ATTR(rescan, S_IWUSR, NULL, store_rescan_field);
@@ -855,7 +855,7 @@ store_state_field(struct device *dev, struct device_attribute *attr,
 		 * waiting for pending I/O to finish.
 		 */
 		blk_mq_run_hw_queues(sdev->request_queue, true);
-		scsi_rescan_device(dev);
+		scsi_rescan_device(sdev);
 	}
 
 	return ret == 0 ? count : -EINVAL;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 9f0f69c1ed665..47d487729635c 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2278,7 +2278,7 @@ static void pqi_update_device_list(struct pqi_ctrl_info *ctrl_info,
 			device->advertised_queue_depth = device->queue_depth;
 			scsi_change_queue_depth(device->sdev, device->advertised_queue_depth);
 			if (device->rescan) {
-				scsi_rescan_device(&device->sdev->sdev_gendev);
+				scsi_rescan_device(device->sdev);
 				device->rescan = false;
 			}
 		}
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7a1dc5c7c49ee..c2d981d5a2dd5 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -471,7 +471,7 @@ static void storvsc_device_scan(struct work_struct *work)
 	sdev = scsi_device_lookup(wrk->host, 0, wrk->tgt_id, wrk->lun);
 	if (!sdev)
 		goto done;
-	scsi_rescan_device(&sdev->sdev_gendev);
+	scsi_rescan_device(sdev);
 	scsi_device_put(sdev);
 
 done:
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 2a79ab16134b1..3f8c553f3d91e 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -325,7 +325,7 @@ static void virtscsi_handle_param_change(struct virtio_scsi *vscsi,
 	/* Handle "Parameters changed", "Mode parameters changed", and
 	   "Capacity data has changed".  */
 	if (asc == 0x2a && (ascq == 0x00 || ascq == 0x01 || ascq == 0x09))
-		scsi_rescan_device(&sdev->sdev_gendev);
+		scsi_rescan_device(sdev);
 
 	scsi_device_put(sdev);
 }
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index d27d9fb7174c8..16848def47a1d 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -752,7 +752,7 @@ extern int __must_check scsi_add_host_with_dma(struct Scsi_Host *,
 					       struct device *,
 					       struct device *);
 extern void scsi_scan_host(struct Scsi_Host *);
-extern void scsi_rescan_device(struct device *);
+extern void scsi_rescan_device(struct scsi_device *);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
 extern int scsi_host_busy(struct Scsi_Host *shost);
-- 
2.40.1



