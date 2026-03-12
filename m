Return-Path: <stable+bounces-224877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPbBGZjZsmkAQQAAu9opvQ
	(envelope-from <stable+bounces-224877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:19:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C6274333
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5123049172
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FEE377ED0;
	Thu, 12 Mar 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZlPP8VS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6640DFD6
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328226; cv=none; b=L0OG/nIbWbIFcTbCnoPVKoLxq/YRkqpVVmRYbFOhwb2eKsPAQTCbh8hTB6+lfdjg5dVtkEDEgFGM+a9cwTLb3mK39RhPRiAnqMWfRAUR1Esdy9sfjtZcnXmBbDxwRfl5QKelOA2i3WIt7i/hYMyyl5QjxtDSVVH+V4WN1qTCCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328226; c=relaxed/simple;
	bh=huXs5uFIfdFqfBSpRphHu8n9ZQJvsf/LbgIpPf3oWLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/K5QaPYEzWr0g8ey6VdeeyX4DEXLD2ejnqxkGWmcGdONTACuDLUzecID1enfeH/FQh9E4PvqEY0jGHhGiYffjtGvrZ5xDHdM3vN+CaxN6ebLyAmv9uaAE9mIrJTaUOzXRKW4SFjh3CmqijovUG08aJBx3V+bpimPK6hsdsSNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZlPP8VS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773328224; x=1804864224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=huXs5uFIfdFqfBSpRphHu8n9ZQJvsf/LbgIpPf3oWLQ=;
  b=TZlPP8VSrjwGejSHDbBr3nWhNBe3cy/PMFcmbLUrCgPu7Oc3Scguo/m+
   2TS5S3dHzd3ZkEcmFik0jxrkkXlMqywdoHl8cQrdJpovoRtuzo3Aqj8CZ
   S3F1NH8wHFCabrZXm4mL2ZhVJTl8Z/QTLVo2J/D/LvzB9P+Ajin+emo1r
   web/XfbRYSxw9ip85CwRz/+UfGD3w84sEDkGhpVzNfD74/5JvW0PhpAyM
   MU20eAX83CpAOfF+sdARJpbP/x/ekuWzW7wcbO1wgMLkZ2wBllIj7hZxE
   IVoYMfztbKFUuNgizXXQhsz/UE7iny1fWj7GxXVvpOUy8VS89cwvPHTzR
   g==;
X-CSE-ConnectionGUID: quwvyugkRXisXUxbvixRlg==
X-CSE-MsgGUID: kKNT9yboRsiuiv6OXRv67w==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78026882"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78026882"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 08:10:24 -0700
X-CSE-ConnectionGUID: WBrJt3PvQxC8ytfWbIlvkQ==
X-CSE-MsgGUID: +khoG2Y0Q9GF/UvXLSeBEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="215895991"
Received: from gaggeryt-mobl.sc.intel.com ([172.25.65.89])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 08:10:24 -0700
From: gaggery.tsai@intel.com
To: linux-drivers-review-request@eclists.intel.com
Cc: pierre-louis.bossart@linux.dev,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org,
	Gaggery Tsai <gaggery.tsai@intel.com>
Subject: [PATCH v2] ASoC: SOF: Intel: hda: Fix NULL pointer dereference on SoundWire IRQ during removal
Date: Thu, 12 Mar 2026 08:08:37 -0700
Message-ID: <20260312150837.2076641-1-gaggery.tsai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312150005.2069660-1-gaggery.tsai@intel.com>
References: <20260312150005.2069660-1-gaggery.tsai@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224877-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaggery.tsai@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: CD4C6274333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gaggery Tsai <gaggery.tsai@intel.com>

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


