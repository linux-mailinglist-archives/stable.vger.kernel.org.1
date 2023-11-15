Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB607ECF29
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjKOTqp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjKOTqo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2691A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101D9C433C7;
        Wed, 15 Nov 2023 19:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077600;
        bh=zk7BEK/bxnMpVnK6QpemsaLRWVzwxTuV37ac+sBKrrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4q1Ii6y6J5Orr6yt5ROkrPvwFlbPulz6TAQbDlo8JiV/xM6GZHHJsuA8eb4BRUYG
         eqSHZFNJyTpfIGTBKvj8TrSoQGsTGaZm9ZZLXMgr09jTapoguKKqyVA+PnDrf55r3i
         SsaEllcIPj1BwrtJz5/Zec4VPibSDfBQtCxARmPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 402/603] crypto: qat - refactor fw config related functions
Date:   Wed, 15 Nov 2023 14:15:47 -0500
Message-ID: <20231115191640.854361162@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 2990d2edac6061c6f0f646a46e40957244be2268 ]

The logic that selects the correct adf_fw_config structure based on the
configured service is replicated twice in the uof_get_name() and
uof_get_ae_mask() functions. Refactor the code so that there is no
replication.

This does not introduce any functional change.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: a238487f7965 ("crypto: qat - fix ring to service map for QAT GEN4")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     | 69 ++++++++-----------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 12b5d18191119..10839269c4d32 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -394,40 +394,42 @@ static u32 uof_get_num_objs(void)
 	return ARRAY_SIZE(adf_fw_cy_config);
 }
 
-static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num,
-				const char * const fw_objs[], int num_objs)
+static const struct adf_fw_config *get_fw_config(struct adf_accel_dev *accel_dev)
 {
-	int id;
-
 	switch (get_service_enabled(accel_dev)) {
 	case SVC_CY:
 	case SVC_CY2:
-		id = adf_fw_cy_config[obj_num].obj;
-		break;
+		return adf_fw_cy_config;
 	case SVC_DC:
-		id = adf_fw_dc_config[obj_num].obj;
-		break;
+		return adf_fw_dc_config;
 	case SVC_DCC:
-		id = adf_fw_dcc_config[obj_num].obj;
-		break;
+		return adf_fw_dcc_config;
 	case SVC_SYM:
-		id = adf_fw_sym_config[obj_num].obj;
-		break;
+		return adf_fw_sym_config;
 	case SVC_ASYM:
-		id =  adf_fw_asym_config[obj_num].obj;
-		break;
+		return adf_fw_asym_config;
 	case SVC_ASYM_DC:
 	case SVC_DC_ASYM:
-		id = adf_fw_asym_dc_config[obj_num].obj;
-		break;
+		return adf_fw_asym_dc_config;
 	case SVC_SYM_DC:
 	case SVC_DC_SYM:
-		id = adf_fw_sym_dc_config[obj_num].obj;
-		break;
+		return adf_fw_sym_dc_config;
 	default:
-		id = -EINVAL;
-		break;
+		return NULL;
 	}
+}
+
+static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num,
+				const char * const fw_objs[], int num_objs)
+{
+	const struct adf_fw_config *fw_config;
+	int id;
+
+	fw_config = get_fw_config(accel_dev);
+	if (fw_config)
+		id = fw_config[obj_num].obj;
+	else
+		id = -EINVAL;
 
 	if (id < 0 || id > num_objs)
 		return NULL;
@@ -451,28 +453,13 @@ static const char *uof_get_name_402xx(struct adf_accel_dev *accel_dev, u32 obj_n
 
 static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
 {
-	switch (get_service_enabled(accel_dev)) {
-	case SVC_CY:
-		return adf_fw_cy_config[obj_num].ae_mask;
-	case SVC_DC:
-		return adf_fw_dc_config[obj_num].ae_mask;
-	case SVC_DCC:
-		return adf_fw_dcc_config[obj_num].ae_mask;
-	case SVC_CY2:
-		return adf_fw_cy_config[obj_num].ae_mask;
-	case SVC_SYM:
-		return adf_fw_sym_config[obj_num].ae_mask;
-	case SVC_ASYM:
-		return adf_fw_asym_config[obj_num].ae_mask;
-	case SVC_ASYM_DC:
-	case SVC_DC_ASYM:
-		return adf_fw_asym_dc_config[obj_num].ae_mask;
-	case SVC_SYM_DC:
-	case SVC_DC_SYM:
-		return adf_fw_sym_dc_config[obj_num].ae_mask;
-	default:
+	const struct adf_fw_config *fw_config;
+
+	fw_config = get_fw_config(accel_dev);
+	if (!fw_config)
 		return 0;
-	}
+
+	return fw_config[obj_num].ae_mask;
 }
 
 void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
-- 
2.42.0



