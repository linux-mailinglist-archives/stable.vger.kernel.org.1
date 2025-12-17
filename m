Return-Path: <stable+bounces-202863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74ECC88C3
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E411430A35E0
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B07366DAD;
	Wed, 17 Dec 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDm0J507"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25613446DE;
	Wed, 17 Dec 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982379; cv=none; b=TiU39gBYzm1E3eQLQvk5GhsD2uIP+AXruELPYbCd5TtwMflkTdXvsvGSG9xcAzXJhWgPeuBrAneW37wzZZJekgmOb4GN4kL8CMffOve90JFQ3GTa0IEMwhX7MeLZZZz471DqgVk8uD8ar6aHTVstG/xrclPnb6NB6He/AWfssXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982379; c=relaxed/simple;
	bh=xT1pXT5hJE6E6AkUL/aY//Q1JKDlBWvD6pGQ5q/HHB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKLgEw50o+JdnlFbDGGL78VCSHFdf6M8hE5EiE+MlDhqwVhlVOzNy9QzDXl2uV95egWnp37VLGLIF6SlV52ZQpkLheNlmGbgzLxZctL5yEac/8MhAQxfSKxv+LOEmBAcqpSFidBhXX2iILFTLSyjVHfRrsYuNUZcGjfkV4VMhpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDm0J507; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982378; x=1797518378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xT1pXT5hJE6E6AkUL/aY//Q1JKDlBWvD6pGQ5q/HHB4=;
  b=mDm0J507sYfb4MrjaSyd0z2rkLCPC6FA0Ln4a4OMm/I7Ku2MmuEQrSoA
   AhhuO/HM8dcxxBXeZmoirfsz/YUB2Atwf0BhnMra504HtYm21vH39lmRW
   l3kduxZC7hYxTxN+e9TgYSuEIF3H48PM6gV6d+Fq/moksgM3M6dzZTErD
   kGjwWzeF+Tgty0m9H27cjwEv3G7k5rXpDCumHyA5ta2c66100eHS44fC0
   KUrUZyaqa6zYAWk2/ymLKH6Y/FhX9r/vHmRtSN/xxPRb+x55dztPA3AfI
   oFN6ntWAhHw6tv3GoKUGGhssrUJ6+LOnRscYrU8FfrVxCGrruwBn3JZn9
   g==;
X-CSE-ConnectionGUID: bFlsUVCzRTuPdByKUSNdVw==
X-CSE-MsgGUID: N23DQLfwQJevpAHg7I+QVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859859"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:38 -0800
X-CSE-ConnectionGUID: 5/PMcshUSAOaqPya+1tAUw==
X-CSE-MsgGUID: BMUj4ew1T6+riGu3qSnRIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084958"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:35 -0800
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
Subject: [PATCH v3 5/8] ASoC: SOF: ipc4-topology: Set initial param_id for bytes control type
Date: Wed, 17 Dec 2025 16:39:42 +0200
Message-ID: <20251217143945.2667-6-peter.ujfalusi@linux.intel.com>
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
index 485490365436..479772dc466a 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2939,6 +2939,7 @@ static int sof_ipc4_control_load_bytes(struct snd_sof_dev *sdev, struct snd_sof_
 	msg->primary = SOF_IPC4_MSG_TYPE_SET(SOF_IPC4_MOD_LARGE_CONFIG_SET);
 	msg->primary |= SOF_IPC4_MSG_DIR(SOF_IPC4_MSG_REQUEST);
 	msg->primary |= SOF_IPC4_MSG_TARGET(SOF_IPC4_MODULE_MSG);
+	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(control_data->data->type);
 
 	return 0;
 
-- 
2.52.0


