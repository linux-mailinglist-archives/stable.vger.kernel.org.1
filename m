Return-Path: <stable+bounces-80825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705EF990B7F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CD1280D33
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE41DF960;
	Fri,  4 Oct 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEEKLgM6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DAA1E284F;
	Fri,  4 Oct 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065994; cv=none; b=YSTs+rwJf1EFPMNjPi0JoXU5DLsqNpCIwOs/A0xFHGrN9w9np9yyxv0iNQbeei65b5Gi0LaVK/ol/s6ntUwDt4WAyIwkS7qN4xh0Q/At7weL/FlucNHB/A3oZBnHCSO4yzyKTXrjPzCv8QFH0oRa1nx4Wwuelo7fQdzpaM/bH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065994; c=relaxed/simple;
	bh=gtzWo99z98MAVsqzZyZyVJlwrxTdbh/NNL5OBmjzUPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bejZxkuGfdsoav7hfyUkdC1y/OReLHV3VLPOm0Bv/3CrxydHKhoWTo1jIJTSERm1avXArQqNIY13/t+MQlUHqfE4D7Wm4/kqqpFYMuMuRfT3PYoxqALYn1cLA/GegBmTtkGtbUs/CmpQvX3i9rOhIZ4l0j8CYbdAZBV6pUY6MCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEEKLgM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B07C4CECD;
	Fri,  4 Oct 2024 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065994;
	bh=gtzWo99z98MAVsqzZyZyVJlwrxTdbh/NNL5OBmjzUPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEEKLgM6wMW9/fJZpaqVGkdmSULb5AA6KrQsvyoLW09ZUxMNMCaNwz8dU/hiQOlel
	 yKHyh8IkuGl1rE+D7zHlUMO9j3ZKQv5k3YhgVgJ01cYNlwQ+DE05LEf5xC8t/1wvhD
	 RQSg95BMSjEB377aGkX/Q/8i83PJNKr5sxfwK2qWwIJNzSIniHHP5zCAQZYjr2Epim
	 vCUcyquLyNX34hAogJ3eZx+Y9JJSl3WNBZqH5bh0c6BQGprLufb9hgwO3s7V10x+5c
	 b3cdlQ+iJfhvwfZhfNksFDy1km/rWJEA4Sz5lVo+2tdpidYKq3RL2XZvh+ureBK7zD
	 1aYcSf2IYSG8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	andersson@kernel.org,
	shawnguo@kernel.org,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 45/76] remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table
Date: Fri,  4 Oct 2024 14:17:02 -0400
Message-ID: <20241004181828.3669209-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit e954a1bd16102abc800629f9900715d8ec4c3130 ]

If there is a resource table device tree node, use the address as
the resource table address, otherwise use the address(where
.resource_table section loaded) inside the Cortex-M elf file.

And there is an update in NXP SDK that Resource Domain Control(RDC)
enabled to protect TCM, linux not able to write the TCM space when
updating resource table status and cause kernel dump. So use the address
from device tree could avoid kernel dump.

Note: NXP M4 SDK not check resource table update, so it does not matter
use whether resource table address specified in elf file or in device
tree. But to reflect the fact that if people specific resource table
address in device tree, it means people are aware and going to use it,
not the address specified in elf file.

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20240719-imx_rproc-v2-2-10d0268c7eb1@nxp.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/imx_rproc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 144c8e9a642e8..f1424da9cb5a7 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -666,6 +666,17 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 	return (struct resource_table *)priv->rsc_table;
 }
 
+static struct resource_table *
+imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+
+	if (priv->rsc_table)
+		return (struct resource_table *)priv->rsc_table;
+
+	return rproc_elf_find_loaded_rsc_table(rproc, fw);
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
@@ -676,7 +687,7 @@ static const struct rproc_ops imx_rproc_ops = {
 	.da_to_va       = imx_rproc_da_to_va,
 	.load		= rproc_elf_load_segments,
 	.parse_fw	= imx_rproc_parse_fw,
-	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
+	.find_loaded_rsc_table = imx_rproc_elf_find_loaded_rsc_table,
 	.get_loaded_rsc_table = imx_rproc_get_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
-- 
2.43.0


