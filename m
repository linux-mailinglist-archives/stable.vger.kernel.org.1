Return-Path: <stable+bounces-188182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46608BF25BD
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E580034BD52
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809881F875A;
	Mon, 20 Oct 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC4zdm/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B51A00CE
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977097; cv=none; b=fCF/zMVIXzyAbFg9Hh6xx9HKs8lWAOlzFrupwnpcOhZ3QSGqaZDAn4hawZitVbOU3FMy4keelsGPBuaGO43ppgpcinCV/FczOgDJnvizPe5YlBY9qOVw0N+VVUqIi04NQC3fUQleeV8rnhJvWuCqwVBZhUJaF2GTMM481QRZoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977097; c=relaxed/simple;
	bh=TJNnbl96hMHCZ3DBbkqtOsXSE07wJoEwNreMZCwSJEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOcEfIx1x73gAyc/4AKbPenciUkzZ0umoWQt/D6csV5h8gMaym9ZXc9sywGxWenfrHYeOAYhrWf8yDhpZTUOOc8JWr7PyOoUAt51fYj9wD27Qzz9h5lE5p/97WA4OSlRPzwnllpCwa0GgBaR74DaeItKIHknl+hqoGey1G8mKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC4zdm/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B219C4CEF9;
	Mon, 20 Oct 2025 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977095;
	bh=TJNnbl96hMHCZ3DBbkqtOsXSE07wJoEwNreMZCwSJEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aC4zdm/r97i8sI7KafxlpQjE5mEWHsXTbl46pobkH6IKkWxQKcrrDx901mSlaxqBi
	 cYZGT1FXR6DrHXgQ/yySEMP7yQQJ4u5MFoTFMerjlmdOR6cT2juXZRLzo8nlNrB5gv
	 4VQoDYyoXQ8sW4T7yeTRavGFde+rnVMrPJEtP5uMQUV2jRbOvsvdJ7PDJCDHc0sSoK
	 mCSiond8MZMrQAPpb+ehovNH1BBXk3m+Gxkv1JGmtPdqbJBpgBOfyu7EM04eC8kGcY
	 0fFHhZajmXUR2o2uPnPAmVGBXIUBVaP1E5XJkIBPI6XgFOfggIZKz0kgkm+BOlfDlV
	 MS/wPQm+7e6Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again
Date: Mon, 20 Oct 2025 12:18:13 -0400
Message-ID: <20251020161813.1835424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101626-library-underfoot-da02@gregkh>
References: <2025101626-library-underfoot-da02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit 32be3ca4cf78b309dfe7ba52fe2d7cc3c23c5634 ]

Don't deinitialize and reinitialize the HAL helpers. The dma memory is
deallocated and there is high possibility that we'll not be able to get
the same memory allocated from dma when there is high memory pressure.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://patch.msgid.link/20250722053121.1145001-1-usama.anjum@collabora.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  6 +-----
 drivers/net/wireless/ath/ath11k/hal.c  | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/hal.h  |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 6282ccad79d5e..67c78ad2243b9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -710,14 +710,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
-	ath11k_hal_srng_deinit(ab);
+	ath11k_hal_srng_clear(ab);
 
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
 
-	ret = ath11k_hal_srng_init(ab);
-	if (ret)
-		return ret;
-
 	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	ret = ath11k_core_qmi_firmware_ready(ab);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index d5921805af636..029827e14a15a 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1317,6 +1317,22 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
+void ath11k_hal_srng_clear(struct ath11k_base *ab)
+{
+	/* No need to memset rdp and wrp memory since each individual
+	 * segment would get cleared in ath11k_hal_srng_src_hw_init()
+	 * and ath11k_hal_srng_dst_hw_init().
+	 */
+	memset(ab->hal.srng_list, 0,
+	       sizeof(ab->hal.srng_list));
+	memset(ab->hal.shadow_reg_addr, 0,
+	       sizeof(ab->hal.shadow_reg_addr));
+	ab->hal.avail_blk_resource = 0;
+	ab->hal.current_blk_index = 0;
+	ab->hal.num_shadow_reg_configured = 0;
+}
+EXPORT_SYMBOL(ath11k_hal_srng_clear);
+
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
 {
 	struct hal_srng *srng;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 5fbfded8d546c..00ab4f46e429a 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -940,6 +940,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 			  struct hal_srng_params *params);
 int ath11k_hal_srng_init(struct ath11k_base *ath11k);
 void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
+void ath11k_hal_srng_clear(struct ath11k_base *ab);
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
 void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
 				       u32 **cfg, u32 *len);
-- 
2.51.0


