Return-Path: <stable+bounces-54887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A10913943
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB3E1C20C98
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1A12FF73;
	Sun, 23 Jun 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hY8P5ew4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D612FB0B;
	Sun, 23 Jun 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135169; cv=none; b=BI+I32e6uPQrRMjuHsRyEPAdwTTJaan/CG5dlHhydZWM2why/sfqeqfb0L/i60DqhGHItIx4dKnxHJ87qlopL0l5VSc0PO+6sLL4yqDUdr4PyXKR3iO0t13utyN5nv+prPX/hjGnUPwSI/JLYhK06O8v3cGi/oxSFnW47vQuJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135169; c=relaxed/simple;
	bh=qTMPWsu7YkfJAzlZHprziJZbdGJsTuC7Lk0WAHlkJxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpWpWdqYXXBwfLc71AHdz7BJfN1uxRlcs/sS1M5qSsCCxlEQIgtAtuIN74r7RuFwHczl7yOENkp682i8yHpBm37OmWVlMsgY5sP8xvcNNdcEdsOOEH2AxsA5xooD2H9kMHoTmwWfhirWlOmY6+rO0MGERPeqzR7bR5yqlyjiKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hY8P5ew4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719135167; x=1750671167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qTMPWsu7YkfJAzlZHprziJZbdGJsTuC7Lk0WAHlkJxc=;
  b=hY8P5ew4ricWVO0nOlGmq7U0/jPtCRiMu6LmwNcJuWntiYxeOiZOmzME
   ySdLdnC0RIEbrDpRzSiAHJHpqbLL9ijCOg8e8uLONwxT9X/GHYhSavNiW
   K9Qcx6hJh2KdeVGDqhOMc5Ym1Ap7PCNhiZN6MsOAtpvefC74pq0zrERPC
   RZcYRCa8YAA3xpZCHZqYrcxqWi51WcUA9zJAS5qQyMNPl8sIukPjLgppm
   X3d0q+jTZJyvQgMkrOLSF5ymEi3fyq7J76qU96Z6glbHNimhaElfHt4cw
   BHK+tnJpdPcDAjSYpsftPs1aRLd/DjHRjLY13VXl8RItPnbdEmjnWN5t0
   A==;
X-CSE-ConnectionGUID: 9cQ7nr0iRMOARSd9cZoimQ==
X-CSE-MsgGUID: 95p+SxW6RfmIYSACAitdPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16089102"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="16089102"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 02:32:47 -0700
X-CSE-ConnectionGUID: 4iRWJGYiQKuYIlgF3Orcag==
X-CSE-MsgGUID: 7Nl+VDi5Sy63vc3skNEwow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="73761761"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2024 02:32:46 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH 6/6] mei: vsc: Fix spelling error
Date: Sun, 23 Jun 2024 17:30:56 +0800
Message-Id: <20240623093056.4169438-7-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623093056.4169438-1-wentong.wu@intel.com>
References: <20240623093056.4169438-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a spelling error in a comment.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-fw-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
index 596a9d695dfc..084d0205f97d 100644
--- a/drivers/misc/mei/vsc-fw-loader.c
+++ b/drivers/misc/mei/vsc-fw-loader.c
@@ -204,7 +204,7 @@ struct vsc_img_frag {
 
 /**
  * struct vsc_fw_loader - represent vsc firmware loader
- * @dev: device used to request fimware
+ * @dev: device used to request firmware
  * @tp: transport layer used with the firmware loader
  * @csi: CSI image
  * @ace: ACE image
-- 
2.34.1


