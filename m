Return-Path: <stable+bounces-153467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04659ADD4E7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FBC4081B8
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EAD2ED14F;
	Tue, 17 Jun 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mlkj2Ji9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB22ED142;
	Tue, 17 Jun 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176059; cv=none; b=HPizeRhb5yLLEaV5kWMu4zQzpq+0JSR8yCKMhmZYUr7AckMlKZXSLjmiKZPFL608VQIyU2oIWYSUS34hQ+mSLsW14SpI7bYHFo6e1syxnGHFfw3E9WhgU1Zood4JjUbM8oS2aZkunqFHZVYcpIGNfW356LgL7I1NjudiIflUpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176059; c=relaxed/simple;
	bh=wi2/H+o4xD9jHm3Gt3tfklv6rJynmHUwYSE2ghx68no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgATtg6S/R2aT3kdsN1BhWnjmA6N4a62SyVKYIGcgYDazBlT/X/C9JbtCIPZY0vzCC/rYYTF2e/nn0jwAc7hIiIpJ2g5wNMqKgfa9jjcUMQwr+2asRSRpX96CU3LySir2RUOAvp+6TjOK9AjTNZTIP9Y/6d6u4TbH40O/VRorI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mlkj2Ji9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4127C4CEF3;
	Tue, 17 Jun 2025 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176059;
	bh=wi2/H+o4xD9jHm3Gt3tfklv6rJynmHUwYSE2ghx68no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlkj2Ji93DnZkqJBkgOzsE7jZMtcqsc0E4nD7UN1ASflTs3JXcl/gqvQ+6Da9CSxw
	 ZhAbqkM2mB7+BjKD3QKxQUcSa7As0dIAsPtblIrlHSkMCl/UQIHG9UFXWS6SWagSIj
	 acLZMhQe3d+cTaaabgZ9lP7T46RiaKqkGhSWgOj8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	William Breathitt Gray <wbg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 239/356] counter: interrupt-cnt: Protect enable/disable OPs with mutex
Date: Tue, 17 Jun 2025 17:25:54 +0200
Message-ID: <20250617152347.832062985@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[ Upstream commit 7351312632e831e51383f48957d47712fae791ef ]

Enable/disable seems to be racy on SMP, consider the following scenario:

CPU0					CPU1

interrupt_cnt_enable_write(true)
{
	if (priv->enabled == enable)
		return 0;

	if (enable) {
		priv->enabled = true;
					interrupt_cnt_enable_write(false)
					{
						if (priv->enabled == enable)
							return 0;

						if (enable) {
							priv->enabled = true;
							enable_irq(priv->irq);
						} else {
							disable_irq(priv->irq)
							priv->enabled = false;
						}
		enable_irq(priv->irq);
	} else {
		disable_irq(priv->irq);
		priv->enabled = false;
	}

The above would result in priv->enabled == false, but IRQ left enabled.
Protect both write (above race) and read (to propagate the value on SMP)
callbacks with a mutex.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20250331163642.2382651-1-alexander.sverdlin@siemens.com
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/counter/interrupt-cnt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 229473855c5b3..bc762ba87a19b 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -3,12 +3,14 @@
  * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
  */
 
+#include <linux/cleanup.h>
 #include <linux/counter.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -19,6 +21,7 @@ struct interrupt_cnt_priv {
 	struct gpio_desc *gpio;
 	int irq;
 	bool enabled;
+	struct mutex lock;
 	struct counter_signal signals;
 	struct counter_synapse synapses;
 	struct counter_count cnts;
@@ -41,6 +44,8 @@ static int interrupt_cnt_enable_read(struct counter_device *counter,
 {
 	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
+	guard(mutex)(&priv->lock);
+
 	*enable = priv->enabled;
 
 	return 0;
@@ -51,6 +56,8 @@ static int interrupt_cnt_enable_write(struct counter_device *counter,
 {
 	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
+	guard(mutex)(&priv->lock);
+
 	if (priv->enabled == enable)
 		return 0;
 
@@ -227,6 +234,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	mutex_init(&priv->lock);
+
 	ret = devm_counter_add(dev, counter);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add counter\n");
-- 
2.39.5




