Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2D79B6F1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358305AbjIKWId (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbjIKN76 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:59:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB692CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:59:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E444C433C8;
        Mon, 11 Sep 2023 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440794;
        bh=Fg+25EGZqYpSXrJgqw/HEsHF+2/tq+froswtqKJTc6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVsU950IyAtj2dFyy22r+hGoBbssZXYFhvfCAOSrYwCm4mhMndiZvy8AXt/SSoY/w
         7kY+b2mCxvwjR/+sxoU+j+i93Kj7vNxhBsUy8GhxL8cjlm1+b72Zs/YJQ2xVP2HdqY
         OMvwSu9eXjbNz99gOJREqM2h3SCMbn/KqMnP2eXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Guerin <adam.guerin@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 187/739] crypto: qat - fix crypto capability detection for 4xxx
Date:   Mon, 11 Sep 2023 15:39:46 +0200
Message-ID: <20230911134656.414787337@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Guerin <adam.guerin@intel.com>

[ Upstream commit fab9516f02b418e37d3cde6c21c316085262aece ]

When extending the capability detection logic for 4xxx devices the
SMx algorithms were accidentally missed.
Enable these SMx capabilities by default for QAT GEN4 devices.

Check for device variants where the SMx algorithms are explicitly
disabled by the GEN4 hardware. This is indicated in fusectl1
register.
Mask out SM3 and SM4 based on a bit specific to those algorithms.
Mask out SM2 if the PKE slice is not present.

Fixes: 4b44d28c715d ("crypto: qat - extend crypto capability detection for 4xxx")
Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c | 9 +++++++++
 drivers/crypto/intel/qat/qat_common/icp_qat_hw.h     | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index e543a9e24a06f..3eda91aa7c112 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -223,6 +223,8 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 			  ICP_ACCEL_CAPABILITIES_HKDF |
 			  ICP_ACCEL_CAPABILITIES_CHACHA_POLY |
 			  ICP_ACCEL_CAPABILITIES_AESGCM_SPC |
+			  ICP_ACCEL_CAPABILITIES_SM3 |
+			  ICP_ACCEL_CAPABILITIES_SM4 |
 			  ICP_ACCEL_CAPABILITIES_AES_V2;
 
 	/* A set bit in fusectl1 means the feature is OFF in this SKU */
@@ -246,12 +248,19 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
 	}
 
+	if (fusectl1 & ICP_ACCEL_4XXX_MASK_SMX_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SM3;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SM4;
+	}
+
 	capabilities_asym = ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC |
 			  ICP_ACCEL_CAPABILITIES_CIPHER |
+			  ICP_ACCEL_CAPABILITIES_SM2 |
 			  ICP_ACCEL_CAPABILITIES_ECEDMONT;
 
 	if (fusectl1 & ICP_ACCEL_4XXX_MASK_PKE_SLICE) {
 		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC;
+		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_SM2;
 		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_ECEDMONT;
 	}
 
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h b/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
index a65059e56248a..0c8883e2ccc6d 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
@@ -97,7 +97,10 @@ enum icp_qat_capabilities_mask {
 	ICP_ACCEL_CAPABILITIES_SHA3_EXT = BIT(15),
 	ICP_ACCEL_CAPABILITIES_AESGCM_SPC = BIT(16),
 	ICP_ACCEL_CAPABILITIES_CHACHA_POLY = BIT(17),
-	/* Bits 18-21 are currently reserved */
+	ICP_ACCEL_CAPABILITIES_SM2 = BIT(18),
+	ICP_ACCEL_CAPABILITIES_SM3 = BIT(19),
+	ICP_ACCEL_CAPABILITIES_SM4 = BIT(20),
+	/* Bit 21 is currently reserved */
 	ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY = BIT(22),
 	ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64 = BIT(23),
 	ICP_ACCEL_CAPABILITIES_LZ4_COMPRESSION = BIT(24),
-- 
2.40.1



