Return-Path: <stable+bounces-102414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE69EF243
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C56C16C1C1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD9523589C;
	Thu, 12 Dec 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dqPvtxII"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AC2253E6;
	Thu, 12 Dec 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021146; cv=none; b=oa+2OnjsPKUtjzc99nrkYgaPsukrdzQ2gVp69lAQEfpKkaVQTpPxlT4rxxwZOUZ3yuOedVbAgl96XE0yyMcGX8jy2o/DO8/8MOpgJbQe8hhxLOfqxe0otLP/9wDeDzfXDu5wFRv0vYo+sqtH6g6rfockRv084JOfaLZPSnUZ7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021146; c=relaxed/simple;
	bh=T5LFqRsQoEBdhBp/fUmUYQ2S8zGVrcYWI2Q7LLEMiE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h50bUL9qDIgqPq1nd7TmwSU+2PG2aypEiZmyPYlUdsbQRHsaLPEbm3oOmZ2efAOmJ3jPAieIXkpeak2wqCn3kNs4zi3tZ5njiwrZG9WdKcZfJFiknqsQibU+VqzCqaIMRa6OQv+ctAbOAL2fs8u1ztBTie2RwqTYhmQ+QwlHkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dqPvtxII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5857C4CECE;
	Thu, 12 Dec 2024 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021146;
	bh=T5LFqRsQoEBdhBp/fUmUYQ2S8zGVrcYWI2Q7LLEMiE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqPvtxIIH/eAg+TbR5JInDkhuqAgxeX6hDPeUHuyYguab8Sd+Awn7dM9Y5BSMseFZ
	 6cNPoRyewanBSG5nF1MYC9+VMaZCmmGPiNoiZlfvkJc8ugf9LAO4xakgumDt7Woz8h
	 OnSTdJQo5A1qis9fbFECT1LRCbIlAxi5WsgF3OtI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Chen <liaochen4@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 658/772] drm/bridge: it6505: Enable module autoloading
Date: Thu, 12 Dec 2024 16:00:03 +0100
Message-ID: <20241212144417.108349363@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 1e2ab24cd708b1c864ff983ee1504c0a409d2f8e ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240902113320.903147-2-liaochen4@huawei.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index fbccf7835f700..5a23277be4445 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3349,6 +3349,7 @@ static const struct of_device_id it6505_of_match[] = {
 	{ .compatible = "ite,it6505" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, it6505_of_match);
 
 static struct i2c_driver it6505_i2c_driver = {
 	.driver = {
-- 
2.43.0




