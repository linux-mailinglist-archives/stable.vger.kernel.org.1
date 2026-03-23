Return-Path: <stable+bounces-227939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFuZNjwOwWngQAQAu9opvQ
	(envelope-from <stable+bounces-227939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:56:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D052EF76F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A773063602
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210B38758D;
	Mon, 23 Mar 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EChqPTeR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000A36DA10
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259440; cv=none; b=Q9i7R0K8jdXHJnq0I3GDHSqPXF7OhdcnG9kzKU6ZqnczOPFn1SfchVHD9641IZc5X5WH8/L9/cJZkDiyDPyT27cixZSBlsQ6nD33FwuTOHFT+x+QZT/7oI+Xt9CYUHRyGWgqr6hMzyuNFmsWfsEJlFmg9cYXl1mSr/u90SMuOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259440; c=relaxed/simple;
	bh=LoTD6yQU6kUFqkIiRgFrYHuMrZ7+p06yFW0pyqLl5DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZ4Cn9rXNoLzh9Paj4dumC67Ri5w9b7/qw5HzR5gZs0HWk47pKLYMohAMxlSUvqE8U0oOU1Gfqpfe/JzKYkGKI7rtCBgsqlm091I0Tc9J+wP6/MNe84z5euJ00bvc7//XiE7d52RSaBPhTNc63r+xf3K/xNOMKMv431vw8jGrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EChqPTeR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774259440; x=1805795440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LoTD6yQU6kUFqkIiRgFrYHuMrZ7+p06yFW0pyqLl5DQ=;
  b=EChqPTeRBF5UoOk94Gl6uhry8ZhgpECOvOHX0hxWv7/4dJ2VbBJdkVyO
   8jEhj9m9L2UoRwFpnk+umXH+Oj8E+gfd2Okq9zr5B2glPU4PSBnXRnjm6
   Vop60B+91yfbOcZNpYUAI0YPiHoAppWMiW+5p8cTgEOcgoFxTbOmvWQ1+
   W6ocZ8RMYeeMIrs40L4YB4gFTAQBPsurp5uS3e7S37fdcDdksPa8oThC1
   K2oA4nmLnMniXyPQxx3pOhFBRuxMwuTTTImTbIOiRQd8nhCcgt9vzk6DL
   w2J/5yBA87qk0vnuPvDmkCO1U8jO39YnTC3Grx4uJ3XQ7g9ieHfy5eXcN
   Q==;
X-CSE-ConnectionGUID: hJwJOvyaQpqVHjwiTUGKMw==
X-CSE-MsgGUID: 9K0btDp3QlSEvIIF6vLbTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="77862579"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="77862579"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 02:50:39 -0700
X-CSE-ConnectionGUID: 15v1QZjBSuujZoCgJMmBrQ==
X-CSE-MsgGUID: kjuWa3qWQWiVJuA/k6XzxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="217495791"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 02:50:37 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	maciej.falkowski@linux.intel.com,
	lizhi.hou@amd.com,
	andrzej.kacprowski@linux.intel.com,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Add disable clock relinquish workaround for NVL-A0
Date: Mon, 23 Mar 2026 10:50:29 +0100
Message-ID: <20260323095029.64613-1-karol.wachowski@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-227939-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,linux.intel.com,amd.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karol.wachowski@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41D052EF76F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Turn on disable clock relinquish workaround for Nova Lake A0.
Without this workaround NPU may not power off correctly after
inference, leading to unexpected system behavior.

Fixes: 550f4dd2cedd ("accel/ivpu: Add support for Nova Lake's NPU")
Cc: <stable@vger.kernel.org> # v6.19+

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.h | 1 +
 drivers/accel/ivpu/ivpu_hw.c  | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 5b34b6f50e69..f1b6155065ff 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -35,6 +35,7 @@
 #define IVPU_HW_IP_60XX 60
 
 #define IVPU_HW_IP_REV_LNL_B0 4
+#define IVPU_HW_IP_REV_NVL_A0 0
 
 #define IVPU_HW_BTRS_MTL 1
 #define IVPU_HW_BTRS_LNL 2
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index d69cd0d93569..d4a9bcda4100 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -70,8 +70,10 @@ static void wa_init(struct ivpu_device *vdev)
 	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
 		vdev->wa.interrupt_clear_with_0 = ivpu_hw_btrs_irqs_clear_with_0_mtl(vdev);
 
-	if (ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
-	    ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0)
+	if ((ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
+	     ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0) ||
+	    (ivpu_device_id(vdev) == PCI_DEVICE_ID_NVL &&
+	     ivpu_revision(vdev) == IVPU_HW_IP_REV_NVL_A0))
 		vdev->wa.disable_clock_relinquish = true;
 
 	if (ivpu_test_mode & IVPU_TEST_MODE_CLK_RELINQ_ENABLE)
-- 
2.43.0


