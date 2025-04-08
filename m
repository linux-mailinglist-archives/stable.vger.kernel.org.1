Return-Path: <stable+bounces-130197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72265A8033A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328A97AC929
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8117269819;
	Tue,  8 Apr 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VttvZoUA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8A269CF6;
	Tue,  8 Apr 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113076; cv=none; b=ix/q/QsR2mOX/c/u63R2iuLQCvzOfwczG5RQr5zWA9OMATKxk8WmvMJtaxYNgPpX9OXG+MtfjnxCxztglaAw9BGQKtfrAjwfVo/LOjl6oi4wKFTZuu6u+XPfHRtsrI5zay6h15x6k8kCCeY7is1X9muvYV2h19jBzq27OgxB0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113076; c=relaxed/simple;
	bh=b6w2g2WMR0WaC4lAnuFSqL3mqW/s3mRG/lQhfDGvT3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pogEugtx9JFieVu8+r2cMbXkVC3GH3QYL55heWKpWqZ7AeTyVED5omk8kuBFA5Pi1il65rFAb3AXyC4Y0Glp6ajvVehxmtNdp/A0rzWqeZ/RRjR1tF7NVMALn6UbwzrGJRF94qonlU2Rl59uw75K34hYlIt0lEZrD3F9pjiCSsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VttvZoUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04FFC4AF09;
	Tue,  8 Apr 2025 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113076;
	bh=b6w2g2WMR0WaC4lAnuFSqL3mqW/s3mRG/lQhfDGvT3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VttvZoUAyqpWT0CTQO3EdEisHQp2U0V3LwFc1Glhf68KguVUK8hhgX65tzrd/IEl8
	 fr35+A9V5C8JitO/RTJLW6ExiO/AYHLLvJYL81YXmuGlNKmYmDWtOt8bokaWDbHH6P
	 HLWJEqYvzS78VTINqlE0qJubkrp+HPKPspgiOdZk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Chang <kevin1.chang@intel.com>,
	Thomas Chen <Thomas.Chen@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/268] EDAC/{skx_common,i10nm}: Fix some missing error reports on Emerald Rapids
Date: Tue,  8 Apr 2025 12:46:57 +0200
Message-ID: <20250408104828.677364193@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit d9207cf7760f5f5599e9ff7eb0fedf56821a1d59 ]

When doing error injection to some memory DIMMs on certain Intel Emerald
Rapids servers, the i10nm_edac missed error reports for some memory DIMMs.

Certain BIOS configurations may hide some memory controllers, and the
i10nm_edac doesn't enumerate these hidden memory controllers. However, the
ADXL decodes memory errors using memory controller physical indices even
if there are hidden memory controllers. Therefore, the memory controller
physical indices reported by the ADXL may mismatch the logical indices
enumerated by the i10nm_edac, resulting in missed error reports for some
memory DIMMs.

Fix this issue by creating a mapping table from memory controller physical
indices (used by the ADXL) to logical indices (used by the i10nm_edac) and
using it to convert the physical indices to the logical indices during the
error handling process.

Fixes: c545f5e41225 ("EDAC/i10nm: Skip the absent memory controllers")
Reported-by: Kevin Chang <kevin1.chang@intel.com>
Tested-by: Kevin Chang <kevin1.chang@intel.com>
Reported-by: Thomas Chen <Thomas.Chen@intel.com>
Tested-by: Thomas Chen <Thomas.Chen@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20250214002728.6287-1-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/i10nm_base.c |  2 ++
 drivers/edac/skx_common.c | 33 +++++++++++++++++++++++++++++++++
 drivers/edac/skx_common.h | 11 +++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 535f058b48eef..67a46abe07da9 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -755,6 +755,8 @@ static int i10nm_get_ddr_munits(void)
 				continue;
 			} else {
 				d->imc[lmc].mdev = mdev;
+				if (res_cfg->type == SPR)
+					skx_set_mc_mapping(d, i, lmc);
 				lmc++;
 			}
 		}
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 0b8aaf5f77d9f..d47f0055217e4 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -120,6 +120,35 @@ void skx_adxl_put(void)
 }
 EXPORT_SYMBOL_GPL(skx_adxl_put);
 
+static void skx_init_mc_mapping(struct skx_dev *d)
+{
+	/*
+	 * By default, the BIOS presents all memory controllers within each
+	 * socket to the EDAC driver. The physical indices are the same as
+	 * the logical indices of the memory controllers enumerated by the
+	 * EDAC driver.
+	 */
+	for (int i = 0; i < NUM_IMC; i++)
+		d->mc_mapping[i] = i;
+}
+
+void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc)
+{
+	edac_dbg(0, "Set the mapping of mc phy idx to logical idx: %02d -> %02d\n",
+		 pmc, lmc);
+
+	d->mc_mapping[pmc] = lmc;
+}
+EXPORT_SYMBOL_GPL(skx_set_mc_mapping);
+
+static u8 skx_get_mc_mapping(struct skx_dev *d, u8 pmc)
+{
+	edac_dbg(0, "Get the mapping of mc phy idx to logical idx: %02d -> %02d\n",
+		 pmc, d->mc_mapping[pmc]);
+
+	return d->mc_mapping[pmc];
+}
+
 static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 {
 	struct skx_dev *d;
@@ -187,6 +216,8 @@ static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 		return false;
 	}
 
+	res->imc = skx_get_mc_mapping(d, res->imc);
+
 	for (i = 0; i < adxl_component_count; i++) {
 		if (adxl_values[i] == ~0x0ull)
 			continue;
@@ -307,6 +338,8 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 			 d->bus[0], d->bus[1], d->bus[2], d->bus[3]);
 		list_add_tail(&d->list, &dev_edac_list);
 		prev = pdev;
+
+		skx_init_mc_mapping(d);
 	}
 
 	if (list)
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index e7f18ada16681..5acfef8fd3d36 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -94,6 +94,16 @@ struct skx_dev {
 	struct pci_dev *uracu; /* for i10nm CPU */
 	struct pci_dev *pcu_cr3; /* for HBM memory detection */
 	u32 mcroute;
+	/*
+	 * Some server BIOS may hide certain memory controllers, and the
+	 * EDAC driver skips those hidden memory controllers. However, the
+	 * ADXL still decodes memory error address using physical memory
+	 * controller indices. The mapping table is used to convert the
+	 * physical indices (reported by ADXL) to the logical indices
+	 * (used the EDAC driver) of present memory controllers during the
+	 * error handling process.
+	 */
+	u8 mc_mapping[NUM_IMC];
 	struct skx_imc {
 		struct mem_ctl_info *mci;
 		struct pci_dev *mdev; /* for i10nm CPU */
@@ -243,6 +253,7 @@ void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 void skx_set_mem_cfg(bool mem_cfg_2lm);
 void skx_set_res_cfg(struct res_config *cfg);
+void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
-- 
2.39.5




