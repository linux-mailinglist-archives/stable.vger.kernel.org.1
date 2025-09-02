Return-Path: <stable+bounces-177554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BDB410BA
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 01:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC40270029F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9527283FC5;
	Tue,  2 Sep 2025 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S64MfAA+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAE280328;
	Tue,  2 Sep 2025 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855305; cv=none; b=G+jFYrPPxdGTFs0i49TdJPfmRDGHr2CF7DAI8ssH1F50v3kLPCWG1iZZCBSAdFqb5ZMlHvQFvPLmlK4o/o+7cE0lpcy0M2WxYDioILrn5C5iSTFXuhaNT4B/ia7/PtK5hsORB370IH0E5OOgBSgZXNKOo75xFf4ZQNLZQT9ZbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855305; c=relaxed/simple;
	bh=eJHTysiuWuCUuAWFTXX1H+b70w0tf0jPqoZ8Q6esja4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5m7WqGhRWxge7FXNk87JeD+v7l2HSoxkRkl0o+CPpLWUPhWXJSQZd3P1CeNaWREnQJWGH06+HFEz5VHuNd4tfKqCGK8hpydNo4bT7lB7DMfEnzIaHXODXRSrbxrpM4948ur+uixDrPe7Ubt5v7CiQmdEAD6/DDRxi1u9sTX0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S64MfAA+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756855304; x=1788391304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJHTysiuWuCUuAWFTXX1H+b70w0tf0jPqoZ8Q6esja4=;
  b=S64MfAA+FG8O02xZKQkePIyVndnuxZ573aLMcKinbnDoO+MIMgE7Qzfk
   1t9Nsfj3/qZVCtDBdTnmzRACs35LZdqRtZD9rJ/BYrz6vU3Y26GHOC7YH
   1/Nq/grfCWyqITCJGur/HHmY1dNzUNJ/gHjkpj/KWA03Wl4KdwAXRc/BY
   fuir2Oaaw74YJtcgtEaFrsi3tAESfteXO/83VkYVvt+lo6cfFBbEezQ7/
   ddBGFYZN0uQdyJdGQWrW3JpXiKggeRNpHjk3BXeyzz0ey3mNHLtjylEAB
   rtYHfXVCXuYGL5o2N01B4mnEWIcGipmUUkvlhWdwGwPWgk9j8knJLI/Bz
   A==;
X-CSE-ConnectionGUID: HboCHkbcQMGWTkA4e7rZ+Q==
X-CSE-MsgGUID: v8v1zXBsTe6JT8uZalvjMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69767234"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69767234"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:21:38 -0700
X-CSE-ConnectionGUID: giFR/dEmS+G3Z9w+bcwq4w==
X-CSE-MsgGUID: VAnTp0w1QE2QXiOzzzGHnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171575916"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2025 16:21:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	stable@vger.kernel.org,
	Mikael Wessel <post@mikaelkw.online>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 8/8] e1000e: fix heap overflow in e1000_set_eeprom
Date: Tue,  2 Sep 2025 16:21:28 -0700
Message-ID: <20250902232131.2739555-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
References: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Fix a possible heap overflow in e1000_set_eeprom function by adding
input validation for the requested length of the change in the EEPROM.
In addition, change the variable type from int to size_t for better
code practices and rearrange declarations to RCT.

Cc: stable@vger.kernel.org
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Co-developed-by: Mikael Wessel <post@mikaelkw.online>
Signed-off-by: Mikael Wessel <post@mikaelkw.online>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index c0bbb12eed2e..cf01a108a5bb 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -549,12 +549,12 @@ static int e1000_set_eeprom(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
+	size_t total_len, max_len;
 	u16 *eeprom_buff;
-	void *ptr;
-	int max_len;
+	int ret_val = 0;
 	int first_word;
 	int last_word;
-	int ret_val = 0;
+	void *ptr;
 	u16 i;
 
 	if (eeprom->len == 0)
@@ -569,6 +569,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 
 	max_len = hw->nvm.word_size * 2;
 
+	if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
+	    total_len > max_len)
+		return -EFBIG;
+
 	first_word = eeprom->offset >> 1;
 	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
 	eeprom_buff = kmalloc(max_len, GFP_KERNEL);
-- 
2.47.1


