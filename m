Return-Path: <stable+bounces-254110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ/MDWULFGr6JAcAu9opvQ
	(envelope-from <stable+bounces-254110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:42:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 232405C7EDC
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A2C53006164
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894E3E3C79;
	Mon, 25 May 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2SmpWiw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A73E16B9;
	Mon, 25 May 2026 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698522; cv=none; b=tpHyglNODZzDzaWbwkN5xMrY3ZOyWFeTJiBlQ9apXAyz/97xz8qebHuqs+2zY1fO2Aocgu83uw7i/hx2kGl1DUDWatPB8v52w0xdCBdf/tjhiiFVdjBWIbF5psNDwIM7fBOqruxyN0iVijwXw1sdlCqH6Dzte7MX4DoN12rmiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698522; c=relaxed/simple;
	bh=rhZeCAfuClKv/Mu8IFHZ3hmztx6GzmMheK7IXKONEDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZm82wG1iLYjBg7F7Ji4nMAxm12qFjUQtO312DE7C11pAdNO0E0I+h2I0BZpq8jb6hl4mn/IwFzEHHPtLdwGZ2xDgV/BgErSru6YtJcZmWvE28C1U6ysKqE7FwIQSKicvHc4gGBtSdTYyp+tEqjBPCg0bKWbO01h2D7Jecj+1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2SmpWiw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779698521; x=1811234521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rhZeCAfuClKv/Mu8IFHZ3hmztx6GzmMheK7IXKONEDg=;
  b=M2SmpWiwM0cva0+rg4A5dkAa2cbJj3/y/7i8Bp/Zft2MFu1Dgj58ZVPB
   ZzmXK+BJwKpqKVF8Xdv6oTTdT6PO/czOy54/JfrtCFI6u90NQrCCZXmIf
   zYLk6JsJFu5gL7D4YVJtJWNI7DA6VlnMHTUptf6cb6rh52WZhAkrlE6Js
   QVcu0vYCpViR4gJV+qsXNqvL+3sVWgVItGH4oOFzLqURDRtpKwxobUCmD
   ViP6CA8Y3p1zKSNUcJ3uFWVE2JV9kHTcHvNAEnQW+2Ibn+ATd7xXWbdRR
   b4q8/mUgysmxuKB2oj3xkLjQ15IhMv/f5hHLqRQxEubsxLltCpnGkw6UR
   Q==;
X-CSE-ConnectionGUID: QPFixwk6RUioEcpzYnBNmQ==
X-CSE-MsgGUID: BWfETJeEQDiq0BhpT3n0Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80573297"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="80573297"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:42:01 -0700
X-CSE-ConnectionGUID: kyp2uXDUTJ6ArQirl/1Tzw==
X-CSE-MsgGUID: V03PED3bTZuB4SL2IOJGfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="238968451"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
  by fmviesa008.fm.intel.com with ESMTP; 25 May 2026 01:41:58 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	konstantin.ilichev@intel.com,
	aleksander.lobakin@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] idpf: add padding to PTP virtchnl structures
Date: Mon, 25 May 2026 10:38:03 +0200
Message-ID: <20260525083835.481974-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254110-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 232405C7EDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

base-commit: 4548d565aa80aad80274e2f3bff4d7cd914c703e
-- 
2.47.3


