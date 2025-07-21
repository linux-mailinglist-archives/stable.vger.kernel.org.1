Return-Path: <stable+bounces-163620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF7B0C9CE
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 19:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9032A542501
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B72E266A;
	Mon, 21 Jul 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw4aBZjv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275E2E1C5B;
	Mon, 21 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119466; cv=none; b=lN4MABnZ4S1lsdIpIK3W3bG7Ho49AEyk9iOylQ6xh39E+sIGMb+wxT6f4eGvXL1DwfnQi67f/aOTFfcHtB+iEV6IFZUZ1y3nGy5TDTTKr+/YF4KjkUTVgZBWDODziFReN4kT3avlpkig37OireHW5oiTCwOa5kuXorLeEgXLUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119466; c=relaxed/simple;
	bh=T5RNBA25Utm0EodcHragTzQ4AVFGBMYFJF6+tSb1uIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSzAiLcO7Kjpd09Dx0AXf6RmdvsIxJVdEVRU6MYCwQ43CmBJu7mwCWrlJnCAAXK/2HNe1uIvoQqggFCc0uSQatzGctyFLrEhllNFIz+7o18A1+BYbiUbz2wkhmQnYpgo4iQ4YpsJLvNbZDuv30Xk/3lG8mz7EmtF4syej+NtzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw4aBZjv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753119465; x=1784655465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T5RNBA25Utm0EodcHragTzQ4AVFGBMYFJF6+tSb1uIk=;
  b=iw4aBZjv1IEhgOI0liQMiRaayQCHC0SaiVSXluO79E0XsY/54c4qty71
   Y7PRoRqp918G+9bHnQE9c6x3G8W8LibQi7PLhZ1p8p9F/UfRnDvoFTfhP
   FRpDlp0rGJQQHYBnTfIRUTHXQaqWWIHLcOC9F0O9ZoM0SVl22AZMhP5NC
   SYUP+jdXzUkqUlsCL9qhV+ibi8Mf11XMhw7N0x2XNvUmnddCPKAJuqYuP
   SOIVO0WczS01gPZYZlo7Gj4xmBQpSLCI5i9KkUi0X1nhsAXQXLQW7AUu8
   r3Xv63QqtlKR2IGN4HYHaYudRpl0EFVYafjeR6mTlHiaFEzxdswriN+Dq
   Q==;
X-CSE-ConnectionGUID: zrzrtmNtTUWEfz+Q7qSDyA==
X-CSE-MsgGUID: 6T0NF4VhTZuZw9GKN75GxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55193205"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55193205"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:37:42 -0700
X-CSE-ConnectionGUID: Y1rp7k9SRPezajMrYHu+WA==
X-CSE-MsgGUID: nRBZLFP5TXC2Heig9Umt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158231574"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 21 Jul 2025 10:37:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacek Kowalski <jacek@jacekk.info>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	horms@kernel.org,
	Vlad URSU <vlad@ursu.me>,
	stable@vger.kernel.org,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 5/5] e1000e: ignore uninitialized checksum word on tgp
Date: Mon, 21 Jul 2025 10:37:26 -0700
Message-ID: <20250721173733.2248057-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
References: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacek Kowalski <jacek@jacekk.info>

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set.

Unfortunately some systems have left the factory with an uninitialized
value of 0xFFFF at register address 0x3F (checksum word location).
So on Tiger Lake platform we ignore the computed checksum when such
condition is encountered.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Tested-by: Vlad URSU <vlad@ursu.me>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h | 3 +++
 drivers/net/ethernet/intel/e1000e/nvm.c     | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 8294a7c4f122..ba331899d186 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -638,6 +638,9 @@
 /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
 #define NVM_SUM                    0xBABA
 
+/* Uninitialized ("empty") checksum word value */
+#define NVM_CHECKSUM_UNINITIALIZED 0xFFFF
+
 /* PBA (printed board assembly) number words */
 #define NVM_PBA_OFFSET_0           8
 #define NVM_PBA_OFFSET_1           9
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index e609f4df86f4..16369e6d245a 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -558,6 +558,12 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
+	if (hw->mac.type == e1000_pch_tgp &&
+	    nvm_data == NVM_CHECKSUM_UNINITIALIZED) {
+		e_dbg("Uninitialized NVM Checksum on TGP platform - ignoring\n");
+		return 0;
+	}
+
 	if (checksum != (u16)NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
-- 
2.47.1


