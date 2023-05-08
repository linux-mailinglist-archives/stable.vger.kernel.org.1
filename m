Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B846FA51D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjEHKGH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjEHKGG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A1D3017B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4FF6233D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB9C433D2;
        Mon,  8 May 2023 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540363;
        bh=CJjoRdqgpk7JkR34HYpuB7YfDiB6F8hwdsTVn6NHUvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaqxSBpf1p8kfOB3fIAuiwu0mRH3Ds4zAmAMQ5oxmCnnBjWSSjakK/h+6rEnni05W
         Ew5zZoaeizhNojTCM5XtZKrIf+fj7yISlfwQXsxdnaHxnT98RU9vwPmboF1FE7cKG8
         +2lfAPTh4g5104YH5QwAaFZNX2YSILcbOC2YIWo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 336/611] nvmet: fix I/O Command Set specific Identify Controller
Date:   Mon,  8 May 2023 11:42:58 +0200
Message-Id: <20230508094433.337319909@linuxfoundation.org>
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

[ Upstream commit a5a6ab0950b46ab1ef4a5c83c80234018b81b38a ]

For an identify command with cns set to NVME_ID_CNS_CS_CTRL, the NVMe
2.0 specification states that:

If the I/O Command Set specified by the CSI field does not have an
Identify Controller data structure, then the controller shall return
a zero filled data structure. If the host requests a data structure for
an I/O Command Set that the controller does not support, the controller
shall abort the command with a status code of Invalid Field in Command.

However, the current implementation of this identify command in
nvmet_execute_identify() only handles the ZNS command set, returning an
error for the NVM command set, which is not compliant with the
specifications as we do support this command set.

Fix this by:
1) Renaming nvmet_execute_identify_cns_cs_ctrl() to
   nvmet_execute_identify_ctrl_zns() to continue handling the
   ZNS command set as is.
2) Introduce a nvmet_execute_identify_ctrl_ns() helper to handle the
   NVM command set, returning a zero filled nvme_id_ctrl_nvm data
   structure.
3) Modify nvmet_execute_identify() to call these helpers based on
   the csi specified, returning an error for unsupported command sets.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 22 ++++++++++++++++------
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/zns.c       |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d414269756c82..31d35279b37a5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -686,6 +686,13 @@ static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
+{
+	/* Not supported: return zeroes */
+	nvmet_req_complete(req,
+		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -709,13 +716,16 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		nvmet_execute_identify_ctrl(req);
 		return;
 	case NVME_ID_CNS_CS_CTRL:
-		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			switch (req->cmd->identify.csi) {
-			case NVME_CSI_ZNS:
-				return nvmet_execute_identify_cns_cs_ctrl(req);
-			default:
-				break;
+		switch (req->cmd->identify.csi) {
+		case NVME_CSI_NVM:
+			nvmet_execute_identify_ctrl_nvm(req);
+			return;
+		case NVME_CSI_ZNS:
+			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+				nvmet_execute_identify_ctrl_zns(req);
+				return;
 			}
+			break;
 		}
 		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index bda1c1f71f394..273cca49a040f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -578,7 +578,7 @@ bool nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req);
 void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 017c13f8bef14..d93ee4ae19454 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -70,7 +70,7 @@ bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 	return true;
 }
 
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req)
 {
 	u8 zasl = req->sq->ctrl->subsys->zasl;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-- 
2.39.2



