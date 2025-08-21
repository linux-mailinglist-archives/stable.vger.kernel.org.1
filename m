Return-Path: <stable+bounces-172140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70179B2FCDA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9D7B65060
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD6283138;
	Thu, 21 Aug 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWoxH1U9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40A286D71
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786556; cv=none; b=CMDS/0MdlcOirQOcejRcuTcmQ5hNjMGVVCAijrUpj8xgunI75QJr8WEnQxSG/cqZ1hXGgbw141Kg8PmHZsbf0ercDAbmLMMYh3p6j6QB+zRaBOGN+fvZ4kCJ6Bu2jVpOjN7rVG1DvLE8V/Zk1nL+0+fwx9jAYlcfiOL30tgKuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786556; c=relaxed/simple;
	bh=ar2xd8lKafYhqsevDiH7vu9kAxN70erzx4ia+ysBlNc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D9ZPCqsJAHR2AI4fDaloDLQyj4G7BuiVTJrBUSG7qxIVs3ysvYeM6ndrUOgMSF4qkDvH3tsAG69ZEyoSlKZhtJosZYkiEhYuRmvF9TQoBPfYAxuJGCPTln9aIptjhNJOu4giotsHj0qC+xMjq8Ru2R0QVuUUVl2RwA4CzsK3TxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nWoxH1U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAFCC4CEEB;
	Thu, 21 Aug 2025 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786556;
	bh=ar2xd8lKafYhqsevDiH7vu9kAxN70erzx4ia+ysBlNc=;
	h=Subject:To:Cc:From:Date:From;
	b=nWoxH1U9m/aTAjb5YR07tyuI3etQ1qEueS/66SP3pZWPsXrqUzhcNJnf27/+PYTj0
	 HBxQTzxXqCLiWtMSc8wP8lvEOyhJTGKRrh6lIyOzmzXe8AoxvsgDhixNJClp2BSeuh
	 JNzt9rvgZmiH+XNynQ2Gj73PWRZkpqo9SVC/zHwk=
Subject: FAILED: patch "[PATCH] media: venus: vdec: Clamp param smaller than 1fps and bigger" failed to apply to 5.4-stable tree
To: ribalda@chromium.org,bod@kernel.org,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:29:06 +0200
Message-ID: <2025082106-elevate-boil-beef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 377dc500d253f0b26732b2cb062e89668aef890a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082106-elevate-boil-beef@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 377dc500d253f0b26732b2cb062e89668aef890a Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Jun 2025 15:29:14 +0000
Subject: [PATCH] media: venus: vdec: Clamp param smaller than 1fps and bigger
 than 240.

The driver uses "whole" fps in all its calculations (e.g. in
load_per_instance()). Those calculation expect an fps bigger than 1, and
not big enough to overflow.

Clamp the value if the user provides a param that will result in an invalid
fps.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Closes: https://lore.kernel.org/linux-media/f11653a7-bc49-48cd-9cdb-1659147453e4@xs4all.nl/T/#m91cd962ac942834654f94c92206e2f85ff7d97f0
Fixes: 7472c1c69138 ("[media] media: venus: vdec: add video decoder files")
Cc: stable@vger.kernel.org
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # qrb5615-rb5
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
[bod: Change "parm" to "param"]
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index b412e0c5515a..5b1ba1c69adb 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -28,6 +28,8 @@
 #define VIDC_RESETS_NUM_MAX		2
 #define VIDC_MAX_HIER_CODING_LAYER 6
 
+#define VENUS_MAX_FPS			240
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 99ce5fd41577..fca27be61f4b 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -481,11 +481,10 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
 	do_div(us_per_frame, timeperframe->denominator);
 
-	if (!us_per_frame)
-		return -EINVAL;
-
+	us_per_frame = clamp(us_per_frame, 1, USEC_PER_SEC);
 	fps = (u64)USEC_PER_SEC;
 	do_div(fps, us_per_frame);
+	fps = min(VENUS_MAX_FPS, fps);
 
 	inst->fps = fps;
 	inst->timeperframe = *timeperframe;


