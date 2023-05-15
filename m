Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67570395C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbjEORld (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbjEORlO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD62C15533
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4376E62E10
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353DAC433EF;
        Mon, 15 May 2023 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172321;
        bh=Ey9SXtDm4MHsmW8U53wHZ768rSca/8UKbYWuPhjr9AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCF6e1LwBIgjhEdyEM2PwpPR5QSGb9WCVq7MPD6siX5+QfLERkn5j/+fKWBKQ9Y4c
         0/bU+K4KHWoerB/nja4CQcO2xtu/LO46BnyZ/wwd4T/NkyR7m01aABf7PIWqZabcW0
         7mg8Ua+0nCJP+FcwN7oc77kdJVrqLlO9DKzO1SfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 116/381] media: venus: vdec: Make decoder return LAST flag for sufficient event
Date:   Mon, 15 May 2023 18:26:07 +0200
Message-Id: <20230515161742.068836796@linuxfoundation.org>
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

[ Upstream commit a4ca67af8b831a781ac53060c5d5c3dccaf7676e ]

This makes the decoder to behaives equally for sufficient and
insufficient events. After this change the LAST buffer flag will be set
when the new resolution (in dynamic-resolution-change state) is smaller
then the old bitstream resolution.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 50248ad9f190 ("media: venus: dec: Fix handling of the start cmd")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 42 ++++++++++++++++--------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index b6b5ae0a457bb..3adff10fce6a7 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -636,6 +636,7 @@ static int vdec_output_conf(struct venus_inst *inst)
 {
 	struct venus_core *core = inst->core;
 	struct hfi_enable en = { .enable = 1 };
+	struct hfi_buffer_requirements bufreq;
 	u32 width = inst->out_width;
 	u32 height = inst->out_height;
 	u32 out_fmt, out2_fmt;
@@ -711,6 +712,23 @@ static int vdec_output_conf(struct venus_inst *inst)
 	}
 
 	if (IS_V3(core) || IS_V4(core)) {
+		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
+		if (ret)
+			return ret;
+
+		if (bufreq.size > inst->output_buf_size)
+			return -EINVAL;
+
+		if (inst->dpb_fmt) {
+			ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT2,
+						      &bufreq);
+			if (ret)
+				return ret;
+
+			if (bufreq.size > inst->output2_buf_size)
+				return -EINVAL;
+		}
+
 		if (inst->output2_buf_size) {
 			ret = venus_helper_set_bufsize(inst,
 						       inst->output2_buf_size,
@@ -1330,19 +1348,15 @@ static void vdec_event_change(struct venus_inst *inst,
 	dev_dbg(dev, VDBGM "event %s sufficient resources (%ux%u)\n",
 		sufficient ? "" : "not", ev_data->width, ev_data->height);
 
-	if (sufficient) {
-		hfi_session_continue(inst);
-	} else {
-		switch (inst->codec_state) {
-		case VENUS_DEC_STATE_INIT:
-			inst->codec_state = VENUS_DEC_STATE_CAPTURE_SETUP;
-			break;
-		case VENUS_DEC_STATE_DECODING:
-			inst->codec_state = VENUS_DEC_STATE_DRC;
-			break;
-		default:
-			break;
-		}
+	switch (inst->codec_state) {
+	case VENUS_DEC_STATE_INIT:
+		inst->codec_state = VENUS_DEC_STATE_CAPTURE_SETUP;
+		break;
+	case VENUS_DEC_STATE_DECODING:
+		inst->codec_state = VENUS_DEC_STATE_DRC;
+		break;
+	default:
+		break;
 	}
 
 	/*
@@ -1351,7 +1365,7 @@ static void vdec_event_change(struct venus_inst *inst,
 	 * itself doesn't mark the last decoder output buffer with HFI EOS flag.
 	 */
 
-	if (!sufficient && inst->codec_state == VENUS_DEC_STATE_DRC) {
+	if (inst->codec_state == VENUS_DEC_STATE_DRC) {
 		int ret;
 
 		inst->next_buf_last = true;
-- 
2.39.2



