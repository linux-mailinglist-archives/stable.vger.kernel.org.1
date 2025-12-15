Return-Path: <stable+bounces-201051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CACCBE48D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93CAC304391E
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD97C33BBA0;
	Mon, 15 Dec 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsH8st7J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDC22154F;
	Mon, 15 Dec 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808702; cv=none; b=i1aDupr6hHRm1J4BC1YG23uUN+3RjUYySEn3UMPozm0cvQBo0+so16lOL4OLRN0lWkJB2gL3N2gUZpHs9+M7TGxADx9VyZoKJOS3DtUNADpNGpxT8TPpgR2VsSslUUa3uAOB2OU/dRc8gGgBdPQrrSpPXi7hrnaGSJleMR7Fr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808702; c=relaxed/simple;
	bh=qm6/a8nA15CS+PtG6uehoFAhSTL1TGymPYKbbiuY/jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmqSQJxwR8N0Ush0oHTl4ozDmQMTXk1ZIjQMH+8MwK91Do84TAAX0QhS9AJOKCIYjwnJj6Q2tKTseH5tuAZsjOYU517DPZ5SVFShJ4ns2py1uq3K5TLzMcQo4EfreRXSmg7mchaCvsjf8DxBdzWUb0SoHsLBD9SS0Cc3czuS4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsH8st7J; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808701; x=1797344701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qm6/a8nA15CS+PtG6uehoFAhSTL1TGymPYKbbiuY/jo=;
  b=JsH8st7Jg7xrr8lCixC9TZQI9tqH45RryNMJgvSQFV0C+HgWSYoRFHqv
   cpfIIi4IMDCV0I0VARs6m6PSJS/zfIqKQGhKnoYj3Vb+KBxB8YbhO0hUd
   fcia3fzXdVXDXJYryIPpyxejYKtBbDBPM/HdGtMy86O0WbHYdC6XoIcRt
   p73NB/d9A2SQOOTAtuK2VVN+rYATUAQy3xMSmGpw4T3WgIOpky9wxvut2
   ZXAIAaIauXMFOkHvmY1uN94hRr8jD3Hy4wHK7HTTe6xSwDx/iDJFsLiU+
   fEjaQaXrsgSEQL4lVRM8hH6uGpEXQVKNgTRacSAkw6laV5Mm0Gu5wqenv
   Q==;
X-CSE-ConnectionGUID: c+ZhqolrRzS/ndYufCpsLQ==
X-CSE-MsgGUID: aIgoexloSAqyxCxEgclZgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67866439"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67866439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:01 -0800
X-CSE-ConnectionGUID: 9QYqGDBmTwSyz3Thd9he/g==
X-CSE-MsgGUID: 7AQ09bbjRRi7ksYN2grNgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197362361"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:24:58 -0800
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
Subject: [PATCH v2 2/8] ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls
Date: Mon, 15 Dec 2025 16:25:10 +0200
Message-ID: <20251215142516.11298-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
References: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
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

Fixes: a062c8899fed ("ASoC: SOF: ipc4-topology: add byte kcontrol support")
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
index 221e9d4052b8..4272d84679ac 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2855,22 +2855,41 @@ static int sof_ipc4_control_load_bytes(struct snd_sof_dev *sdev, struct snd_sof_
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


