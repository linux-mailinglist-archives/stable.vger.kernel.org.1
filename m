Return-Path: <stable+bounces-94893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA17B9D701E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70501285883
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D036D1E1C18;
	Sun, 24 Nov 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxuFMyI0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964D1E1C09;
	Sun, 24 Nov 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453142; cv=none; b=hO9/yWCE5emw4rKeeO+sO9gD/ZD3dD4Rt2Xq3b8HPXErlaiOnE2wLgc066LS5yyaYD02VyJVOgowQiPVv3rYiDAAh1PYRQhINzy1BCwi5L8cC4go/GocL2Z8FNlLVXkwMp6bFQEKNi0uL+EAJ288tdCwt7Jj43r9UsersbjiS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453142; c=relaxed/simple;
	bh=ZlclmR9ekvOSnoWo/wpuWV0rwFwwMhCV5hTWvuQ0BqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaVyQrLzZfY0amz4Hk6dStEgDTtrcn8sbX5vkAzfhCrfbkRzhaB3IAZT21mVafdymv5BKjwWCPcTUMFceS1ZI+t1RFxCAuye/7Z9jIFQUM5D7DEAtVOgmFdx+reU/fIlROB8VKUS9ZCMlauLyqTFluTTYOg9Z4qMHPIaseGl72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxuFMyI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B359C4CED3;
	Sun, 24 Nov 2024 12:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732453142;
	bh=ZlclmR9ekvOSnoWo/wpuWV0rwFwwMhCV5hTWvuQ0BqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxuFMyI0HyKKVot41z5QwtiyTyG7eVsI4tFoI3kGrlZMQJNVwa+hvMULVMBb2Ui6w
	 Qwrb8Ji2lXH6Cy5YZCvnG1x//sQJj958qq+OLKE+gHpxi/0GdwFtqI9dk6wnl7D25F
	 9rEhFV6aYaaTbKHqsG4yPPg0X7KWOg5BuFTTuAxxsmKOo984jwrO23Bqd1W5HJcmpJ
	 idAVTK0X4/AZpaMrj237DRmrpsojztzlm6L37OVC5/lhqcKpOsA2RJikOvjfAIaebh
	 vTAlHdCdJ4AQ9RQToiP87fBgYmY2wIXjgoNPDo4L625V0WbSWGYgoMJdRc4uE0dg2S
	 Jm7ggJhE8i6JQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/4] media: vb2: use lock if wait_prepare/finish are NULL
Date: Sun, 24 Nov 2024 07:58:40 -0500
Message-ID: <20241124125856.3341388-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125856.3341388-1-sashal@kernel.org>
References: <20241124125856.3341388-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 88785982a19daa765e30ab3a605680202cfaee4e ]

If the wait_prepare or wait_finish callback is set, then call it.
If it is NULL and the queue lock pointer is not NULL, then just
unlock/lock that mutex.

This allows simplifying drivers by dropping the wait_prepare and
wait_finish ops (and eventually the vb2_ops_wait_prepare/finish helpers).

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 98719aa986bb9..e439831f6df46 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1528,7 +1528,10 @@ static int __vb2_wait_for_done_vb(struct vb2_queue *q, int nonblocking)
 		 * become ready or for streamoff. Driver's lock is released to
 		 * allow streamoff or qbuf to be called while waiting.
 		 */
-		call_void_qop(q, wait_prepare, q);
+		if (q->ops->wait_prepare)
+			call_void_qop(q, wait_prepare, q);
+		else if (q->lock)
+			mutex_unlock(q->lock);
 
 		/*
 		 * All locks have been released, it is safe to sleep now.
@@ -1538,12 +1541,16 @@ static int __vb2_wait_for_done_vb(struct vb2_queue *q, int nonblocking)
 				!list_empty(&q->done_list) || !q->streaming ||
 				q->error);
 
+		if (q->ops->wait_finish)
+			call_void_qop(q, wait_finish, q);
+		else if (q->lock)
+			mutex_lock(q->lock);
+
+		q->waiting_in_dqbuf = 0;
 		/*
 		 * We need to reevaluate both conditions again after reacquiring
 		 * the locks or return an error if one occurred.
 		 */
-		call_void_qop(q, wait_finish, q);
-		q->waiting_in_dqbuf = 0;
 		if (ret) {
 			dprintk(1, "sleep was interrupted\n");
 			return ret;
-- 
2.43.0


