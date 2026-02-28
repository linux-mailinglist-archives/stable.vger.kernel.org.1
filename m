Return-Path: <stable+bounces-220264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGLMHj4vo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2651C576F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2562632133B5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD9637E673;
	Sat, 28 Feb 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvWpVR9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48CA37E66C;
	Sat, 28 Feb 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300167; cv=none; b=G1AtnuV0XuSdqiw2mYQoYs13FmSrgauiazJZBVp8dAaNf8s8HiNy9Vz0wfQ5//rIo0BxMm9KqTXhpd95C4br+nzkvkmDhsIu2k16DIAGITbtPvQEwaXmtxJr8rAsYsvGRDwjFtZ2CTL2iFxgdQY+/brhzQ+f6/LIcEsztccHKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300167; c=relaxed/simple;
	bh=qN7FlshoqMU79pI9pEyR07XAtSCL+xPGJYwlXEJa1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+egkOyecVXmaB0gpGzsuTRWh+MZ574dfIQou6J5ktqo/fmp52zFwBNg1xSB4NAi3fmnwkxpFM24NXeLubEolsb029NZgvbCqWLR2Oj0QEb4PIQ6YjlwtiIr1wkScDAUjAQ4GjU78XqWYqN3NDYULUVd37fiP0CtAE6iDJtJAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvWpVR9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B2CC19424;
	Sat, 28 Feb 2026 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300167;
	bh=qN7FlshoqMU79pI9pEyR07XAtSCL+xPGJYwlXEJa1Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvWpVR9IVf5ioFbyEfbUqyCn2e/VPkukTirljmvl2NnPKQ8/i2ZRPPyjPqz5sJDSM
	 gu83pNjgJvy2xD/DuyIFDaNzIxIqeTSMeaHf2GLKqpDIG6LWfuZVteMHkqz5wWPGUw
	 CiECp0rJid3nhQci2cEaRivy17zlqPNZssd/ciSN1eD5GwXhDY9Xbh1UCUWXMIyWUV
	 /m1x1aWg1XUzkRoGl/QoYXE1UaWdzkALpmDlstLJ4yRQScbbfQmSBzPDA+b54mZybO
	 1z8PRUSntOQOngNZtHZJnWZiG+zADqainhO7HJQWrYmob2aim2mAUPUdlN690vaWtL
	 mFT8D+htOCgtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 186/844] media: ipu6: Ensure stream_mutex is acquired when dealing with node list
Date: Sat, 28 Feb 2026 12:21:39 -0500
Message-ID: <20260228173244.1509663-187-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220264-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 1C2651C576F
X-Rspamd-Action: no action

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 779bdaad2abf718fb8116839e818e58852874b4d ]

The ipu6 isys driver maintains the list of video buffer queues related to
a stream (in ipu6 context streams on the same CSI-2 virtual channel) and
this list is modified through VIDIOC_STREAMON and VIDIOC_STREAMOFF IOCTLs.
Ensure the common mutex is acquired when accessing the linked list, i.e.
the isys device context's stream_mutex.

Add a lockdep assert to ipu6_isys_get_buffer_list() and switch to guard()
while at it as the error handling becomes more simple this way.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu6/ipu6-isys-queue.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c b/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c
index aa2cf7287477c..8f05987cdb4e7 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2013--2024 Intel Corporation
  */
 #include <linux/atomic.h>
+#include <linux/cleanup.h>
 #include <linux/bug.h>
 #include <linux/device.h>
 #include <linux/list.h>
@@ -201,6 +202,8 @@ static int buffer_list_get(struct ipu6_isys_stream *stream,
 	unsigned long flags;
 	unsigned long buf_flag = IPU6_ISYS_BUFFER_LIST_FL_INCOMING;
 
+	lockdep_assert_held(&stream->mutex);
+
 	bl->nbufs = 0;
 	INIT_LIST_HEAD(&bl->head);
 
@@ -294,9 +297,8 @@ static int ipu6_isys_stream_start(struct ipu6_isys_video *av,
 	struct ipu6_isys_buffer_list __bl;
 	int ret;
 
-	mutex_lock(&stream->isys->stream_mutex);
+	guard(mutex)(&stream->isys->stream_mutex);
 	ret = ipu6_isys_video_set_streaming(av, 1, bl);
-	mutex_unlock(&stream->isys->stream_mutex);
 	if (ret)
 		goto out_requeue;
 
@@ -637,10 +639,10 @@ static void stop_streaming(struct vb2_queue *q)
 	mutex_lock(&av->isys->stream_mutex);
 	if (stream->nr_streaming == stream->nr_queues && stream->streaming)
 		ipu6_isys_video_set_streaming(av, 0, NULL);
+	list_del(&aq->node);
 	mutex_unlock(&av->isys->stream_mutex);
 
 	stream->nr_streaming--;
-	list_del(&aq->node);
 	stream->streaming = 0;
 	mutex_unlock(&stream->mutex);
 
-- 
2.51.0


