Return-Path: <stable+bounces-192875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B2C44ADA
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDAC3B0254
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A251C8FBA;
	Mon, 10 Nov 2025 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljNGT4VT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E22AD1F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735676; cv=none; b=bLPHjTkajiM/P8ObHahLWvKnhb0h2N4QRGAdeYrwwgjtNZUz1SosbDM7kgOCi1wlhGtNZaLFXRKfUdVuogATnM5z6tYkdWib7Ri8WDtD0ko3FXp6yNJmGTMyA8bBb0rgZ3Uian4BWwesCSmqx+qYlnkL/ciwF8UumLxMSOJ7VvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735676; c=relaxed/simple;
	bh=ZGGS9vYdHrRNEuVKDJsGHI9w8mymU0UgeDHrJ41pvzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnvY4RnEToCEet0fCTjMesxqrMKdj+pgcqfi1zTaSTVsua9Qsy4k1fyGgycizra+bpcNPrCIPHJaa3YwTZ9L+ZNe0WBDCP2TcSh0WV+qssarEch1C/0KiQgbAH8Xg4yJCPDqQgP7UnWfOVf3caWnwadoQzvsup4tP1Fx4e5Hv3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljNGT4VT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57943C4CEF8;
	Mon, 10 Nov 2025 00:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762735676;
	bh=ZGGS9vYdHrRNEuVKDJsGHI9w8mymU0UgeDHrJ41pvzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljNGT4VTjiwsqeSq58CckPpZFquX8kx/fMEGm8Z/aBT9BOSmMZhel5NAVOQGK+IE8
	 frpn+mOUmCXPB3L9OTLVGT/7rg+isoSnYyxuElsKrsP7aHlMkd02Iptioin/adI/zs
	 mi+rNsHFeJkExPtIeQWyF3ECw9toAyi0Aj80j5Ay1LE+kz55UxW9xMBXTrrMJY9eiw
	 Md3B30vwU19rqIosi+uhrr5P/SMw3bIoEcTttH63EJIaj+LzAETkJC3RKjczxe2k6s
	 lz/SH2fd6B3NP3cpzSYyB39W1EyfUtwYOJ9CcB73CQnkclzgwiZanXih/SfIwn+clj
	 ouoP+fd/ztN/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/8] scsi: ufs: core: Add fill_crypto_prdt variant op
Date: Sun,  9 Nov 2025 19:47:46 -0500
Message-ID: <20251110004750.555028-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110004750.555028-1-sashal@kernel.org>
References: <2025110940-control-hence-f9a8@gregkh>
 <20251110004750.555028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 8ecea3da1567e0648b5d37a6faec73fc9c8571ba ]

Add a variant op to allow host drivers to initialize nonstandard
crypto-related fields in the PRDT.  This is needed to support inline
encryption on the "Exynos" UFS controller.

Note that this will be used together with the support for overriding the
PRDT entry size that was already added by commit ada1e653a5ea ("scsi: ufs:
core: Allow UFS host drivers to override the sg entry size").

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20240708235330.103590-5-ebiggers@kernel.org
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d968e99488c4 ("scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd-crypto.h | 19 +++++++++++++++++++
 drivers/ufs/core/ufshcd.c        |  2 +-
 include/ufs/ufshcd.h             |  4 ++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd-crypto.h b/drivers/ufs/core/ufshcd-crypto.h
index be8596f20ba2f..3eb8df42e1942 100644
--- a/drivers/ufs/core/ufshcd-crypto.h
+++ b/drivers/ufs/core/ufshcd-crypto.h
@@ -37,6 +37,19 @@ ufshcd_prepare_req_desc_hdr_crypto(struct ufshcd_lrb *lrbp,
 	h->dunu = cpu_to_le32(upper_32_bits(lrbp->data_unit_num));
 }
 
+static inline int ufshcd_crypto_fill_prdt(struct ufs_hba *hba,
+					  struct ufshcd_lrb *lrbp)
+{
+	struct scsi_cmnd *cmd = lrbp->cmd;
+	const struct bio_crypt_ctx *crypt_ctx = scsi_cmd_to_rq(cmd)->crypt_ctx;
+
+	if (crypt_ctx && hba->vops && hba->vops->fill_crypto_prdt)
+		return hba->vops->fill_crypto_prdt(hba, crypt_ctx,
+						   lrbp->ucd_prdt_ptr,
+						   scsi_sg_count(cmd));
+	return 0;
+}
+
 bool ufshcd_crypto_enable(struct ufs_hba *hba);
 
 int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba);
@@ -54,6 +67,12 @@ static inline void
 ufshcd_prepare_req_desc_hdr_crypto(struct ufshcd_lrb *lrbp,
 				   struct request_desc_header *h) { }
 
+static inline int ufshcd_crypto_fill_prdt(struct ufs_hba *hba,
+					  struct ufshcd_lrb *lrbp)
+{
+	return 0;
+}
+
 static inline bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
 	return false;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7dcdaac31546b..8b7033cd6cdbb 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2586,7 +2586,7 @@ static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 
 	ufshcd_sgl_to_prdt(hba, lrbp, sg_segments, scsi_sglist(cmd));
 
-	return 0;
+	return ufshcd_crypto_fill_prdt(hba, lrbp);
 }
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 3a3183dc899c3..9ba8162c00a5e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -323,6 +323,7 @@ struct ufs_pwr_mode_info {
  * @device_reset: called to issue a reset pulse on the UFS device
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
+ * @fill_crypto_prdt: initialize crypto-related fields in the PRDT
  * @event_notify: called to notify important events
  * @mcq_config_resource: called to configure MCQ platform resources
  * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
@@ -366,6 +367,9 @@ struct ufs_hba_variant_ops {
 				struct devfreq_simple_ondemand_data *data);
 	int	(*program_key)(struct ufs_hba *hba,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
+	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
+				    const struct bio_crypt_ctx *crypt_ctx,
+				    void *prdt, unsigned int num_segments);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
 	int	(*mcq_config_resource)(struct ufs_hba *hba);
-- 
2.51.0


