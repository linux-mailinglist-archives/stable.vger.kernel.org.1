Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1696FA808
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjEHKhK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjEHKgq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:36:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723D324AAC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0644A627BD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C50C433EF;
        Mon,  8 May 2023 10:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542199;
        bh=alUG6lu9qCCS4jm1sWpXzf8o5nmGBJnBVr/oUvFgFK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xktEXFMXw5yOGgF18bao5sZAlxcTeKx+pcTmxC76xEfmSycsoRv6eM6tE0yUAwa0c
         5hDb5cjOdNB9aAwqHbhu4uwHXqpJdWN66vwrO9NKqqzjpZvf7XKiUfT/XsPx4xbNLX
         lHJKH+7xziVyZkRw19gztiT68KK07y1QQeKmRn7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 359/663] nvmet: fix I/O Command Set specific Identify Controller
Date:   Mon,  8 May 2023 11:43:05 +0200
Message-Id: <20230508094439.809098549@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index 8c375cdaa63fc..29b73e6581d73 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -685,6 +685,13 @@ static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
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
@@ -708,13 +715,16 @@ static void nvmet_execute_identify(struct nvmet_req *req)
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
index 89bedfcd974c4..ed3786140965f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -581,7 +581,7 @@ bool nvmet_ns_revalidate(struct nvmet_ns *ns);
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



