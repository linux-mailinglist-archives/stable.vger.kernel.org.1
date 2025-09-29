Return-Path: <stable+bounces-181934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E543BA9AA9
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369733B15F8
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF719309DC6;
	Mon, 29 Sep 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAsn65Pr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE941308F36
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157163; cv=none; b=SFaktL4eYt/pCnlAqcryMRWpUMlkrYWEEu3AWU0ecEu/WoFUsxCgZHyGgKCPTov3tpSjfUbyHGmAPk/EhBOG0Bh96OXb8fs383ajF/UXH44+a0btM1K7NIn2q0OBvOQkv5cFhMGk0MAmZHZW5miMDbh/2OLVuesEjDd+ioI65nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157163; c=relaxed/simple;
	bh=PFFjobB+F5hzGA+w+aVl/QcUd9zEc4UJ8yyF30f0Mmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfepuNrICt4Tx+UhBieCKZIso6zSoA9KC5lcMCsbeOju2Dvv0xrfEUO3oaCckYUwvCiI/etTGGIdt1JzSA6tGkEsCgoKq3HFBvaC86TwHKoHJqUigI24xXaHcb2UKqb+h49Jbyy9VrvrcpZ4xmjIYPxsLBVJT620jPwFTJsU7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAsn65Pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4C7C4CEF7;
	Mon, 29 Sep 2025 14:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157163;
	bh=PFFjobB+F5hzGA+w+aVl/QcUd9zEc4UJ8yyF30f0Mmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAsn65Prt8RUZu7DpNJ0nSE1dMaTrQRscAKOOwWI6RPu4WWl2NtfX0yZ/Q2gubbk5
	 A9Fs6cfsd9mSV90zF7XK0HHzfa+/fYxVo0lad5zMrMZttWkE0csahPUMwcF48YK43R
	 fRhDmvig+WSeux80F++ygVmwEx3w6P5N9tTwLElcuazMYAzuhFMbRaCs4CiDWRUBOx
	 DlcBCk4vbZfm7GfXWmSy1ETgB5FS5KLFPhe9MFfCV7e2UUu5MlR+joK5eNQ1mYBxmc
	 sYoLYip0YYfrSxz5402dNfUmDl1jgzEkQ97ih75fv+UgQ6kItOSnpVFDezQJOJhKi6
	 hfC6eaRcvJguw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] i40e: add validation for ring_len param
Date: Mon, 29 Sep 2025 10:45:59 -0400
Message-ID: <20250929144559.106806-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929144559.106806-1-sashal@kernel.org>
References: <2025092935-atonable-underdog-9664@gregkh>
 <20250929144559.106806-1-sashal@kernel.org>
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
index c86c429e9a3a3..61b4064da7aed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -600,6 +600,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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
@@ -665,6 +672,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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


