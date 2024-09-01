Return-Path: <stable+bounces-72482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1895967ACE
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7B01C214E7
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB323381BD;
	Sun,  1 Sep 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9iSavVy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7426AC1;
	Sun,  1 Sep 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210068; cv=none; b=Q+bZ936KEV0CSXCfL+3arbVNSpdFlorByhElmAB97ytPMl56bFWTy1IQs+PjgOdCZBBnwcbK4YfEnzgiQ0iYm7suSP6YBiMbcwW+wkjLeDfETWJf/nSI7v2894QHxtD9VPFzloaR4vuoAAuZo1Yjfhkigl4SGZVdsMa5QghOysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210068; c=relaxed/simple;
	bh=S47Rj58fU+CR8F2Iq+fCP/ZhIHW4j0uKAxS46CqGFLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaS7b0kpqr6KYTI+3qng4FthOz8XnixRs+KkKpUqaxuT4imdnw9+4mcO8rpI1ak/aiZhoOph8GTLEkYsffDiNWR2PDr4EXK+YIgXdMU26HPZ2IjS3gNCU2GrgKS3rcjSqkWVYY4ctpHF31SqSpRytqvVzlel9cojUsKVuVX8qDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S9iSavVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EBBC4CEC3;
	Sun,  1 Sep 2024 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725210068;
	bh=S47Rj58fU+CR8F2Iq+fCP/ZhIHW4j0uKAxS46CqGFLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9iSavVyE0OxFw31vGeviOfGMDhHj3IZKeW1tsPOr+Z7b8zWTBlrV01kCMe/tQ3OR
	 e6os1OpnNnv/P7ZrgL8fSB8ZqgNbxOYbkXrFnL16dpyF40LSEpNd+Lup6tabOQUlzg
	 3U/3ReSQfEREcPE7fHdHCTPGOmaZtGCjlLL0rGN4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 079/215] clocksource/drivers/arm_global_timer: Guard against division by zero
Date: Sun,  1 Sep 2024 18:16:31 +0200
Message-ID: <20240901160826.339720137@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
References: <20240901160823.230213148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit e651f2fae33634175fae956d896277cf916f5d09 ]

The result of the division of new_rate by gt_target_rate can be zero (if
new_rate is smaller than gt_target_rate). Using that result as divisor
without checking can result in a division by zero error. Guard against
this by checking for a zero value earlier.
While here, also change the psv variable to an unsigned long to make
sure we don't overflow the datatype as all other types involved are also
unsiged long.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240225151336.2728533-3-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/arm_global_timer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index e1c773bb55359..22a58d35a41fa 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -290,18 +290,17 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
 	switch (event) {
 	case PRE_RATE_CHANGE:
 	{
-		int psv;
+		unsigned long psv;
 
-		psv = DIV_ROUND_CLOSEST(ndata->new_rate,
-					gt_target_rate);
-
-		if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
+		psv = DIV_ROUND_CLOSEST(ndata->new_rate, gt_target_rate);
+		if (!psv ||
+		    abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
 			return NOTIFY_BAD;
 
 		psv--;
 
 		/* prescaler within legal range? */
-		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
+		if (psv > GT_CONTROL_PRESCALER_MAX)
 			return NOTIFY_BAD;
 
 		/*
-- 
2.43.0




