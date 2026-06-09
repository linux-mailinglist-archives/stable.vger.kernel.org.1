Return-Path: <stable+bounces-262357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9yJPMulPKGoGCAMAu9opvQ
	(envelope-from <stable+bounces-262357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:39:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA7C66305B
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:39:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QeqvpDmY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262357-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262357-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D0123014A01
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED96A4C6EE5;
	Tue,  9 Jun 2026 17:25:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97674360EFF;
	Tue,  9 Jun 2026 17:25:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025906; cv=none; b=WKqIZcidbMFytnmEJR4iJHgoMCD1cMCPJVJy6B+haSSaHaWPa12cTaLVrSwDiCmV+nFrAhYIRh/xAbKn8sKxFD6vI21jOnB9kPiCC/tJ0Npa2zgfjgXKsU0uLytEfSKhe9+u7sxiR5DksfkE53qdzE6wd6Fhh3n368C0gR7CyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025906; c=relaxed/simple;
	bh=7TPgHVPsNGX1ZWVnyuoC8QmFtNFWXcrC4XJRUUQ5tiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIJPxPcext8vS1rI82MWz/nHJ6zTmRsF63iL3agTBgbfGrAXpTJQkHBnYiOHGwM8gG7469plZ+55hSqy6Khgag4iIZIFhcx1Qv/sQdupiMg07gMMre7VRNFrRHYK6PachMAK/Fvzhn7/G0DodOzGGAE+TcTlmEM7826Y3psSs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeqvpDmY; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781025906; x=1812561906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7TPgHVPsNGX1ZWVnyuoC8QmFtNFWXcrC4XJRUUQ5tiA=;
  b=QeqvpDmYBenvOMLTF1nnl/77FX12k5P1jk1xArVjP118WxOnZBSjISWB
   0IW9lHcx+EQAD7okdtXBbcooKWAbqTB5FV3poTrTD9PZM7MOZ83MhmIQ6
   ojjnHEQcBJkgjUWQe3/SoRul0VTwaa3LYU1PshgltDtt86Q68qjiYcpGr
   +37T4z/58mJa6i/lk7X7BTf0C5YCRpJTu3Z4f12tBgaTi/ydSeJ+IuRiw
   Evf7WwOCYzZ9xPe/s9wk5ojA4QO2kAqjOhkUN3kQI/aADEsPcudeb6Hhx
   hCSBMLdCrSs3LuSV70Nx6D9vkkPC8gFGi9LYJ7C3N8TUKrpV2lVRiLPXI
   A==;
X-CSE-ConnectionGUID: xxgOXu3XQ7CmVWq/0TwG6g==
X-CSE-MsgGUID: ShBGWyj9TxC3WzNTbxoZmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99373422"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99373422"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:25:04 -0700
X-CSE-ConnectionGUID: cUUKLbyoR5GvGALLIECMKw==
X-CSE-MsgGUID: MWBeQb/WRvGJL3ELJhCDxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="250995088"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2026 10:25:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	konstantin.ilichev@intel.com,
	willemb@google.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 1/3] idpf: add padding to PTP virtchnl structures
Date: Tue,  9 Jun 2026 10:24:54 -0700
Message-ID: <20260609172458.4046222-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
References: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262357-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:przemyslaw.korba@intel.com,m:anthony.l.nguyen@intel.com,m:richardcochran@gmail.com,m:konstantin.ilichev@intel.com,m:willemb@google.com,m:stable@vger.kernel.org,m:aleksandr.loktionov@intel.com,m:aleksander.lobakin@intel.com,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,google.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAA7C66305B

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

Add padding to virtchnl2 PTP structures to match the Control Plane
expected message sizes:
* virtchnl2_ptp_get_dev_clk_time: 8 -> 16 bytes
* virtchnl2_ptp_set_dev_clk_time: 8 -> 16 bytes
* virtchnl2_ptp_get_cross_time: 16 -> 24 bytes

The FW expects the above sizes and PTP negotiation fails due to the
mismatch. Previously neither the FW nor the driver checked message/reply
sizes strictly, so the problem appeared only after recent validation
improvements.

reproduction steps:
ptp4l -i <pf> -m
Observe: failed to open /dev/ptp0: Permission denied

Fixes: bf27283ba594 ("virtchnl: add PTP virtchnl definitions")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 02ae447cc24a..39fea65c075c 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -1572,13 +1572,15 @@ VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_vport_tx_tstamp_latches);
  * struct virtchnl2_ptp_get_dev_clk_time - Associated with message
  *					   VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME.
  * @dev_time_ns: Device clock time value in nanoseconds
+ * @pad: Padding for future extensions
  *
  * PF/VF sends this message to receive the time from the main timer.
  */
 struct virtchnl2_ptp_get_dev_clk_time {
 	__le64 dev_time_ns;
+	u8 pad[8];
 };
-VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_get_dev_clk_time);
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_dev_clk_time);
 
 /**
  * struct virtchnl2_ptp_get_cross_time: Associated with message
@@ -1586,26 +1588,30 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_get_dev_clk_time);
  * @sys_time_ns: System counter value expressed in nanoseconds, read
  *		 synchronously with device time
  * @dev_time_ns: Device clock time value expressed in nanoseconds
+ * @pad: Padding for future extensions
  *
  * PF/VF sends this message to receive the cross time.
  */
 struct virtchnl2_ptp_get_cross_time {
 	__le64 sys_time_ns;
 	__le64 dev_time_ns;
+	u8 pad[8];
 };
-VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_cross_time);
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_get_cross_time);
 
 /**
  * struct virtchnl2_ptp_set_dev_clk_time: Associated with message
  *					  VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME.
  * @dev_time_ns: Device time value expressed in nanoseconds to set
+ * @pad: Padding for future extensions
  *
  * PF/VF sends this message to set the time of the main timer.
  */
 struct virtchnl2_ptp_set_dev_clk_time {
 	__le64 dev_time_ns;
+	u8 pad[8];
 };
-VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_set_dev_clk_time);
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_set_dev_clk_time);
 
 /**
  * struct virtchnl2_ptp_adj_dev_clk_fine: Associated with message
-- 
2.47.1


