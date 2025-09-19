Return-Path: <stable+bounces-180689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80162B8AFA4
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E1C562EA9
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7732765C9;
	Fri, 19 Sep 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4A8zO8D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70BD262FD7;
	Fri, 19 Sep 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307807; cv=none; b=dki0tEmZ3peSXvYjOExcgwaSi/vXKZn56HgregrgIi7bSndMSRSOxzHlCn1PbCgJyLQV2E2rlenV/PdNc2Pw29hh8K3cBohrdqjf1f1lI8vmkPBJvK6tnbpcEVk9B/NFSyCyXDdOVPTRm78KV8rvrRo29SUvNZ0tyLMCD2ciTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307807; c=relaxed/simple;
	bh=K1e1u658uxOiBzpEcjrgYCfDFAYnhWwFXciHmPx0WFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY1Jv6H78HSu3vkY417mN3gakLtlJ+RF9IG5/XN6NZTgU6r7CPk/09Gwgy4E0t05AyAhuRCM/2Fmf2sJRZ/kworPSuSy3AGqB3ikjbnj36vChmsoPHJefGqDdPRpkIFSwqh36NRANZg7HF5PecvkN/UCSv81kirtJzKpJdb/aow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4A8zO8D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758307806; x=1789843806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1e1u658uxOiBzpEcjrgYCfDFAYnhWwFXciHmPx0WFU=;
  b=H4A8zO8Dt2qxrnuv1xKaAYn+5tSF5vrBGKlIBc+qhw1cdiPKBHlAqNad
   XywrVcN1N7gEz96dCJimvmFtTi6MzpJIWwqkt4pUQxlNr/GcUNFE9v4mg
   j08/tAkt3FGHqWg+cs2GzMU0X3P1BcW82y+xs3mptXBYyW81p/BWowQ69
   wyVqK19guTCuTNIXHJz3pZsnY14QhfqsvTeSwTfNnS8zZ/5iwTuGaHCvc
   ImHXq26ByY/3b+/SzLrKkIsdqMd73oqXmnNt4mT0GPN+yXsVG8kwHl/+v
   qlFDWeSpe0SBHUD9IjbfKVDlc3BrDQWEzmRMMH6lfQdV0qNqhPdQLcKpN
   Q==;
X-CSE-ConnectionGUID: Htx9UHiZQkaU4f8K7FGwdg==
X-CSE-MsgGUID: Wgex1WUISFea4QMizMAsGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60589728"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60589728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:50:04 -0700
X-CSE-ConnectionGUID: 5TPAQOwBTpyTgMFIYGWFJA==
X-CSE-MsgGUID: aAK4hTlmSgu7SnIsdBrmOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175458765"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 11:50:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	leszek.pepiak@intel.com,
	jeremiah.kyle@intel.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/8] i40e: add validation for ring_len param
Date: Fri, 19 Sep 2025 11:49:51 -0700
Message-ID: <20250919184959.656681-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
References: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

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
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9b8efdeafbcf..cb37b2ac56f1 100644
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
@@ -716,6 +723,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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
2.47.1


