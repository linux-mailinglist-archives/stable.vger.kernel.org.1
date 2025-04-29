Return-Path: <stable+bounces-137095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7A2AA0D62
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7DC1892D9C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3303621ABC2;
	Tue, 29 Apr 2025 13:23:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A03207;
	Tue, 29 Apr 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745933005; cv=none; b=khDffkrSbT5eDScExh5v9IxV4uYSCxR8S0gKvPiVegWORkkfm+5Z+EqmJvLxMY62yEDvt6oNLg7/xqU0imRvmTJ/1mRux+yxL2R482TvLOu7tA42KmxyC1VpbknxRv84/8xnLQ8z7s3aJJadm0h8qRh3fOEmOWcxTYizvGA7XPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745933005; c=relaxed/simple;
	bh=0Df1tr9ESOUvh7LuwEp6gMMcbsbQJSkC5Q+o6OEkQQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4F1ZqwBLhZQ1aacEEaoFL8f8N35XdPi2Ek32Gu7Xr9ymiDcOWcM5hENMBIDAFpqeIUxbx4vfVO7lQFi2my9Kl19983Q1/rWW036gstXqQVywaZdWgoQb4Gx/tBfa+7PGsnEaUlGps24FEFH3Yx9C8n4bTOeuCJL6iAF3XtAnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowACHwwu60hBoFAOvDQ--.44558S2;
	Tue, 29 Apr 2025 21:23:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	YiPeng.Chai@amd.com,
	tao.zhou1@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: Remove redundant return value checks for amdgpu_ras_error_data_init
Date: Tue, 29 Apr 2025 13:22:39 +0800
Message-ID: <20250429052240.963-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHwwu60hBoFAOvDQ--.44558S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw17Xw4UJF1fuw18KFykKrg_yoWxJFyUpF
	WrJw1DZryUZFnrJrykAFyUuasIyw1SvFy8KF40ya4I93W5CrW5XF1rtw40q3ZrKr4DCwsI
	vrWDW3yUWF1qvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_JFv_Gryl8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsHA2gQm1yCWwABsv

The function amdgpu_ras_error_data_init() always returns 0, making its
return value checks redundant. This patch changes its return type to
void and removes all unnecessary checks in the callers.

This simplifies the code and avoids confusion about the function's
behavior. Additionally, this change keeps the usage consistent within
amdgpu_ras_do_page_retirement(), which also does not check the return
value.

Fixes: 5b1270beb380 ("drm/amdgpu: add ras_err_info to identify RAS error source")
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Add a missing semicolon

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 +++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  8 ++------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c  |  3 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c  |  3 +--
 5 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4c9fa24dd972..5be391ebeca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -182,9 +182,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 		return 0;
 	}
 
-	ret = amdgpu_ras_error_data_init(&err_data);
-	if (ret)
-		return ret;
+	amdgpu_ras_error_data_init(&err_data);
 
 	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
 	err_data.err_addr = &err_rec;
@@ -687,8 +685,7 @@ static struct ras_manager *amdgpu_ras_create_obj(struct amdgpu_device *adev,
 	if (alive_obj(obj))
 		return NULL;
 
-	if (amdgpu_ras_error_data_init(&obj->err_data))
-		return NULL;
+	amdgpu_ras_error_data_init(&obj->err_data);
 
 	obj->head = *head;
 	obj->adev = adev;
@@ -1428,9 +1425,7 @@ static int amdgpu_ras_query_error_status_with_event(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
-	ret = amdgpu_ras_error_data_init(&err_data);
-	if (ret)
-		return ret;
+	amdgpu_ras_error_data_init(&err_data);
 
 	if (!amdgpu_ras_get_error_query_mode(adev, &error_query_mode))
 		return -EINVAL;
@@ -2255,9 +2250,7 @@ static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
 	if (!data->cb)
 		return;
 
-	ret = amdgpu_ras_error_data_init(&err_data);
-	if (ret)
-		return;
+	amdgpu_ras_error_data_init(&err_data);
 
 	/* Let IP handle its data, maybe we need get the output
 	 * from the callback to update the error type/count, etc
@@ -4623,13 +4616,11 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-int amdgpu_ras_error_data_init(struct ras_err_data *err_data)
+void amdgpu_ras_error_data_init(struct ras_err_data *err_data)
 {
 	memset(err_data, 0, sizeof(*err_data));
 
 	INIT_LIST_HEAD(&err_data->err_node_list);
-
-	return 0;
 }
 
 static void amdgpu_ras_error_node_release(struct ras_err_node *err_node)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6db772ecfee4..5f88e70fbf5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -931,7 +931,7 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
 					   uint32_t reg_list_size,
 					   uint32_t instance);
 
-int amdgpu_ras_error_data_init(struct ras_err_data *err_data);
+void amdgpu_ras_error_data_init(struct ras_err_data *err_data);
 void amdgpu_ras_error_data_fini(struct ras_err_data *err_data);
 int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 					struct amdgpu_smuio_mcm_config_info *mcm_info,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 896f3609b0ee..5de6e332c2cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -52,9 +52,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 	struct ras_err_data err_data;
 	int ret;
 
-	ret = amdgpu_ras_error_data_init(&err_data);
-	if (ret)
-		return ret;
+	amdgpu_ras_error_data_init(&err_data);
 
 	err_data.err_addr =
 		kcalloc(adev->umc.max_ras_err_cnt_per_query,
@@ -230,9 +228,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			};
 			struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
 
-			ret = amdgpu_ras_error_data_init(&err_data);
-			if (ret)
-				return ret;
+			amdgpu_ras_error_data_init(&err_data);
 
 			ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index a26a9be58eac..d4bdfe280c88 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -364,8 +364,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 	struct ras_err_data err_data;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	if (amdgpu_ras_error_data_init(&err_data))
-		return;
+	amdgpu_ras_error_data_init(&err_data);
 
 	if (adev->asic_type == CHIP_ALDEBARAN)
 		bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL_ALDE);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 8a0a63ac88d2..c79ed1adf681 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -537,8 +537,7 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 	struct ras_err_data err_data;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	if (amdgpu_ras_error_data_init(&err_data))
-		return;
+	amdgpu_ras_error_data_init(&err_data);
 
 	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
 
-- 
2.42.0.windows.2


