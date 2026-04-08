Return-Path: <stable+bounces-233821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFJ9BFsW1mnwAwgAu9opvQ
	(envelope-from <stable+bounces-233821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:48:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A303B94E4
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB229305B2BA
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CD3A75A7;
	Wed,  8 Apr 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luw8CMoF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715583A7824;
	Wed,  8 Apr 2026 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637901; cv=none; b=S8xrV2wQmHdEz3MWjLKcEC9HPmW4AsKxP2v21BxM/KXdCNsB3H8yEZFdjoj1uTGTSLlYozWt9CkX3i382waZxtbTC6YUCpaY49X8BZKA9/Fmmeb2svqMnTOEafqhF676kHeoL2P9DE9V3if18kFGIsDOezwT90TRAXr5/B0MYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637901; c=relaxed/simple;
	bh=k9g4wWBWlNNTTl3N42muplf1TO4qQ+6AVpfewmcI3bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKyfoiDkoVAqJcjhvqL40u6nDXWWgZIApwB9ul+1rpsaY89dWHfbtMIIONBf9Xa1N7KaItBgs8xwGFHMzQAdlUlMbDAcnr12i/80MQU5YAyWdQTsPy9NG21UTE9nw/cclbDGsHoDO9MHw6Bf7f7KiIPt8UE326/C+mY6eptmEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luw8CMoF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775637899; x=1807173899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9g4wWBWlNNTTl3N42muplf1TO4qQ+6AVpfewmcI3bY=;
  b=luw8CMoFPbRTc1GjRuH9i+ihVIVEGSWLwOlKuUdRTkk6OxeDOVxpX/dF
   yXZh1quiWAWPzWQbb7beUN7RHESZU5IhMJSV/xLQxjbAv7KsNTVT05Xma
   wjGFPTlzknM8pPmoH86Va701pFq/fxe54tcxpFvK6FdoPRZHKRO+26jT0
   tyzkOju0kRs5HVCTl/T8muYg96l1h6KQMAW0EXEwccoLFF1smp/ZsabF3
   073ErslbE2DnzjxqFvWj5o8Y110LSxZ/112oIELzgIdxCAKhtqhjrU6oI
   BbiD4vrg0IvR1Rn96SkP2gUnO+3Oxy4z6haiICR3/q/GAqGGHKtzmCl1Z
   A==;
X-CSE-ConnectionGUID: KcscDUzmQCaFy/gcQr5t2A==
X-CSE-MsgGUID: VLBd4SCeQb+BHFVn47511w==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="94003654"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="94003654"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:44:59 -0700
X-CSE-ConnectionGUID: SCkVMTOoQ/2l8iYP8ty4MA==
X-CSE-MsgGUID: AVBWPw1mTlKtHtuqiY4foQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="251741972"
Received: from rvuia-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:44:56 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: [PATCH for 7.0 1/2] ALSA: hda/intel: enforce stricter period-size alignment for Intel NVL
Date: Wed,  8 Apr 2026 11:45:13 +0300
Message-ID: <20260408084514.24325-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
References: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,suse.de];
	TAGGED_FROM(0.00)[bounces-233821-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 69A303B94E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Intel ACE4 based products set more strict constraints on HDA BDLE start
address and length alignment. Modify capability flags to drop
AZX_DCAPS_NO_ALIGN_BUFSIZE for Intel Nova Lake platforms.

Fixes: 7f428282fde3 ("ALSA: hda: controllers: intel: add support for Nova Lake")
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
---
 sound/hda/controllers/intel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 1b22dbf7a719..257c498c3260 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -295,6 +295,9 @@ enum {
 #define AZX_DCAPS_INTEL_LNL \
 	(AZX_DCAPS_INTEL_SKYLAKE | AZX_DCAPS_PIO_COMMANDS)
 
+#define AZX_DCAPS_INTEL_NVL \
+	(AZX_DCAPS_INTEL_LNL & ~AZX_DCAPS_NO_ALIGN_BUFSIZE)
+
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
 	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_POSFIX_LPIB |\
@@ -2552,8 +2555,8 @@ static const struct pci_device_id azx_ids[] = {
 	/* Wildcat Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Nova Lake */
-	{ PCI_DEVICE_DATA(INTEL, HDA_NVL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
-	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_NVL) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_NVL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.53.0


