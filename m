Return-Path: <stable+bounces-224280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJNINgUBsGm0eQIAu9opvQ
	(envelope-from <stable+bounces-224280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:31:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCF24AE3F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4341F3058AF5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4375313E32;
	Tue, 10 Mar 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwF9NlTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863A3876D5;
	Tue, 10 Mar 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141976; cv=none; b=F2psvXBFcW/FQ6/sNMhxXmBGAaZ+Weo68wA6HTj2weoDGJeHsII7QK2sqzjH2X50Tnuzp3HtFxD7xmts7M5UYuqSYd65D3hPzD+9wHCwxR25cuxw+XaxmH1fp9PQZth9TeA5+hH+/mGfk5/eRTlqZbjk457+j5i/hLFC3f79EPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141976; c=relaxed/simple;
	bh=pH1+wUlH4V3cxyurRkzGzUjshwY9CiXzkIzPgRzKgfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew2ksji8zvrHnG347pSTdPh3s00TQmx9BLmXZwYBE9u29e27uD4mkUHwbSt90ArHMSJ5Amvugm6BeXU4f5bdrAqhZeTymTV9kdO5RvSR6ii8CaJ2Yjs7avclQhDt0nOSGXXlbjAAq+Ea3b5VU1vvk3op3lfkFD/oV+RSSnx+3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwF9NlTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31FBC19423;
	Tue, 10 Mar 2026 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141976;
	bh=pH1+wUlH4V3cxyurRkzGzUjshwY9CiXzkIzPgRzKgfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwF9NlTcDoByXldeNj8rZWJF8iPtpP2FtKteYYZjwfv2uCHjGcymgJ+m5YWdU6nqE
	 Y3PM1twxRHP/64WHqG7epois0jPd72tSszHlJqMHDxgzp4AYlcaNZVr8XECReTu9Kw
	 VYpp4BEgLJHBkIo13nRX4TH0cB2uv4vehO1PIXkgEC6uItSnxjVaYOkVmGFP0wdc59
	 xZS1tReMAZWLsrO6Fisn0lDdd05clpTuNGFmJ5+eeetvcbA1dai6ZLH6MQEYvpV2TH
	 UN2pQ1Glwo+3S4oY4RDBAjayyiXuY4F4soH9F2lRP83M7NyoJaKXvthDkgAOQeh2iz
	 Wwu5RzTeCx32g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 101/314] media: iris: remove v4l2_m2m_ioctl_{de,en}coder_cmd API usage during STOP handling
Date: Tue, 10 Mar 2026 07:16:00 -0400
Message-ID: <60c20bd5fe638027e9cbe05fffe81fead47c3585.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AAFCF24AE3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224280-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 8fc707d13df517222db12b465af4aa9df05c99e1 ]

Currently v4l2_m2m_ioctl_{de,enc}coder_cmd is being invoked during STOP
command handling. However, this is not required as the iris driver has
its own drain and stop handling mechanism in place.

Using the m2m command API in this context leads to incorrect behavior,
where the LAST flag is prematurely attached to a capture buffer,
when there are no buffers in m2m source queue. But, in this scenario
even though the source buffers are returned to client, hardware might
still need to process the pending capture buffers.

Attaching LAST flag prematurely can result in the capture buffer being
removed from the destination queue before the hardware has finished
processing it, causing issues when the buffer is eventually returned by
the hardware.

To prevent this, remove the m2m API usage in stop handling.

Fixes: d09100763bed ("media: iris: add support for drain sequence")
Fixes: 75db90ae067d ("media: iris: Add support for drain sequence in encoder video device")
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_vidc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index d38d0f6961cd5..07682400de690 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -572,9 +572,10 @@ static int iris_dec_cmd(struct file *filp, void *fh,
 
 	mutex_lock(&inst->lock);
 
-	ret = v4l2_m2m_ioctl_decoder_cmd(filp, fh, dec);
-	if (ret)
+	if (dec->cmd != V4L2_DEC_CMD_STOP && dec->cmd != V4L2_DEC_CMD_START) {
+		ret = -EINVAL;
 		goto unlock;
+	}
 
 	if (inst->state == IRIS_INST_DEINIT)
 		goto unlock;
@@ -605,9 +606,10 @@ static int iris_enc_cmd(struct file *filp, void *fh,
 
 	mutex_lock(&inst->lock);
 
-	ret = v4l2_m2m_ioctl_encoder_cmd(filp, fh, enc);
-	if (ret)
+	if (enc->cmd != V4L2_ENC_CMD_STOP && enc->cmd != V4L2_ENC_CMD_START) {
+		ret = -EINVAL;
 		goto unlock;
+	}
 
 	if (inst->state == IRIS_INST_DEINIT)
 		goto unlock;
-- 
2.51.0


