Return-Path: <stable+bounces-589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC627F7BB7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027981C21006
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC5B39FEA;
	Fri, 24 Nov 2023 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIKrtazW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486C39FDD;
	Fri, 24 Nov 2023 18:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C1BC433C7;
	Fri, 24 Nov 2023 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849276;
	bh=jfKrK4I0J/nVArKkqot8N4nuDJvjcFg3VffwFEZY3iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIKrtazWIotuZ3AkacOdfGZwnYqZwDGxcF/15sb21LDcvfXo9/U6m0nOodYob9FLl
	 m/9jGvt8TDtCrGgJ5nUoRTxIqE7zZDCrNPjHEGE1xZN3hmfB/FIi9QnkKBMZgxk7rN
	 QnSH1TrbJCnTI0CMU2HgksmrdhYQY/xpArlFfb8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 118/530] iio: adc: stm32-adc: harden against NULL pointer deref in stm32_adc_probe()
Date: Fri, 24 Nov 2023 17:44:44 +0000
Message-ID: <20231124172031.707682326@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 3a23b384e7e3d64d5587ad10729a34d4f761517e ]

of_match_device() may fail and returns a NULL pointer.

In practice there is no known reasonable way to trigger this, but
in case one is added in future, harden the code by adding the check

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Link: https://lore.kernel.org/r/tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stm32-adc-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 2f082006550fd..bbd5bdd732f01 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -708,6 +708,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	struct stm32_adc_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+
 	struct resource *res;
 	u32 max_rate;
 	int ret;
@@ -720,8 +722,11 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, &priv->common);
 
-	priv->cfg = (const struct stm32_adc_priv_cfg *)
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	of_id = of_match_device(dev->driver->of_match_table, dev);
+	if (!of_id)
+		return -ENODEV;
+
+	priv->cfg = (const struct stm32_adc_priv_cfg *)of_id->data;
 	priv->nb_adc_max = priv->cfg->num_adcs;
 	spin_lock_init(&priv->common.lock);
 
-- 
2.42.0




