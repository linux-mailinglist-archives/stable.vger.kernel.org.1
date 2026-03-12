Return-Path: <stable+bounces-224871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKgcIPDOsmmPPwAAu9opvQ
	(envelope-from <stable+bounces-224871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:34:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C0B273705
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 340EB3006D73
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5636EA97;
	Thu, 12 Mar 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSXhvT9P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015A358397;
	Thu, 12 Mar 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326047; cv=none; b=dDTLdHDKlnMrdFKtv2dmUmAbCMwg/HqByH6AMwL7eTZwDr6J6P2KDBZA9T/dYEMq/Spubsufv8XiGQFpgXQBbzCsh+tf9oSFkyoXd7V8I/due7k5ZnVb2Dfs6rjHTbf/Sxd9ZhlU6+g7z5izjA8UAKv8j9VcO7t0nK77/fhURc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326047; c=relaxed/simple;
	bh=A5ilgnS1EyuYH26kfTB4EZlt9UNNLtSVCXi+fCHaX6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+bZRXgNgMJO9YFdKRSRgG0ReJA9dIYjhPgewZYVr4ve5D1vjeFtP7mvq6OKD0baP5Df4FW0h82794HtDP4nwMQbPSx0nurgQsRfQE+3ICTKWG+nGKPTfDNsyjyF9wwYmdjvhWa/GMySdN8Gn7e9hhlGMcKKgqx+E71Cq2/+uIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSXhvT9P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773326046; x=1804862046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5ilgnS1EyuYH26kfTB4EZlt9UNNLtSVCXi+fCHaX6I=;
  b=YSXhvT9PMR+PrVeMNU8qylP1kHVwu3G7TWvUM0jelVzifJoxbyMYSFH2
   jaRNyh0Mi9YHFTmSxt4t+tNlKAuVXrnnuleCI3xyTLTPuQBgPMlZIjCan
   yLxEQti9GyhXNGxxE9D5UhA9wZ5arIFB+pEGmOC3IINql6gaU/ngqsFwS
   kKdCuu8Jz/FP1Po6nCkhGgJq2uEV1tq7enhefPqVZUCM6yLk/hitr2CQT
   m+VutDnuScD3Dix8IaOojpJb6nc/hugvcZr2xOxtPu0vhMuZYvgAgenCl
   +BuRJsLFnlL+BuIg3ZrwCxDWkAap9xQcUSn+sHkgZ+YVkN8eynCfpAn6d
   w==;
X-CSE-ConnectionGUID: SxYzFNfZSxKdXqWDA3v96Q==
X-CSE-MsgGUID: aK2jw27JQSad+rUU5tBweQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="99881890"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="99881890"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:34:05 -0700
X-CSE-ConnectionGUID: 5QGSVHSoS9SgE1GPch79Iw==
X-CSE-MsgGUID: GX5WBr/xTFabaqJMRiXiZw==
X-ExtLoop1: 1
Received: from gaggeryt-mobl.sc.intel.com ([172.25.65.89])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:34:05 -0700
From: gaggery.tsai@intel.com
To: linux-sound@vger.kernel.org
Cc: ckeepax@opensource.cirrus.com,
	mstrozek@opensource.cirrus.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	TsaiGaggery <gaggery.tsai@intel.com>
Subject: [PATCH v2] ASoC: SDCA: Fix NULL pointer dereference in sdca_jack_process()
Date: Thu, 12 Mar 2026 07:32:18 -0700
Message-ID: <20260312143218.2008222-1-gaggery.tsai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310183829.2907805-1-gaggery.tsai@intel.com>
References: <20260310183829.2907805-1-gaggery.tsai@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-224871-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaggery.tsai@intel.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82C0B273705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: TsaiGaggery <gaggery.tsai@intel.com>

sdca_jack_process() unconditionally dereferences component->card and
card->snd_card at the top of the function. This causes a NULL pointer
dereference when the SDCA IRQ handler fires after the ASoC card has
been torn down.

The crash occurs deterministically on platforms where snd_soc_bind_card()
fails (e.g. due to missing machine driver support). The sequence is:

  1. soc_probe_component() sets component->card and calls
     snd_soc_component_probe(), which registers the SDCA IRQ handler
     via sdca_irq_populate() / devm_request_threaded_irq().

  2. snd_soc_bind_card() fails (e.g. sof_sdw returns -ENOTSUPP when
     no matching machine driver is found for the codec configuration).

  3. soc_cleanup_card_resources() -> soc_remove_component() sets
     component->card = NULL.

  4. The SDCA IRQ handler remains registered because it is tied to
     device lifetime (devm), not card lifetime.

  5. A subsequent SoundWire alert fires via
     cdns_update_slave_status_work() -> sdw_handle_slave_status() ->
     handle_nested_irq() -> detected_mode_handler() ->
     sdca_jack_process(), which dereferences the now-NULL
     component->card, causing the crash at offset 0xa0
     (offsetof(struct snd_soc_card, snd_card)).

  BUG: kernel NULL pointer dereference, address: 00000000000000a0
  RIP: 0010:sdca_jack_process+0x47/0x470 [snd_soc_sdca]
  Call Trace:
   detected_mode_handler+0x2e/0x70 [snd_soc_sdca]
   handle_nested_irq+0xa9/0x120
   regmap_irq_thread+0x1d5/0x320
   handle_nested_irq+0xa9/0x120
   sdw_handle_slave_status+0xe92/0x17d0 [soundwire_bus]
   cdns_update_slave_status_work+0x25e/0x470 [soundwire_cadence]

Fix this in two ways:

  1. Add a .remove callback to class_function_component_drv that calls
     sdca_irq_disable() before the component is removed and
     component->card is set to NULL. Since disable_irq() includes
     synchronize_irq(), this guarantees no handler is running when
     the card pointer is cleared, eliminating the TOCTOU race.

  2. Keep a NULL guard in sdca_jack_process() as defense-in-depth,
     returning -ENODEV if card or card->snd_card is NULL.

Tested on Intel Panther Lake with Cirrus Logic CS42L45/CS35L57
SoundWire codecs. The crash reproduces reliably when
snd_soc_bind_card() fails and can be triggered by any unsupported
codec configuration that causes card registration to return an error.

Fixes: 82e12800f563 ("ASoC: SDCA: Add ability to connect SDCA jacks to ASoC jacks")
Cc: stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Gaggery Tsai <gaggery.tsai@intel.com>
---
 sound/soc/sdca/sdca_class_function.c |  9 +++++++++
 sound/soc/sdca/sdca_jack.c           | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sdca/sdca_class_function.c b/sound/soc/sdca/sdca_class_function.c
index 98fd3fd1052b..a43ad5262db2 100644
--- a/sound/soc/sdca/sdca_class_function.c
+++ b/sound/soc/sdca/sdca_class_function.c
@@ -207,8 +207,17 @@ static int class_function_set_jack(struct snd_soc_component *component,
 	return sdca_jack_set_jack(core->irq_info, jack);
 }
 
+static void class_function_component_remove(struct snd_soc_component *component)
+{
+	struct class_function_drv *drv = snd_soc_component_get_drvdata(component);
+	struct sdca_class_drv *core = drv->core;
+
+	sdca_irq_disable(drv->function, core->irq_info);
+}
+
 static const struct snd_soc_component_driver class_function_component_drv = {
 	.probe			= class_function_component_probe,
+	.remove			= class_function_component_remove,
 	.endianness		= 1,
 };
 
diff --git a/sound/soc/sdca/sdca_jack.c b/sound/soc/sdca/sdca_jack.c
index 49d317d3b8c8..b52d88a08634 100644
--- a/sound/soc/sdca/sdca_jack.c
+++ b/sound/soc/sdca/sdca_jack.c
@@ -37,13 +37,21 @@ int sdca_jack_process(struct sdca_interrupt *interrupt)
 	struct device *dev = interrupt->dev;
 	struct snd_soc_component *component = interrupt->component;
 	struct snd_soc_card *card = component->card;
-	struct rw_semaphore *rwsem = &card->snd_card->controls_rwsem;
+	struct rw_semaphore *rwsem;
 	struct jack_state *state = interrupt->priv;
-	struct snd_kcontrol *kctl = state->kctl;
+	struct snd_kcontrol *kctl;
 	struct snd_ctl_elem_value *ucontrol __free(kfree) = NULL;
 	unsigned int reg, val;
 	int ret;
 
+	if (!card || !card->snd_card) {
+		dev_dbg(dev, "card not yet bound, deferring jack event\n");
+		return -ENODEV;
+	}
+
+	rwsem = &card->snd_card->controls_rwsem;
+	kctl = state->kctl;
+
 	guard(rwsem_write)(rwsem);
 
 	if (!kctl) {
-- 
2.43.0


