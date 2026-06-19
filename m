Return-Path: <stable+bounces-267415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 86dzBnNaNWoxtwYAu9opvQ
	(envelope-from <stable+bounces-267415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:04:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4B6A6915
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hyi2TgTc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267415-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267415-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3BE930059A4
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633C3A254A;
	Fri, 19 Jun 2026 15:04:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08C2B9BA;
	Fri, 19 Jun 2026 15:04:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881454; cv=none; b=oBHs2tyGSg29iFftOnd7MXaqT3dCw09aoVNrYmeiPGeDaqWYLRe4l+ELOpwGEnBHguY7Y4kHyprTqAopCbg6mgBvkCGFB82kjewHUt2BS2+Wninmc0YvZfR5Tg9QTQ+bn+x+0MmweTQ+jE09GACdw6iukMjeg1HVYUMHOFbjAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881454; c=relaxed/simple;
	bh=lmThtTde8A2kexr9X/ktffpNfffqiuw7oczNDBREhOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPCsZr7W1VN4L4hpTpncpGSSin9aU8xG8wV75DOawn2tsRJ2mfeG/tVDCG4OlSBCF6s3sd7+Q7sKppRT7A+C0BRR4FtOXvh2FVNs+hWZVoujgQrft+9DIU5XB2XRc8CD3jqJioXvmjD+1IItyfkxnrULV85XVoWRbpFzbP+CO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyi2TgTc; arc=none smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781881453; x=1813417453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lmThtTde8A2kexr9X/ktffpNfffqiuw7oczNDBREhOQ=;
  b=hyi2TgTcaCo/Kx1urDBoZlfJZoEWDJOjygkMBsn3CuZ5YPNBdfxP1Vcy
   7Sh2q3vnkdrN5RONS4x+UJ4hJ5H9Nfce4J8hlwHyEXFkIgYP8VDN8fjVd
   HY6KT4iqUuCru83oGxYf5rgFlOJRoX9eADpqMhglwt69RwwONloP5cdWm
   ghEe2x6DF39mecziXuDhtwGHJyHnk3z0KZN18XtD5waYMIUS/ScxHDERo
   qtKphbTAdb7RCiBNrjdf4CrjZtrEuZrxDaOrwIOsz3+HKLNFbc8Eu8oYW
   rhCnZ6VZoG10Bo/BzIP1J6rOVxd437WL6d/QR6ttedRCTdd0DNwiJPep0
   A==;
X-CSE-ConnectionGUID: 9RYUyqU+S5WNtiiPHyRL1g==
X-CSE-MsgGUID: fC7eTxE5RPKR76AI3LsSPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="70241292"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="70241292"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 08:04:12 -0700
X-CSE-ConnectionGUID: zyquARy1Tyu8HsdYh/rNcA==
X-CSE-MsgGUID: QRPHrvk1Q1upV+C4KhZyPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="247508669"
Received: from madhum (HELO madhum..) ([10.223.131.52])
  by orviesa006.jf.intel.com with ESMTP; 19 Jun 2026 08:03:19 -0700
From: madhu.m@intel.com
To: gregkh@linuxfoundation.org
Cc: heikki.krogerus@linux.intel.com,
	stable@vger.kernel.org,
	jthies@google.com,
	akuchynski@chromium.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Madhu M <madhu.m@intel.com>
Subject: [PATCH v2] usb: typec: ucsi: Pass full DP config payload in SET_NEW_CAM for DP alt mode
Date: Fri, 19 Jun 2026 21:03:11 +0530
Message-Id: <20260619153311.3526083-1-madhu.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <message-id-of-gregs-reply>
References: <message-id-of-gregs-reply>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267415-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[madhu.m@intel.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:heikki.krogerus@linux.intel.com,m:stable@vger.kernel.org,m:jthies@google.com,m:akuchynski@chromium.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:madhu.m@intel.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[madhu.m@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34E4B6A6915

From: Madhu M <madhu.m@intel.com>

In the UCSI Specification Revision 3.1 RC1, bits 32-63 of the SET_NEW_CAM
command hold the 32-bit Alternate Mode Specific (AMSpecific) field.

For DisplayPort Alternate Mode, this field must contain the full
32-bit DisplayPort configuration VDO payload that the OPM wants the
connector to operate in, rather than just the pin assignment value.
This AMSpecific value follows the DisplayPort Configurations defined
in the DisplayPort Alt Mode on USB Type-C Specification v2.1a,
Table 5-13: SOP DisplayPort Configurations.

Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Cc: stable@vger.kernel.org
Signed-off-by: Madhu M <madhu.m@intel.com>
Reviewed-by: Jameson Thies <jthies@google.com>
Reviewed-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v2:
- Add Fixes: tag and Cc: stable; the bug (passing only the pin-assignment
  value instead of the full DP configuration VDO) dates back to the initial
  UCSI DisplayPort alt mode support in af8622f6a585.
 drivers/usb/typec/ucsi/displayport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 67a0991a7b76..2e3d7c734d9f 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -185,13 +185,12 @@ static int ucsi_displayport_status_update(struct ucsi_dp *dp)
 
 static int ucsi_displayport_configure(struct ucsi_dp *dp)
 {
-	u32 pins = DP_CONF_GET_PIN_ASSIGN(dp->data.conf);
 	u64 command;
 
 	if (!dp->override)
 		return 0;
 
-	command = UCSI_CMD_SET_NEW_CAM(dp->con->num, 1, dp->offset, pins);
+	command = UCSI_CMD_SET_NEW_CAM(dp->con->num, 1, dp->offset, dp->data.conf);
 
 	return ucsi_send_command(dp->con->ucsi, command, NULL, 0);
 }
-- 
2.34.1


