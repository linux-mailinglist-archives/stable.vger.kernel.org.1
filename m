Return-Path: <stable+bounces-248892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFmeIr9lB2qE1gIAu9opvQ
	(envelope-from <stable+bounces-248892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:28:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96891556352
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AC8E301905A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBBA3E168E;
	Fri, 15 May 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtktzCkH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C36448B384;
	Fri, 15 May 2026 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869472; cv=none; b=poRqa89OyYUv5DOBAVX4BhKc1recahp2mF/q93ycjQnlAUX0KUDaWORoF4iyxNoz1b5UzK8FWl7jhk+DRLmiqctKgTYvAuW7WVdoa5oCJiwuP5mskuymSFFXHidONlBLIYMdcHBbs9cMwvUxPkoPTywQXcRD5kCAS0ae7rJkrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869472; c=relaxed/simple;
	bh=t1ui3N42GK4rpNlMUOHOo/aHpZOPkCXxpeKRbVMguGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+QZ2vUAM+p1lCle5fGV1w0suUtp8KpNZJRMwmb8ExENFN2ljCHBji9wA/wwWGdFGaNI2Wgys0A6Ia/t0QQ3WiNTbu9gvuisENUvcFNjCFJhrbVJzVFbGTVx6yoU5DzyEXoUfuMMc1+TlEFXAUIyoPAlV2Le8UY/K7z/rhd06V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtktzCkH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869471; x=1810405471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t1ui3N42GK4rpNlMUOHOo/aHpZOPkCXxpeKRbVMguGU=;
  b=CtktzCkHz159KOhuuM82D1MEm7Ioow/n+Q6Semio2dGPqK5wzfPW6PTf
   dmIGK4DLkPTeTNvC61ZqUdpp36I9ML8xQCPjf1v6dFbqHPgAbjXaPmLB2
   Trm77dWS7XoKK1m6GWVquKpGBEDiPkWE0coiFOdenxzJfj3MeAO7ZEpjY
   WBGtV4d+N1ck2h/rG8nPsjMbOCWydRVAQufFHMS8mOWEuf3JSc6/jmy6N
   2WI1a4DwT9J8DXoF6nKYpKP43wqgfhNe20iW9vkonHfDUAPHSE5JVU3yY
   Wtx/qbryMbnhpQbX8gCshBYnxmPgKwFNPJkV4YNFFSxiBU4p6+RnLHuCL
   g==;
X-CSE-ConnectionGUID: 68zgAXeCQxuIF0tj3XjbBg==
X-CSE-MsgGUID: 9L92UCCvQwmW7//55zofzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83701161"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83701161"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:27 -0700
X-CSE-ConnectionGUID: eirs/03oTbiChxOlfjLLBA==
X-CSE-MsgGUID: 4OWmHIR5SjivTXGkmj/i/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238647451"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2026 11:24:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 06/10] ice: restore PTP Rx timestamp config after ethtool set-channels
Date: Fri, 15 May 2026 11:24:13 -0700
Message-ID: <20260515182419.1597859-7-anthony.l.nguyen@intel.com>
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
X-Rspamd-Queue-Id: 96891556352
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
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248892-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

When ethtool -L changes queue counts, ice_vsi_recfg_qs() closes and
rebuilds the VSI, reallocating Rx rings. The newly allocated rings have
ptp_rx cleared, so RX hardware timestamps are no longer attached to skb
until hwtstamp configuration is applied again.

Restore timestamp mode after ice_vsi_open() in the queue reconfiguration
path, matching reset/rebuild behavior and ensuring newly rebuilt Rx rings
have PTP RX timestamping re-enabled.

Testing hints:
- run ptp4l application in client synchronization mode:
	 ptp4l -i ethX -m -s
- run PTP traffic
- change queue number on ethX netdev interface:
	ethtool -L ethX combined new_queue_size
- observe ptp4l output
- expected result: no "received DELAY_REQ without timestamp" messages

Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 66642232b282..e2fbe111f849 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4104,6 +4104,12 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 	}
 	ice_pf_dcb_recfg(pf, locked);
 	ice_vsi_open(vsi);
+	/* Rx rings are reallocated during VSI rebuild and lose their ptp_rx
+	 * flag. Restore timestamp mode so newly allocated rings are set up
+	 * for hardware Rx timestamping.
+	 */
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
+		ice_ptp_restore_timestamp_mode(pf);
 	goto done;
 
 rebuild_err:
-- 
2.47.1


