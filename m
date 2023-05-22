Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164A70C4EC
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjEVSEd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjEVSEc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BE910D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D636625F1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D85EC433EF;
        Mon, 22 May 2023 18:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778647;
        bh=MMISMSHy+huy5xaf6Rcoi3XTbkYpGaTw5hiGOvL987M=;
        h=Subject:To:Cc:From:Date:From;
        b=1cWTkCnXxWuHURGSV/S9VyYTGH8HOMCBh6L68SVs6erIk5D66ZDD6z0TJE8OGqJpN
         gvGANZNWaj7+Vx1z6bD1/dyJKQdhlO6zCekuLjQcfvQpNBuzpSlYsPjq6d5U/zTlf7
         LrzPHdQzEA3lkZ7cK8J4DCoBr7zBUdve98VM3MJ0=
Subject: FAILED: patch "[PATCH] s390/dasd: fix command reject error on ESE devices" failed to apply to 5.4-stable tree
To:     sth@linux.ibm.com, axboe@kernel.dk, hoeppner@linux.ibm.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:03:55 +0100
Message-ID: <2023052255-gizmo-diagnosis-dd08@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x c99bff34290f1b994073557b754aff86e4c7b22e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052255-gizmo-diagnosis-dd08@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

c99bff34290f ("s390/dasd: fix command reject error on ESE devices")
542e30ce8e6e ("s390/dasd: summarize dasd configuration data in a separate structure")
23596961b437 ("s390/dasd: split up dasd_eckd_read_conf")
952835edb4fd ("s390/dasd: fix use after free in dasd path handling")
2b7a8dc06d0f ("s390/dasd: Avoid field over-reading memcpy()")
b72949328869 ("s390/dasd: Prepare for additional path event handling")
19508b204740 ("s390/dasd: Display FC Endpoint Security information via sysfs")
9e34c8ba9169 ("s390/dasd: Fix operational path inconsistency")
460181217a24 ("s390/dasd: Store path configuration data during path handling")
d2a527580c0a ("s390/dasd: Move duplicate code to separate function")
5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned devices")
00b39f698a4f ("s390/dasd: fix memleak in path handling error case")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c99bff34290f1b994073557b754aff86e4c7b22e Mon Sep 17 00:00:00 2001
From: Stefan Haberland <sth@linux.ibm.com>
Date: Fri, 19 May 2023 12:23:40 +0200
Subject: [PATCH] s390/dasd: fix command reject error on ESE devices

Formatting a thin-provisioned (ESE) device that is part of a PPRC copy
relation might fail with the following error:

dasd-eckd 0.0.f500: An error occurred in the DASD device driver, reason=09
[...]
24 Byte: 0 MSG 4, no MSGb to SYSOP

During format of an ESE disk the Release Allocated Space command is used.
A bit in the payload of the command is set that is not allowed to be set
for devices in a copy relation. This bit is set to allow the partial
release of an extent.

Check for the existence of a copy relation before setting the respective
bit.

Fixes: 91dc4a197569 ("s390/dasd: Add new ioctl to release space")
Cc: stable@kernel.org # 5.3+
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20230519102340.3854819-2-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ade1369fe5ed..113c509bf6d0 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -127,6 +127,8 @@ static int prepare_itcw(struct itcw *, unsigned int, unsigned int, int,
 			struct dasd_device *, struct dasd_device *,
 			unsigned int, int, unsigned int, unsigned int,
 			unsigned int, unsigned int);
+static int dasd_eckd_query_pprc_status(struct dasd_device *,
+				       struct dasd_pprc_data_sc4 *);
 
 /* initial attempt at a probe function. this can be simplified once
  * the other detection code is gone */
@@ -3733,6 +3735,26 @@ static int count_exts(unsigned int from, unsigned int to, int trks_per_ext)
 	return count;
 }
 
+static int dasd_in_copy_relation(struct dasd_device *device)
+{
+	struct dasd_pprc_data_sc4 *temp;
+	int rc;
+
+	if (!dasd_eckd_pprc_enabled(device))
+		return 0;
+
+	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	rc = dasd_eckd_query_pprc_status(device, temp);
+	if (!rc)
+		rc = temp->dev_info[0].state;
+
+	kfree(temp);
+	return rc;
+}
+
 /*
  * Release allocated space for a given range or an entire volume.
  */
@@ -3749,6 +3771,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	int cur_to_trk, cur_from_trk;
 	struct dasd_ccw_req *cqr;
 	u32 beg_cyl, end_cyl;
+	int copy_relation;
 	struct ccw1 *ccw;
 	int trks_per_ext;
 	size_t ras_size;
@@ -3760,6 +3783,10 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (dasd_eckd_ras_sanity_checks(device, first_trk, last_trk))
 		return ERR_PTR(-EINVAL);
 
+	copy_relation = dasd_in_copy_relation(device);
+	if (copy_relation < 0)
+		return ERR_PTR(copy_relation);
+
 	rq = req ? blk_mq_rq_to_pdu(req) : NULL;
 
 	features = &private->features;
@@ -3788,9 +3815,11 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	/*
 	 * This bit guarantees initialisation of tracks within an extent that is
 	 * not fully specified, but is only supported with a certain feature
-	 * subset.
+	 * subset and for devices not in a copy relation.
 	 */
-	ras_data->op_flags.guarantee_init = !!(features->feature[56] & 0x01);
+	if (features->feature[56] & 0x01 && !copy_relation)
+		ras_data->op_flags.guarantee_init = 1;
+
 	ras_data->lss = private->conf.ned->ID;
 	ras_data->dev_addr = private->conf.ned->unit_addr;
 	ras_data->nr_exts = nr_exts;

