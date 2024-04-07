Return-Path: <stable+bounces-36181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB289AE0F
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 04:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515F11F21A85
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 02:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8915B3;
	Sun,  7 Apr 2024 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuh9q9XH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893D7460
	for <stable@vger.kernel.org>; Sun,  7 Apr 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712456942; cv=none; b=rm2KqHWOLNgS84xiArc+eqkA1NDvZeEEqG8m1tQjYiSI245AIpU5wX5qHU2Ngm3lwb8LBda9xFHyX3JiWN4A0T9QULF11KKtRCvysuUpg7TITm37QAd+3Pe7BY0k0fUg+fM7/YTvsFYE5WrEC95uIgG6ZlhlSuM9w++PM61VvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712456942; c=relaxed/simple;
	bh=fX5zR/9FCOW7HTL8GdlTrij07h06gho1hH2QuqZ3NLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZsghjykZn6yIUxCzfBIGTWt2hd4KBGduLazo7pHtE2YN54bOYvSnZd33AJaE71+zPBg/DJChtw0Ab+or/nnC4qYHRNQX1KxBjfx35o9d0Zc7Vn7i51DgGLzOkXeZs69//3mmaThKjxsCJU+DLhXTz0zz1GDNrEFGq6QM6cVti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zuh9q9XH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e24c889618so28546075ad.2
        for <stable@vger.kernel.org>; Sat, 06 Apr 2024 19:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712456940; x=1713061740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04EWYPQ3tqA1KddlrE0T62PVcteMsovJRtjGtyQ4xS8=;
        b=Zuh9q9XHh0lvg9zox++CPrkw0dURLIsDVwWfAaN/KH3oOXfEAdYTApvZagg80+mXb+
         sT5a/lxc0bJsjpWfeeVVMScGcBjkue/vyZKQ22L8TYe7IPN108EG3UYC2hKX88bPynrv
         c5NFfNzYGp+GcIaVq8Gs/QBK4/cz5tc0gU1BPH5S8jtSBBHkuz8OC5AY0Y1a0fzUK+uX
         0YEzIH3WMVDEIq/tLQLq+hPFvr0XlRWVEQNXZtjp3DyAgaLkqUKrOBRDXVS+/qMJe3Ea
         Vn9NRKM99j4qorn7JXXtr5WESFF99ZF2Pz8BbMr2iDp9s9/dJjKb16y+el5Fr3m90Z/9
         xweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712456940; x=1713061740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04EWYPQ3tqA1KddlrE0T62PVcteMsovJRtjGtyQ4xS8=;
        b=qJtB/cmFDfgio3if0CNX8zLgsXncoBWyt/ITkxDXBTeQfbr541J2D5uc9d9hfrDu79
         1wgbfI1XmEz5IvP6R+n1hCtlEYlarCSpkGKd+tuzisDoi3/ZStOVrULDuZRjGmBT0EYs
         5xud3+y4vaWs9p+fErx+t0Fjk5vI77QTpA2rvtwxqLSP3UH9U5tekrAufu6GOSNGxUJR
         dpjT+LPvFzBaGZPa378zkB2uxK0Xwh/+b61FkXXaJi1Y6nR4hoGHi+Knl/l3Nx3LLG1F
         QDKtEeEmAd5P5tBU7+NLuiv0IA8d0iu5MVPgJclUG9pJlhopLfiaJMQb1l7ltAhVAWwX
         TbVw==
X-Forwarded-Encrypted: i=1; AJvYcCWERVxIr5mYUSlohPc22vEhXQX2AiRb9or79zf+nwetG5dfNnbtLaXURsFD2WsCiOsDJyy345bXBd2BFNEG+xRy3k4hIoA3
X-Gm-Message-State: AOJu0Yzi2RZhcWKYdwLYPS5k5SDZmTkWUt8H7eMrvTHr7s3h2akSSReY
	deGZxRK1PcICsb+QeHoSSJB1+X6waVrM2uKkwkoZntLsnbaa5x9H
X-Google-Smtp-Source: AGHT+IE37hWMmWkGJVGt79PlmEPyrgaqf8R77pgZrS+jFSfFKBChcG6cWpzfyia+njZbES3gFaYjxw==
X-Received: by 2002:a17:903:44d:b0:1e2:82fc:bf71 with SMTP id iw13-20020a170903044d00b001e282fcbf71mr4616512plb.22.1712456940493;
        Sat, 06 Apr 2024 19:29:00 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:f052:3362:3c6a:3999])
        by smtp.gmail.com with ESMTPSA id kp11-20020a170903280b00b001d8aa88f59esm4044516plb.110.2024.04.06.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 19:29:00 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org,
	stable@vger.kernel.org,
	"min15.li" <min15.li@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH for 6.1.y] nvme: fix miss command type check
Date: Sun,  7 Apr 2024 11:28:36 +0900
Message-Id: <20240407022836.6148-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "min15.li" <min15.li@samsung.com>

commit 31a5978243d24d77be4bacca56c78a0fbc43b00d upstream.

In the function nvme_passthru_end(), only the value of the command
opcode is checked, without checking the command type (IO command or
Admin command). When we send a Dataset Management command (The opcode
of the Dataset Management command is the same as the Set Feature
command), kernel thinks it is a set feature command, then sets the
controller's keep alive interval, and calls nvme_keep_alive_work().

Signed-off-by: min15.li <min15.li@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c       | 4 +++-
 drivers/nvme/host/ioctl.c      | 3 ++-
 drivers/nvme/host/nvme.h       | 2 +-
 drivers/nvme/target/passthru.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d7516e99275b..20160683e868 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1151,7 +1151,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1167,6 +1167,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 91e6d0347579..b3e322e4ade3 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -147,6 +147,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
+	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta = NULL;
@@ -181,7 +182,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	blk_mq_free_request(req);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a892d679e338..8e28d2de45c0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1063,7 +1063,7 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 int nvme_execute_passthru_rq(struct request *rq, u32 *effects);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index adc0958755d6..a0a292d49588 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -216,6 +216,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
 	struct request *rq = req->p.rq;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	struct nvme_ns *ns = rq->q->queuedata;
 	u32 effects;
 	int status;
 
@@ -242,7 +243,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, req->cmd, status);
+		nvme_passthru_end(ctrl, ns, effects, req->cmd, status);
 }
 
 static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
-- 
2.40.1


