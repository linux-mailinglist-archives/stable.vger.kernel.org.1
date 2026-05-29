Return-Path: <stable+bounces-256609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF1HAI5/GWp9xAgAu9opvQ
	(envelope-from <stable+bounces-256609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:59:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28C601F00
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5436530475C4
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F099370AD0;
	Fri, 29 May 2026 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdNP1OLm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4A35FF5B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055947; cv=none; b=IKn9yi2QOEclGXnG5yPhbfHHcXI36MgeN349rO636CxCYRe1ejHvKSx5T2aqGm2daAxrvl5fOiHgzzV0kADki4j19WgOWj0Acndwz9c/lgPuX12hdT3OzeFVFXPe0B5y5EutjPuGDJGCqfhRTgRF9H6Vy2a+n0IEXZxMR8tgwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055947; c=relaxed/simple;
	bh=HHUIRMWGDIsqL9kQs+dk2T94LYVQaVJ3tsM6Xq18TxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPLDHDHdjIBlB55JyQsMKsTH92MO+s6F1hnzRjBLN7Gn91BdRczwNkOgPgvuyQFbFx8rjKQTq4aitmx1BCw+u76Yx8E85Lo6HivX01YE5HHULBvGvY0ARPsCXbaxauECvFRUk8sE909hICObNJ4iV3Jt1WVMIPHiMXL/ewhRhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdNP1OLm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780055946; x=1811591946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HHUIRMWGDIsqL9kQs+dk2T94LYVQaVJ3tsM6Xq18TxY=;
  b=cdNP1OLmC86f2izVRNHKSM8y5/kchhVEw7lNWu5h0YSLFYZPPPjflSvk
   Xo8RvPR6BMaf12O1CA7syb19dVwLr/YkXlNUdQmwG1TKvtv4JDSUdE2iJ
   IlejvWyGvPuUqmVVt9IwDtCDr8cINg2XY4m3l+SE3UUCv0GgalA8TFKud
   pX9O/2BvcngoEC/sbz7TFovxBxc0OO1b1MQuNHesWEwBaPlpMPyg1I5Hp
   sZj2mG8Yfyi0wG2u04H4bJYqJF0IogA+WaqESMwESw7Ni4Zb2kqrKwmOB
   JDSILHDKK9sIZyKRSJVEwgDoUk/xbQRIjtz3aDtd7GIFT+kFA1IkmhRIa
   w==;
X-CSE-ConnectionGUID: c8OdJJUHSQSSu+clbnVHew==
X-CSE-MsgGUID: egV1C3QpQry+5Mzg+th2uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80935253"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80935253"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 04:59:06 -0700
X-CSE-ConnectionGUID: Jcl0HK4SSwmVhBT8VpUgoQ==
X-CSE-MsgGUID: 4sl67yWJTPKr9zzQS4ratg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="241788413"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 04:59:04 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	karol.wachowski@linux.intel.com,
	dawid.osuchowski@linux.intel.com,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Fix signed integer truncation in IPC receive
Date: Fri, 29 May 2026 13:54:53 +0200
Message-ID: <20260529115453.132291-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256609-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,amd.com,linux.intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrzej.kacprowski@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Queue-Id: 6F28C601F00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix potential buffer overflow where firmware-supplied data_size is cast
to signed int before being used in min_t(). Large unsigned values
(>= 0x80000000) become negative, causing unsigned wraparound and
oversized memcpy operations that can overflow the stack buffer.

Change min_t(int, ...) to min_t(u32, ...) to ensure large values are
properly clamped instead of becoming negative.

Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index f47df092bb0d..9980a7898bed 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 	if (ipc_buf)
 		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
 	if (rx_msg->jsm_msg) {
-		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
+		u32 size = min_t(u32, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
 
 		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
 			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);
-- 
2.43.0


