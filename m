Return-Path: <stable+bounces-256610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP+aDgKBGWrVxAgAu9opvQ
	(envelope-from <stable+bounces-256610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:05:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C78B601F8E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6E48305DEF4
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3693DEFE3;
	Fri, 29 May 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv0vGV+Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA23DEFE7
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056175; cv=none; b=FmKVSA9YT6i2aR17CrtmUGdxtcp05ulayXJMLZkKJII5f0IihzPEcOvDHYd4EIFu1gS0wKAYJZCJc6ELwUt6M1nM5ag/YiEuSdrJd1Fxbl/aTZRHz8aeM5Yx3tLf630errvLCnyDW7Iob9IG+9Y4OShoD7V4k+7qJbGU3orGW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056175; c=relaxed/simple;
	bh=TZy73E+3IaSpE5wUpSsjK15CVH/hei5A9B1e1I4n2C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1Uh9/jhj5QXg24xCKjhGCKspfavAeC+FcLCw7FB036Ah1yUJE1ptILembQzCzcmcrbLKvUmsVCRqM6OtV8X+wJOUdvLzWv3xeWya+S7dIPTCQa3FVANF0PSwuyR+OLV7KGQNutsn/435WJTx6MqIQO73my5MqqQ3UmLSdYnjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv0vGV+Z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780056175; x=1811592175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TZy73E+3IaSpE5wUpSsjK15CVH/hei5A9B1e1I4n2C8=;
  b=Xv0vGV+Zc3L+MdLRWDGXvicugnvk07LS3Dp+F7Ba/xM4QodDq5zL/SX5
   y21G8J9dPXkf2x7qe/9xFbbWuJe9uuu2Sbf50KrxXU3/M3/74NL4E40kX
   J/VQqw1OQPDS+AtIUkXU/s07ILcpHZ4JQ92F5Uy8n5xQX+ONJbCQU1Oh/
   tJJixP1PpRT6OULWpwNUr+H8VbDZclsYADiw7aHs4f0elKa39dWPN6hPb
   LK4OxxF++BvaJODrnW2kv9mzkbtx0+5kwrqpXppLi5iUl9NUesldDj0rH
   Iu7CvV/x0WHNAKGiip9caQ+yefhR8ZQ7mTN5YPAj8uz8adpq2gYvzV3l6
   Q==;
X-CSE-ConnectionGUID: OtaeL1FDRBGu3PFtn0Ahjg==
X-CSE-MsgGUID: aI7yuV6FQRa7QLLH/42i8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81021367"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81021367"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:02:54 -0700
X-CSE-ConnectionGUID: 4Sb1i9p2Qi+eXKb1fuE7WA==
X-CSE-MsgGUID: bV4inkxeTmOMvhNb/7R5GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="239832279"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:02:52 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	karol.wachowski@linux.intel.com,
	dawid.osuchowski@linux.intel.com,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Add bounds checks for firmware log indices
Date: Fri, 29 May 2026 13:58:42 +0200
Message-ID: <20260529115842.135378-1-andrzej.kacprowski@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256610-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,amd.com,linux.intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrzej.kacprowski@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 8C78B601F8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add validation that read and write indices in the firmware log buffer
are within valid bounds (< data_size) before using them. If
out-of-bounds indices are encountered (from firmware), clamp them to
safe values instead of proceeding with invalid offsets.

This prevents potential out-of-bounds buffer access when firmware
supplies invalid log indices.

Fixes: 1fc1251149a7 ("accel/ivpu: Refactor functions in ivpu_fw_log.c")
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 337c906b0210..275baf844b56 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -98,6 +98,11 @@ static void fw_log_print_buffer(struct vpu_tracing_buffer_header *log, const cha
 	u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
 	u32 log_end = READ_ONCE(log->write_index);
 
+	if (log_start >= data_size)
+		log_start = 0;
+	if (log_end > data_size)
+		log_end = data_size;
+
 	if (log->wrap_count == log->read_wrap_count) {
 		if (log_end <= log_start) {
 			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
-- 
2.43.0


