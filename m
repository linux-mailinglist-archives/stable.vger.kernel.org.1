Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA2470395B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbjEORlb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbjEORlN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:41:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A02100E2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19A3E62DE2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD50C433D2;
        Mon, 15 May 2023 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172318;
        bh=clBBDFwernhtCC9RalsshTgN0xPKDakN/yU9b828QbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFrq9E0vh03Z8cpQr0bEFwjQddcT1FIOYdbEaPbg5nfiuBJj110bDiK/Y1QoyXZFq
         dY+AzwY5C/DpyGJn4FlRWcHGgDK9G44fwTw444z/51OkkyerGYzV0A5U4CZkiL6Y3V
         rrIim1d8ICIktadf64pvw4OddaxhKHnTMUF1EOSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 115/381] media: venus: vdec: Fix non reliable setting of LAST flag
Date:   Mon, 15 May 2023 18:26:06 +0200
Message-Id: <20230515161742.021636010@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

[ Upstream commit acf8a57d8caf5ceabbe50774953fe04745ad1a50 ]

In real use of dynamic-resolution-change it is observed that the
LAST buffer flag (which marks the last decoded buffer with the
resolution before the resolution-change event) is not reliably set.

Fix this by set the LAST buffer flag on next queued capture buffer
after the resolution-change event.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 50248ad9f190 ("media: venus: dec: Fix handling of the start cmd")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/core.h    |  5 +--
 drivers/media/platform/qcom/venus/helpers.c |  6 +++
 drivers/media/platform/qcom/venus/vdec.c    | 45 ++++++++++++---------
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index f2a0ef9ee884e..f78eed2c243a8 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -283,7 +283,6 @@ enum venus_dec_state {
 	VENUS_DEC_STATE_DRAIN		= 5,
 	VENUS_DEC_STATE_DECODING	= 6,
 	VENUS_DEC_STATE_DRC		= 7,
-	VENUS_DEC_STATE_DRC_FLUSH_DONE	= 8,
 };
 
 struct venus_ts_metadata {
@@ -348,7 +347,7 @@ struct venus_ts_metadata {
  * @priv:	a private for HFI operations callbacks
  * @session_type:	the type of the session (decoder or encoder)
  * @hprop:	a union used as a holder by get property
- * @last_buf:	last capture buffer for dynamic-resoluton-change
+ * @next_buf_last: a flag to mark next queued capture buffer as last
  */
 struct venus_inst {
 	struct list_head list;
@@ -410,7 +409,7 @@ struct venus_inst {
 	union hfi_get_property hprop;
 	unsigned int core_acquired: 1;
 	unsigned int bit_depth;
-	struct vb2_buffer *last_buf;
+	bool next_buf_last;
 };
 
 #define IS_V1(core)	((core)->res->hfi_version == HFI_VERSION_1XX)
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 50439eb1ffeaa..5ca3920237c5a 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1347,6 +1347,12 @@ void venus_helper_vb2_buf_queue(struct vb2_buffer *vb)
 
 	v4l2_m2m_buf_queue(m2m_ctx, vbuf);
 
+	/* Skip processing queued capture buffers after LAST flag */
+	if (inst->session_type == VIDC_SESSION_TYPE_DEC &&
+	    V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
+	    inst->codec_state == VENUS_DEC_STATE_DRC)
+		goto unlock;
+
 	cache_payload(inst, vb);
 
 	if (inst->session_type == VIDC_SESSION_TYPE_ENC &&
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index de34a87d1130e..b6b5ae0a457bb 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -916,10 +916,6 @@ static int vdec_start_capture(struct venus_inst *inst)
 		return 0;
 
 reconfigure:
-	ret = hfi_session_flush(inst, HFI_FLUSH_OUTPUT, true);
-	if (ret)
-		return ret;
-
 	ret = vdec_output_conf(inst);
 	if (ret)
 		return ret;
@@ -947,6 +943,8 @@ static int vdec_start_capture(struct venus_inst *inst)
 
 	venus_pm_load_scale(inst);
 
+	inst->next_buf_last = false;
+
 	ret = hfi_session_continue(inst);
 	if (ret)
 		goto free_dpb_bufs;
@@ -987,6 +985,7 @@ static int vdec_start_output(struct venus_inst *inst)
 	venus_helper_init_instance(inst);
 	inst->sequence_out = 0;
 	inst->reconfig = false;
+	inst->next_buf_last = false;
 
 	ret = vdec_set_properties(inst);
 	if (ret)
@@ -1080,9 +1079,7 @@ static int vdec_stop_capture(struct venus_inst *inst)
 		inst->codec_state = VENUS_DEC_STATE_STOPPED;
 		break;
 	case VENUS_DEC_STATE_DRC:
-		WARN_ON(1);
-		fallthrough;
-	case VENUS_DEC_STATE_DRC_FLUSH_DONE:
+		ret = hfi_session_flush(inst, HFI_FLUSH_OUTPUT, true);
 		inst->codec_state = VENUS_DEC_STATE_CAPTURE_SETUP;
 		venus_helper_free_dpb_bufs(inst);
 		break;
@@ -1206,9 +1203,28 @@ static void vdec_buf_cleanup(struct vb2_buffer *vb)
 static void vdec_vb2_buf_queue(struct vb2_buffer *vb)
 {
 	struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	static const struct v4l2_event eos = { .type = V4L2_EVENT_EOS };
 
 	vdec_pm_get_put(inst);
 
+	mutex_lock(&inst->lock);
+
+	if (inst->next_buf_last && V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
+	    inst->codec_state == VENUS_DEC_STATE_DRC) {
+		vbuf->flags |= V4L2_BUF_FLAG_LAST;
+		vbuf->sequence = inst->sequence_cap++;
+		vbuf->field = V4L2_FIELD_NONE;
+		vb2_set_plane_payload(vb, 0, 0);
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+		v4l2_event_queue_fh(&inst->fh, &eos);
+		inst->next_buf_last = false;
+		mutex_unlock(&inst->lock);
+		return;
+	}
+
+	mutex_unlock(&inst->lock);
+
 	venus_helper_vb2_buf_queue(vb);
 }
 
@@ -1252,13 +1268,6 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 		vb->timestamp = timestamp_us * NSEC_PER_USEC;
 		vbuf->sequence = inst->sequence_cap++;
 
-		if (inst->last_buf == vb) {
-			inst->last_buf = NULL;
-			vbuf->flags |= V4L2_BUF_FLAG_LAST;
-			vb2_set_plane_payload(vb, 0, 0);
-			vb->timestamp = 0;
-		}
-
 		if (vbuf->flags & V4L2_BUF_FLAG_LAST) {
 			const struct v4l2_event ev = { .type = V4L2_EVENT_EOS };
 
@@ -1343,12 +1352,9 @@ static void vdec_event_change(struct venus_inst *inst,
 	 */
 
 	if (!sufficient && inst->codec_state == VENUS_DEC_STATE_DRC) {
-		struct vb2_v4l2_buffer *last;
 		int ret;
 
-		last = v4l2_m2m_last_dst_buf(inst->m2m_ctx);
-		if (last)
-			inst->last_buf = &last->vb2_buf;
+		inst->next_buf_last = true;
 
 		ret = hfi_session_flush(inst, HFI_FLUSH_OUTPUT, false);
 		if (ret)
@@ -1397,8 +1403,7 @@ static void vdec_event_notify(struct venus_inst *inst, u32 event,
 
 static void vdec_flush_done(struct venus_inst *inst)
 {
-	if (inst->codec_state == VENUS_DEC_STATE_DRC)
-		inst->codec_state = VENUS_DEC_STATE_DRC_FLUSH_DONE;
+	dev_dbg(inst->core->dev_dec, VDBGH "flush done\n");
 }
 
 static const struct hfi_inst_ops vdec_hfi_ops = {
-- 
2.39.2



