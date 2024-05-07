Return-Path: <stable+bounces-43179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C48BE4AE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 15:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7333EB2E5F3
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2152115E1E6;
	Tue,  7 May 2024 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gd/kdfIR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB51152E13;
	Tue,  7 May 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089400; cv=none; b=F+dOaEQ789TjYfTPcCxaWbIeLSU3cNHKqT20xNE+jHjMktEQolpICNJKZvIwb2VgX3L5Ycz5FyB7HgRd4rfMGEgE+km8CrsWItfBUY774CLqZD6qf+Um0Bo8nbi7BOHBzZ1LtSEoEPx5Axaq5tcTRpU9gpAw1xGx6sKG4mlAg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089400; c=relaxed/simple;
	bh=rLDJNPl5qNyO2Cwa2T+ZmAT0Oyqp1JIcnI9cHjL9mdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJtju9U8xlWxanyb4JLC6gtW2LRhgPX1UM/3SiRyccglhaI/tIWcH/9PU2TpdgTb6Z1v7JvqlA0jT9foWFFV7M4yZqn9fWn03K5YO2LSah6mysjXiOBUy1O7RS1E/jXdp5Z0FAbXOCEyxLeeARP648Emix5eLS4WMxX7Vw9r9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gd/kdfIR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715089400; x=1746625400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rLDJNPl5qNyO2Cwa2T+ZmAT0Oyqp1JIcnI9cHjL9mdY=;
  b=gd/kdfIRDO35jGKGd03QdXMs2Ojw/RGcg2FBtHXDbTtjcSH5mRuKY2KP
   /c2/wYgtdZFAKUYmM0QK7dJr0xsvRl5qU+dfWEYFxTJ198lFazqKAATkF
   llNE1fVMxZXgIa1pxPLMKrMbw82nsqFPWXX/fUw1Q/4HcQu6bQTgyxCYB
   QCisplvXAKJxt5bm6lnQuJ7LmDg89PeiLV2BaN2K3JqrFsn7oppnCqwTN
   hG6wjVetG2i2PkSIyGsTj2dK5A3omh3lAsZL4LFd4MpQ+4Z4sVMdzf91r
   Gs/NDEJe+CR822NF/Z/PkXCBubI1eEGprFwM1Rln+Uh0mEFjA4fJaKHYg
   A==;
X-CSE-ConnectionGUID: bn1durWlRESA3mtq5BcEcg==
X-CSE-MsgGUID: eWZ+2Ed3RM+5FjuGSib4Mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14670994"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="14670994"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:43:19 -0700
X-CSE-ConnectionGUID: mft4YJ9xTFGtsD2WdUrsfA==
X-CSE-MsgGUID: 0oQ2Ff33R4SuVk+vQo8lKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="59690642"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 07 May 2024 06:43:17 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: displayport: Fix potential deadlock
Date: Tue,  7 May 2024 16:43:16 +0300
Message-ID: <20240507134316.161999-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ucsi_displayport_work() does not access the
connector, so it also must not acquire the connector lock.

This fixes a potential deadlock scenario:

ucsi_displayport_work() -> lock(&con->lock)
typec_altmode_vdm()
dp_altmode_vdm()
dp_altmode_work()
typec_altmode_enter()
ucsi_displayport_enter() -> lock(&con->lock)

Reported-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/displayport.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index d9d3c91125ca..8be92fc1d12c 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -275,8 +275,6 @@ static void ucsi_displayport_work(struct work_struct *work)
 	struct ucsi_dp *dp = container_of(work, struct ucsi_dp, work);
 	int ret;
 
-	mutex_lock(&dp->con->lock);
-
 	ret = typec_altmode_vdm(dp->alt, dp->header,
 				dp->vdo_data, dp->vdo_size);
 	if (ret)
@@ -285,8 +283,6 @@ static void ucsi_displayport_work(struct work_struct *work)
 	dp->vdo_data = NULL;
 	dp->vdo_size = 0;
 	dp->header = 0;
-
-	mutex_unlock(&dp->con->lock);
 }
 
 void ucsi_displayport_remove_partner(struct typec_altmode *alt)
-- 
2.43.0


