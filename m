Return-Path: <stable+bounces-256617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKmOOiiEGWouxQgAu9opvQ
	(envelope-from <stable+bounces-256617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:18:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C1760227F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85A6330553D1
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8503DE457;
	Fri, 29 May 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXgRakhZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F13DA5DB
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056788; cv=none; b=H09PoN0MNT1HJe8kZFSV9ZFNYJ1LbisCW1Q7UMwfk2CVB/QYFfAIsXGiEN0DJtmvQO0z1BVyIdaXyix60DbJBNKo83fQn1F324B9zQBEmBAsv+gEA58OpB3MT0dAQnWshxsOmDarCyyEXsY1NmklPcMkMPqRTjG4GPDflPMH3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056788; c=relaxed/simple;
	bh=4A/c8Oy9znqnw/CbgfQDRXvRioPD8P0qyZunjaa9+VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qA5MB477QrCknBLoqPN/MTHFSrGeH3ncaREiUKHE1YHYK9g0Dcvk2uVOHH3ZnVJkV32Oc8ZyiJDos1Qi/G9ELmTZpl/eIZpfwTBqnzk1LZNDpfnXNi03fkNVmSRCdNy23/yzJOWKdE/7qlQFcNefPrDC4qrOG/Nc0bkF/nYSo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXgRakhZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780056785; x=1811592785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4A/c8Oy9znqnw/CbgfQDRXvRioPD8P0qyZunjaa9+VQ=;
  b=CXgRakhZYAMGeLMkaCMjNouCjboMkhXIUcD/jNGoBk72YeXMArfu4RFO
   fEz69Q26CiBm3PUczG3oJe9vzsQFb5hiMDg8iBqM8ijuVgDbvQSwRNVU+
   uDmdP8N4M4Qji7Ot+ntaNLazkDPjR0SdS15TCc5epAnJFnxejNTsYsaS2
   AEbF6rtBXDROFFVEu/yuX7EO1m/CWZB6KI22VOnPMXvZZs7Ua4jAuYYpl
   kRGD7Z2gWgUxJM5ljraRMQ4x0H5PnF0dTQLEHwiMtHQEtV65kNyHLjrTL
   WsNIu5SdNmmUxXGzIhaRqrnGXRPBW/OV/TO8n6p8awcewxGlEVaPfuBcd
   g==;
X-CSE-ConnectionGUID: kW865wk7RmiQKONJmCUnXQ==
X-CSE-MsgGUID: nib5gR90QYK0NDZUcitv1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91216965"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91216965"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:13:05 -0700
X-CSE-ConnectionGUID: WrXtacOESniLFFbzwLkLvA==
X-CSE-MsgGUID: 85olzGkhQlao+snk3CeScA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="238643413"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:13:03 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	karol.wachowski@linux.intel.com,
	dawid.osuchowski@linux.intel.com,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Add bounds check for firmware runtime memory
Date: Fri, 29 May 2026 14:08:53 +0200
Message-ID: <20260529120853.135876-1-andrzej.kacprowski@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256617-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,amd.com,linux.intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrzej.kacprowski@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 05C1760227F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Validate that the firmware runtime memory specified in the image
header is properly aligned and sized to hold the firmware image.
This prevents errors during memory allocation and image transfer.

Fixes: 2007e210b6a1 ("accel/ivpu: Split FW runtime and global memory buffers")
Cc: <stable@vger.kernel.org> # v7.0+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 107f8ad31050..33c50779c06b 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -259,6 +259,22 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 		return -EINVAL;
 	}
 
+	if (!PAGE_ALIGNED(runtime_addr)) {
+		ivpu_err(vdev, "Runtime address 0x%llx not page aligned\n", runtime_addr);
+		return -EINVAL;
+	}
+
+	if (!PAGE_ALIGNED(runtime_size)) {
+		ivpu_err(vdev, "Runtime size %llu not page aligned\n", runtime_size);
+		return -EINVAL;
+	}
+
+	if (runtime_size < image_size) {
+		ivpu_err(vdev, "Runtime size too small: %llu, image size: %llu\n",
+			 runtime_size, image_size);
+		return -EINVAL;
+	}
+
 	if (!ivpu_is_within_range(image_load_addr, image_size, &vdev->hw->ranges.runtime)) {
 		ivpu_err(vdev, "Invalid firmware load address: 0x%llx and size %llu\n",
 			 image_load_addr, image_size);
-- 
2.43.0


