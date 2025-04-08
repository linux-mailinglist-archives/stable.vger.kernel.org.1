Return-Path: <stable+bounces-131362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDCA80969
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA03188B14A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DD26A1A3;
	Tue,  8 Apr 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J9HfWYNe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344F2690D6;
	Tue,  8 Apr 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116193; cv=none; b=RqRmG3l1fhq9FA0/YZFOzFI1+ac3RkCBSTvHSnBiTg2iJV5R7V5hlrdQqMFcEOyqdg5uyiXRcJ+SmC1zT+9rnFDfG3bAS0RFrii1wKuzGHcu9xfw9VL2yFIL/8Q1BIzisJof5cV9aZVCP2FmI7y5XOkzGPRMaJ77VPnpXBI/yCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116193; c=relaxed/simple;
	bh=1Zw0xDSA4Mgo1pt7/3Rgym+SrRSxCLIg8qsHxUJpZ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nY6yjghYrhonpsuf7oJEILDOTBpv+MrmnaGywUrjHjOyXinncclOQtdZViY+FqHgkUPc91g2SGuJXaCCd3W/Z6vdXBgQOzO1VoFNhTYvGwzs06Kj3a2juNfHL0zI4eW7KwEnXI+fmCUlwdj+GVWvHD7hdIj6aUpM7monyX70wGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J9HfWYNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5183C4CEE5;
	Tue,  8 Apr 2025 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116193;
	bh=1Zw0xDSA4Mgo1pt7/3Rgym+SrRSxCLIg8qsHxUJpZ7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9HfWYNer81Iuz4GCRRoQEUb6kofMaqitoCooZ86y0c1SDMDxgtKJsfzY7Ybl1hFh
	 /jBlux+4TT7BMk36Z03bXkIs5InURZlScX1WO22S3LXwERDzD5J1eALkm2vcr17EZk
	 Vgowa6b26NDIN465ZmYHivB2LPA++/sfCbtd61xg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Chang <kevin1.chang@intel.com>,
	Thomas Chen <Thomas.Chen@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 009/423] EDAC/{skx_common,i10nm}: Fix some missing error reports on Emerald Rapids
Date: Tue,  8 Apr 2025 12:45:35 +0200
Message-ID: <20250408104845.931765785@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 51556c72a9674..fbdf005bed3a4 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -751,6 +751,8 @@ static int i10nm_get_ddr_munits(void)
 				continue;
 			} else {
 				d->imc[lmc].mdev = mdev;
+				if (res_cfg->type == SPR)
+					skx_set_mc_mapping(d, i, lmc);
 				lmc++;
 			}
 		}
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 6cf17af7d9112..85ec3196664d3 100644
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
index 54bba8a62f727..849198fd14da6 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -93,6 +93,16 @@ struct skx_dev {
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
@@ -242,6 +252,7 @@ void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 void skx_set_mem_cfg(bool mem_cfg_2lm);
 void skx_set_res_cfg(struct res_config *cfg);
+void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
-- 
2.39.5




