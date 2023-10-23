Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3B7D2FC3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjJWKZS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjJWKZR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:25:17 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424F0D68
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:25:14 -0700 (PDT)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <hverkuil@linuxtv.org>)
        id 1qus7U-005WZ9-HN; Mon, 23 Oct 2023 10:25:12 +0000
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Mon, 23 Oct 2023 10:24:52 +0000
Subject: [git:media_stage/master] media: venus: hfi: add checks to perform sanity on queue pointers
To:     linuxtv-commits@linuxtv.org
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>, stable@vger.kernel.org,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qus7U-005WZ9-HN@www.linuxtv.org>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: venus: hfi: add checks to perform sanity on queue pointers
Author:  Vikash Garodia <quic_vgarodia@quicinc.com>
Date:    Thu Aug 10 07:55:01 2023 +0530

Read and write pointers are used to track the packet index in the memory
shared between video driver and firmware. There is a possibility of OOB
access if the read or write pointer goes beyond the queue memory size.
Add checks for the read and write pointer to avoid OOB access.

Cc: stable@vger.kernel.org
Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

---

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 19fc6575a489..f9437b6412b9 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -205,6 +205,11 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 
 	new_wr_idx = wr_idx + dwords;
 	wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
+
+	if (wr_ptr < (u32 *)queue->qmem.kva ||
+	    wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*wr_ptr)))
+		return -EINVAL;
+
 	if (new_wr_idx < qsize) {
 		memcpy(wr_ptr, packet, dwords << 2);
 	} else {
@@ -272,6 +277,11 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 	}
 
 	rd_ptr = (u32 *)(queue->qmem.kva + (rd_idx << 2));
+
+	if (rd_ptr < (u32 *)queue->qmem.kva ||
+	    rd_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*rd_ptr)))
+		return -EINVAL;
+
 	dwords = *rd_ptr >> 2;
 	if (!dwords)
 		return -EINVAL;
