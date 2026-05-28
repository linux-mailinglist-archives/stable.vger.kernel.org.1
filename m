Return-Path: <stable+bounces-255657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFfBNFGlGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:28:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 635105F8C0D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EBEA327A916
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206222D9787;
	Thu, 28 May 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0ahdL23"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB3282F17;
	Thu, 28 May 2026 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999527; cv=none; b=OvR5yTW1q0AG7y2jOEaLCSdQyZPhfHSnKBXWBczJg90iYqTTi6VgiJMm2457hzGbkd47/H946gvsW2qP/MPDt1F9WCe1euCHTWHjiv809YjoIywJ6zxf0o4/HRddhX4uTfLtz98zq8/Iw3ADnqJsm9ROHNBUjBxCNTuQxL1WS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999527; c=relaxed/simple;
	bh=xAnyZGpvtd4iV5qY3URsr6GVNdraHpwBYSXvq/ozjfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R14mo5MCyDlyldeWgpzxzsrJMSNTv5IcaXb1jMOatHIkLx7NqOKOwsM1H47+FA+1cifPbUijQVst0j67Picy+bsiDSwSHptBgZjv8A5MXbfEcHbABGBPcVDRwk9aeCvEZrW0iSRziri4R2FmJAw5yFmsGjckYG0ntR5uP5zMhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0ahdL23; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1871F000E9;
	Thu, 28 May 2026 20:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999526;
	bh=mvbfZOUHxTfpey03pQQ/e+oYnG+rR1l9fDfhJwFOeng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0ahdL23nlgAE9BoCsOI/jNNbDiBxBUqlgQ7nvznQ7T+MAxTmAC2RebAS3/CZ+r0I
	 Uyu2BAUSKaXJ6JXNvwBzQAxGDHzec5RcXbNxt7jv6KJLth2udlErCMEpIgGhPzMkja
	 qfl0peZgpGir2bZkWosx2fY313tuJkQeRUY3iwQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH 6.18 098/377] ice: fix locking around wait_event_interruptible_locked_irq
Date: Thu, 28 May 2026 21:45:36 +0200
Message-ID: <20260528194641.190577817@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255657-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 635105F8C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

commit 89bbff099bfc94888eb942d5b981592bbbe0c856 upstream.

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
Link: https://patch.msgid.link/20260515182419.1597859-2-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

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
 
@@ -4529,7 +4528,7 @@ ice_read_phy_tstamp_ll_e810(struct ice_h
 				       REG_LL_PROXY_H);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
-		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		spin_unlock_irq(&params->atqbal_wq.lock);
 		return err;
 	}
 
@@ -4539,7 +4538,7 @@ ice_read_phy_tstamp_ll_e810(struct ice_h
 	/* Read the low 32 bit value and set the TS valid bit */
 	*lo = rd32(hw, REG_LL_PROXY_L) | TS_VALID;
 
-	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+	spin_unlock_irq(&params->atqbal_wq.lock);
 
 	return 0;
 }



