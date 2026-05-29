Return-Path: <stable+bounces-256608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN5wCYJ/GWp9xAgAu9opvQ
	(envelope-from <stable+bounces-256608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:58:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3D601EF9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04FE73044F03
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F963DD502;
	Fri, 29 May 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8myalZS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351F36AB5E
	for <stable@vger.kernel.org>; Fri, 29 May 2026 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055657; cv=none; b=CUvTkYSPfI2SZcOw9eWBwZwYBOsG2W65WIr7cEVQJsPYgS2NGgw+YRTLeET7Uyt1J6T+DQv1hZRMn4qBN5vsfYbXzWcpIyRauco1/Z7BDJy9rUs7t+/B9jbQHD1FS3GezD+AZO4RBGAfqIGrAi1AGMyjL1hL9Y0jVqF6TRDK+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055657; c=relaxed/simple;
	bh=HHUIRMWGDIsqL9kQs+dk2T94LYVQaVJ3tsM6Xq18TxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mg2t5ZcOIAyi5sLxMEABb4rXXD4YxoTxiIPuXODcswf0ZVgPXRCy8nkcitTb0jloYEZTEymApEf+sMKlEDceuv/K6TwI0fPf4PpaOlNg3enB3uvpwr/r2muEfFcOx8zMZwnZ/h+H2EF4bQ0Yp2YkbL//iUzT51t2HuSZxptdU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8myalZS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780055656; x=1811591656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HHUIRMWGDIsqL9kQs+dk2T94LYVQaVJ3tsM6Xq18TxY=;
  b=V8myalZSHVp1Tiw/+vxXg4aR+y31GfW/rtEmhsh4biDQdfLYFQUHSad1
   oPZNvvhfpZO6WbtyNPgwCY1aFHt5rBbjMzU1lYahm9ijyuLM69GUp0QMs
   ODXEP9yw7x0n1VMIkj1jWvirWI9i93TE5lJ42DJsmRKKAZ/issZomyT8J
   4xeheepsEDId9BNAENlYuOY5jyRPp4RwavbTEFsxU3tBNlcmiGufv9mEj
   qRJPREhbp0YEwsOwbsDy79f59HDz7QCwwcalv/eTsm8/2CZCIl+CuFycw
   oHrsZl/OhP0R8SnkT9fj8iIB5YX4RIcWsBBiVK0aFcjBi+3P7FZnnu0JM
   w==;
X-CSE-ConnectionGUID: 3v8MfYYwTjq8FWmeLBr8Ww==
X-CSE-MsgGUID: wBdYG6dcQFef46ud6TlGcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="68442134"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="68442134"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 04:54:15 -0700
X-CSE-ConnectionGUID: HdUtu0leQSyQokDpHftIxA==
X-CSE-MsgGUID: 19d323utQMywhjVNZ0K+Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="238429993"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 04:54:14 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: andrzej.kacprowski@linux.intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Fix signed integer truncation in IPC receive
Date: Fri, 29 May 2026 13:50:05 +0200
Message-ID: <20260529115005.131888-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256608-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrzej.kacprowski@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 17E3D601EF9
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


