Return-Path: <stable+bounces-81049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E784990E43
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4EB1F2466E
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295F21A70B;
	Fri,  4 Oct 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgFcMXEt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4D2204D1;
	Fri,  4 Oct 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066574; cv=none; b=h05wKDtwrYgmKY46Xpz6Vay+qWPRRdNv4SdkBFn2tZ1eiLbfIDUyCx7kRBCM03C9kgfS+BH3bCG0/1oR8V7S547gAZ3cBt7gQi+Ed6/lDKVVdBdXw2ztQcY1ZtMgmLVJd0x/hubWIxnL0NFzH0JAlKSwZ6YkpMnA7viDWVVk6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066574; c=relaxed/simple;
	bh=Dblni4K5wNZD0UVUM/ESMLDn32H7O/DhASbYm1NOOgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3hvApPXJrnrtPWy8ALYNBZtBjTD/jqNRESjDbx/MnttgXQUnAmOBHwsYPzFH/dtqqyiISPesrFq83IYZm3CcuYF61PQZNbIEeWrjnTHulkoGCIWn9a0mkry+vB8uCwk9vc7Q6XCI9u2Or/aNZZJ2jExlcEM7+jrv4ogFCNdyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgFcMXEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1337EC4CECC;
	Fri,  4 Oct 2024 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066574;
	bh=Dblni4K5wNZD0UVUM/ESMLDn32H7O/DhASbYm1NOOgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgFcMXEtGOUiJFGGL0ZM9WXrtzZNdZ+Qc00ZdqkFRDNgIFrw6vrPlRNE5oDT4DFIx
	 ma9RKwf4OUfoH1NFjDMn8cZTVw4OnoZqyD5NbdZ0Kv0tMgYKnfc5aG7iJ9kc99xhkb
	 CUldvnToYkh4cnE3IzVCQ0UM6W/SGj3rgB9M3ufWfAr2/rW7Ymlr0mYnJHAlZ55Lta
	 GFpB9ODDvc7pDsaht2HW2rVnGK3+q5k7EsoZGN8NFwYl6Qh+lLrWDekf2XUXXJHmjM
	 hkMsHn81w6s5fVyEJxnFhEH8fhskO2OVXICJamafPx+2DzGO1SvFyRzURgn/Y4mmO0
	 I5FiXIb7A7r6w==
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
Subject: [PATCH AUTOSEL 5.15 22/31] remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table
Date: Fri,  4 Oct 2024 14:28:30 -0400
Message-ID: <20241004182854.3674661-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index d5ce97e75f027..ae8b64ac12fd9 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -529,6 +529,17 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
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
@@ -538,7 +549,7 @@ static const struct rproc_ops imx_rproc_ops = {
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


