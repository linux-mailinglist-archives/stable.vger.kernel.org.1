Return-Path: <stable+bounces-224875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGDTASzXsmlDQAAAu9opvQ
	(envelope-from <stable+bounces-224875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:09:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F2D273F32
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0BA33122411
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743433B4EBF;
	Thu, 12 Mar 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JC6mbzvR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78738DD3
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327737; cv=none; b=ZkJLdSIUFzU0FthWi81goIWN0EMgAXVa2ITTsoaEhsVpDGqEASbfIJqitUFMO2OmgWuSl65cfSLO87YbDY1eJ+sFmuQN7+eFVyYE+uufrBOWvwFNK/T4dGYxBGuWMp5fpDtZzibKsU0WA6mKWi+0/CqFi7znB6qHtM9jcq/t/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327737; c=relaxed/simple;
	bh=01sBkHjeAPiYutS3v+l7TJD810lgmSflHg7oHic580w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEjBK/+QjMLvfvXenh3Z44kryAbZkR7qDS+iXh4rlRta1LOApzEpJMvadFV4PCw6JJMCud88ZIyuBCSpMtf0ETiQky3Mxuzp0IqBmbS/ZjBpwMUToePcduBi/e2dGP19Jl697rU9lSOu3G7eVJXJnWHhJi4qquFgmZImPeezgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JC6mbzvR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773327735; x=1804863735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=01sBkHjeAPiYutS3v+l7TJD810lgmSflHg7oHic580w=;
  b=JC6mbzvRVrpnvzmw8EfhURBvfDTjhK/3MLs8X3lri65VOGrxS/CLL4XD
   3UGC/6MOc3NO9JodD7ktP7UQvlmhbvwdvn0eUI/Hi0G3eaG3wjqOiTGVd
   3k8P0ckbOZYMftdsEt+XmXj2jXLQRWIOpx7N85lZToYzq6JE8fx40Qcce
   UbOY69zVJWZranx+VbNsxOoSTBqWPT9BEBD76a8jpAo8+aW6LzCbVm56R
   HM3sENvBDwUjpIxqY6qePmHGUvzORl9cxdgraryKP6FSI/6RmEhUpmlkO
   bX+40cSUih4kKysNxPYA29ozYGqXzYyeHd3yejQJNgWPQop2DveYSt+Cz
   Q==;
X-CSE-ConnectionGUID: Y7PlWRGaQnySxiJoCE4cMQ==
X-CSE-MsgGUID: 9/ikB53cQS2/KhYaGgrTHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74506097"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74506097"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 08:02:14 -0700
X-CSE-ConnectionGUID: taB2XLLgQg6P1O04nB+GtQ==
X-CSE-MsgGUID: BF+AWqT1RZWxrKRkdRn1Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="224990310"
Received: from gaggeryt-mobl.sc.intel.com ([172.25.65.89])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 08:01:53 -0700
From: gaggery.tsai@intel.com
To: linux-drivers-review-request@eclists.intel.com
Cc: pierre-louis.bossart@linux.dev,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org,
	TsaiGaggery <gaggery.tsai@intel.com>
Subject: [PATCH] ASoC: SOF: Intel: hda: Fix NULL pointer dereference on SoundWire IRQ during removal
Date: Thu, 12 Mar 2026 08:00:05 -0700
Message-ID: <20260312150005.2069660-1-gaggery.tsai@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224875-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gaggery.tsai@intel.com,stable@vger.kernel.org]
X-Rspamd-Queue-Id: 64F2D273F32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: TsaiGaggery <gaggery.tsai@intel.com>

hda_sdw_exit() sets hdev->sdw to NULL after calling sdw_intel_exit(),
but the shared IPC IRQ handler is not freed until much later in
hda_dsp_remove(). If a SoundWire interrupt fires in this window, the
IRQ thread calls hda_dsp_sdw_thread() -> sdw_intel_thread() with a
NULL context pointer or with link->cdns already freed, causing a NULL
pointer dereference:

  BUG: kernel NULL pointer dereference, address: 00000000000003d0
  RIP: 0010:sdw_cdns_irq+0x9/0x2b0 [soundwire_cadence]
  Call Trace:
   sdw_intel_thread+0x2d/0x50 [soundwire_intel]
   hda_dsp_interrupt_thread+0x99/0x3a0 [snd_sof_intel_hda_generic]
   irq_thread_fn+0x25/0x60

The race window is between hda_sdw_exit() tearing down SoundWire
links and free_irq() in hda_dsp_remove(). During sdw_intel_exit() ->
sdw_intel_cleanup(), each link's auxiliary device is unregistered,
which clears link->cdns. Meanwhile the IRQ thread can still fire and
iterate the link list, calling sdw_cdns_irq() with a NULL cdns.

Fix this in three ways:

  1. In hda_sdw_exit(), disable SoundWire interrupts at the hardware
     level (hda_sdw_int_enable) and call synchronize_irq() BEFORE
     tearing down the SoundWire context, preventing new IRQ threads
     from entering the SoundWire path.

  2. Add a NULL guard for link->cdns in sdw_intel_thread() to handle
     the case where the IRQ thread races with individual link
     removal during sdw_intel_cleanup().

  3. Add a NULL guard in hda_dsp_sdw_thread() as defense-in-depth
     for the case where hdev->sdw is already NULL.

Tested on Intel Panther Lake with SoundWire codecs by manually
unbinding the SOF PCI device while audio was active.

Fixes: 722ba5f1f530 ("ASoC: SOF: Intel: hda: merge IPC, stream and SoundWire interrupt handlers")
Cc: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Gaggery Tsai <gaggery.tsai@intel.com>
---
 drivers/soundwire/intel_init.c |  6 ++++--
 sound/soc/sof/intel/hda.c      | 11 +++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index ad48d67fa935..e093a29f1590 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -145,8 +145,10 @@ irqreturn_t sdw_intel_thread(int irq, void *dev_id)
 	struct sdw_intel_ctx *ctx = dev_id;
 	struct sdw_intel_link_res *link;
 
-	list_for_each_entry(link, &ctx->link_list, list)
-		sdw_cdns_irq(irq, link->cdns);
+	list_for_each_entry(link, &ctx->link_list, list) {
+		if (link->cdns)
+			sdw_cdns_irq(irq, link->cdns);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index c0cc7d3ce526..02a0e354414e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -256,12 +256,17 @@ static int hda_sdw_exit(struct snd_sof_dev *sdev)
 
 	hdev = sdev->pdata->hw_pdata;
 
+	/* Disable SoundWire IRQ at the hardware level first to prevent
+	 * the IRQ handler from accessing hdev->sdw after it is freed.
+	 * synchronize_irq() ensures any in-flight handler has completed.
+	 */
+	hda_sdw_int_enable(sdev, false);
+	synchronize_irq(sdev->ipc_irq);
+
 	if (hdev->sdw)
 		sdw_intel_exit(hdev->sdw);
 	hdev->sdw = NULL;
 
-	hda_sdw_int_enable(sdev, false);
-
 	return 0;
 }
 
@@ -309,6 +314,8 @@ static bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
 
 static irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
 {
+	if (!context)
+		return IRQ_HANDLED;
 	return sdw_intel_thread(irq, context);
 }
 
-- 
2.43.0


