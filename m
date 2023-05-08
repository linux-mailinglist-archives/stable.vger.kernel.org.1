Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA4F6FA809
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjEHKhL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjEHKgr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805C924A84
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 165E7627C2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07334C433D2;
        Mon,  8 May 2023 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542202;
        bh=Qv3X1XOR9n6WuGshdbN8zlHH1LJsrKbl19HvRM+T4Ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fc8GhhZJNcggbElitLpRRGgx3g6os6g8dKq2kyH1EJRFgXbILrKAXgc0umuwm9B+f
         gMOfydAeB0/7gWvkg9PhV9YB5yQXDCFuyp3HhrYqmdrq7P9gtMIX9sFoiWv2xSGbYz
         rMsFGMu85J7Idxhln/vc1Eb2sAzBvU5NBTjBlCOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nate Thornton <nate.thornton@samsung.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 360/663] nvme: fix async event trace event
Date:   Mon,  8 May 2023 11:43:06 +0200
Message-Id: <20230508094439.842015748@linuxfoundation.org>
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
index c0429f9f50920..d567762545b05 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4808,8 +4808,6 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	u32 aer_notice_type = nvme_aer_subtype(result);
 	bool requeue = true;
 
-	trace_nvme_async_event(ctrl, aer_notice_type);
-
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
@@ -4845,7 +4843,6 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 
 static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
 {
-	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
 	dev_warn(ctrl->device, "resetting controller due to AER\n");
 	nvme_reset_ctrl(ctrl);
 }
@@ -4861,6 +4858,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
+	trace_nvme_async_event(ctrl, result);
 	switch (aer_type) {
 	case NVME_AER_NOTICE:
 		requeue = nvme_handle_aen_notice(ctrl, result);
@@ -4878,7 +4876,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
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



