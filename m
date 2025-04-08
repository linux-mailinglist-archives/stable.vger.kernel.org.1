Return-Path: <stable+bounces-130724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C00A80681
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDA08A0BC3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8826A1B1;
	Tue,  8 Apr 2025 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYFrZ+mV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DE268FEB;
	Tue,  8 Apr 2025 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114480; cv=none; b=hkjx/pc531SyvZZ4/uWhVinMgrM92hnZlDCtn/jUq53Enk1pQenVngD99BPpx1KsiKcDrQwCizlHWw2iQhFJlYe+u5H2hXvt3KQXg5M6d9DToYJlH7dP6YE6Mp8XT9J/HoUu3AlC4Re2UlYvnNR1yY1uKoGUzXwl+7uyd12BI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114480; c=relaxed/simple;
	bh=nquQahr6T3L0ZRWqUdOgy60aD+/L0f2RI5cA5QhnvRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNmvAeDVZ7ZLNMb3sIACcPUKRcnZZvC9ZO3LQRJD9A3lEE8fg9KsmGkdD+FjEg+i4GPjQalUJOz9BjJr1ZvOQ07Saa8ieoR4htSwW2DYp4HfrudGOYp2ltuInjVxzKwX6OBB5FWk3ehC/8vbh57M6XXsrwZ2odRtBFTDvCUx1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYFrZ+mV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A244C4CEE5;
	Tue,  8 Apr 2025 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114479;
	bh=nquQahr6T3L0ZRWqUdOgy60aD+/L0f2RI5cA5QhnvRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xYFrZ+mVlXSlFal+ISvoR0vV6FPAZ5NX1EwTSvIDg2x9njDGG91yMId2sjoo7LJaV
	 +ZrKkXbmu+uJYc4OF6SO05KCJLQHnfdHniJ3Y2Ph+aC2C7W8olFwqD3+E5qWzrgeJq
	 fe40WYrOuBXyK4ZFynzqbCfcJ8h3nsxydOBl0oEo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bairavi Alagappan <bairavix.alagappan@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 121/499] crypto: qat - set parity error mask for qat_420xx
Date: Tue,  8 Apr 2025 12:45:33 +0200
Message-ID: <20250408104854.218267046@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bairavi Alagappan <bairavix.alagappan@intel.com>

[ Upstream commit f9555d18084985c80a91baa4fdb7d205b401a754 ]

The field parerr_wat_wcp_mask in the structure adf_dev_err_mask enables
the detection and reporting of parity errors for the wireless cipher and
wireless authentication accelerators.

Set the parerr_wat_wcp_mask field, which was inadvertently omitted
during the initial enablement of the qat_420xx driver, to ensure that
parity errors are enabled for those accelerators.

In addition, fix the string used to report such errors that was
inadvertently set to "ath_cph" (authentication and cipher).

Fixes: fcf60f4bcf54 ("crypto: qat - add support for 420xx devices")
Signed-off-by: Bairavi Alagappan <bairavix.alagappan@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c | 1 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 9faef33e54bd3..a17adc4beda2e 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -420,6 +420,7 @@ static void adf_gen4_set_err_mask(struct adf_dev_err_mask *dev_err_mask)
 	dev_err_mask->parerr_cpr_xlt_mask = ADF_420XX_PARITYERRORMASK_CPR_XLT_MASK;
 	dev_err_mask->parerr_dcpr_ucs_mask = ADF_420XX_PARITYERRORMASK_DCPR_UCS_MASK;
 	dev_err_mask->parerr_pke_mask = ADF_420XX_PARITYERRORMASK_PKE_MASK;
+	dev_err_mask->parerr_wat_wcp_mask = ADF_420XX_PARITYERRORMASK_WAT_WCP_MASK;
 	dev_err_mask->ssmfeatren_mask = ADF_420XX_SSMFEATREN_MASK;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
index 2dd3772bf58a6..bf0ea09faa650 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
@@ -695,7 +695,7 @@ static bool adf_handle_slice_hang_error(struct adf_accel_dev *accel_dev,
 	if (err_mask->parerr_wat_wcp_mask)
 		adf_poll_slicehang_csr(accel_dev, csr,
 				       ADF_GEN4_SLICEHANGSTATUS_WAT_WCP,
-				       "ath_cph");
+				       "wat_wcp");
 
 	return false;
 }
-- 
2.39.5




