Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E62752661
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGMPOe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjGMPOd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 11:14:33 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C9E2121
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 08:14:28 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DDfH8Q027429;
        Thu, 13 Jul 2023 17:14:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=9F6WErzaW9yZms4oqilaaA1OMFfEi8u05w2TDpODLdQ=;
 b=2AJVlNEKKPy3mP/hGBRlddz953O1ZcLZ2n4v8nL62BE8j8ygx8mwbMWSCa4SgdqAy+Qc
 Ld6GydwjsmFlZDhoULenaRRbfJBsePGi0IaoP2f3RA2a06hbuBLvImHC3xHemWM/1uCG
 /YzUeutFQCLAk1uivsjem0ssWLUV+Z0kZyJV2+BVHAgc9PaEgwVQvUUUx3c+iNSlbCEr
 iGpe02nC1iMjlKyAORoZTyKrElqgFGuS0OFWTzXXNWnb/MCy6M0HHn3WUyAqhMA4lMXR
 jM4UjjYMp715YqFAeuJWVVCo9xTzUXVXQbQVayiJZgM2Zm3136rd2MRQgZbqWKySQ5yv rQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rtjce0kyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 17:14:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6530E100056;
        Thu, 13 Jul 2023 17:14:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4DCA922A6C6;
        Thu, 13 Jul 2023 17:14:25 +0200 (CEST)
Received: from localhost (10.201.22.9) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 13 Jul
 2023 17:14:27 +0200
From:   Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
To:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
CC:     <stable@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 6/7] crypto: stm32 - fix MDMAT condition
Date:   Thu, 13 Jul 2023 17:13:06 +0200
Message-ID: <20230713151307.1513470-7-thomas.bourgoin@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713151307.1513470-1-thomas.bourgoin@foss.st.com>
References: <20230713151307.1513470-1-thomas.bourgoin@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.9]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

If IP has MDMAT support, set or reset the bit MDMAT in Control Register.

Fixes: b56403a25af7 ("crypto: stm32/hash - Support Ux500 hash")
Cc: stable@vger.kernel.org
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

---
Changes in v2:
 - add Cc: stable@vger.kernel.org in commit message
 - add Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

 drivers/crypto/stm32/stm32-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 701995a72e57..a48e6a14da2e 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -544,7 +544,7 @@ static int stm32_hash_xmit_dma(struct stm32_hash_dev *hdev,
 
 	reg = stm32_hash_read(hdev, HASH_CR);
 
-	if (!hdev->pdata->has_mdmat) {
+	if (hdev->pdata->has_mdmat) {
 		if (mdma)
 			reg |= HASH_CR_MDMAT;
 		else
-- 
2.25.1

