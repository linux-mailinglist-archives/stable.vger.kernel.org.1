Return-Path: <stable+bounces-52198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F6908CEF
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4266E1C25DF6
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD38BE7;
	Fri, 14 Jun 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPMvBqYX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634A8489
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373747; cv=none; b=o3D4SB5UoAi6RQ38FjovF7hqWhVL5SDlGtZM1ozOkohnNESQAbxiEXpJaPw9IMd8Qr8nGRgmOIfrTvY/XTyLvNNziJgYB3sVs6zLGL5wNWKlB35tzKON+6hUfvg6CPda+a+R+mxI7yYVFCfjmZkcfOhuKcBMt+V+qoqUMM1bKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373747; c=relaxed/simple;
	bh=s6xRNmCCbSgnBkdiDlasSc+/0KaX3EhVizmJHdtpVZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kz/S5NR0HXjGce1zL0P2eX6vMQ+Wo2Rcn6tFR9y2l2hsKyxfKFDL5MHLHB2L7pvOB5aT+2fyiNqfIV9p4Kup5hZvpkXDF7tE46D5RC3gkuwsC1ds9wrLxSQbv1QAK60DEM2xsItGUOzuECUMr4tWBmeI6s8N4W+AkVLpiTEesr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPMvBqYX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718373746; x=1749909746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s6xRNmCCbSgnBkdiDlasSc+/0KaX3EhVizmJHdtpVZs=;
  b=LPMvBqYX6p1ajQRPmX6acTpON+DjL9MhPpZqCp5TkOw4Bjt7i1kL0K/a
   EEUo/orQMsfSF84+nXGYHDhxxKYgoV7wBO7Zd1rcKg8W5OmnxhGDe4KzU
   GRu3xlwtytmJxRAFE0+wYSsCGAI7KyLm3pvN3sGLrXtLtfKaXzuTEmV7H
   VH5I2Y4oK3Ws51e+s8x1YzV+Xq6V7bn6B8sDsOBJmdIZOIFbYHRkuR1xZ
   ZxkZ9UhpgXDp7qk6fliVMGhVKkoE38xzW1Q7QeT3ewTv06V+YwwEtoJUK
   vTU4XKhOBIPId1nc3Su8QZsyfeQJQJYJ9Ni240LLt1TYTncCl5Cn2vJzi
   Q==;
X-CSE-ConnectionGUID: /+3crLk9QQ+hfz38IKbKoA==
X-CSE-MsgGUID: S2uGpEoYQ+aJv8T8kVeJ8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15040036"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15040036"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:02:16 -0700
X-CSE-ConnectionGUID: Ggwpxcd2T86SJqIhiQgj8w==
X-CSE-MsgGUID: uA3qFTeERPeyE9d6Q1Egiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45622567"
Received: from ehlflashnuc2.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.57])
  by orviesa004.jf.intel.com with ESMTP; 14 Jun 2024 07:02:14 -0700
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-i3c@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	stable@vger.kernel.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI versions < 1.1
Date: Fri, 14 Jun 2024 17:02:08 +0300
Message-ID: <20240614140208.1100914-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was wrong about the TABLE_SIZE field description in the
commit 0676bfebf576 ("i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes").

For the MIPI I3C HCI versions 1.0 and earlier the TABLE_SIZE field in
the registers DAT_SECTION_OFFSET and DCT_SECTION_OFFSET is indeed defined
in DWORDs and not number of entries like it is defined in later versions.

Where above fix allowed driver initialization to continue the wrongly
interpreted TABLE_SIZE field leads variables DAT_entries being twice and
DCT_entries four times as big as they really are.

That in turn leads clearing the DAT table over the boundary in the
dat_v1.c: hci_dat_v1_init().

So interprete the TABLE_SIZE field in DWORDs for HCI versions < 1.1 and
fix number of DAT/DCT entries accordingly.

Fixes: 0676bfebf576 ("i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index faf723a0c739..0ff3055b8e78 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -646,6 +646,7 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
 static int i3c_hci_init(struct i3c_hci *hci)
 {
 	u32 regval, offset;
+	bool size_in_dwords;
 	int ret;
 
 	/* Validate HCI hardware version */
@@ -670,11 +671,16 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	hci->caps = reg_read(HC_CAPABILITIES);
 	DBG("caps = %#x", hci->caps);
 
+	size_in_dwords = hci->version_major < 1 ||
+			 (hci->version_major == 1 && hci->version_minor < 1);
+
 	regval = reg_read(DAT_SECTION);
 	offset = FIELD_GET(DAT_TABLE_OFFSET, regval);
 	hci->DAT_regs = offset ? hci->base_regs + offset : NULL;
 	hci->DAT_entries = FIELD_GET(DAT_TABLE_SIZE, regval);
 	hci->DAT_entry_size = FIELD_GET(DAT_ENTRY_SIZE, regval) ? 0 : 8;
+	if (size_in_dwords)
+		hci->DAT_entries = 4 * hci->DAT_entries / hci->DAT_entry_size;
 	dev_info(&hci->master.dev, "DAT: %u %u-bytes entries at offset %#x\n",
 		 hci->DAT_entries, hci->DAT_entry_size, offset);
 
@@ -683,6 +689,8 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	hci->DCT_regs = offset ? hci->base_regs + offset : NULL;
 	hci->DCT_entries = FIELD_GET(DCT_TABLE_SIZE, regval);
 	hci->DCT_entry_size = FIELD_GET(DCT_ENTRY_SIZE, regval) ? 0 : 16;
+	if (size_in_dwords)
+		hci->DCT_entries = 4 * hci->DCT_entries / hci->DCT_entry_size;
 	dev_info(&hci->master.dev, "DCT: %u %u-bytes entries at offset %#x\n",
 		 hci->DCT_entries, hci->DCT_entry_size, offset);
 
-- 
2.43.0


