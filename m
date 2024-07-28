Return-Path: <stable+bounces-62270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B822B93E7D4
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6483F282412
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F44144D31;
	Sun, 28 Jul 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qivTPyKn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304FF144D27;
	Sun, 28 Jul 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182838; cv=none; b=l6Xyg5e16ss0V0Dqsf9jtgg/iW0eT4LL9nE6bZBqGYJb6vM+9xAS0tudQ3poNS5K17EtDxmD9e6DISybl5YazeXdCuWh22CwflZHgo9tzoOj4XUEHucODsmxzgU98VbMdJeFhsqKpWWl7HsfUHT5lIYnzrS9Zweo0XiAwDYh0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182838; c=relaxed/simple;
	bh=NBqCHv+4nvwQnzjbu+xsjgerV9joXx3WtcrYp4kePOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuUksNfo1TkJSusGfYJmY9Kdc76c6MUb1ZZx8dea5M5IuFEb5D8x988li+Mk0OXHjt4MbP9xV81UGrl0AWqBUMs8NwT0gOsQb/C8ykLqXt8XWIZyyXwpBeOQna68uYNNt3+spj8HQ/GAuS7goxAYrds9Z4uIrHv9uFbUbDhzymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qivTPyKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D66C32782;
	Sun, 28 Jul 2024 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182838;
	bh=NBqCHv+4nvwQnzjbu+xsjgerV9joXx3WtcrYp4kePOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qivTPyKnVlDT7+PjmW5NZ7nvU5WDFD3Q442FuFThNyW24ajZ46ZpcTmW0Cnrhsf04
	 VaeB2xFqLtNl8u5uRIKR0VxcR2pYd1rMSxsBrUx1d2HpclhNyJUXHskP7kDiwKBHfe
	 /rA1lRCon9bwOpGvqCdZV4bli+QTuEE1FLtJ1wKOD8oK6/+duoBtezS2MxD9Q5UvNM
	 v9dtepcCpdGNMDROxakgKRFIQhGU1uCe+NwSsb5hOQ2a9NIQm0fp8ii6SVxJ3w8aNr
	 XCS07JDJLQCOWtaezUlsOUHC1Xb/MW8s8WoE9pN5+in+2NhZpAhDPtxaf3fWGeqJsJ
	 yhWsnjw3xhTpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Quadros <rogerq@kernel.org>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	pawell@cadence.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/17] usb: cdns3-ti: Add workaround for Errata i2409
Date: Sun, 28 Jul 2024 12:06:40 -0400
Message-ID: <20240728160709.2052627-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Roger Quadros <rogerq@kernel.org>

[ Upstream commit b50a2da03bd95784541b3f9058e452cc38f9ba05 ]

TI USB2 PHY is known to have a lockup issue on very short
suspend intervals. Enable the Suspend Residency quirk flag to
workaround this as described in Errata i2409 [1].

[1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240516044537.16801-3-r-gunasekaran@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/cdns3-ti.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 5945c4b1e11f6..cfabc12ee0e3c 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include "core.h"
 
 /* USB Wrapper register offsets */
 #define USBSS_PID		0x0
@@ -85,6 +86,18 @@ static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 value)
 	writel(value, data->usbss + offset);
 }
 
+static struct cdns3_platform_data cdns_ti_pdata = {
+	.quirks = CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE,   /* Errata i2409 */
+};
+
+static const struct of_dev_auxdata cdns_ti_auxdata[] = {
+	{
+		.compatible = "cdns,usb3",
+		.platform_data = &cdns_ti_pdata,
+	},
+	{},
+};
+
 static int cdns_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -176,7 +189,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	reg |= USBSS_W1_PWRUP_RST;
 	cdns_ti_writel(data, USBSS_W1, reg);
 
-	error = of_platform_populate(node, NULL, NULL, dev);
+	error = of_platform_populate(node, NULL, cdns_ti_auxdata, dev);
 	if (error) {
 		dev_err(dev, "failed to create children: %d\n", error);
 		goto err;
-- 
2.43.0


