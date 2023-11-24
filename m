Return-Path: <stable+bounces-818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B5B7F7CB3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FED8B20F20
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBB39FFD;
	Fri, 24 Nov 2023 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oW4N9u5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083B381D4;
	Fri, 24 Nov 2023 18:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108D5C433C7;
	Fri, 24 Nov 2023 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849853;
	bh=31eOCKgYjoy4O+6ENI1GPGALaApNcy6bHPQbrLoPHIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oW4N9u5ug0IQ7a+FcLtvbceb20tvLqcSHfs2HaSR9dr7brT1n3XW4PmIxXoJXFhLn
	 fl1IOrsVq6eO6O0Ei0F+AQO+eiZv4JVT0nwyxdnCo+5oegJe1zoUzRuO4fsgu6ILdU
	 vhmDKLUJF1G4a/0oy/rJCDACnHZ2oi5RcwNNlWKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.6 346/530] mfd: qcom-spmi-pmic: Fix reference leaks in revid helper
Date: Fri, 24 Nov 2023 17:48:32 +0000
Message-ID: <20231124172038.553190967@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit a0fa44c261e448c531f9adb3a5189a3520f3e316 upstream.

The Qualcomm SPMI PMIC revid implementation is broken in multiple ways.

First, it totally ignores struct device_node reference counting and
leaks references to the parent bus node as well as each child it
iterates over using an open-coded for_each_child_of_node().

Second, it leaks references to each spmi device on the bus that it
iterates over by failing to drop the reference taken by the
spmi_device_from_of() helper.

Fix the struct device_node leaks by reimplementing the lookup using
for_each_child_of_node() and adding the missing reference count
decrements. Fix the sibling struct device leaks by dropping the
unnecessary lookups of devices with the wrong USID.

Note that this still leaves one struct device reference leak in case a
base device is found but it is not the parent of the device used for the
lookup. This will be addressed in a follow-on patch.

Fixes: e9c11c6e3a0e ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
Cc: stable@vger.kernel.org	# 6.0
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
Link: https://lore.kernel.org/r/20231003152927.15000-2-johan+linaro@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/qcom-spmi-pmic.c |   32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -81,7 +81,7 @@ static struct spmi_device *qcom_pmic_get
 	struct spmi_device *sdev;
 	struct qcom_spmi_dev *ctx;
 	struct device_node *spmi_bus;
-	struct device_node *other_usid = NULL;
+	struct device_node *child;
 	int function_parent_usid, ret;
 	u32 pmic_addr;
 
@@ -105,28 +105,34 @@ static struct spmi_device *qcom_pmic_get
 	 * device for USID 2.
 	 */
 	spmi_bus = of_get_parent(sdev->dev.of_node);
-	do {
-		other_usid = of_get_next_child(spmi_bus, other_usid);
-
-		ret = of_property_read_u32_index(other_usid, "reg", 0, &pmic_addr);
-		if (ret)
-			return ERR_PTR(ret);
+	sdev = ERR_PTR(-ENODATA);
+	for_each_child_of_node(spmi_bus, child) {
+		ret = of_property_read_u32_index(child, "reg", 0, &pmic_addr);
+		if (ret) {
+			of_node_put(child);
+			sdev = ERR_PTR(ret);
+			break;
+		}
 
-		sdev = spmi_device_from_of(other_usid);
 		if (pmic_addr == function_parent_usid - (ctx->num_usids - 1)) {
-			if (!sdev)
+			sdev = spmi_device_from_of(child);
+			if (!sdev) {
 				/*
 				 * If the base USID for this PMIC hasn't probed yet
 				 * but the secondary USID has, then we need to defer
 				 * the function driver so that it will attempt to
 				 * probe again when the base USID is ready.
 				 */
-				return ERR_PTR(-EPROBE_DEFER);
-			return sdev;
+				sdev = ERR_PTR(-EPROBE_DEFER);
+			}
+			of_node_put(child);
+			break;
 		}
-	} while (other_usid->sibling);
+	}
+
+	of_node_put(spmi_bus);
 
-	return ERR_PTR(-ENODATA);
+	return sdev;
 }
 
 static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,



