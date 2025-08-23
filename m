Return-Path: <stable+bounces-172547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D523B326B1
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 05:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A80B60F71
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B62C1EE032;
	Sat, 23 Aug 2025 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw7lRf6T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5930C4317D
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755920158; cv=none; b=duxfSrOePHJuCAON/vwwyqBKpn9ZJXAz/0VrrJyiuSsWUe0rMeBue+CaJ0PyqVidZp5mOZlCyzAo2iGsQGMSHa+i768cZLaTh021iLhObOCsE03s9qI0cxqJhY88WYOhmw3f8x4idH1QD7JE18CtE+7kY7Id/4+tI5Pd2u+3sAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755920158; c=relaxed/simple;
	bh=maEZ2+/D8+tn/+PlJ7yxnYTmbMum+4BkjKOIG4yGRUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzykyTwL/71AWDQCpqgb/Bt5lqEz/p53/qmcylYgqY7HAsv9qBznXzSSSZa+vVr17ScjiHkU6Oe0RELxTVhP24kswwD96D1oeTwndmlcJ62VCvLJVUwtdTyK3x8nh6tHMkHtfzSBUuSixP481eg/gOxxcFdlMaou8IQcUdg1jWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw7lRf6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAFDC4CEF4;
	Sat, 23 Aug 2025 03:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755920157;
	bh=maEZ2+/D8+tn/+PlJ7yxnYTmbMum+4BkjKOIG4yGRUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nw7lRf6Th9c/a9a9dP/ai1aAlLcXXAHj1jGeeqKMVH7ZaZkvL9SGadmvPw2LD+Oxk
	 YltZkqZedxdi7oDrbW6T/qcbgpPsvMH8JfcZd0gOdYLu20PdS1dtj5LODzOZTD1sQj
	 kOFA4Xp+kfaL1mYUi28yGu4Myzdho9m4czITyYMXwp4u/iyac+fKsx0SatPfZUnL05
	 VbTRAI6KqEGm4iXOazcUYhegkGjD2X5Y5Eq1dL0xky1xcuqvDOOdQTXOXcqU4sCn0o
	 HLAxMuYkRgLZOMdKyfLW4TdUgKHVbX0VAI/07bpItATsmqD80ShCIbxQPTdWGw2ttv
	 xLjSPf/cWwZUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15.y 2/2] media: qcom: camss: cleanup media device allocated resource on error path
Date: Fri, 22 Aug 2025 23:35:54 -0400
Message-ID: <20250823033554.1801998-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823033554.1801998-1-sashal@kernel.org>
References: <2025082155-riches-diaper-55d5@gregkh>
 <20250823033554.1801998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 69080ec3d0daba8a894025476c98ab16b5a505a4 ]

A call to media_device_init() requires media_device_cleanup() counterpart
to complete cleanup and release any allocated resources.

This has been done in the driver .remove() right from the beginning, but
error paths on .probe() shall also be fixed.

Fixes: a1d7c116fcf7 ("media: camms: Add core files")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[ adapted error label from err_genpd_cleanup to err_cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index c9265fb26182..3b2dae7c15ac 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1396,7 +1396,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_cleanup;
+		goto err_media_cleanup;
 	}
 
 	ret = camss_register_entities(camss);
@@ -1438,6 +1438,8 @@ static int camss_probe(struct platform_device *pdev)
 	camss_unregister_entities(camss);
 err_register_entities:
 	v4l2_device_unregister(&camss->v4l2_dev);
+err_media_cleanup:
+	media_device_cleanup(&camss->media_dev);
 err_cleanup:
 	v4l2_async_notifier_cleanup(&camss->notifier);
 err_free:
-- 
2.50.1


