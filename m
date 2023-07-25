Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E3676125F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjGYLBk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjGYLBR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250CB4EC8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A755861689
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33CAC433C7;
        Tue, 25 Jul 2023 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282726;
        bh=SUVhGosHRum/jUQDTVrIuxx7+v2wL+1/fesjUUKby+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGqsLbLKHnt3C9tMkWBDZ5h5gu3JV9GoD1FV90hNBT3yZxeWa6l1bznvu4j8v7ylj
         NIYiGXJSf6m+PfH5/kcYNbf9jwGda/0rX4BzRUS2opbVWt/KdYmxpmlDNQIWqTMpq2
         8Hdu4LKGQm23nAzHwwra0DSaF5ZKqrlBd5DRJgN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Hartmayer <mhartmay@linux.ibm.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 225/227] scsi: sg: Fix checking return value of blk_get_queue()
Date:   Tue, 25 Jul 2023 12:46:32 +0200
Message-ID: <20230725104524.013873253@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

commit 80b6051085c5fedcb1dfd7b2562a63a83655c4d8 upstream.

Commit fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference") make
a mess how blk_get_queue() is called, blk_get_queue() returns true on
success while the caller expects it returns 0 on success.

Fix this problem and also add a corresponding error message on failure.

Fixes: fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Closes: https://lore.kernel.org/all/87lefv622n.fsf@linux.ibm.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230705024001.177585-1-yukuai1@huaweicloud.com
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sg.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1496,9 +1496,10 @@ sg_add_device(struct device *cl_dev)
 	int error;
 	unsigned long iflags;
 
-	error = blk_get_queue(scsidp->request_queue);
-	if (error)
-		return error;
+	if (!blk_get_queue(scsidp->request_queue)) {
+		pr_warn("%s: get scsi_device queue failed\n", __func__);
+		return -ENODEV;
+	}
 
 	error = -ENOMEM;
 	cdev = cdev_alloc();


