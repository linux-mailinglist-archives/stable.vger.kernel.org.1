Return-Path: <stable+bounces-81011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E91990DCF
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D2D288430
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EDE213ED2;
	Fri,  4 Oct 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRfdi57b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75821213EC8;
	Fri,  4 Oct 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066487; cv=none; b=oWn6yLXftMHUfBbX2zcvWuD2ivRSM6lPtSpc6peTbfnJ1H0h1D+kWRkEWtwBNBRBXr47h0huOPASVAeOs0giAG0exLepoUlE0U7KsFNwyyZWje/epASXre+yUeW8grWkC3GZw0Qh+7EHPPOwLMte0rlV4zPmzeG+T2bwhUYRIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066487; c=relaxed/simple;
	bh=JOh76tM1p/updAL5Reemuyb2zpjgUR4jmSjGWvyo70c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uADxCFkCxU8nPIiCqMuF4VtWuvphSipr/3TMTZg5mSkbYQ6zUu0ymRkNET5cX12NBVnojSdmGJn9TG3/aVi1laicaajht1vJf+J8OQDX29j6d9lJ7Y4+G9rKNtx2Svg7vTC76lkm03n0iBczPNPTjwBdO5x6gbEZUDoZ3WwKoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRfdi57b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1663CC4CEC6;
	Fri,  4 Oct 2024 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066487;
	bh=JOh76tM1p/updAL5Reemuyb2zpjgUR4jmSjGWvyo70c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRfdi57bwry5MHo3sMFwRV3oEnAVd9reDVs4/9fY6SyC2LrUu3nhRR0+vY2zyDLKp
	 RFlHJt5JLyE7uP9R66zif41qujpFGYVAPLMoa7ip5sY7UvSpoWOaTCw/lTiV8uVIS+
	 o1totaOy32WrIla0wJbOg6pOZ32XhWMOP6PWTsLBhVQ2xpUuDK7iQTqx3f5xFcU+Ht
	 E3XpsiFsxg5EVEtSXZjjj5/jj6+73EPbV94IFQcPtTfRaax128y/6e1Ygp6IDLriUG
	 XMf4xtbP3c6E8hy0WmjEfCYT5DavSgSKLEmq0a4I0koJEY4pIBuEOkkg46CjpmROuv
	 a39GS6MU1oGJw==
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
Subject: [PATCH AUTOSEL 6.1 27/42] remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table
Date: Fri,  4 Oct 2024 14:26:38 -0400
Message-ID: <20241004182718.3673735-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index bc26fe5416627..0154846c42667 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -537,6 +537,17 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
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
@@ -546,7 +557,7 @@ static const struct rproc_ops imx_rproc_ops = {
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


