Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA879B4E9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348907AbjIKVbk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbjIKONb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E775DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4558C433C8;
        Mon, 11 Sep 2023 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441607;
        bh=BXmD4Z4TiQ3D1J5g2f4JPlplX7YNEk/33J91fxB/kBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsWeE355tcps1HBghkYxpvYLldY/3MxAKxVyydMCRF2fuHEHy4H5NsbgQ2xCtukmb
         rGqT/OjvQDiHsAxLsSSm9o+YtIT4iEBwN5Zu5/RDow/XlQnp5LNvRXCzwQbCPWGe6h
         YVBx1MpMtMiX+BoTtGY2q3fR934etmAfRC0yWasI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 473/739] media: amphion: fix UNINIT issues reported by coverity
Date:   Mon, 11 Sep 2023 15:44:32 +0200
Message-ID: <20230911134704.357217878@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit c224d0497a31ea2d173e1ea16af308945bff9037 ]

using uninitialized value may introduce risk

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_msgs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index f9eb488d1b5e2..d0ead051f7d18 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -32,7 +32,7 @@ static void vpu_session_handle_start_done(struct vpu_inst *inst, struct vpu_rpc_
 
 static void vpu_session_handle_mem_request(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_pkt_mem_req_data req_data;
+	struct vpu_pkt_mem_req_data req_data = { 0 };
 
 	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&req_data);
 	vpu_trace(inst->dev, "[%d] %d:%d %d:%d %d:%d\n",
@@ -80,7 +80,7 @@ static void vpu_session_handle_resolution_change(struct vpu_inst *inst, struct v
 
 static void vpu_session_handle_enc_frame_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_enc_pic_info info;
+	struct vpu_enc_pic_info info = { 0 };
 
 	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
 	dev_dbg(inst->dev, "[%d] frame id = %d, wptr = 0x%x, size = %d\n",
@@ -90,7 +90,7 @@ static void vpu_session_handle_enc_frame_done(struct vpu_inst *inst, struct vpu_
 
 static void vpu_session_handle_frame_request(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_fs_info fs;
+	struct vpu_fs_info fs = { 0 };
 
 	vpu_iface_unpack_msg_data(inst->core, pkt, &fs);
 	call_void_vop(inst, event_notify, VPU_MSG_ID_FRAME_REQ, &fs);
@@ -107,7 +107,7 @@ static void vpu_session_handle_frame_release(struct vpu_inst *inst, struct vpu_r
 		info.type = inst->out_format.type;
 		call_void_vop(inst, buf_done, &info);
 	} else if (inst->core->type == VPU_CORE_TYPE_DEC) {
-		struct vpu_fs_info fs;
+		struct vpu_fs_info fs = { 0 };
 
 		vpu_iface_unpack_msg_data(inst->core, pkt, &fs);
 		call_void_vop(inst, event_notify, VPU_MSG_ID_FRAME_RELEASE, &fs);
@@ -122,7 +122,7 @@ static void vpu_session_handle_input_done(struct vpu_inst *inst, struct vpu_rpc_
 
 static void vpu_session_handle_pic_decoded(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_dec_pic_info info;
+	struct vpu_dec_pic_info info = { 0 };
 
 	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
 	call_void_vop(inst, get_one_frame, &info);
@@ -130,7 +130,7 @@ static void vpu_session_handle_pic_decoded(struct vpu_inst *inst, struct vpu_rpc
 
 static void vpu_session_handle_pic_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_dec_pic_info info;
+	struct vpu_dec_pic_info info = { 0 };
 	struct vpu_frame_info frame;
 
 	memset(&frame, 0, sizeof(frame));
-- 
2.40.1



