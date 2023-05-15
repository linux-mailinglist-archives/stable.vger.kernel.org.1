Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA434703B36
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244123AbjEOSAr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242514AbjEOSAX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F5C1552E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F7AE62FFE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D6C433D2;
        Mon, 15 May 2023 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173451;
        bh=n+bQBWVykmospjECs+KBZycIz/cgkSNsZU/UYT9MRdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smlHZOGjBc/guQvTb2yF4rVR2fOlv+BFj08GpRPha4kITDY80ZdnnVFa3yy+nAXP0
         bnnnfCZByxUvzRAFvt/5f3BRkUa5o5ZD1Ra7m86n6jB0+kiJVOf4BC5pUyr0dT+Jc1
         f6WpeCXio4aN+YDUtoI26YltEhFjiX9QfFEUNgRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Kelley <mikelley@microsoft.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 098/282] nvme: handle the persistent internal error AER
Date:   Mon, 15 May 2023 18:27:56 +0200
Message-Id: <20230515161725.195827222@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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
index 029a89aead53e..fa5753de56582 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3976,9 +3976,19 @@ static void nvme_fw_act_work(struct work_struct *work)
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
 
@@ -4011,11 +4021,19 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
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
@@ -4025,6 +4043,15 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
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
index ff0ee07b1e8f4..dd2801c28b99c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -522,6 +522,10 @@ enum {
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



