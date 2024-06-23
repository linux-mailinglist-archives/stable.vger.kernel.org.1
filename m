Return-Path: <stable+bounces-54884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E440A91393D
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A701C20C54
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC612E1DD;
	Sun, 23 Jun 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzmtJVlB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCA12E1CE;
	Sun, 23 Jun 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135154; cv=none; b=ANYsc7vobt3w7OkRLPE0KKQSUVg2dQtD3Q6LtsiMZaAoz6e/b/tSIIkAftNkBMN5zo9E8KOkG6uS2RfIbVbx1jm/g2jp8Man7OLcD0gHbGndNrGiPHwyLfh556XtQ1yEYe+FHU8GZv86uRSAb1W8d1oszh+YvGZuTgVmCwjoFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135154; c=relaxed/simple;
	bh=EXkNc/Ttx7OMvyjILPC3VaKaH6IL0o8GMCiR0jJ5wKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWv7F+FnB19Ye7LgCiIbhK9UcFRfix4zTPbDl4b379sYLpuMWnXauFHf2YaKd9YU8ig1wq55E7q7o0QKKIj+yKrlkHcEmwkPEAR4xB70Ks8ES6afbxaPHAZBth4aRyqGuPkX9Ca7SdN7pCDpIg7v9JJUTZBfipzz9m1jc7kg6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzmtJVlB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719135153; x=1750671153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXkNc/Ttx7OMvyjILPC3VaKaH6IL0o8GMCiR0jJ5wKw=;
  b=hzmtJVlBQkbxb901MnBTIJ4kAQ1hMSV9UC1BqygLEvMh31s9pklj8BQZ
   BJKSea7q5TwgHOVwQvS8sTC1qXv30FMNuw8T7qCAKd/DjxZEMtFYfGg04
   qm+wSSnIYkWqR0K1evYR9l8ImZMZziVgxE5OMRJx9QvI5grJX5OMM+YkD
   0xCx6i7qnOw2FHTL37PY1IbOI8GBjzQihqTr1e+ggf1VwjeMWq48Tv0Yx
   a6QYdwwX2fv4zcwDcRmK266b/Jsah0luKWqmLKiSeQR75IZ3dQjdKucI3
   0XqulPBZMz9bLDFBzx0BIMxsBtS7JO6siEezL9aB/BSHPMzZ464m+scFR
   g==;
X-CSE-ConnectionGUID: hz0pFQH2Q+WGoVWW/q8cWQ==
X-CSE-MsgGUID: f/IjNLoERzS28H/aNHarUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16089090"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="16089090"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 02:32:33 -0700
X-CSE-ConnectionGUID: gYicLethRRmGgw/YZJKPVw==
X-CSE-MsgGUID: M/6xiyp+S0+ZaFYH3Venug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="73761728"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2024 02:32:31 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH 3/6] mei: vsc: Enhance SPI transfer of IVSC rom
Date: Sun, 23 Jun 2024 17:30:53 +0800
Message-Id: <20240623093056.4169438-4-wentong.wu@intel.com>
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

Constructing the SPI transfer command as per the specific request.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 4595b1a25536..7a89e4e5d553 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 	}
 
-	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
+	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : ibuf, len);
 	if (ret)
 		return ret;
 
-- 
2.34.1


