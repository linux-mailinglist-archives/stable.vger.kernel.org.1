Return-Path: <stable+bounces-220711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOAXL6hAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 654361C6EBA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38496304F030
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E753FC0F1;
	Sat, 28 Feb 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wli8Tw/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A13FC0E9;
	Sat, 28 Feb 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300591; cv=none; b=HHA26aO/Wyhfw9SVGaS2Cs0NI7JhGLY0H+RUjxCCDPTuu9LXrIQ6RcFdzCwNwx9kIbHeyHwRDch+WMyTldAzcspGJiqTxrphZ2f+5G6/lr78qMEb3e7NqyuHMw/vtK2ISm4rFK1HyTXq2GhwJyTu+r6D37mcHRPyT2eOwT2+pbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300591; c=relaxed/simple;
	bh=GVG2CccgbtedmWaGhiaA33rg9BGO31x0WCbImzpyZac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blpKMltnK6YNpFzy1EriiM+UqyEzn+wXgmbohcY5cEQmnNnyEr6MapqRkcncC2yiSKjmvRT+59qG24UOQOmIo1NfUD3MMCw+Cbopg2v92LwooV0teK2td8XUye7me0h4j69hXy7wY3T0OgbfMmMhz2ZMvNXbXXj91Qray9M7jTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wli8Tw/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5B7C19425;
	Sat, 28 Feb 2026 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300590;
	bh=GVG2CccgbtedmWaGhiaA33rg9BGO31x0WCbImzpyZac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wli8Tw/x/4Pwp1O3iUkkBVI7pCP2Ss/s55O55BVe+i7QST7DiefrxNwn5V43EiAtY
	 qwd3bFFlz4AJmabyXMLuWm5a37QPyu3AhixxoYwC4pPTDofr17BpwVvVQ00ljcfKj2
	 CXARmANmIvMexMC1Zt9oLl3lSQobeXZcfEof1vMQxruJWo2OmBrvYTesrWLf5Zdi9x
	 F0pI0tl7yNwDiwc9WmkTtpYCHd/RTgH0heQEfHjgaOMfsFkLc/kmwxOo5PzFiVFqbd
	 yuA3DFjxJOQslXKjtLjAbqfUCf3NKlgPew4c3ozlQzlql+RUe9tvH4U+7c+yKwN8X0
	 kFX8Hs7OtK62w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 632/844] Revert "media: iris: Add sanity check for stop streaming"
Date: Sat, 28 Feb 2026 12:29:05 -0500
Message-ID: <20260228173244.1509663-633-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220711-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 654361C6EBA
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 370e19042fb8ac68109f8bdb0fdd8118baf39318 ]

This reverts commit ad699fa78b59241c9d71a8cafb51525f3dab04d4.

Revert the check that skipped stop_streaming when the instance was in
IRIS_INST_ERROR, as it caused multiple regressions:

1. Buffers were not returned to vb2 when the instance was already in
   error state, triggering warnings in the vb2 core because buffer
   completion was skipped.

2. If a session failed early (e.g. unsupported configuration), the
   instance transitioned to IRIS_INST_ERROR. When userspace attempted
   to stop streaming for cleanup, stop_streaming was skipped due to the
   added check, preventing proper teardown and leaving the firmware
   in an inconsistent state.

Fixes: ad699fa78b59 ("media: iris: Add sanity check for stop streaming")
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_vb2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
index db8768d8a8f61..139b821f7952f 100644
--- a/drivers/media/platform/qcom/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/iris/iris_vb2.c
@@ -231,8 +231,6 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 		return;
 
 	mutex_lock(&inst->lock);
-	if (inst->state == IRIS_INST_ERROR)
-		goto exit;
 
 	if (!V4L2_TYPE_IS_OUTPUT(q->type) &&
 	    !V4L2_TYPE_IS_CAPTURE(q->type))
@@ -243,10 +241,10 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 		goto exit;
 
 exit:
-	if (ret) {
-		iris_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
+	iris_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
+	if (ret)
 		iris_inst_change_state(inst, IRIS_INST_ERROR);
-	}
+
 	mutex_unlock(&inst->lock);
 }
 
-- 
2.51.0


