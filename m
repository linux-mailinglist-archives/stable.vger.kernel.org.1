Return-Path: <stable+bounces-168550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6FB2354A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDA07AC376
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7342FD1A4;
	Tue, 12 Aug 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEhbF+Cg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593902CA9;
	Tue, 12 Aug 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024547; cv=none; b=G43PzH+yqjY+8UnPchfanU2uEAKR/XWAybgKndXJSzQ0XBcZjSKMqv6nWYH5X08OExTiRb4smHnZfJDPHV15DREajBKAlmzkKCL/gcyDfF4FyTJ9sgndT9Wk1VBVmXyZRfFQeFbYcDBjLCX+m9N+knLzT2hTjOl2GvqfBqmov1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024547; c=relaxed/simple;
	bh=DnTwO4gZ9nGklDH8Y0DwFw9dQVspBPr/VltsRmWDPss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuOQGzYRlo9rgAI8t4OaAG+HsPnsv7PVfGYPAPq2L57yqjqnuxd1XVVlr6cK2IvCNfYGXGT3P2CER+1ugFPVY+UqJNbCJqmyYzKCYwVrb7YMNKRc7kIedWLFFivCgfGAY3FPUOmIk8c/hitdem6cdWtCv0j8beElmOC85b8UbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEhbF+Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80F6C4CEF0;
	Tue, 12 Aug 2025 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024547;
	bh=DnTwO4gZ9nGklDH8Y0DwFw9dQVspBPr/VltsRmWDPss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEhbF+CgqYfyRKcSiPV+q7zpAX90QZxbpUvDLjvbhVfZJNtS1zAAjthMznI8VsU5k
	 Ja+fbfnQZoEm6T9gRa/45/7AX2C5CpHgu79R/ixSif4Dc82U9TF5ipgKxV6errQ6Bb
	 q+3SNaxxz8el6//AGVCl+PGoaYlfrprHreNGT9oc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 405/627] crypto: qat - fix virtual channel configuration for GEN6 devices
Date: Tue, 12 Aug 2025 19:31:40 +0200
Message-ID: <20250812173434.696987968@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>

[ Upstream commit e83cfb8ff1433cc832d31b8cac967a1eb79d5b44 ]

The TCVCMAP (Traffic Class to Virtual Channel Mapping) field in the
PVC0CTL and PVC1CTL register controls how traffic classes are mapped to
virtual channels in QAT GEN6 hardware.

The driver previously wrote a default TCVCMAP value to this register, but
this configuration was incorrect.

Modify the TCVCMAP configuration to explicitly enable both VC0 and VC1,
and map Traffic Classes 0 to 7 → VC0 and Traffic Class 8 → VC1.
Replace FIELD_PREP() with FIELD_MODIFY() to ensure that only the intended
TCVCMAP field is updated, preserving other bits in the register. This
prevents unintended overwrites of unrelated configuration fields when
modifying TC to VC mappings.

Fixes: 17fd7514ae68 ("crypto: qat - add qat_6xxx driver")
Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c | 10 +++++-----
 drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
index 185a7ab92b7b..2207e5e576b2 100644
--- a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
@@ -520,8 +520,8 @@ static void set_vc_csr_for_bank(void __iomem *csr, u32 bank_number)
 	 * driver must program the ringmodectl CSRs.
 	 */
 	value = ADF_CSR_RD(csr, ADF_GEN6_CSR_RINGMODECTL(bank_number));
-	value |= FIELD_PREP(ADF_GEN6_RINGMODECTL_TC_MASK, ADF_GEN6_RINGMODECTL_TC_DEFAULT);
-	value |= FIELD_PREP(ADF_GEN6_RINGMODECTL_TC_EN_MASK, ADF_GEN6_RINGMODECTL_TC_EN_OP1);
+	FIELD_MODIFY(ADF_GEN6_RINGMODECTL_TC_MASK, &value, ADF_GEN6_RINGMODECTL_TC_DEFAULT);
+	FIELD_MODIFY(ADF_GEN6_RINGMODECTL_TC_EN_MASK, &value, ADF_GEN6_RINGMODECTL_TC_EN_OP1);
 	ADF_CSR_WR(csr, ADF_GEN6_CSR_RINGMODECTL(bank_number), value);
 }
 
@@ -537,7 +537,7 @@ static int set_vc_config(struct adf_accel_dev *accel_dev)
 	 * Read PVC0CTL then write the masked values.
 	 */
 	pci_read_config_dword(pdev, ADF_GEN6_PVC0CTL_OFFSET, &value);
-	value |= FIELD_PREP(ADF_GEN6_PVC0CTL_TCVCMAP_MASK, ADF_GEN6_PVC0CTL_TCVCMAP_DEFAULT);
+	FIELD_MODIFY(ADF_GEN6_PVC0CTL_TCVCMAP_MASK, &value, ADF_GEN6_PVC0CTL_TCVCMAP_DEFAULT);
 	err = pci_write_config_dword(pdev, ADF_GEN6_PVC0CTL_OFFSET, value);
 	if (err) {
 		dev_err(&GET_DEV(accel_dev), "pci write to PVC0CTL failed\n");
@@ -546,8 +546,8 @@ static int set_vc_config(struct adf_accel_dev *accel_dev)
 
 	/* Read PVC1CTL then write masked values */
 	pci_read_config_dword(pdev, ADF_GEN6_PVC1CTL_OFFSET, &value);
-	value |= FIELD_PREP(ADF_GEN6_PVC1CTL_TCVCMAP_MASK, ADF_GEN6_PVC1CTL_TCVCMAP_DEFAULT);
-	value |= FIELD_PREP(ADF_GEN6_PVC1CTL_VCEN_MASK, ADF_GEN6_PVC1CTL_VCEN_ON);
+	FIELD_MODIFY(ADF_GEN6_PVC1CTL_TCVCMAP_MASK, &value, ADF_GEN6_PVC1CTL_TCVCMAP_DEFAULT);
+	FIELD_MODIFY(ADF_GEN6_PVC1CTL_VCEN_MASK, &value, ADF_GEN6_PVC1CTL_VCEN_ON);
 	err = pci_write_config_dword(pdev, ADF_GEN6_PVC1CTL_OFFSET, value);
 	if (err)
 		dev_err(&GET_DEV(accel_dev), "pci write to PVC1CTL failed\n");
diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
index 78e2e2c5816e..8824958527c4 100644
--- a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
@@ -99,7 +99,7 @@
 #define ADF_GEN6_PVC0CTL_OFFSET			0x204
 #define ADF_GEN6_PVC0CTL_TCVCMAP_OFFSET		1
 #define ADF_GEN6_PVC0CTL_TCVCMAP_MASK		GENMASK(7, 1)
-#define ADF_GEN6_PVC0CTL_TCVCMAP_DEFAULT	0x7F
+#define ADF_GEN6_PVC0CTL_TCVCMAP_DEFAULT	0x3F
 
 /* VC1 Resource Control Register */
 #define ADF_GEN6_PVC1CTL_OFFSET			0x210
-- 
2.39.5




