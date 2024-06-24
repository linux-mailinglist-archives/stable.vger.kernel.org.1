Return-Path: <stable+bounces-54966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE3914028
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 03:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B351F22F39
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765046B5;
	Mon, 24 Jun 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0+JEOVL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410F749A;
	Mon, 24 Jun 2024 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193426; cv=none; b=ZbNzQPW8uQyaikozl3tjZp1iPaNLFqX1n8VsRLIFf3kkR2dnZnT+6fsuM0Y7RPhEM9qgiY3in/R6B2f2aQEX4JeON1iAySAGey/s6YKG4CgeOeEV86JG6mkjfISPzaamDZOTrl4fwiuvfVlSEzqz8KjKuZe5hsaiTu4g+uV808Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193426; c=relaxed/simple;
	bh=JM1sD9QP4RyHSPhRqlUabkVUXwe0DuYqN6xM1zvvobw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5kKIeWkMw7jRo4k1Nt/zkA89Zio+Wtce9IAyrD9WCpiytP5xw5MXYEVVqFiAIbt8DHHoHp0IbThKP+V9wBpq5Hihbj+lhJQpo3QuZrQvMWiKUYEgrG7BiJUekbPZ5Y4P8vlbk4PPrJ3qaTALZW5DzeJi8isLHDUV1bf4I/i6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0+JEOVL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719193425; x=1750729425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JM1sD9QP4RyHSPhRqlUabkVUXwe0DuYqN6xM1zvvobw=;
  b=m0+JEOVLAbA61Y8JaSbEx+6Jacm/W05pvyQapaXtP15GbfFjhVdpyHR9
   kaL/XClnDEqLNB9CNpeKcE4rJwE781k+bisi25K9Y75Ui7AaWBIB+66x9
   sxR37ND4QmJHsTTt0Fq67AiBiqupZfXDQZKM6Wa0+9w+RzxRH951Onsb9
   YUlu4Drvy7Qd5pXVPPxcbDuLU8+UIjpRAe3zLdK7mCpnuG8643weSTDnY
   7Ly8om2EfUH88kLj6fGf1VcIUupi5iwN73RR/Ek8JWlDDbSJaoqqc+qo9
   RYAT9hLtnwyaACXM4ypyKFrIFZQoEHD0Xv5MWO55fJE7kK0G6Cqp5bsp6
   g==;
X-CSE-ConnectionGUID: OO/uiz14QuaV8c5fLg1WYg==
X-CSE-MsgGUID: qRBf8u+7SQiOl/Dkhh/rxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="12202780"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="12202780"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 18:43:44 -0700
X-CSE-ConnectionGUID: jQm4zB0LR0qSf5sKmLzWmg==
X-CSE-MsgGUID: JEQc1Ez3S/aHVMdeoFjo6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43821399"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2024 18:43:42 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v2 4/5] mei: vsc: Prevent timeout error with added delay post-firmware download
Date: Mon, 24 Jun 2024 09:42:22 +0800
Message-Id: <20240624014223.4171341-5-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624014223.4171341-1-wentong.wu@intel.com>
References: <20240624014223.4171341-1-wentong.wu@intel.com>
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


