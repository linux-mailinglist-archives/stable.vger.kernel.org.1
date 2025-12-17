Return-Path: <stable+bounces-202860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5DACC9229
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 338A930094AB
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50734DB5C;
	Wed, 17 Dec 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSArAGri"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6835E52A;
	Wed, 17 Dec 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982370; cv=none; b=hAimszSH90rCnV77U3ySq7gRyEvqAmjd4FFL34kOVIkFTmt2qn8TGrg9VlW4Pmtag+2Qegc0bQ4nFejuULwiC2HvrayiQ3cfTjvkEZ9EUmotgXNXwNjGjuy8Siyxo1No2Gi4OUFnMG1eupTtz7FO7Zvy0t3BlTbDgnYwxE5oeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982370; c=relaxed/simple;
	bh=rjBm4ZKWitmg4rgnrDfpr8eE6B9JXu2wDXlPTI0q59o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3ZP3gdXg/XE5AMb2AL+B66IMU1Q4Qhdnc0yzMTQyv4CPsP44+EIe7F/5lOiCB4Uxb0C3LDAjPoIFV9EreESTJlCVYgyVhJLRx08jl53VscmJTMXhk1rlElnEk5yQPEXA4MIecOrjc+wlcYkiQUr+h3EOM26NQ3sC+zUy/EHkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSArAGri; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982369; x=1797518369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rjBm4ZKWitmg4rgnrDfpr8eE6B9JXu2wDXlPTI0q59o=;
  b=lSArAGricEm7IRj6nPiRV7NtAVBJ2wYbkpEoUpeaptKlkrfDABKU5LeE
   EfmxEDaUgEOo/gY+CVWrGW0b2vJqxTeSAJw/w3jb6D6KtNFU8rKqSgLzn
   RoT1NqrmpP9qJHy6oUbja5i/YIsPjimsEfycVzz52PiOU3WPMen49iHfQ
   MjGIxPTZY0voOiHOKzMrJT9nzGEU78nXM7uk/9yagwpoN+dfisT1kDdyh
   tFCWHwke6zgm94HC0pSjCmRR/ftVTOE/nlQVHrY1uQHZcU1s8uTl41N4I
   EpFnAjlmlewNuFnE+4Xok+pxAPR1G521KbjeHd+GO0G6KPaSoqWm2xxl4
   A==;
X-CSE-ConnectionGUID: fHXEuzHITyW3sTzABGKxXQ==
X-CSE-MsgGUID: 6srkyWWKT0Opc644cJfaCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859836"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859836"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:29 -0800
X-CSE-ConnectionGUID: IxO+TsmSTlSs5aIs8vNfqw==
X-CSE-MsgGUID: S92fDV2xRH6+kIl/8sxjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084929"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:25 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/8] ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls
Date: Wed, 17 Dec 2025 16:39:39 +0200
Message-ID: <20251217143945.2667-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
References: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of the data behind of scontrol->ipc_control_data for bytes
controls is:
[1] sizeof(struct sof_ipc4_control_data) + // kernel only struct
[2] sizeof(struct sof_abi_hdr)) + payload

The max_size specifies the size of [2] and it is coming from topology.

Change the function to take this into account and allocate adequate amount
of memory behind scontrol->ipc_control_data.

With the change we will allocate [1] amount more memory to be able to hold
the full size of data.

Fixes: a382082ff74b ("ASoC: SOF: ipc4-topology: Add support for TPLG_CTL_BYTES")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index d621e7914a73..485490365436 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2870,22 +2870,41 @@ static int sof_ipc4_control_load_bytes(struct snd_sof_dev *sdev, struct snd_sof_
 	struct sof_ipc4_msg *msg;
 	int ret;
 
-	if (scontrol->max_size < (sizeof(*control_data) + sizeof(struct sof_abi_hdr))) {
-		dev_err(sdev->dev, "insufficient size for a bytes control %s: %zu.\n",
+	/*
+	 * The max_size is coming from topology and indicates the maximum size
+	 * of sof_abi_hdr plus the payload, which excludes the local only
+	 * 'struct sof_ipc4_control_data'
+	 */
+	if (scontrol->max_size < sizeof(struct sof_abi_hdr)) {
+		dev_err(sdev->dev,
+			"insufficient maximum size for a bytes control %s: %zu.\n",
 			scontrol->name, scontrol->max_size);
 		return -EINVAL;
 	}
 
-	if (scontrol->priv_size > scontrol->max_size - sizeof(*control_data)) {
-		dev_err(sdev->dev, "scontrol %s bytes data size %zu exceeds max %zu.\n",
-			scontrol->name, scontrol->priv_size,
-			scontrol->max_size - sizeof(*control_data));
+	if (scontrol->priv_size > scontrol->max_size) {
+		dev_err(sdev->dev,
+			"bytes control %s initial data size %zu exceeds max %zu.\n",
+			scontrol->name, scontrol->priv_size, scontrol->max_size);
+		return -EINVAL;
+	}
+
+	if (scontrol->priv_size < sizeof(struct sof_abi_hdr)) {
+		dev_err(sdev->dev,
+			"bytes control %s initial data size %zu is insufficient.\n",
+			scontrol->name, scontrol->priv_size);
 		return -EINVAL;
 	}
 
-	scontrol->size = sizeof(struct sof_ipc4_control_data) + scontrol->priv_size;
+	/*
+	 * The used size behind the cdata pointer, which can be smaller than
+	 * the maximum size
+	 */
+	scontrol->size = sizeof(*control_data) + scontrol->priv_size;
 
-	scontrol->ipc_control_data = kzalloc(scontrol->max_size, GFP_KERNEL);
+	/* Allocate the cdata: local struct size + maximum payload size */
+	scontrol->ipc_control_data = kzalloc(sizeof(*control_data) + scontrol->max_size,
+					     GFP_KERNEL);
 	if (!scontrol->ipc_control_data)
 		return -ENOMEM;
 
-- 
2.52.0


