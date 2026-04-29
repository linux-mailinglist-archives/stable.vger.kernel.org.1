Return-Path: <stable+bounces-241937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC6nDKlh8mk0qgEAu9opvQ
	(envelope-from <stable+bounces-241937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:53:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C750F499E8C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C552430659F0
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE237E2FD;
	Wed, 29 Apr 2026 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHBVXxOK"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172D3876C4;
	Wed, 29 Apr 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492344; cv=none; b=XTKIxBUl8PkEMq/KcB8Nd9fi3O+hHrxVxXK6Y1qIvOjoZ6/qSNrQ3xdq7LCquIWpXvs84qcbtnO3S44zOUIEzWeetUf/jj1K1OmQ+XmEBq1h5lRsdRfDRoJQXA5lSRRy58aPwm5ea5R4ltBj5Lo62efxx98a7x5iNma3jB1u/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492344; c=relaxed/simple;
	bh=PdUgFwDo8nPZBr4J0JoLCl5z4bpSTZfiaHAh6by9cWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg1fVC9ShQSvWBkXZ+LQYzJtHzPgSF8PRMRzRPsF95Ul4KmSPX+knc5Fwq2w5oSxU2W/e0JYZVMqKOeaZy04kq1q5axxPlAbRVav12R1ijndijz9isGcB8ra+G7ODe61AGXLI3/llWv+pQtBLBjaDA1ewg/NbGouGEDq/ap5jCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHBVXxOK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777492343; x=1809028343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PdUgFwDo8nPZBr4J0JoLCl5z4bpSTZfiaHAh6by9cWI=;
  b=AHBVXxOKX4gIbvpbdts/5qRQ7rc/HX02wZF0JbAxpmzIrslpiRVbwjdV
   jYZS6shVVU30wE3URKAI8GWCl1EMQYIk31PtieDxwNBwZT7eaePK+HlgK
   +tiJhzEy+xtNpSYyAjkyPOdpaUsyE8JOjgyTxivo9qGkUAlddatRHRK52
   vdyePgByUQ73e5R57RpJ8d7+owdZ3VTGTSY4R2wxw0cHVzAz2RElb6VpW
   QWkpJJPKKoSXC4s+3bcwzkBXCOwEcD4c4VqjqvjtSthLvIZmrFEF3Unaq
   0npVt652B9quSwqYBc45j9kxd66Pez0O7y7C5qvLHQQ2oA6HoSSIggHIZ
   Q==;
X-CSE-ConnectionGUID: I2KVQFtoTM+/li02mptELw==
X-CSE-MsgGUID: vGK6BAXPQ+mZYproACHx+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78326734"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78326734"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:52:16 -0700
X-CSE-ConnectionGUID: IG0MTGW3Ri6we6i8ZCUZOQ==
X-CSE-MsgGUID: 6LGFCtzoQPWmFwruQlMOnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="239385674"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa005.jf.intel.com with ESMTP; 29 Apr 2026 12:52:16 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stable@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: intel: Move debugfs register before creating devices
Date: Wed, 29 Apr 2026 12:52:12 -0700
Message-ID: <20260429195214.1532711-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429195214.1532711-1-srinivas.pandruvada@linux.intel.com>
References: <20260429195214.1532711-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C750F499E8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241937-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]

It is possible that the driver handling device is enumerated before
registering debugfs. If the driver wants to access debugfs by calling
tpmi_get_debugfs_dir(), this will return error in this case.

Hence register debugfs before creating devices.

Fixes: 811f67c51636 ("platform/x86/intel/tpmi: Add new auxiliary driver for performance limits")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: <Stable@vger.kernel.org>
---
 drivers/platform/x86/intel/vsec_tpmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index 7fc6ff8d1040..a38014e81e85 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -817,10 +817,6 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 
 	auxiliary_set_drvdata(auxdev, tpmi_info);
 
-	ret = tpmi_create_devices(tpmi_info);
-	if (ret)
-		return ret;
-
 	/*
 	 * Allow debugfs when security policy allows. Everything this debugfs
 	 * interface provides, can also be done via /dev/mem access. If
@@ -830,6 +826,12 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 	if (!security_locked_down(LOCKDOWN_DEV_MEM) && capable(CAP_SYS_RAWIO))
 		tpmi_dbgfs_register(tpmi_info);
 
+	ret = tpmi_create_devices(tpmi_info);
+	if (ret) {
+		debugfs_remove_recursive(tpmi_info->dbgfs_dir);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.52.0


