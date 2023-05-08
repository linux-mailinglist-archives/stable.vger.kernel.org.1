Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E246FAB7D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjEHLNz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjEHLNy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:13:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA5836545
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB76162BBB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0883C4339B;
        Mon,  8 May 2023 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544428;
        bh=qBp95ec1sKsD8Wd8A+/Qfh6pigJaUVjlnMzFzz30alw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jS2c+mxbvKOkohklZp9BLmPyKW3z1AoSj4QmaIdQzBqE7Tte0Fzq7GRqJbwUCbl6S
         fuzSI6giVMflfebeR7khn9koS2I25c2k1L2pErQ0w8gmb6sE+ncNr3qMtLXz2wm9pG
         Y71xzUKLlDd2WNq+kTcxcMRJfcctaNir6IFUaOfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nate Thornton <nate.thornton@samsung.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 406/694] nvme: fix async event trace event
Date:   Mon,  8 May 2023 11:44:01 +0200
Message-Id: <20230508094446.375893025@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index d6a9bac91a4cd..bdf1601219fc4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4819,8 +4819,6 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	u32 aer_notice_type = nvme_aer_subtype(result);
 	bool requeue = true;
 
-	trace_nvme_async_event(ctrl, aer_notice_type);
-
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
@@ -4856,7 +4854,6 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 
 static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
 {
-	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
 	dev_warn(ctrl->device, "resetting controller due to AER\n");
 	nvme_reset_ctrl(ctrl);
 }
@@ -4872,6 +4869,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
+	trace_nvme_async_event(ctrl, result);
 	switch (aer_type) {
 	case NVME_AER_NOTICE:
 		requeue = nvme_handle_aen_notice(ctrl, result);
@@ -4889,7 +4887,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
-		trace_nvme_async_event(ctrl, aer_type);
 		ctrl->aen_result = result;
 		break;
 	default:
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 6f0eaf6a15282..4fb5922ffdac5 100644
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



