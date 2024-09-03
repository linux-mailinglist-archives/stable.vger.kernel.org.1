Return-Path: <stable+bounces-72850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369396A6BC
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6346B21A48
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E351922CD;
	Tue,  3 Sep 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jqmw//lF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C2F15574F;
	Tue,  3 Sep 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388984; cv=none; b=JyLHl3aUIeWLNRQW0p+2bIkWMhLymByMnsVfZ1bdDC5ytmESNs9z/WBM1xy6H/Tefh+HCSz2Wakgg8Chpn7F8k8fibE/sZBiwXCp5X/mV/PxRUP2ZbBclpJ0TjbKMp7Xh1NjgLGSYR3V3me7G6ndvBe8ieMHeSIyXQnGv+Rv6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388984; c=relaxed/simple;
	bh=ld9gagOa0fa1CJUN37/ZlIKkg9SRVVn3N2D0lHHCkzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdEYt7NABkH5e3m+/HcDeieQ6iAEGQtMSHzhovmdxIiVsCELqRv2vBRhF0/CClNorvlDnXn3rhGUjpV5FeoEItiplzjBnwNMiMbIcR4AFCMo1EuacifSusmOBLCgjuhi0DWS2Tv5ARDGJ5H9UmyZS6cwMEWVgtVgavVtA7bjv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jqmw//lF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388983; x=1756924983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ld9gagOa0fa1CJUN37/ZlIKkg9SRVVn3N2D0lHHCkzI=;
  b=Jqmw//lFTaXl4x9QigRYwnap7FiGm1W7/vFor6bSDp0Q23d75PujAma1
   QEDqhaGhHJkSYTExgbm3m7LMSQntDHI/GaiDXGA1ZcdRc8aULB8UMtmXD
   uWHNPEYGWJawwqXKh/a5j8mYGbN2/GRMq4/HrzUl0VzJApRC0Z02g5cyT
   ugIEa+72rEjX9SILQYWSppRqQzLUmavCjTsvVWezn4IYzFuh8jLEcPymQ
   GMIJQJYWuaBNqIGsmdNvpwEQb7ewUyI8wUmlF6ROMt0bDMZyWPeU5q97q
   cRp1RrwmgUypMSNNb2lQQDdPf5Fnpr73/a0XIb4aKd4VvkQTfGFXpCApw
   A==;
X-CSE-ConnectionGUID: F5I6F09ER+ynsAOyKR7RGg==
X-CSE-MsgGUID: rHIcyoa3Rla2B+MsxePvGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24148512"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24148512"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:43:03 -0700
X-CSE-ConnectionGUID: FAb18MeQSmqXZesO1LIS/w==
X-CSE-MsgGUID: zpRnkUTCT7uay3rrJ2F3Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64655220"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by fmviesa006.fm.intel.com with ESMTP; 03 Sep 2024 11:43:03 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: milena.olech@intel.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	stable@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [Intel-wired-lan][PATCH iwl-net] idpf: use actual mbx receive payload length
Date: Tue,  3 Sep 2024 11:49:56 -0700
Message-Id: <20240903184956.1572344-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a mailbox message is received, the driver is checking for a non 0
datalen in the controlq descriptor. If it is valid, the payload is
attached to the ctlq message to give to the upper layer.  However, the
payload response size given to the upper layer was taken from the buffer
metadata which is _always_ the max buffer size. This meant the API was
returning 4K as the payload size for all messages.  This went unnoticed
since the virtchnl exchange response logic was checking for a response
size less than 0 (error), not less than exact size, or not greater than
or equal to the max mailbox buffer size (4K). All of these checks will
pass in the success case since the size provided is always 4K. However,
this breaks anyone that wants to validate the exact response size.

Fetch the actual payload length from the value provided in the
descriptor data_len field (instead of the buffer metadata).

Unfortunately, this means we lose some extra error parsing for variable
sized virtchnl responses such as create vport and get ptypes.  However,
the original checks weren't really helping anyways since the size was
_always_ 4K.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org # 6.9+
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..3c0f97650d72 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -666,7 +666,7 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 
 	if (ctlq_msg->data_len) {
 		payload = ctlq_msg->ctx.indirect.payload->va;
-		payload_size = ctlq_msg->ctx.indirect.payload->size;
+		payload_size = ctlq_msg->data_len;
 	}
 
 	xn->reply_sz = payload_size;
@@ -1295,10 +1295,6 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 		err = reply_sz;
 		goto free_vport_params;
 	}
-	if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN) {
-		err = -EIO;
-		goto free_vport_params;
-	}
 
 	return 0;
 
@@ -2602,9 +2598,6 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 		if (reply_sz < 0)
 			return reply_sz;
 
-		if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN)
-			return -EIO;
-
 		ptypes_recvd += le16_to_cpu(ptype_info->num_ptypes);
 		if (ptypes_recvd > max_ptype)
 			return -EINVAL;
-- 
2.39.2


