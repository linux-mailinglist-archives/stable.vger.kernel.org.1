Return-Path: <stable+bounces-55018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4624B914EA5
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0218A2850AA
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEFF1411C8;
	Mon, 24 Jun 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDoJCowY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C81448D9;
	Mon, 24 Jun 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235795; cv=none; b=OwZ3/8VRxZ/oefJhvU3O/qMA5qZjzsFiP+G8q7nevZr+CXIfDTkHmHTkzGRY7dmFTcOx60r9Y66efAfMB2i9XkOohKGuZAxrHthXB0M7uA3HOrP0jNHzzuX+x2NWJ5WMvTFLX9wAMfaxRN/PxBgmG1iAT+GjipHWGTsnSJhqmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235795; c=relaxed/simple;
	bh=JM1sD9QP4RyHSPhRqlUabkVUXwe0DuYqN6xM1zvvobw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7fhmh+Bg+c+lofj+zrJTwc55z+oDTKlKIzJ+pxHP/BOah+2Yj0+aXjOUxBKzxgb+uhYZ2o/DbBVBbYzJMBVKbVZwBH3avwsJ2mO/06lv5IizW4D33aUH7lyVvuafI4ZXq0Rv+Asn4prADmnNvwvsKYGD69+1KTBrfJuwyeJ68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDoJCowY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719235794; x=1750771794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JM1sD9QP4RyHSPhRqlUabkVUXwe0DuYqN6xM1zvvobw=;
  b=eDoJCowYyDhPVtxYhrwt6h0zt/u3fseu6y1oldX0P3mCCFmnsnSHeIz+
   iHDiHUXU1WuBp9Hsf3qHIrmcDA1tNXNfPF2RGTr/c2Ys53ulyQyXZPl4d
   Fz3YRicHKNvn0WLo7tINKQUnA3bg0OG9zm9dybQ+lrbP9vclFdGlSKom3
   0mdGkxLsNYNjM1mJgvL597VsbnjKOxZTgps52z+mNIGwGy6S8h8kfuOu3
   0wKtbQRVJfJ3c2av+0jbvk2x86oBPp0gf1EqAxbjf69PIKqm8XuVkBRy2
   9vQ8bTvq9T974/4fkp5dszEJpR52rIpydISb/DXEYFYoPjY6a85nPAeWs
   A==;
X-CSE-ConnectionGUID: JaBHE5U1RcaED/hWOVPynw==
X-CSE-MsgGUID: wEQl7WLCRteK4wIEEuZWWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="26830755"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="26830755"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 06:29:54 -0700
X-CSE-ConnectionGUID: K+q5CI5dTZaceQrjTvCvmA==
X-CSE-MsgGUID: xXN1cEZkQIG+SfpCEqsjiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47746743"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2024 06:29:51 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v3 4/5] mei: vsc: Prevent timeout error with added delay post-firmware download
Date: Mon, 24 Jun 2024 21:28:48 +0800
Message-Id: <20240624132849.4174494-5-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624132849.4174494-1-wentong.wu@intel.com>
References: <20240624132849.4174494-1-wentong.wu@intel.com>
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


