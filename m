Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7390F703B35
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjEOSAq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjEOSAW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C41CA68
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA9863002
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09093C4339B;
        Mon, 15 May 2023 17:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173454;
        bh=UmXOglmjcWX2r+6HX1t7q6hhmXLL+iOBgRJf58/o6LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BbOKxuKNaF7+WjbVgzGRgVqbs4dzuaGRicqwfScCkkYUSN4f+LkxrsGmNXV7y5wNf
         Py0JXchH4CUN8yanr0maoFPMGWz6gNhxgDrNiQx2J/z3xMjUMcMo8n8Ums9uZCJMuf
         iOuCG5ab4WwH+23VrVOPXI8UAad30H4sxy8wtHmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nate Thornton <nate.thornton@samsung.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 099/282] nvme: fix async event trace event
Date:   Mon, 15 May 2023 18:27:57 +0200
Message-Id: <20230515161725.224286412@linuxfoundation.org>
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 6622b76fe922b94189499a90ccdb714a4a8d0773 ]

Mixing AER Event Type and Event Info has masking clashes. Just print the
event type, but also include the event info of the AER result in the
trace.

Fixes: 09bd1ff4b15143b ("nvme-core: add async event trace helper")
Reported-by: Nate Thornton <nate.thornton@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c  |  5 +----
 drivers/nvme/host/trace.h | 15 ++++++---------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa5753de56582..9144ed14b0741 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3990,8 +3990,6 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
 	u32 aer_notice_type = nvme_aer_subtype(result);
 
-	trace_nvme_async_event(ctrl, aer_notice_type);
-
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
@@ -4023,7 +4021,6 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 
 static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
 {
-	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
 	dev_warn(ctrl->device, "resetting controller due to AER\n");
 	nvme_reset_ctrl(ctrl);
 }
@@ -4038,6 +4035,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
+	trace_nvme_async_event(ctrl, result);
 	switch (aer_type) {
 	case NVME_AER_NOTICE:
 		nvme_handle_aen_notice(ctrl, result);
@@ -4055,7 +4053,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
-		trace_nvme_async_event(ctrl, aer_type);
 		ctrl->aen_result = result;
 		break;
 	default:
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 35bac7a254227..700fdce2ecf15 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -127,15 +127,12 @@ TRACE_EVENT(nvme_async_event,
 	),
 	TP_printk("nvme%d: NVME_AEN=%#08x [%s]",
 		__entry->ctrl_id, __entry->result,
-		__print_symbolic(__entry->result,
-		aer_name(NVME_AER_NOTICE_NS_CHANGED),
-		aer_name(NVME_AER_NOTICE_ANA),
-		aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),
-		aer_name(NVME_AER_NOTICE_DISC_CHANGED),
-		aer_name(NVME_AER_ERROR),
-		aer_name(NVME_AER_SMART),
-		aer_name(NVME_AER_CSS),
-		aer_name(NVME_AER_VS))
+		__print_symbolic(__entry->result & 0x7,
+			aer_name(NVME_AER_ERROR),
+			aer_name(NVME_AER_SMART),
+			aer_name(NVME_AER_NOTICE),
+			aer_name(NVME_AER_CSS),
+			aer_name(NVME_AER_VS))
 	)
 );
 
-- 
2.39.2



