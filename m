Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E870CA14
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjEVTyo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjEVTyn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBD69C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB8862B70
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E0C433EF;
        Mon, 22 May 2023 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785281;
        bh=gmjbaPMyPLsDV3oBXKV011djaAeV9paJ+ye1im/PCSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLvSkVEEX+b8JIFd09hgUxGxfjHrZ+ByDXAXtZzrl4qoQF2iZD/PjFSX3oRXtBAyK
         kJUodwywXOmEbiqyMsJ1hdDf6H66HgQhKlHePNHwhvpR9JEnrvlTBT3m3fooQdObv9
         lWF7g3kNcWX3nGllYPGjSBlCxQm1qAlAATUhnM4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, stable@kernel.org
Subject: [PATCH 6.3 352/364] s390/dasd: fix command reject error on ESE devices
Date:   Mon, 22 May 2023 20:10:57 +0100
Message-Id: <20230522190421.579138701@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stefan Haberland <sth@linux.ibm.com>

commit c99bff34290f1b994073557b754aff86e4c7b22e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_eckd.c |   33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -127,6 +127,8 @@ static int prepare_itcw(struct itcw *, u
 			struct dasd_device *, struct dasd_device *,
 			unsigned int, int, unsigned int, unsigned int,
 			unsigned int, unsigned int);
+static int dasd_eckd_query_pprc_status(struct dasd_device *,
+				       struct dasd_pprc_data_sc4 *);
 
 /* initial attempt at a probe function. this can be simplified once
  * the other detection code is gone */
@@ -3732,6 +3734,26 @@ static int count_exts(unsigned int from,
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
@@ -3748,6 +3770,7 @@ dasd_eckd_dso_ras(struct dasd_device *de
 	int cur_to_trk, cur_from_trk;
 	struct dasd_ccw_req *cqr;
 	u32 beg_cyl, end_cyl;
+	int copy_relation;
 	struct ccw1 *ccw;
 	int trks_per_ext;
 	size_t ras_size;
@@ -3759,6 +3782,10 @@ dasd_eckd_dso_ras(struct dasd_device *de
 	if (dasd_eckd_ras_sanity_checks(device, first_trk, last_trk))
 		return ERR_PTR(-EINVAL);
 
+	copy_relation = dasd_in_copy_relation(device);
+	if (copy_relation < 0)
+		return ERR_PTR(copy_relation);
+
 	rq = req ? blk_mq_rq_to_pdu(req) : NULL;
 
 	features = &private->features;
@@ -3787,9 +3814,11 @@ dasd_eckd_dso_ras(struct dasd_device *de
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


