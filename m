Return-Path: <stable+bounces-248889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAjtEillB2q90wIAu9opvQ
	(envelope-from <stable+bounces-248889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6E5556268
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89D1E300BC6C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22BE279DC8;
	Fri, 15 May 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEro1RCq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41730C159;
	Fri, 15 May 2026 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869469; cv=none; b=JK4Q3XlBV6OhXkst+PqmI+DllC5ackJo62gDSfYS7ApyVsNgRlIEBSlKh1Q4jSdNgtS8wkQWlqNMNDXUAzsmaPB1JQwFIfSmvEA5gPvv0kUV3sNteOwLjPpCBpqcQr+PUX8IwUGKAV+tyEaeclMraL3uIZ+n2c+QNo5TOWqGRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869469; c=relaxed/simple;
	bh=LyKZ2z30aE3ZSSS25borKcqKeKRuAYHU3frRhdizxHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrwLUGYVTBzFS+6dFLGg0/aAykNuBYXyJ5KUj4anLvy6A3BXfBZX983ei/QdvdnqUX3nexF8015b3l3+719vbCxiLT2DdZL86clKsubOKjHzkMbKHlUy2eE+v6mi/BjCcHeqLuwE4iwGohDHga/cMSuXVHKFUk1jaF7xU6a5/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEro1RCq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869468; x=1810405468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LyKZ2z30aE3ZSSS25borKcqKeKRuAYHU3frRhdizxHs=;
  b=WEro1RCqU+IyeHuZmpSXMedDPsvr03Xa0gfhw6Jwsb07Rv0hCZ5OHRCb
   67r110FwWavK9RXpt7k3ALyR7LCl4t/XcQGqthTlwuO56KUdsRPMNAS3B
   K/8e1VqrQ8kufQxtxnJfMHLwvi5VMIS3vrTAjlaur4ENvrSpIbx26umPS
   fmsuVbeiHQwIoab+gj2+0LcWOc73DIkEsJbKlwTVlQgCVsjZErFd63d6U
   xpkjC9fxC99C6dIizCTXBIsQijH5Pqr+Qpv1F5I29HYtb4SB/hrqykc0k
   D5s7Pa8ebBs59FtsJx7xhhziGnVnDinIGn+QZaM4IVzq3K/CBiv5/XuIH
   g==;
X-CSE-ConnectionGUID: uQI+nqJFSCyx38xrgAdpsA==
X-CSE-MsgGUID: 8yiUr7+1Sv697of1wg7C4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83701126"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83701126"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:26 -0700
X-CSE-ConnectionGUID: b7l3EYEHSGu+cqgfdH6psQ==
X-CSE-MsgGUID: vhVgTO5XT3KtfSj683q9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238647435"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2026 11:24:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 01/10] ice: fix locking around wait_event_interruptible_locked_irq
Date: Fri, 15 May 2026 11:24:08 -0700
Message-ID: <20260515182419.1597859-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
References: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D6E5556268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248889-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 50327223a8bb ("ice: add lock to protect low latency interface")
introduced a wait queue used to protect the low latency timer interface.
The queue is used with the wait_event_interruptible_locked_irq macro, which
unlocks the wait queue lock while sleeping. The irq variant uses
spin_lock_irq and spin_unlock_irq to manage this. The wait queue lock was
previously locked using spin_lock_irqsave. This difference in lock variants
could lead to issues, since wait_event would unlock the wait queue and
restore interrupts while sleeping.

The ice_read_phy_tstamp_ll_e810() function is ultimately called through
ice_read_phy_tstamp, which is called from ice_ptp_process_tx_tstamp or
ice_ptp_clear_unexpected_tx_ready. The former is called through the
miscellaneous IRQ thread function, while the latter is called from the
service task work queue thread. Neither of these functions has interrupts
disabled, so use spin_lock_irq instead of spin_lock_irqsave.

Fixes: 50327223a8bb ("ice: add lock to protect low latency interface")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20250109181823.77f44c69@kernel.org/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 24fb7a3e14d6..672218e5d1f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4503,18 +4503,17 @@ static int
 ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 {
 	struct ice_e810_params *params = &hw->ptp.phy.e810;
-	unsigned long flags;
 	u32 val;
 	int err;
 
-	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
+	spin_lock_irq(&params->atqbal_wq.lock);
 
 	/* Wait for any pending in-progress low latency interrupt */
 	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
 						  !(params->atqbal_flags &
 						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
 	if (err) {
-		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		spin_unlock_irq(&params->atqbal_wq.lock);
 		return err;
 	}
 
@@ -4529,7 +4528,7 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 				       REG_LL_PROXY_H);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
-		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		spin_unlock_irq(&params->atqbal_wq.lock);
 		return err;
 	}
 
@@ -4539,7 +4538,7 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 	/* Read the low 32 bit value and set the TS valid bit */
 	*lo = rd32(hw, REG_LL_PROXY_L) | TS_VALID;
 
-	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+	spin_unlock_irq(&params->atqbal_wq.lock);
 
 	return 0;
 }
-- 
2.47.1


