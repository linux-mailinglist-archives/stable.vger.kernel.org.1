Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D05735424
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjFSKwm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjFSKwP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659CE1B8
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E53DF60B5F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86FEC433C8;
        Mon, 19 Jun 2023 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171875;
        bh=bsx0pDijI2UiyIllwZzFkWcQOIJQPeZhNFtfchrVIo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mRD+9CfKjznlN85t7sLOKFS4Y4gistXlkIksD6VWNah1nn6CF8CiRipG4EjBy6eW
         FwZh0Go0f220cWcY1sGp5muL+Ks5JDzbmpMGn0SU4Q2nvqSl+4TpcsLR/RqgIBXvW6
         RIttu8lfF8IGZwaWZeLWl+3rBkDOwUUixj2ZMMSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Stefan Haberland <sth@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 03/64] dasd: refactor dasd_ioctl_information
Date:   Mon, 19 Jun 2023 12:29:59 +0200
Message-ID: <20230619102132.998127767@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 9353848c6589ffe6373d03f3a58feaeda1009641 ]

Prepare for in-kernel callers of this functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[sth@de.ibm.com: remove leftover kfree]
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: ccc45cb4e727 ("s390/dasd: Use correct lock while counting channel queue length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_ioctl.c | 42 ++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9a5f3add325fc..9b7782395c379 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -457,10 +457,9 @@ static int dasd_ioctl_read_profile(struct dasd_block *block, void __user *argp)
 /*
  * Return dasd information. Used for BIODASDINFO and BIODASDINFO2.
  */
-static int dasd_ioctl_information(struct dasd_block *block,
-				  unsigned int cmd, void __user *argp)
+static int __dasd_ioctl_information(struct dasd_block *block,
+		struct dasd_information2_t *dasd_info)
 {
-	struct dasd_information2_t *dasd_info;
 	struct subchannel_id sch_id;
 	struct ccw_dev_id dev_id;
 	struct dasd_device *base;
@@ -473,15 +472,9 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	if (!base->discipline || !base->discipline->fill_info)
 		return -EINVAL;
 
-	dasd_info = kzalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
-	if (dasd_info == NULL)
-		return -ENOMEM;
-
 	rc = base->discipline->fill_info(base, dasd_info);
-	if (rc) {
-		kfree(dasd_info);
+	if (rc)
 		return rc;
-	}
 
 	cdev = base->cdev;
 	ccw_device_get_id(cdev, &dev_id);
@@ -520,15 +513,24 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
 	spin_unlock_irqrestore(&block->queue_lock, flags);
+	return 0;
+}
 
-	rc = 0;
-	if (copy_to_user(argp, dasd_info,
-			 ((cmd == (unsigned int) BIODASDINFO2) ?
-			  sizeof(struct dasd_information2_t) :
-			  sizeof(struct dasd_information_t))))
-		rc = -EFAULT;
+static int dasd_ioctl_information(struct dasd_block *block, void __user *argp,
+		size_t copy_size)
+{
+	struct dasd_information2_t *dasd_info;
+	int error;
+
+	dasd_info = kzalloc(sizeof(*dasd_info), GFP_KERNEL);
+	if (!dasd_info)
+		return -ENOMEM;
+
+	error = __dasd_ioctl_information(block, dasd_info);
+	if (!error && copy_to_user(argp, dasd_info, copy_size))
+		error = -EFAULT;
 	kfree(dasd_info);
-	return rc;
+	return error;
 }
 
 /*
@@ -622,10 +624,12 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 		rc = dasd_ioctl_check_format(bdev, argp);
 		break;
 	case BIODASDINFO:
-		rc = dasd_ioctl_information(block, cmd, argp);
+		rc = dasd_ioctl_information(block, argp,
+				sizeof(struct dasd_information_t));
 		break;
 	case BIODASDINFO2:
-		rc = dasd_ioctl_information(block, cmd, argp);
+		rc = dasd_ioctl_information(block, argp,
+				sizeof(struct dasd_information2_t));
 		break;
 	case BIODASDPRRD:
 		rc = dasd_ioctl_read_profile(block, argp);
-- 
2.39.2



