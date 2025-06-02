Return-Path: <stable+bounces-150423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F5CACB8A0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A541C24363
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79724224244;
	Mon,  2 Jun 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PQ8eBi6+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D01FF61E;
	Mon,  2 Jun 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877077; cv=none; b=R14zVISH+6eiejZp+I5CY6ejTN2dd8GtRk/vpm+h+lzhqawMCr4NExFiR3E0rCbwysYTQQE54aZ2yqTohX8IoWl9Jv9AGyySMM2YCYoTaSi+2E05qFT3dl6fBFMgWb/c9a9jLjFtDaDcJ+b2Aq2ABIndfTg0D8ow/pb0SXzy54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877077; c=relaxed/simple;
	bh=UP1raTO1TD1rJf9p23VzhMnxzVSDYsbv/AVTd4LPqw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEjPR11HVc77qTJPjHVurrFyfkkphCrq6XPZ9FTpZJDCUQMHpQSKRUc+WCk13ZFm6jdBLL6+a66XtpguQjluPpGrFsBZRwn0zic1dB/xz27JdotzJgUqSnibE1rQyFjj3LUaMR4oDZV6T3V1H9OMfkERRttQfRNfxPO7ASJN8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PQ8eBi6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0979C4CEEB;
	Mon,  2 Jun 2025 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877077;
	bh=UP1raTO1TD1rJf9p23VzhMnxzVSDYsbv/AVTd4LPqw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQ8eBi6+0rhWRSBg9PNx7/B0KovdsUpJ3u+WMrwbWLRoOigmWzQkm9/fjVYK5NaXg
	 7B9KvAvWCAGWOUv1NqbnAIAdoidwaYVDYaGclKGlJrcGdHPJAiMhnbZlqH3mOeZVwB
	 lQS434bvw3zbTimleE+4TCqG4+sGk22GvfoRsa+A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil@xs4all.nl>,
	"Artem S. Tashkinov" <aros@gmx.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 164/325] media: test-drivers: vivid: dont call schedule in loop
Date: Mon,  2 Jun 2025 15:47:20 +0200
Message-ID: <20250602134326.461016405@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit e4740118b752005cbed339aec9a1d1c43620e0b9 ]

Artem reported that the CPU load was 100% when capturing from
vivid at low resolution with ffmpeg.

This was caused by:

while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
       !kthread_should_stop())
        schedule();

If there are no other processes running that can be scheduled,
then this is basically a busy-loop.

Change it to wait_event_interruptible_timeout() which doesn't
have that problem.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Reported-by: Artem S. Tashkinov <aros@gmx.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219570
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/test-drivers/vivid/vivid-kthread-cap.c  | 11 ++++++++---
 drivers/media/test-drivers/vivid/vivid-kthread-out.c  | 11 ++++++++---
 .../media/test-drivers/vivid/vivid-kthread-touch.c    | 11 ++++++++---
 drivers/media/test-drivers/vivid/vivid-sdr-cap.c      | 11 ++++++++---
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
index 690daada7db4f..54e6a6772035f 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
@@ -894,9 +894,14 @@ static int vivid_thread_vid_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
-		       !kthread_should_stop())
-			schedule();
+		if (!time_is_after_jiffies(cur_jiffies + wait_jiffies))
+			continue;
+
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+		wait_event_interruptible_timeout(wait, kthread_should_stop(),
+					cur_jiffies + wait_jiffies - jiffies);
 	}
 	dprintk(dev, 1, "Video Capture Thread End\n");
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-out.c b/drivers/media/test-drivers/vivid/vivid-kthread-out.c
index 0833e021bb11d..8a17a01e6e426 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-out.c
@@ -235,9 +235,14 @@ static int vivid_thread_vid_out(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
-		       !kthread_should_stop())
-			schedule();
+		if (!time_is_after_jiffies(cur_jiffies + wait_jiffies))
+			continue;
+
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+		wait_event_interruptible_timeout(wait, kthread_should_stop(),
+					cur_jiffies + wait_jiffies - jiffies);
 	}
 	dprintk(dev, 1, "Video Output Thread End\n");
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-touch.c b/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
index fa711ee36a3fb..c862689786b69 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
@@ -135,9 +135,14 @@ static int vivid_thread_touch_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
-		       !kthread_should_stop())
-			schedule();
+		if (!time_is_after_jiffies(cur_jiffies + wait_jiffies))
+			continue;
+
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+		wait_event_interruptible_timeout(wait, kthread_should_stop(),
+					cur_jiffies + wait_jiffies - jiffies);
 	}
 	dprintk(dev, 1, "Touch Capture Thread End\n");
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-sdr-cap.c b/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
index 0ae5628b86c95..abccd1d0109ec 100644
--- a/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
@@ -206,9 +206,14 @@ static int vivid_thread_sdr_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
-		       !kthread_should_stop())
-			schedule();
+		if (!time_is_after_jiffies(cur_jiffies + wait_jiffies))
+			continue;
+
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+		wait_event_interruptible_timeout(wait, kthread_should_stop(),
+					cur_jiffies + wait_jiffies - jiffies);
 	}
 	dprintk(dev, 1, "SDR Capture Thread End\n");
 	return 0;
-- 
2.39.5




