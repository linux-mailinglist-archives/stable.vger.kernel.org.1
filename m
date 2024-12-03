Return-Path: <stable+bounces-97339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9659E243D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C50166A79
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6061FECCC;
	Tue,  3 Dec 2024 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K615TZw6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE81F7558;
	Tue,  3 Dec 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240201; cv=none; b=lf+WyO+daWgQubgwXtbxzy/hctZvlQ09zYDx0Ae5uqoAXquYiaoW8pbwxShuIuYCcS6yJ3H6cawUyhc//DaCY9FKoxh/+YA8yWSOiTzy12Dd/+bzQ396TmaB0BLc60c+4EBrypTpv2Vm0EYpPl/FuZnCAAP4Xfgq4RHcT9ILb/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240201; c=relaxed/simple;
	bh=CagYEJ8Dbp2KMDr3CY9PUaxb1p7VvzwvhgciGf4nErE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtTnmyZ66/NM0J+t8ZZkjNsOBlVrZqfYAirZr7mrumwV/3Gq53Ltjdzb9Wy0C1mygrTJ/KxnxE6SCDnUZwNCn4JHZ9SE9JAcCNsHahB/lqvwGF3fVKkAmvj40xQRVz0JTRabH4aWNOeygvL514f1fZ2P1K+PjMaRwbCNyFHlgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K615TZw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F674C4CECF;
	Tue,  3 Dec 2024 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240200;
	bh=CagYEJ8Dbp2KMDr3CY9PUaxb1p7VvzwvhgciGf4nErE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K615TZw6lt5jQCJT/gK9s8/ryeambx9Db5rkk29b91Lz+Ih+ZP6b/SSSsbO3jFWT2
	 B6FIMM5MFLNOxyxxXf2GdQ+ohDZ0fqhGb4Nu+F5rhGfAxee8VVJpyeFtnY24oxKmQ5
	 0XSJzUNgmisDZ3xPd0mOZjZXyMHAHY8n4mBWFyY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 057/826] EDAC/{skx_common,i10nm}: Fix incorrect far-memory error source indicator
Date: Tue,  3 Dec 2024 15:36:24 +0100
Message-ID: <20241203144745.697453274@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit a36667037a0c0e36c59407f8ae636295390239a5 ]

The Granite Rapids CPUs with Flat2LM memory configurations may
mistakenly report near-memory errors as far-memory errors, resulting
in the invalid decoded ADXL results:

  EDAC skx: Bad imc -1

Fix this incorrect far-memory error source indicator by prefetching the
decoded far-memory controller ID, and adjust the error source indicator
to near-memory if the far-memory controller ID is invalid.

Fixes: ba987eaaabf9 ("EDAC/i10nm: Add Intel Granite Rapids server support")
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
Link: https://lore.kernel.org/r/20241015072236.24543-3-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/i10nm_base.c |  1 +
 drivers/edac/skx_common.c | 23 +++++++++++++++++++++++
 drivers/edac/skx_common.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index e2a954de913b4..51556c72a9674 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -1036,6 +1036,7 @@ static int __init i10nm_init(void)
 		return -ENODEV;
 
 	cfg = (struct res_config *)id->driver_data;
+	skx_set_res_cfg(cfg);
 	res_cfg = cfg;
 
 	rc = skx_get_hi_lo(0x09a2, off, &tolm, &tohm);
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 52b4628998700..6cf17af7d9112 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -47,6 +47,7 @@ static skx_show_retry_log_f skx_show_retry_rd_err_log;
 static u64 skx_tolm, skx_tohm;
 static LIST_HEAD(dev_edac_list);
 static bool skx_mem_cfg_2lm;
+static struct res_config *skx_res_cfg;
 
 int skx_adxl_get(void)
 {
@@ -135,6 +136,22 @@ static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 		return false;
 	}
 
+	/*
+	 * GNR with a Flat2LM memory configuration may mistakenly classify
+	 * a near-memory error(DDR5) as a far-memory error(CXL), resulting
+	 * in the incorrect selection of decoded ADXL components.
+	 * To address this, prefetch the decoded far-memory controller ID
+	 * and adjust the error source to near-memory if the far-memory
+	 * controller ID is invalid.
+	 */
+	if (skx_res_cfg && skx_res_cfg->type == GNR && err_src == ERR_SRC_2LM_FM) {
+		res->imc = (int)adxl_values[component_indices[INDEX_MEMCTRL]];
+		if (res->imc == -1) {
+			err_src = ERR_SRC_2LM_NM;
+			edac_dbg(0, "Adjust the error source to near-memory.\n");
+		}
+	}
+
 	res->socket  = (int)adxl_values[component_indices[INDEX_SOCKET]];
 	if (err_src == ERR_SRC_2LM_NM) {
 		res->imc     = (adxl_nm_bitmap & BIT_NM_MEMCTRL) ?
@@ -191,6 +208,12 @@ void skx_set_mem_cfg(bool mem_cfg_2lm)
 }
 EXPORT_SYMBOL_GPL(skx_set_mem_cfg);
 
+void skx_set_res_cfg(struct res_config *cfg)
+{
+	skx_res_cfg = cfg;
+}
+EXPORT_SYMBOL_GPL(skx_set_res_cfg);
+
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 {
 	driver_decode = decode;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index cd47f81868319..54bba8a62f727 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -241,6 +241,7 @@ int skx_adxl_get(void);
 void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 void skx_set_mem_cfg(bool mem_cfg_2lm);
+void skx_set_res_cfg(struct res_config *cfg);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
-- 
2.43.0




