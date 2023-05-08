Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237646FA519
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjEHKF7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjEHKFz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E80C3044D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8B262341
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1783EC433D2;
        Mon,  8 May 2023 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540353;
        bh=xIuJQWrpRlqxoHxRVVeYRc59/Q983zZZA23pvc2nBYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNqpfE1wrRNL/1F8UQ3lD1yXeM0jSp4JZUZDcZShWtkDonWjd0TdVCnF5eDGJhMr3
         ZOiCbZMh1WObbYyEJsJMO8iz7e7LVxkXLaeUzxdfMCDQ+fJ6/a3qJ+VFG0JKD+UHeo
         wA+WArlSwYXpY9YiyZRIi/7hHYBlvjj2N+tdDeIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 332/611] nvmet: fix error handling in nvmet_execute_identify_cns_cs_ns()
Date:   Mon,  8 May 2023 11:42:54 +0200
Message-Id: <20230508094433.212829374@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit ab76e7206b672b2e8818cb121a04506956d6b223 ]

Nvme specifications state that:

If the I/O Command Set associated with the namespace identified by the
NSID field does not support the Identify Namespace data structure
specified by the CSI field, the controller shall abort the command with
a status code of Invalid Field in Command.

In other words, if nvmet_execute_identify_cns_cs_ns() is called for a
target with a block device that is not zoned, we should not return any
data and set the status to NVME_SC_INVALID_FIELD.

While at it, it is also better to revalidate the ns block devie *before*
checking if the block device is zoned, to ensure that
nvmet_execute_identify_cns_cs_ns() operates against updated device
characteristics.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/zns.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 1254cf57e008d..017c13f8bef14 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -97,7 +97,7 @@ void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 
 void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 {
-	struct nvme_id_ns_zns *id_zns;
+	struct nvme_id_ns_zns *id_zns = NULL;
 	u64 zsze;
 	u16 status;
 	u32 mar, mor;
@@ -118,16 +118,18 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	if (status)
 		goto done;
 
-	if (!bdev_is_zoned(req->ns->bdev)) {
-		req->error_loc = offsetof(struct nvme_identify, nsid);
-		goto done;
-	}
-
 	if (nvmet_ns_revalidate(req->ns)) {
 		mutex_lock(&req->ns->subsys->lock);
 		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
 		mutex_unlock(&req->ns->subsys->lock);
 	}
+
+	if (!bdev_is_zoned(req->ns->bdev)) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc = offsetof(struct nvme_identify, nsid);
+		goto out;
+	}
+
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
@@ -148,8 +150,8 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 
 done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
-	kfree(id_zns);
 out:
+	kfree(id_zns);
 	nvmet_req_complete(req, status);
 }
 
-- 
2.39.2



