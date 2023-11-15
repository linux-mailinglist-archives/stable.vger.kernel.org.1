Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B97ED14B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbjKOUAq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344167AbjKOUAn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:00:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B62197
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:00:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB290C433C8;
        Wed, 15 Nov 2023 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078438;
        bh=b4ShBSPw2nmT1sdTjTP6FL8RQpca81WqAgkTMa8ORhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkNTjazDdydIB7GH81f8A9D1ADiC96Cp/XofzEAu1cK/rVkThDwG22ZZaDlq1zP6Y
         MqGvhioxOb9FJo3nztUP/nl6FZcdv/vd5h7NeCnS/pIUYxdS4JBzDfAHfXtig2fkWE
         m0FaOLshT5XTvq30InLNG0aQ+qDhdlK7h+Lm21pQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Qian <ming.qian@nxp.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 321/379] media: amphion: handle firmware debug message
Date:   Wed, 15 Nov 2023 14:26:36 -0500
Message-ID: <20231115192704.142815210@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit 6496617b2b06d7004a5cbd53d48f19567d6b018c ]

decoder firmware may notify host some debug message,
it can help analyze the state of the firmware in case of error

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_defs.h    |  1 +
 drivers/media/platform/amphion/vpu_helpers.c |  1 +
 drivers/media/platform/amphion/vpu_malone.c  |  1 +
 drivers/media/platform/amphion/vpu_msgs.c    | 31 ++++++++++++++++----
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/amphion/vpu_defs.h
index 667637eedb5d4..7320852668d64 100644
--- a/drivers/media/platform/amphion/vpu_defs.h
+++ b/drivers/media/platform/amphion/vpu_defs.h
@@ -71,6 +71,7 @@ enum {
 	VPU_MSG_ID_TIMESTAMP_INFO,
 	VPU_MSG_ID_FIRMWARE_XCPT,
 	VPU_MSG_ID_PIC_SKIPPED,
+	VPU_MSG_ID_DBG_MSG,
 };
 
 enum VPU_ENC_MEMORY_RESOURSE {
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
index 2e78666322f02..66fdb0baea746 100644
--- a/drivers/media/platform/amphion/vpu_helpers.c
+++ b/drivers/media/platform/amphion/vpu_helpers.c
@@ -454,6 +454,7 @@ const char *vpu_id_name(u32 id)
 	case VPU_MSG_ID_UNSUPPORTED: return "unsupported";
 	case VPU_MSG_ID_FIRMWARE_XCPT: return "exception";
 	case VPU_MSG_ID_PIC_SKIPPED: return "skipped";
+	case VPU_MSG_ID_DBG_MSG: return "debug msg";
 	}
 	return "<unknown>";
 }
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index c2f4fb12c3b64..6b37453eef76c 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -726,6 +726,7 @@ static struct vpu_pair malone_msgs[] = {
 	{VPU_MSG_ID_UNSUPPORTED, VID_API_EVENT_UNSUPPORTED_STREAM},
 	{VPU_MSG_ID_FIRMWARE_XCPT, VID_API_EVENT_FIRMWARE_XCPT},
 	{VPU_MSG_ID_PIC_SKIPPED, VID_API_EVENT_PIC_SKIPPED},
+	{VPU_MSG_ID_DBG_MSG, VID_API_EVENT_DBG_MSG_DEC},
 };
 
 static void vpu_malone_pack_fs_alloc(struct vpu_rpc_event *pkt,
diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index d0ead051f7d18..b74a407a19f22 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -23,6 +23,7 @@
 struct vpu_msg_handler {
 	u32 id;
 	void (*done)(struct vpu_inst *inst, struct vpu_rpc_event *pkt);
+	u32 is_str;
 };
 
 static void vpu_session_handle_start_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
@@ -154,7 +155,7 @@ static void vpu_session_handle_error(struct vpu_inst *inst, struct vpu_rpc_event
 {
 	char *str = (char *)pkt->data;
 
-	if (strlen(str))
+	if (*str)
 		dev_err(inst->dev, "instance %d firmware error : %s\n", inst->id, str);
 	else
 		dev_err(inst->dev, "instance %d is unsupported stream\n", inst->id);
@@ -180,6 +181,21 @@ static void vpu_session_handle_pic_skipped(struct vpu_inst *inst, struct vpu_rpc
 	vpu_inst_unlock(inst);
 }
 
+static void vpu_session_handle_dbg_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	char *str = (char *)pkt->data;
+
+	if (*str)
+		dev_info(inst->dev, "instance %d firmware dbg msg : %s\n", inst->id, str);
+}
+
+static void vpu_terminate_string_msg(struct vpu_rpc_event *pkt)
+{
+	if (pkt->hdr.num == ARRAY_SIZE(pkt->data))
+		pkt->hdr.num--;
+	pkt->data[pkt->hdr.num] = 0;
+}
+
 static struct vpu_msg_handler handlers[] = {
 	{VPU_MSG_ID_START_DONE, vpu_session_handle_start_done},
 	{VPU_MSG_ID_STOP_DONE, vpu_session_handle_stop_done},
@@ -193,9 +209,10 @@ static struct vpu_msg_handler handlers[] = {
 	{VPU_MSG_ID_PIC_DECODED, vpu_session_handle_pic_decoded},
 	{VPU_MSG_ID_DEC_DONE, vpu_session_handle_pic_done},
 	{VPU_MSG_ID_PIC_EOS, vpu_session_handle_eos},
-	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error},
-	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt},
+	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error, true},
+	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt, true},
 	{VPU_MSG_ID_PIC_SKIPPED, vpu_session_handle_pic_skipped},
+	{VPU_MSG_ID_DBG_MSG, vpu_session_handle_dbg_msg, true},
 };
 
 static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *msg)
@@ -219,8 +236,12 @@ static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *m
 		}
 	}
 
-	if (handler && handler->done)
-		handler->done(inst, msg);
+	if (handler) {
+		if (handler->is_str)
+			vpu_terminate_string_msg(msg);
+		if (handler->done)
+			handler->done(inst, msg);
+	}
 
 	vpu_response_cmd(inst, msg_id, 1);
 
-- 
2.42.0



