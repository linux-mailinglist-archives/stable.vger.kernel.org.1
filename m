Return-Path: <stable+bounces-221043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP8pEdJXo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:02:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 585F41C8B65
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8162930F0610
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F51175A85;
	Sat, 28 Feb 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDsaSTqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0892175A60;
	Sat, 28 Feb 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301386; cv=none; b=Bh+sKwp/oz70c3yD+AZ/KzUejMDkvXOAt/DC9fNDlYwbAa27RxnUBXiEC3ZflRnMOX/jN6Nv8df2QKpj46iTYHEX9swixCmnuwvJMG+c2AnFXqPd9JDj2CtATjQ+qdQabCmRzUdswQa8f3RpstH4TpHhuXrsT0FRC94JOpDr6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301386; c=relaxed/simple;
	bh=lUk5O7eESbsqaWrLs1QVzAae7+Xwt4nGb9/uTpw8K34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiRMw5DLvzLu07sqhO6yuwMkgVffMVMgZiBS6OwXyespt/V9AoZl/sLOKk8mp/8ZhFzzhXU9154+MwYhOqKZx+TJnyRqDFj0IvwaV4U30mwnJMPdeiFQtvZ/gNqc1iIZ7aiHbhOXN8xX+Yd3cOqoaNlOsJvDg9IPABRSC35VLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDsaSTqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6218C116D0;
	Sat, 28 Feb 2026 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301385;
	bh=lUk5O7eESbsqaWrLs1QVzAae7+Xwt4nGb9/uTpw8K34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDsaSTqV94gsdToWXC7MoxBgmKpRMdgSufsxrQvTAYh+yJQomilM0rn0VZSN+oLLs
	 +TM3buMRoQpLUiw+u4MIJAcQ1nLcp/y4HK0UFPwNwUPLL4GJa/bf40MHzLQHXSfeIx
	 fvHt5+hdyXbe9aOKnhD8dwpC1QO6ufH7S8yA0D5BEtQQv6S48rVybqZ2ORe5DIzIwm
	 JHyT0OOEACFPQJBwhJd5UWCLepTq3Kg2aXnyxXDBaPRCxZ0C2lizGXAPAqqhlpclkX
	 OXre04pCnRIFnk36AdLOT7yIQAZMmNuMvT/PVCylJk6chPtq2PetJWybO6HS0P4Oku
	 X8E3xWkHZ8xPQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 574/752] media: iris: Prevent output buffer queuing before stream-on completes
Date: Sat, 28 Feb 2026 12:44:45 -0500
Message-ID: <20260228174750.1542406-574-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221043-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 585F41C8B65
X-Rspamd-Action: no action

From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

[ Upstream commit 2c73cfd0cfc44ffe331ccb81f6ac45fc399d9ddb ]

During normal playback, stream-on for input is followed by output, and
only after input stream-on does actual streaming begin. However, when
gst-play performs a seek, both input and output streams are stopped,
and on restart, output stream-on occurs first. At this point, firmware
has not yet started streaming. Queuing output buffers before the firmware
begins streaming causes it to process buffers in an invalid state, leading
to an error response. These buffers are returned to the driver as errors,
forcing the driver into an error state and stopping playback.

Fix this by deferring output buffer queuing until stream-on completes.
Input buffers can still be queued before stream-on as required.

Fixes: 92e007ca5ab6 ("media: iris: Add V4L2 streaming support for encoder video device")
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_vb2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
index 139b821f7952f..bf0b8400996ec 100644
--- a/drivers/media/platform/qcom/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/iris/iris_vb2.c
@@ -193,10 +193,14 @@ int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 	buf_type = iris_v4l2_type_to_driver(q->type);
 
 	if (inst->domain == DECODER) {
-		if (inst->state == IRIS_INST_STREAMING)
+		if (buf_type == BUF_INPUT)
+			ret = iris_queue_deferred_buffers(inst, BUF_INPUT);
+
+		if (!ret && inst->state == IRIS_INST_STREAMING) {
 			ret = iris_queue_internal_deferred_buffers(inst, BUF_DPB);
-		if (!ret)
-			ret = iris_queue_deferred_buffers(inst, buf_type);
+			if (!ret)
+				ret = iris_queue_deferred_buffers(inst, BUF_OUTPUT);
+		}
 	} else {
 		if (inst->state == IRIS_INST_STREAMING) {
 			ret = iris_queue_deferred_buffers(inst, BUF_INPUT);
-- 
2.51.0


