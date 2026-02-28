Return-Path: <stable+bounces-220715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLW+FmlEo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:39:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DC71C737E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08109323003A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A473FD129;
	Sat, 28 Feb 2026 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2aXJbiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD83FD120;
	Sat, 28 Feb 2026 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300595; cv=none; b=eRDtSU7LxArAI2DPWBSusyE7H1KycWU/a7tbUpOLFtUZB5mD/zEYZwkGh+RZ9JFX+TyQKbKCzlsoMPVWQ8CqCbMxHqt0HqfuWSfltodYl160C0L3Deoh0IfOmE+j5uGI5CVz9+uRtLEcNTpI6MMuJs5vMLHsNZJMgeEKjs5zWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300595; c=relaxed/simple;
	bh=9SdAbGTyxiHRr9z7FUYyDx8TqImnTtSL8+GW7cSOGk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsJTT2izgCuawJhjGfB5lMQb0TxGLkkfxSxeqjHxrjsFmqzF7pvToTlhNvq6dqkfX/K5kC2rfC8nkRwzCxS6d2cbNonMD40kXBjz5zuWZ9PQWusyFoTcsaUZePMBJDn8sJVX9H0KPQNAAF3Q02bCzd7hMFUzPPpnqTu4P/9YbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2aXJbiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6563BC19424;
	Sat, 28 Feb 2026 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300595;
	bh=9SdAbGTyxiHRr9z7FUYyDx8TqImnTtSL8+GW7cSOGk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2aXJbiEg/5vx5PHUpjEL3EqdF1WZlrRL7nSxK+Gb66FIXDKa5GrRWYbs2BgUtVF1
	 MX0uhq+qz5ogqvaS+Aeq8I42QXalEX1vqi1K3iCcwgTy5I7b10YyyjIqsTwMrN6rd2
	 gGQ8nW9869fLN/U3aNPGt3j4ih87iSftSf5BBRR37gCB1S9c1lEStZVEgroWQl/HWJ
	 ZIT0eKyDvLuSCBZLtJLp33nsoGdDx/7AyHH73imSLNxTeCAfrsX6EEBlhPjpks54hG
	 UjOxPc8qxAPzzxl4zhqkUgrleMTTAK2bwx1xbNE/kzoUD9sK7iX/EiqTent+QrpZMq
	 vDxx9/lgUbMUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 636/844] media: iris: remove v4l2_m2m_ioctl_{de,en}coder_cmd API usage during STOP handling
Date: Sat, 28 Feb 2026 12:29:09 -0500
Message-ID: <20260228173244.1509663-637-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220715-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9DC71C737E
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
index c9b881923ef18..0c9c23ef2d180 100644
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


