Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F076FAE0D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjEHLki (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjEHLkM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4033F2EE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40EE3634CB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3A4C433D2;
        Mon,  8 May 2023 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546009;
        bh=TXXI0qR8IURgWgMwszEtxf2GjVZOtVDDoEDq80aT7eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5S3MHFly0aEJFkRb7ASmG1J/ec+eJUJ7xhTQ9USGpwgN/Of2NJuhfJZ37jinVpMh
         Rz+bhBEnYiwSYVGAAXb8wjhJbN+h3y+IgGFduKyLqTITvIYK6sOUOpqrHSoOmr/2GK
         wgcPuqXxoA/FHyjaBMujH/+ntfhFrzicthZhihok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Kelley <mikelley@microsoft.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 198/371] nvme: handle the persistent internal error AER
Date:   Mon,  8 May 2023 11:46:39 +0200
Message-Id: <20230508094819.963656150@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 2c61c97fb12b806e1c8eb15f04c277ad097ec95e ]

In the NVM Express Revision 1.4 spec, Figure 145 describes possible
values for an AER with event type "Error" (value 000b). For a
Persistent Internal Error (value 03h), the host should perform a
controller reset.

Add support for this error using code that already exists for
doing a controller reset. As part of this support, introduce
two utility functions for parsing the AER type and subtype.

This new support was tested in a lab environment where we can
generate the persistent internal error on demand, and observe
both the Linux side and NVMe controller side to see that the
controller reset has been done.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 6622b76fe922 ("nvme: fix async event trace event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++--
 include/linux/nvme.h     |  4 ++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ef9d7a795b007..2ad1e4acc0d6b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4360,9 +4360,19 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_get_fw_slot_info(ctrl);
 }
 
+static u32 nvme_aer_type(u32 result)
+{
+	return result & 0x7;
+}
+
+static u32 nvme_aer_subtype(u32 result)
+{
+	return (result & 0xff00) >> 8;
+}
+
 static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
-	u32 aer_notice_type = (result & 0xff00) >> 8;
+	u32 aer_notice_type = nvme_aer_subtype(result);
 
 	trace_nvme_async_event(ctrl, aer_notice_type);
 
@@ -4395,11 +4405,19 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	}
 }
 
+static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
+{
+	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
+	dev_warn(ctrl->device, "resetting controller due to AER\n");
+	nvme_reset_ctrl(ctrl);
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
-	u32 aer_type = result & 0x07;
+	u32 aer_type = nvme_aer_type(result);
+	u32 aer_subtype = nvme_aer_subtype(result);
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
@@ -4409,6 +4427,15 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		nvme_handle_aen_notice(ctrl, result);
 		break;
 	case NVME_AER_ERROR:
+		/*
+		 * For a persistent internal error, don't run async_event_work
+		 * to submit a new AER. The controller reset will do it.
+		 */
+		if (aer_subtype == NVME_AER_ERROR_PERSIST_INT_ERR) {
+			nvme_handle_aer_persistent_error(ctrl);
+			return;
+		}
+		fallthrough;
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index de235916c31c2..461ee0ee59fe4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -613,6 +613,10 @@ enum {
 	NVME_AER_VS			= 7,
 };
 
+enum {
+	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
+};
+
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
-- 
2.39.2



