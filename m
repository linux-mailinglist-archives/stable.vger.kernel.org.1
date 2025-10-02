Return-Path: <stable+bounces-183041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E719BB3F02
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 14:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F6717D5B8
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB2F3112BA;
	Thu,  2 Oct 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ifhw2qYR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71930DED8;
	Thu,  2 Oct 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409554; cv=none; b=l7tKhGAtlEH8Sr1IIxmoWebOKvb3KKYAihBpGBTrjNR8jd+giVyY3DTj0Abjllx4G27ci8AjYT9BPrBUwUwDacUfLD0rZsLdxfAaSsfFUrw3rkA9Y7G9A52DSdAphWYOZIHBfoZtD+eWvv9f/+tcOHrrgxCwMJ8CNds06Vqw23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409554; c=relaxed/simple;
	bh=qDL2g7o1Ga9AfjM5rEwMwKfXIXga9Owkr4OhV4F7SpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMP98SqU8K4U2/aNGgZuPR+Ed8JGBUKn8KuzgnFTQ+6We5JiywP5oCB8SCHG74HNqD/srsBt4NjXX/P1DiYtrR5hST7fMQyR83f0YEQ2jlI1fzLoHcIILupkQzB994KG6kjGoCy1nwTXgAGp20kmhK1pykU6JVFbdeCipWt++ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ifhw2qYR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759409553; x=1790945553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qDL2g7o1Ga9AfjM5rEwMwKfXIXga9Owkr4OhV4F7SpQ=;
  b=Ifhw2qYRxpyigApappqn15J7vYHg6oHpbc6Cqn7JXtWLfhja1YBggBT6
   cq03a4GNiZAXUphVXqX+LdWPHk4UZXhwCSH/EPVURCz2Ub+UMsW2r30MB
   eox0AG80AXZr08pZyJnt19rwb9BkY8Bl1d1J31h7mjKvIMsrYewiKzxz1
   iNK8cPg2PNVzDxctOxIrC9w3JVQT/uXyvCscpidHao4FbxNPUY6WD7je+
   TxXVw4a7xlCKLpGOJI6m0NHQW2tYlPpY8+uno3osiDq9QYC88dh9IMp1S
   GOysC2xoB7WdDAuGWGy1jw+HB/xNQxqLsyr4vp9zAiG1eh5bcqBsfrdxE
   A==;
X-CSE-ConnectionGUID: VhTtk8y1Sxy3c3LftpwukQ==
X-CSE-MsgGUID: UiB9DoLZT/a/ziWnLV7W+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61579798"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="61579798"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:52:33 -0700
X-CSE-ConnectionGUID: j/ksVBQlSYCT3PO+8/vrAw==
X-CSE-MsgGUID: 1/V+YaRkTAadXjAsWwH/Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="179057608"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:52:30 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] ASoC: SOF: ipc4-topology: Correct the minimum host DMA buffer size
Date: Thu,  2 Oct 2025 15:53:20 +0300
Message-ID: <20251002125322.15692-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
References: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware has changed the minimum host buffer size from 2 periods to
4 periods (1 period is 1ms) which was missed by the kernel side.

Adjust the SOF_IPC4_MIN_DMA_BUFFER_SIZE to 4 ms to align with firmware.

Link: https://github.com/thesofproject/sof/commit/f0a14a3f410735db18a79eb7a5f40dc49fdee7a7
Fixes: 594c1bb9ff73 ("ASoC: SOF: ipc4-topology: Do not parse the DMA_BUFFER_SIZE token")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index dfa1a6c2ffa8..d6894fdd7e1d 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -70,8 +70,8 @@
 #define SOF_IPC4_CHAIN_DMA_NODE_ID	0x7fffffff
 #define SOF_IPC4_INVALID_NODE_ID	0xffffffff
 
-/* FW requires minimum 2ms DMA buffer size */
-#define SOF_IPC4_MIN_DMA_BUFFER_SIZE	2
+/* FW requires minimum 4ms DMA buffer size */
+#define SOF_IPC4_MIN_DMA_BUFFER_SIZE	4
 
 /*
  * The base of multi-gateways. Multi-gateways addressing starts from
-- 
2.51.0


