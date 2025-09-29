Return-Path: <stable+bounces-181924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61371BA98C9
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8922218947F3
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F42309DA1;
	Mon, 29 Sep 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZushJH2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E8307AD2
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155921; cv=none; b=Vu7jUEALxwRAgX8VnaL/BeyY0SKfQnoIr1f5ER3fOgWpynbC6rHtNvk81J/HYQ5LMpb3zM/LEeAHKsH+sXIggM+2ZD4YxjxDPiVw/vE1Xe0Np/MiC447X6tVtLWi0BL+b5a7bYUbPa9eu3KTgahGUoT3yJRja9E96a34coaS7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155921; c=relaxed/simple;
	bh=ObX8VnoByxaxKL4dZ6WJmp5BDl84oZBCfybzCxw1/mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQ5fpfWRJxpgwMPMXF1K6tTpqvtN533OdFxCVA6NWMPuM/GJXrmcjiMXFV1YWbjmtEHa9sFAnd8nlvDYHvZH3uALvo1luJvxEWuzcCOC0yOwpU5jfjqr3y3z1mHhQOPJdVLyBYgcmj/OMlLAS9zjX5Bz+hTPSR2Fv4VhEFaqxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZushJH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4BAC113D0;
	Mon, 29 Sep 2025 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759155920;
	bh=ObX8VnoByxaxKL4dZ6WJmp5BDl84oZBCfybzCxw1/mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZushJH2Shyg1S8C0vZaHCkyeu3N2oU9a/sci/9+EBOOvWa4nC54MklJqFv8JPGW0
	 36bmLsde4VKVFrBgj4jqVMwwImzmfiIRp7pQtnS26iGfFuqfm8+b2KTaCEtDkaU3uq
	 h4QZsHXlmgFQVmr05jhcYks8eKMqT3i/sL/FUi2apP/tJccHse2vmu210VlJGwiaEi
	 VxPzn41NPXzSN7vSIEZraguJQqt3CY0klqIq29TGsXevaCFzVz/F8JBNqN5Yrcuo4Y
	 efc8K7Cje7qjko2Y/dE8LOdugYy3rh8CVqKZJ4liNLUYv6w23J57YNvc1Nsyj++n1P
	 B0OAq+VqS3LKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] i40e: add validation for ring_len param
Date: Mon, 29 Sep 2025 10:25:17 -0400
Message-ID: <20250929142517.86759-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929142517.86759-1-sashal@kernel.org>
References: <2025092934-spinning-happening-f92a@gregkh>
 <20250929142517.86759-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

[ Upstream commit 55d225670def06b01af2e7a5e0446fbe946289e8 ]

The `ring_len` parameter provided by the virtual function (VF)
is assigned directly to the hardware memory context (HMC) without
any validation.

To address this, introduce an upper boundary check for both Tx and Rx
queue lengths. The maximum number of descriptors supported by the
hardware is 8k-32.
Additionally, enforce alignment constraints: Tx rings must be a multiple
of 8, and Rx rings must be a multiple of 32.

Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7cfcb16c30911..37bee4f58208e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -653,6 +653,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	tx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 8 */
+	if (!IS_ALIGNED(info->ring_len, 8) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_context;
+	}
 	tx_ctx.qlen = info->ring_len;
 	tx_ctx.rdylist = le16_to_cpu(vsi->info.qs_handle[0]);
 	tx_ctx.rdylist_act = 0;
@@ -718,6 +725,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	rx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 32 */
+	if (!IS_ALIGNED(info->ring_len, 32) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_param;
+	}
 	rx_ctx.qlen = info->ring_len;
 
 	if (info->splithdr_enabled) {
-- 
2.51.0


