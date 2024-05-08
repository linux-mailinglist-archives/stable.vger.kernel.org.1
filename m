Return-Path: <stable+bounces-43341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132998BF1E1
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1273280E96
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1743F149C60;
	Tue,  7 May 2024 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz4AGL5E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7099149C58;
	Tue,  7 May 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123452; cv=none; b=focGyyBsZvbwQ6QwsWcvIlGdzDDpOEnXjZygsnEkNt2pQIUw3rD0fPru7HhXPm0omzc10NVCP/MUbh8Y6jxLobOFxRKjf18C2i+3pj82Pa8F2KYMOa7xwBciwJM1/LJPbHv8ZWbVQO8k5K7BTrxXvJKb2RoH0omjZNpoLaREh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123452; c=relaxed/simple;
	bh=wSkfnaPITX5qLw6RyeCyK9vxuYtr6G5t5yRD+6IUEHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slizaqIOidqpZkU9Ybx7mzpF3jLIGBhoELnHsUVIMimHzgeA9LEewnJ+6LGQSpIAmTuH0nUDs5z//pcf3QnEND5sR09bwxmV6ZQ6S18BXd9ldh0SWb6m2XkIPif21CIitAna9t6ywyvHmhbHMEdmnAy3vks1/98SDiuk6YKCZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz4AGL5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521C1C3277B;
	Tue,  7 May 2024 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123452;
	bh=wSkfnaPITX5qLw6RyeCyK9vxuYtr6G5t5yRD+6IUEHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fz4AGL5EetzpJLEqhhVWC+aVgWuqL2SQmoQR1iAxR8RfwzGyR1TCSInlbAP19fTAE
	 YzHr9GLwwYWMOqIepDaFGmsqid4ApgevsBlVyCDzPxssIyPn/u6yb5e3xMK18gni1U
	 USHrSCtdpvqb5CB6X5PKa9IrtdFiWBqK6eAjKnFyCchpE0Vpk1UPjTkTTO2KjpZNIU
	 BQe1xpY2ImKf8gbU80hO3AWQEvTEd561TUatc9zHh2MffExD9XyPgaMf8lIaiLC1IE
	 dLWhrnZrCICcXaiVHOToGJn+RNcBuDnTdgw/UfDWqhVZmGjgmmoDpi0svQGqYVIGFx
	 qxMHqHa30UquA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andersson@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/43] regulator: qcom-refgen: fix module autoloading
Date: Tue,  7 May 2024 19:09:31 -0400
Message-ID: <20240507231033.393285-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit ddd3f34c10002e41ed3cd89c9bd8f1d05a22506a ]

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://msgid.link/r/20240410172615.255424-1-krzk@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/qcom-refgen-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/qcom-refgen-regulator.c b/drivers/regulator/qcom-refgen-regulator.c
index 656fe330d38f0..063e12c08e75f 100644
--- a/drivers/regulator/qcom-refgen-regulator.c
+++ b/drivers/regulator/qcom-refgen-regulator.c
@@ -140,6 +140,7 @@ static const struct of_device_id qcom_refgen_match_table[] = {
 	{ .compatible = "qcom,sm8250-refgen-regulator", .data = &sm8250_refgen_desc },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, qcom_refgen_match_table);
 
 static struct platform_driver qcom_refgen_driver = {
 	.probe = qcom_refgen_probe,
-- 
2.43.0


