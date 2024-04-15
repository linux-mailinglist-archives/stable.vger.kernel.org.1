Return-Path: <stable+bounces-39498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D7E8A51DC
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BAA284CC9
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE1E763E2;
	Mon, 15 Apr 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQn2Flny"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36C745CB
	for <Stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188300; cv=none; b=K9ssa9uA8fb3BCUCSY+RbTYYPQbVuR66MU2CkJCQuQpjRyykr0P1awJoXL+fAGTzuIgnWc4R4Z3VFQy2ijp/TAY1j7tgMOoe44LFAhpE32nQ9Gh8d4idvK8CDfKKXrAEnaq95pAScEQTqSkf3FrQb6jspuiAwjCowmdGR8WX9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188300; c=relaxed/simple;
	bh=7JrfUTYcqm9Xvf7blg07cY+fegnlG3iFRCl46b6ywwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+XSIVlh86fEbp8zV28aMmR7zPi/Mb3EgdByU2PH5j2us/yC5YUrw/SzaKc+CVOoXHf6ZR5dXD28AecHBVCPgbxtZXRLgEuV1MSJrSXZsh5U9PR94hX4jWZ5lJEHVlZnibq1ktqsCIgVzaIbGZHLrb8PAXJKji8mZL95bG6Bldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQn2Flny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C543C2BD10;
	Mon, 15 Apr 2024 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188300;
	bh=7JrfUTYcqm9Xvf7blg07cY+fegnlG3iFRCl46b6ywwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQn2FlnyVobp2YWFeavJMgMC3q4w37D/Dq/URRuT75Rm1jBLubtLwl9PwwZFbkAiu
	 AkMCEbrP8JGJZ7lqsUc4AK5qYiNou5kh95bsyBCElAuX/MCeDYJzejysgz5x+bxkGY
	 CMAUcUigav13s9aCqnZDAe7rxIVffufJegOzj6sPbDXNNBsE6B680WTXnHLoFD3lSn
	 Jh74eRtzQcem8VaKwvveE1QdffSe2bN5gVAaKm3r+hmmtpLE/91AWiiA59jOuz2jeH
	 48GKvzydunz9wKrP6hcZXaaD9y5b3wpwLd4Fj2RGpYPgaDsxmdOykhoFsrorwJxeap
	 mJRuc+Pis6oeg==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: William Breathitt Gray <william.gray@linaro.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 008/190] iio: addac: stx104: Fix race condition for stx104_write_raw()
Date: Mon, 15 Apr 2024 06:48:58 -0400
Message-ID: <20240415105208.3137874-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Breathitt Gray <william.gray@linaro.org>

[ Upstream commit 9740827468cea80c42db29e7171a50e99acf7328 ]

The priv->chan_out_states array and actual DAC value can become
mismatched if stx104_write_raw() is called concurrently. Prevent such a
race condition by utilizing a mutex.

Fixes: 97a445dad37a ("iio: Add IIO support for the DAC on the Apex Embedded Systems STX104")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/r/c95c9a77fcef36b2a052282146950f23bbc1ebdc.1680790580.git.william.gray@linaro.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stx104.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 2da741d27540f..edc3b29eed621 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 
 #define STX104_OUT_CHAN(chan) {				\
@@ -54,10 +55,12 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
 /**
  * struct stx104_iio - IIO device private data structure
+ * @lock: synchronization lock to prevent I/O race conditions
  * @chan_out_states:	channels' output states
  * @base:		base port address of the IIO device
  */
 struct stx104_iio {
+	struct mutex lock;
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
 	unsigned int base;
 };
@@ -160,9 +163,12 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 			if ((unsigned int)val > 65535)
 				return -EINVAL;
 
+			mutex_lock(&priv->lock);
+
 			priv->chan_out_states[chan->channel] = val;
 			outw(val, priv->base + 4 + 2 * chan->channel);
 
+			mutex_unlock(&priv->lock);
 			return 0;
 		}
 		return -EINVAL;
@@ -323,6 +329,8 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	priv = iio_priv(indio_dev);
 	priv->base = base[id];
 
+	mutex_init(&priv->lock);
+
 	/* configure device for software trigger operation */
 	outb(0, base[id] + 9);
 
-- 
2.43.0


