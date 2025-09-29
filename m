Return-Path: <stable+bounces-181990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F134BAA64F
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 20:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D878516D9AB
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F023E229;
	Mon, 29 Sep 2025 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bogl2pJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754978F39
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172280; cv=none; b=HsmKq0Ax5hJ1u/BP1b3TKNw51/IkRGKynHlhm8GdMyrztj989BxqzD3kp59kLVTBX0s2S0eyQTtGFOakRehaLrnH3YUt9mDSET90XWntLMGzVCRRLs5WyAJSc/k/kdInlGrbbtHR8kDiSP0e9zgNLMHkZFX8EEiisEOXuSxg5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172280; c=relaxed/simple;
	bh=KeT1Kwytb2IZzId/xN5IThBmZ1d5VkERxtfJSl8fJNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duHPUSxcjX7GEYnYCeICXfDsj3GD5QiYdRvJuHnbeYbBsxJSE1VJzLtYIdyL6cy9oZd1FlE2tDs8h/52v5txZowynu+/g9lZTvlKBLH8ZSK8F+vhc40bvg6h/u7XMDAiEIhjnGrxsuyxvFh+gsdiqsAb5BAoUO4PBMQCV9MKIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bogl2pJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB5CC4CEF4;
	Mon, 29 Sep 2025 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759172280;
	bh=KeT1Kwytb2IZzId/xN5IThBmZ1d5VkERxtfJSl8fJNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bogl2pJzjns6p+MPiLS5iAqW0AFycdYyEerBMrMPNNmsdIXm+7rlAIxGCKhQcKLjF
	 Cygsn7zuG5wimoXWA1ZyUj9DNEWhNrJctwZtA+BFZcpH1ksM07m5nIiVYKDt6CrNSC
	 kL3JdmFzZmbgOI+Ltz/VQxiYGArWJY197gJtojK7rZA7whYfCfzyp62yV8hkc0zFAL
	 h+meaF5RvJJ+SAjkzKt5aEOxMT7tzcPkqXnt4fHy6uLsgzHBSpiqHJ4cu+KIU4mcte
	 qaVnLBTKq3hzn4t0Gk4sQsgWA7gmD+7+rp8ABsIktZXpTX5bR9K02fDVGq7/q02kz/
	 lC5C3BmEo5zFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gpiolib: Extend software-node support to support secondary software-nodes
Date: Mon, 29 Sep 2025 14:57:56 -0400
Message-ID: <20250929185756.284707-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092939-unsafe-alfalfa-105c@gregkh>
References: <2025092939-unsafe-alfalfa-105c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit c6ccc4dde17676dfe617b9a37bd9ba19a8fc87ee ]

When a software-node gets added to a device which already has another
fwnode as primary node it will become the secondary fwnode for that
device.

Currently if a software-node with GPIO properties ends up as the secondary
fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.

Add a new gpiod_fwnode_lookup() helper which falls back to calling
gpiod_find_by_fwnode() with the secondary fwnode if the GPIO was not
found in the primary fwnode.

Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hansg@kernel.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20250920200955.20403-1-hansg@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index efb592b6f6aa7..9b8a200423858 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4022,6 +4022,23 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	return desc;
 }
 
+static struct gpio_desc *gpiod_fwnode_lookup(struct fwnode_handle *fwnode,
+					     struct device *consumer,
+					     const char *con_id,
+					     unsigned int idx,
+					     enum gpiod_flags *flags,
+					     unsigned long *lookupflags)
+{
+	struct gpio_desc *desc;
+
+	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
+	if (gpiod_not_found(desc) && !IS_ERR_OR_NULL(fwnode))
+		desc = gpiod_find_by_fwnode(fwnode->secondary, consumer, con_id,
+					    idx, flags, lookupflags);
+
+	return desc;
+}
+
 struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 					 struct fwnode_handle *fwnode,
 					 const char *con_id,
@@ -4034,7 +4051,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	struct gpio_desc *desc;
 	int ret;
 
-	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &flags, &lookupflags);
+	desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx, &flags, &lookupflags);
 	if (gpiod_not_found(desc) && platform_lookup_allowed) {
 		/*
 		 * Either we are not using DT or ACPI, or their lookup did not
-- 
2.51.0


