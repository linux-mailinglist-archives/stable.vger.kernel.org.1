Return-Path: <stable+bounces-139769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226BAA9F1F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3CF1A81F0F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E727EC98;
	Mon,  5 May 2025 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoHMZcc0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC81277817;
	Mon,  5 May 2025 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483298; cv=none; b=ejHjyF4LZn9M7FGTkm2kYtmaH1er8Qw+Up1z8FbvS2bZy5fFL5iaFSGDMWdre5mwUy2FcZLZE/u2ovwVS+cfp1+DcaifZP6v7MuOBHJpiWcsF/GcvabkddXvY6kY21Vg55mPHYxyELpGhEOBd1DnM+Dmm5K2E6RnF8G767Bejm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483298; c=relaxed/simple;
	bh=uuO6mDXQclPqjp6WfVLBdD0/cjM2MYWsa2dDKUm0Bpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCsqZJGNMIjtjJFKQqR8tVHuhKhsWOl3YvcDSjHXwCCloaHI78xTiDu+b1EjiJNZqKkctoCgR+YJM2GpuA71hy/S8QO608LGsLdQ+PhOfc9uj/vOTmLzxVdDd5UlmMRtUwyWYCU6uFMhiJvl3KQLtCnzrzA7QOR7hMELOHzuKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoHMZcc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AB4C4CEED;
	Mon,  5 May 2025 22:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483298;
	bh=uuO6mDXQclPqjp6WfVLBdD0/cjM2MYWsa2dDKUm0Bpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoHMZcc0ibU8VI5XCIN3wSvWJH6k0S3+U/kRXRQ1F5rk1FXotE4VPvooGaKF9wxFK
	 GU34wrPGsvth3aMD0LwpMohGTn6kk7G5nd958Atr1MMcx/2uzDmJ4iv2Zt/7Q8xlKr
	 Qf7uTjGPGfXdd8NAnncFt7tSUgS13i+HQPYCYDwLHMAk46PBJPcg0Sfe+aKO/2GdUw
	 9FSNlADlbeZO5b8pUwTySnX0XWtpuZiHt9lmCxpr9bkvPqDz4fbxEK+Rw2GE38hVjW
	 EiO38x5LAWy+LqxSc4dTB2wGVlpRZ5Yj+q5MWXz6iQ6DkiOrk4W7DtR7XT4Ee5BqwI
	 HmwzB4uJJL2QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 022/642] mailbox: use error ret code of of_parse_phandle_with_args()
Date: Mon,  5 May 2025 18:03:58 -0400
Message-Id: <20250505221419.2672473-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit 24fdd5074b205cfb0ef4cd0751a2d03031455929 ]

In case of error, of_parse_phandle_with_args() returns -EINVAL when the
passed index is negative, or -ENOENT when the index is for an empty
phandle. The mailbox core overwrote the error return code with a less
precise -ENODEV. Use the error returned code from
of_parse_phandle_with_args().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d3d26a2c98956..cb174e788a96c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -415,11 +415,12 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 
 	mutex_lock(&con_mutex);
 
-	if (of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", index, &spec)) {
+	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
+					 index, &spec);
+	if (ret) {
 		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
 		mutex_unlock(&con_mutex);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(ret);
 	}
 
 	chan = ERR_PTR(-EPROBE_DEFER);
-- 
2.39.5


