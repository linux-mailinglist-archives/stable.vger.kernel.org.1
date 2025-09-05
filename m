Return-Path: <stable+bounces-177794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65AB4540C
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 12:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A941C88462
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DE52BEC2D;
	Fri,  5 Sep 2025 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsbpnPTg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696829E0EE
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066607; cv=none; b=cmslUJSxelR6ry64DlUZtMjAvCGoWSpIZAyHHYPDFLPZQHV6iXhYbdGkTl3mWmIgCZ23KvbPvtP+HaNEG3zO+3Q1gEGMp4jeaG+SQ3AyWYOPLb4OsPd7Rnx8FPa6hd0BBCcTfHVsFDkNd8uyu0CwAZXasTDbuXYcqSTKFXjfhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066607; c=relaxed/simple;
	bh=RxdiTblO4Wz8Rs154MS5jVm7KrLuUtNHDhYd6LFLef4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTqNu+HJvu5D4G+UKQcR9XRjea6GrjucnfpqooNSe0/+nZr/foAYDn8bS0YXERtUoRwTGPqlLc/3Edz6W1ZiCGxwysg0dIsmSSMGD0qT3Dkw1YTiePvkrN/w+YxrXibXqCnNWd4v2bUmP9p8D5MHmNj7y4INm4T0k3xi9IDeuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsbpnPTg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757066606; x=1788602606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RxdiTblO4Wz8Rs154MS5jVm7KrLuUtNHDhYd6LFLef4=;
  b=MsbpnPTg/cJOcOw/amkWdbwbzhwRfa7+0kSsVNHW7lD3sZPJvFgH9rGr
   zhsxGUj/4FDWv934D+yfupD6g0Ul81NnA0vP3c5mzTdkgLEm1TFhAFlyC
   zN34rZbq4WQbiqrPabDR+MOADp8/hrlnDM2Hdlcr+r6mq1KqEKvmpIRzK
   qcHLBq85oN5iD1B3H9PVrfqyb4xdowbPFqPlYBtt8JtfDOwPpu6u4Th4b
   vh0VJq9+QT1fhfAuiwjzOjAnM5mrBD/MxeuPq6w9PB9Yi8Gnk9cSnhYJO
   XoGVu6fwmMr4+TjDhs/O5kpvGvjegGR9nXFWlE3BHvnwgVY2JI0jM6/Aq
   w==;
X-CSE-ConnectionGUID: YCB4ukQ1Q4KO4NBm2IIDng==
X-CSE-MsgGUID: LPNgNCAmRRSgIZbAQvfYEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59116072"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="59116072"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 03:03:25 -0700
X-CSE-ConnectionGUID: /WCAUJTZRMa83cjGrrr42Q==
X-CSE-MsgGUID: oCD0hlqMSnWO56qky40FDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="172939048"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.151])
  by fmviesa010.fm.intel.com with ESMTP; 05 Sep 2025 03:03:23 -0700
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-i3c@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	stable@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] i3c: Fix default I2C adapter timeout value
Date: Fri,  5 Sep 2025 13:03:20 +0300
Message-ID: <20250905100320.954536-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3a379bbcea0a ("i3c: Add core I3C infrastructure") set the default
adapter timeout for I2C transfers as 1000 (ms). However that parameter
is defined in jiffies not in milliseconds.

With mipi-i3c-hci driver this wasn't visible until commit c0a90eb55a69
("i3c: mipi-i3c-hci: use adapter timeout value for I2C transfers").

Fix this by setting the default timeout as HZ (CONFIG_HZ) not 1000.

Fixes: 1b84691e7870 ("i3c: dw: use adapter timeout value for I2C transfers")
Fixes: be27ed672878 ("i3c: master: cdns: use adapter timeout value for I2C transfers")
Fixes: c0a90eb55a69 ("i3c: mipi-i3c-hci: use adapter timeout value for I2C transfers")
Fixes: a747e01adad2 ("i3c: master: svc: use adapter timeout value for I2C transfers")
Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: <stable@vger.kernel.org> # 6.17
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2:
- Stable Cc'ed just in case. While the incorrect default timeout value was
  introduced back in v5.0 it became visible only due to commits in
  v6.17-rc1 and if CONFIG_HZ != 1000.
- Added Fixes tag for the Renesas I3C controller. Thanks to
  Wolfram Sang <wsa+renesas@sang-engineering.com> for noticing.
- Added Reviewed-by tags from Frank and Wolfram.
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2ef898a8fd80..67a18e437f83 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2492,7 +2492,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	strscpy(adap->name, dev_name(master->dev.parent), sizeof(adap->name));
 
 	/* FIXME: Should we allow i3c masters to override these values? */
-	adap->timeout = 1000;
+	adap->timeout = HZ;
 	adap->retries = 3;
 
 	id = of_alias_get_id(master->dev.of_node, "i2c");
-- 
2.47.2


