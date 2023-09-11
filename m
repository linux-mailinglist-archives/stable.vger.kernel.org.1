Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB26679B77C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjIKUv3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbjIKOtw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:49:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94410106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:49:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE897C433C8;
        Mon, 11 Sep 2023 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443787;
        bh=+GbnCDSV98oCkmx8EkOXQfbd+vOFPVKeHAbLb8lHijM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wy12s5gtOUTuS7ZogSg7UMMvaOg8QcQovod9Aw/cQ/KEfvuoO4bWPzBRhq+g/8RmK
         apAhNpI3oW4DF5dmo/c0uezpnCJCY4GAzsKaBzmN5MnBs21RunUSm5hLC6kVA3px/L
         78M4qRbVl5lsj8bjnew047mkvfUSlBnLSwNL8Cs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 501/737] media: amphion: fix CHECKED_RETURN issues reported by coverity
Date:   Mon, 11 Sep 2023 15:46:00 +0200
Message-ID: <20230911134704.567386228@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit b237b058adbc7825da9c8f358f1ff3f0467d623a ]

calling "vpu_cmd_send/vpu_get_buffer_state/vpu_session_alloc_fs"
without checking return value

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vdec.c     |  5 ++++-
 drivers/media/platform/amphion/vpu_cmds.c |  3 ++-
 drivers/media/platform/amphion/vpu_dbg.c  | 11 +++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index eeb2ef72df5b3..133d77d1ea0c3 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -1019,6 +1019,7 @@ static int vdec_response_frame_abnormal(struct vpu_inst *inst)
 {
 	struct vdec_t *vdec = inst->priv;
 	struct vpu_fs_info info;
+	int ret;
 
 	if (!vdec->req_frame_count)
 		return 0;
@@ -1026,7 +1027,9 @@ static int vdec_response_frame_abnormal(struct vpu_inst *inst)
 	memset(&info, 0, sizeof(info));
 	info.type = MEM_RES_FRAME;
 	info.tag = vdec->seq_tag + 0xf0;
-	vpu_session_alloc_fs(inst, &info);
+	ret = vpu_session_alloc_fs(inst, &info);
+	if (ret)
+		return ret;
 	vdec->req_frame_count--;
 
 	return 0;
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index 647d94554fb5d..7e137f276c3b1 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -306,7 +306,8 @@ static void vpu_core_keep_active(struct vpu_core *core)
 
 	dev_dbg(core->dev, "try to wake up\n");
 	mutex_lock(&core->cmd_lock);
-	vpu_cmd_send(core, &pkt);
+	if (vpu_cmd_send(core, &pkt))
+		dev_err(core->dev, "fail to keep active\n");
 	mutex_unlock(&core->cmd_lock);
 }
 
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index adc523b950618..982c2c777484c 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -50,6 +50,13 @@ static char *vpu_stat_name[] = {
 	[VPU_BUF_STATE_ERROR] = "error",
 };
 
+static inline const char *to_vpu_stat_name(int state)
+{
+	if (state <= VPU_BUF_STATE_ERROR)
+		return vpu_stat_name[state];
+	return "unknown";
+}
+
 static int vpu_dbg_instance(struct seq_file *s, void *data)
 {
 	struct vpu_inst *inst = s->private;
@@ -141,7 +148,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 		num = scnprintf(str, sizeof(str),
 				"output [%2d] state = %10s, %8s\n",
 				i, vb2_stat_name[vb->state],
-				vpu_stat_name[vpu_get_buffer_state(vbuf)]);
+				to_vpu_stat_name(vpu_get_buffer_state(vbuf)));
 		if (seq_write(s, str, num))
 			return 0;
 	}
@@ -156,7 +163,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 		num = scnprintf(str, sizeof(str),
 				"capture[%2d] state = %10s, %8s\n",
 				i, vb2_stat_name[vb->state],
-				vpu_stat_name[vpu_get_buffer_state(vbuf)]);
+				to_vpu_stat_name(vpu_get_buffer_state(vbuf)));
 		if (seq_write(s, str, num))
 			return 0;
 	}
-- 
2.40.1



