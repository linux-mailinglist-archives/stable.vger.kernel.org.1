Return-Path: <stable+bounces-201054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96663CBE430
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEF9430012FE
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589E03128A3;
	Mon, 15 Dec 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEl+bGV/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C47346E58;
	Mon, 15 Dec 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808712; cv=none; b=cwmX5XwsJL36HoLkO7juEPIu1rcKaFXMkS4npIVpl+tQAXjtNhjxLbaCeY4AQPcYk8gA0m5TY2T2jC/HzshKF9hex67nYd8RejM/Zs/PJ8XE4ZlxDpTHnJDnf8NG8Skh5DM76SPjdB/nUv6Ax+NDDio0hrl4pVD3t/6eErFW1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808712; c=relaxed/simple;
	bh=epm/mfkNSFkS5MRl8Y7ZMbQ3WylThWbfZwkvHI+x65A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIzCwZPAIVWDEXPpSBo/01Jr/chqWDY7VZ/gy8BFtElwi3GyRTVO3EyTItP2rmczMO6clQbromjSk0lQiCjCQAIrqbpkISNln6q0h8IfHQzIzzL6pCl0EyIl3wksrMbNfPb2z5pqlwoMGz16JR5QzioGPgaPbTIL7FiHt/KWKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEl+bGV/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808710; x=1797344710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epm/mfkNSFkS5MRl8Y7ZMbQ3WylThWbfZwkvHI+x65A=;
  b=WEl+bGV/Xq7kXLWWybvXuEXZoyQFXkGoMSQH6SCvSCaui+umLKqxmstY
   O2Zz3t+Nt1JDxJPoAAoiscolfYZXSViyge1HcBNXHlUUof6ClLnAIe+OY
   8RIY5ErnP1BERdi0E7wYBJWk8qKYiasTNmQ3yxifyZSGgjJn7S5k4s3AT
   plg4QenFmqtL9OtfnVS99Wr/8fablU9JR5nhtwODR4x7hnqBqnLU7x3O1
   ll0enU+hUc8t4Z3SzQOiqToHmE+nlGaLNcXR1qNOK7dDcqxzbZdLxIvNQ
   3lyuSP3VPNPsr/FR8SUujCSovm3sUE7vPx1pj7aR5HDDMx97W9XZFT6U3
   Q==;
X-CSE-ConnectionGUID: uYnYcKjXQCCrUzAA5cE65Q==
X-CSE-MsgGUID: Eb8pQSiTTVW8f4TM7UTm9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67866462"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67866462"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:10 -0800
X-CSE-ConnectionGUID: K5Kq/iClQLaqC8ZbURYYhw==
X-CSE-MsgGUID: UW7lpEViQgqUFJVeNAeRsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197362459"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:07 -0800
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
Subject: [PATCH v2 5/8] ASoC: SOF: ipc4-topology: Set initial param_id for bytes control type
Date: Mon, 15 Dec 2025 16:25:13 +0200
Message-ID: <20251215142516.11298-6-peter.ujfalusi@linux.intel.com>
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

Set the param_id in extension based on the information we got from the
topology.
If the payload did not present then the param_id will remain 0.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 4272d84679ac..d64e498c6985 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2924,6 +2924,7 @@ static int sof_ipc4_control_load_bytes(struct snd_sof_dev *sdev, struct snd_sof_
 	msg->primary = SOF_IPC4_MSG_TYPE_SET(SOF_IPC4_MOD_LARGE_CONFIG_SET);
 	msg->primary |= SOF_IPC4_MSG_DIR(SOF_IPC4_MSG_REQUEST);
 	msg->primary |= SOF_IPC4_MSG_TARGET(SOF_IPC4_MODULE_MSG);
+	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(control_data->data->type);
 
 	return 0;
 
-- 
2.52.0


