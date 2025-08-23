Return-Path: <stable+bounces-172584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D91B328AA
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756213A5BE3
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018AE2522B1;
	Sat, 23 Aug 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqy4uXji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B606B24CEE8
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953697; cv=none; b=EuXwRo4btWfG8of0f+LmBWaQNkSBr4wt9RGsL7LDmvoKV+IQRAepexEfryv2eZ7JhatYpX4mLgsFYRVtBbSpnpvH5UKgLpmBdKNGHA/M4ZyTtsfoW+3lGMcBlyesUNukMG10nsHDPObuSI8z1+tOJK2SC7azXsHYA0Uat5/4J2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953697; c=relaxed/simple;
	bh=5gT8RCmdYHfHz+ABBZwPbfhelh2KlcH0qt8DRw57H+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIOwzpBK28aumhPVSVLT/+rzkf3T5L2/FfL0C+TbbkZicwLadP2/zSn88yanX/FEg4Vvia8/aqRD753TayDyw9OiUYXD7YDLjP2xIWLEvzh9sVc4rM4dyWsCs8QcmJnIyeaRB8oa8v7CQwIqsjoljgcEJuKCnOohuzxT22IC3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqy4uXji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C655C4CEE7;
	Sat, 23 Aug 2025 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755953697;
	bh=5gT8RCmdYHfHz+ABBZwPbfhelh2KlcH0qt8DRw57H+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rqy4uXjioL23Qgh8XZxMaMd1nGWCHGSCF2JUA3y4+nWUk+erm/5m+2gMIXWe114XE
	 NX1hR+7I6bPBAn/gNlqY3sTVhGOZrJlwLB2Q4EZlZAfbUKdbnW0IxAdUi//PeU6C02
	 vXtZF6cumxQiLZ9Rjjl2FvfoQIMjSmnLRTC/hWodc/o46DRPo3BbIJGseq5uOCjSUB
	 /d+Iw1IzEo1/aBSxaQAcAtE8aiB0lq8N8ykkkbXlbnJk6NRuhB+fM7DWedmkUVtXMc
	 AV2XjTyfa7Ll3ODiohl5OGrnWQxX+pSODqWMrVXvCJ9+5o7KHKISvRIo2ZUgE9UkA5
	 MI2+vny+Snm0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] media: venus: vdec: Clamp param smaller than 1fps and bigger than 240.
Date: Sat, 23 Aug 2025 08:54:54 -0400
Message-ID: <20250823125454.2100689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082106-elevate-boil-beef@gregkh>
References: <2025082106-elevate-boil-beef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 377dc500d253f0b26732b2cb062e89668aef890a ]

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
[ Adjust context in header ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/core.h | 2 ++
 drivers/media/platform/qcom/venus/vdec.c | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 922cb7e64bfa..03512858c868 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -16,6 +16,8 @@
 
 #define VIDC_CLKS_NUM_MAX	4
 
+#define VENUS_MAX_FPS			240
+
 struct freq_tbl {
 	unsigned int load;
 	unsigned long freq;
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index a0a67b7132b8..551462e64082 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -418,11 +418,10 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
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
-- 
2.50.1


