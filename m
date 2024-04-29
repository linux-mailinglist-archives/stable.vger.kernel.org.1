Return-Path: <stable+bounces-41753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F378B5FB6
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1AD1C2189D
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075FB8662B;
	Mon, 29 Apr 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQEbmlSW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4631147A5C;
	Mon, 29 Apr 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410649; cv=none; b=TTfoWx1k1wbuUQZDnClSrNJnSJ58dwDyVv2gLPDJukG3MnZmokfoSOdHT4PG+K18W9jlSOA2ntjigWMbB4qaK/syM9VBDGTJX32Ulo+A3KpB31vbcNAMcOqSxdJ7pHEQUNn+w30oLrZ2G9237ww6ItS5400RwHAszV5fmVFP6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410649; c=relaxed/simple;
	bh=WKdk6WwgPqc2YoANVbL2/w23zvFWOoCOfZ03rXJUwiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EI82BwUXAzq0REHJnJ6Zw8oJsNPoVLzFq0rT337lEaVzv26OFtxJ2tCmJvw7VpKR0gUhV8JsbUVXUymM55/Olqj9r0vuuR/mXRTF2iHeHytTewO8owvBLgKvCOyLyllwLvXQQmslVMGqCEfWhg53lM+bm0kq6dcEjleRYbSfUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQEbmlSW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714410647; x=1745946647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WKdk6WwgPqc2YoANVbL2/w23zvFWOoCOfZ03rXJUwiE=;
  b=VQEbmlSWU047JzvVCLY6f0shtYqCbVAz2gDAWj2C9jR2/sSXSNi2U0bW
   bGv7/vmclDZ8Ln47TPv6jsTIsv9Q8uxkrXPuq1RTd0ssO76Tus7bRbZGP
   o0L/5LIC8I/DdHHFH9OnJRT06KIm3UOtX6DJbN0QbHFucI06It0KsTFES
   Mj6/cx7eq48EG5eTs70+nWTDCVtqNfuKlZco0DVCSGED0FtLUwq1f46WM
   9LJvjDhckZfLy1ZTASq66jxXGR2+EIRLLEF9HooKeKCPNnm2Zr0GJgwW5
   de65WFHFFsFL4JJdT6xCcN5lDb9e2sQozQTqnxB6pppOHHZyzTmVAQeh7
   g==;
X-CSE-ConnectionGUID: 6b9TkGKGQGyUbfWQClWORQ==
X-CSE-MsgGUID: gXRQySm3RoilEhCmZQ8Cew==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13909560"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="13909560"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 10:10:46 -0700
X-CSE-ConnectionGUID: Nuo6ZQFPSsul+fuSL7vKIw==
X-CSE-MsgGUID: VKUvT9ANRqmsO2/og0S4uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26788735"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 29 Apr 2024 10:10:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	regressions@leemhuis.info,
	stable@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Carretero?= <cJ@zougloub.eu>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: [PATCH net] e1000e: change usleep_range to udelay in PHY mdic access
Date: Mon, 29 Apr 2024 10:10:40 -0700
Message-ID: <20240429171040.1152516-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

This is a partial revert of commit 6dbdd4de0362 ("e1000e: Workaround
for sporadic MDI error on Meteor Lake systems"). The referenced commit
used usleep_range inside the PHY access routines, which are sometimes
called from an atomic context. This can lead to a kernel panic in some
scenarios, such as cable disconnection and reconnection on vPro systems.

Solve this by changing the usleep_range calls back to udelay.

Fixes: 6dbdd4de0362 ("e1000e: Workaround for sporadic MDI error on Meteor Lake systems")
Cc: stable@vger.kernel.org
Reported-by: Jérôme Carretero <cJ@zougloub.eu>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218740
Closes: https://lore.kernel.org/lkml/a7eb665c74b5efb5140e6979759ed243072cb24a.camel@zougloub.eu/
Co-developed-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 93544f1cc2a5..f7ae0e0aa4a4 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -157,7 +157,7 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 		 * the lower time out
 		 */
 		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-			usleep_range(50, 60);
+			udelay(50);
 			mdic = er32(MDIC);
 			if (mdic & E1000_MDIC_READY)
 				break;
@@ -181,7 +181,7 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 		 * reading duplicate data in the next MDIC transaction.
 		 */
 		if (hw->mac.type == e1000_pch2lan)
-			usleep_range(100, 150);
+			udelay(100);
 
 		if (success) {
 			*data = (u16)mdic;
@@ -237,7 +237,7 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
 		 * the lower time out
 		 */
 		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-			usleep_range(50, 60);
+			udelay(50);
 			mdic = er32(MDIC);
 			if (mdic & E1000_MDIC_READY)
 				break;
@@ -261,7 +261,7 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
 		 * reading duplicate data in the next MDIC transaction.
 		 */
 		if (hw->mac.type == e1000_pch2lan)
-			usleep_range(100, 150);
+			udelay(100);
 
 		if (success)
 			return 0;
-- 
2.41.0


