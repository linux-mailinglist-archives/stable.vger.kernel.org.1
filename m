Return-Path: <stable+bounces-172552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CCB326C1
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 06:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D8566838
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD21F463F;
	Sat, 23 Aug 2025 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8bfx7PT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238891F4611
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755922143; cv=none; b=pL1L5NPfTog0QBE+qSYMvDutmpj5At0vTsNdCHRDDnCgedidd8cls8nqcoKCMTk1YlYZVNt/gp8I9ef4KycNqdGB3ajYTCrssu/VpnBnEehBOPu11u8YotCE7CIWsPQUiUdqt/0zB2BH+UylN/RHczXghrYXHlJu9Gudpz79GBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755922143; c=relaxed/simple;
	bh=WLgpy0fdiS6Y3BHTI8VA2xixCLe+HDPQJaR12KOhGVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PL86iJ1DXulY2AYHpYMEdfpBA2IXmTlbfYVZUzlS6tVhwWbVw517DFm0T/agYeyl7VlLqJeSJe8vQ8fjVsUp/bzQmNTgbhyvaPJEXGOLsPTMV6nvsCzoRir7zKzGy7Z8EOaTwavAKdzxdCYF8mxJgHOFVKVPiGu0JtTt0+KL92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8bfx7PT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014ACC4CEE7;
	Sat, 23 Aug 2025 04:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755922142;
	bh=WLgpy0fdiS6Y3BHTI8VA2xixCLe+HDPQJaR12KOhGVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8bfx7PTEF6c6d+6itVqBRpyBLaUM90dINapyv125omm8bu4Cbp7+9AD3O/d55cfQ
	 xL/taezWhU0VQDyBbC5KwtAE3w03cgM5aJOzpXoNq0qIy+5eWeCjETe2J5EATz5zG7
	 fr0cNkAR1BoV4UGdf83o27nWuLVydxM6zNyyR5SYYkTv2k8+3LytZd3eU7BazHABLp
	 tmaOfLdGk2w6uhLvuiGQQHUFE9j4JKbVvymIxwXYmQRRyqMaTN/feNRRakTzccvoQG
	 qNrQ0+QL89jgurtHzjoIJ4nbISehBlj0NsikUUta6m98iYmc13EG8/j/48jFnzfY3W
	 lJN0l6+6Ck3JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: venus: vdec: Clamp param smaller than 1fps and bigger than 240.
Date: Sat, 23 Aug 2025 00:08:59 -0400
Message-ID: <20250823040859.1832832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082103-exfoliate-wildness-1f7f@gregkh>
References: <2025082103-exfoliate-wildness-1f7f@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/core.h | 2 ++
 drivers/media/platform/qcom/venus/vdec.c | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 785a5bbb19c3..0abb152c681f 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -25,6 +25,8 @@
 #define VIDC_VCODEC_CLKS_NUM_MAX	2
 #define VIDC_PMDOMAINS_NUM_MAX		3
 
+#define VENUS_MAX_FPS			240
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 68390143d37d..b18459c5290c 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -427,11 +427,10 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
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


