Return-Path: <stable+bounces-52375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17D90AD06
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6566E1C2268B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53775194A73;
	Mon, 17 Jun 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqGKU2NS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A09191461
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623980; cv=none; b=aBZsP6uZ6aMezTfU0338CCtkweCYiJvVeG8C3Ddtuv3/98glu7Q54dZqi8wcwK32qlzL0TAZcWgvFAcwldHaZ17Sd5eBNd+q9e5hrADS96QLMjixmFwFN9nAm7yMTqxefUD/LGOr+83G+i7QKT3icoL9D7iuKsXjxWAVPKPKuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623980; c=relaxed/simple;
	bh=Um1unrEpih4RsdNp/FkQUuZ18mOrO0zcEBS1C4T9egQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1PJcmGSYQI/EnQpJFiBMWl54N1Jde7KN8MIiDU5bXK8rbTdOWPrurUIo5+zFwQjsfPI5mdRHKnGoG7+ONaIF/fkmdnd+qj9R/fGK/kOje/pSScRHbAp6286R20FslqwH2Fknj49PKLk/Rz/R2zJcgMVKzU6phVLtHLZl93CmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqGKU2NS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718623978; x=1750159978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Um1unrEpih4RsdNp/FkQUuZ18mOrO0zcEBS1C4T9egQ=;
  b=fqGKU2NSTWIlJHo7sEiyq/TEZMq5wLXNQBwnE0L3DFxuco+xN/WgSQjm
   nNzW0On30zXkU5cR9FaMLp4vPPQZLkoSnYKR9SCdUE+F5WPd/Qi1cQbZ7
   MsqFNlonpGaIdJCCnspwmtDAZUkHgCUarEPUdnMZY1yuLELXxRkToD57V
   i3u6lEAiCQtEUv2+aeADBFzOx2kTjSFM30J8QwWo2qD01p+A7aWchrByQ
   TzoxWCvGe/Rb33CwpjoyKfXg1KTazs53vtTH8Or3mPtrrow1XjI77x/8Z
   7kKYRWQn/2cPbknFiWAkpy88yNffygWh/5awjn1Wt+/EEQY4KZyVpAnMc
   w==;
X-CSE-ConnectionGUID: dbGo98N9RXiXgRSuBPdBJw==
X-CSE-MsgGUID: p8cDBc33R72ZVRDq/REePA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="40857575"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="40857575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 04:32:58 -0700
X-CSE-ConnectionGUID: ny2rQ4Y7QauXrj9Aba8Tpw==
X-CSE-MsgGUID: iMA1W/G1QQqIB8TaJf0K/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="45534347"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.151])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jun 2024 04:32:56 -0700
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-i3c@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI versions < 1.1
Date: Mon, 17 Jun 2024 14:32:51 +0300
Message-ID: <20240617113251.1159534-1-jarkko.nikula@linux.intel.com>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
v2: Added Cc: stable tag which I forgot in v1.
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index d7e966a25583..4e7d6a43ee9b 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -631,6 +631,7 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
 static int i3c_hci_init(struct i3c_hci *hci)
 {
 	u32 regval, offset;
+	bool size_in_dwords;
 	int ret;
 
 	/* Validate HCI hardware version */
@@ -654,11 +655,16 @@ static int i3c_hci_init(struct i3c_hci *hci)
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
 
@@ -667,6 +673,8 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	hci->DCT_regs = offset ? hci->base_regs + offset : NULL;
 	hci->DCT_entries = FIELD_GET(DCT_TABLE_SIZE, regval);
 	hci->DCT_entry_size = FIELD_GET(DCT_ENTRY_SIZE, regval) ? 0 : 16;
+	if (size_in_dwords)
+		hci->DCT_entries = 4 * hci->DCT_entries / hci->DCT_entry_size;
 	dev_info(&hci->master.dev, "DCT: %u %u-bytes entries at offset %#x\n",
 		 hci->DCT_entries, hci->DCT_entry_size, offset);
 
-- 
2.43.0


