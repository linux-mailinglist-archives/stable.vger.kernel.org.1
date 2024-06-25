Return-Path: <stable+bounces-55155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31D9160B7
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0201F22818
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B92C148853;
	Tue, 25 Jun 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fygv4TRq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743571474CB;
	Tue, 25 Jun 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303109; cv=none; b=lhLitvoULQv7TTVoQvnL2gp5I80Q8OiGV4H5mqr+nOyMwGgIo0BOb+/rOaVrFKA8P4b9V0w9NSCmv1X3Qxl0NmyxCes0/1tZQhWZVgNecTvDYHPOwSDNB6l5J4moePN46l31Bk+9JrRcscHDUK1BAENCYeJc5/Q4iadEpnTeymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303109; c=relaxed/simple;
	bh=JM1sD9QP4RyHSPhRqlUabkVUXwe0DuYqN6xM1zvvobw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2eVCGwK4KfjG6sAodf2mSecji7yxOCRNYJT2ztWwM7LLpCNlrK+gC6jaVpxDaeB6+dmow8BMGEHdpek5EzLatMtybFQL3I83n/ngbZLpUlowiazJr9mVpfZY9ZXT4TDoZuE7w2l5mEvq2/3k6jiUf5/l0IQ3fuWVdYdIDYRDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fygv4TRq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719303107; x=1750839107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JM1sD9QP4RyHSPhRqlUabkVUXwe0DuYqN6xM1zvvobw=;
  b=Fygv4TRqqkeNsqamr9dAf10RUZbfvOd01dwOLlkYHNBenVImEDLAtTEv
   hqwR0v+spDzcvsyIY5UrRR7Om+fGbPuSSczoHK1jXYNJ+Cj2upf7AW5Wo
   hiAS09JhRH+5zcTxfRA2suY/16PCIKezalFYAlBUbIgKq648bkHZN0gxz
   idigVhAzLSGeqi253QUUG5Z+czSsOC3OkTOI7mkgLH2CRvCDiSDb07VSp
   5nRAfGSxS++vdqduZRHchM7KyvWKE0BHSy0cUg452gpoD8VnEulWQjHbZ
   2WIfkl7F+Lx3AWtMqP0Uy26mupmgDN5sdduLLFYl+PZZ67Ilt4MnTMM+j
   A==;
X-CSE-ConnectionGUID: /xqCv4CwRmSlxhmZSUprGA==
X-CSE-MsgGUID: e6WTGiEoT+yRpVdaZ6gT/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12232503"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="12232503"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:11:46 -0700
X-CSE-ConnectionGUID: RorVC/L3SuazX8B16Nn0Lg==
X-CSE-MsgGUID: NkKf/9eSTIySmTKvZdCV7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47944900"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 01:11:45 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v4 2/5] mei: vsc: Prevent timeout error with added delay post-firmware download
Date: Tue, 25 Jun 2024 16:10:44 +0800
Message-Id: <20240625081047.4178494-3-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625081047.4178494-1-wentong.wu@intel.com>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After completing the firmware download, the firmware requires some
time to become functional. This change introduces additional sleep
time before the first read operation to prevent a confusing timeout
error in vsc_tp_xfer().

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/platform-vsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 1ec65d87488a..d02f6e881139 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -28,8 +28,8 @@
 
 #define MEI_VSC_MAX_MSG_SIZE		512
 
-#define MEI_VSC_POLL_DELAY_US		(50 * USEC_PER_MSEC)
-#define MEI_VSC_POLL_TIMEOUT_US		(200 * USEC_PER_MSEC)
+#define MEI_VSC_POLL_DELAY_US		(100 * USEC_PER_MSEC)
+#define MEI_VSC_POLL_TIMEOUT_US		(400 * USEC_PER_MSEC)
 
 #define mei_dev_to_vsc_hw(dev)		((struct mei_vsc_hw *)((dev)->hw))
 
-- 
2.34.1


