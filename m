Return-Path: <stable+bounces-181922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C009BA9814
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7704170876
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EA43093CF;
	Mon, 29 Sep 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF9SSYfU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656583093B2
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155078; cv=none; b=fgclzrULHuUmuytYgfq04csslVmIiRzRHKwzsbxSMRLAbqiv4Zs/32JAM+GwnO3IOvHMim+cDdNcShfmNfsW6eFE1p417PjKWAbkS74kp+b3t9eB6gXEkaNXV5SZzYArvgKzneLWnxg0+y7XAdzbP/X/zaKSgpOZrwPWE1A5g+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155078; c=relaxed/simple;
	bh=8TpDzW0xfLEFPrR+INLV/gg505bkik8GhVDBhhRVprc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBzTlu2VEgytF+D1Yt+OrDVrGd5VnS1LttxcuexjhX42Jxd+6DrSrDnFwJ6B036jbkfiPqv26GFIKfEabqtGCg0EStr46HURBhD8GIaGx+1oUyCgSWxDBiWAUoR2jcSMsncuXdp/2uq39CHUsggMhdMsQV23k59XCPfbKpDYzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF9SSYfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02080C116B1;
	Mon, 29 Sep 2025 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759155076;
	bh=8TpDzW0xfLEFPrR+INLV/gg505bkik8GhVDBhhRVprc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DF9SSYfU6h9WLzoUwEKln3YZEGPIy03EDiCMcEwOQuFfjXb/SGJ82gaz6pttQ4Czg
	 qEJ8qIxeMOi1vPo2q9OiCvA3K5URp/kl/7evApGRVsJKR8WSoRw/uK4DcwWO88uBeM
	 8mPJV9FAeW+evUuOfYqRyUXzFUV8f3/iu8WW0x1z0XqBqBiud4g+4upnj4ZYbyyc/P
	 fMDGYKFdy4wfrSFlljJ9w3yspDMG8PLsAkuHjtwy1dDX15ngtgxPuUPUCjL8AciGRX
	 kInP8gpaPjo+y0hg3S+oT+5ZlRADhDmc+94c/QFLYyJGg+qs4XWcNI9Ej9YmDTdrr2
	 o0jZEmQ09eOOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] i40e: add validation for ring_len param
Date: Mon, 29 Sep 2025 10:11:10 -0400
Message-ID: <20250929141110.80651-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929141110.80651-1-sashal@kernel.org>
References: <2025092933-confess-manhole-6d70@gregkh>
 <20250929141110.80651-1-sashal@kernel.org>
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
index 6d7a4f2c3a49b..f7b0371cff027 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -657,6 +657,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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
@@ -722,6 +729,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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


