Return-Path: <stable+bounces-224546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIKpF55lsGloigIAu9opvQ
	(envelope-from <stable+bounces-224546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:40:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB532567E5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B423130173BE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF77324705;
	Tue, 10 Mar 2026 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhOsZeQg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F431A07F;
	Tue, 10 Mar 2026 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168025; cv=none; b=YOMbzpuCokwpxBuqMuyemPOaOLsPK7xjycpmi8rnQnXvzsgAtjXNZS/jF0QYJfrvapp7efVdzeKJW7kTmuEU2VV4oWe03GUjBxT3iL9cytbWb95PmyHb2j7EGR3eGasz9XrlAW2RqHNZ8is0NcA2LvJtJWI1NJ4pGlHgpQRBOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168025; c=relaxed/simple;
	bh=G1hcaDMlY4C6ZaVbmkrRLOsJe6oTn5vXYw0EZ32Lclw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNVrrbQc2NK/IEnpOMtOMm6FyFzD5EhiBdQTopcnJ4dKrHRpcD7Pqwn53q2iPN9+m7iySFoaUjEnLWxMi4UHKWzTplQw6f20xEI9ClA4qC8z7pzUBgFenMzb/IxK5vxNwIawm/xmLA3CCwuQkE0WiN+84+YPxUvhOHi4B4qHO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhOsZeQg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773168023; x=1804704023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G1hcaDMlY4C6ZaVbmkrRLOsJe6oTn5vXYw0EZ32Lclw=;
  b=QhOsZeQgjKioH+RyVPjpOhgAFa75B52QernwDi2O7TcjQbOcJX2rgoGj
   3FGMpd/YL7sXG+bbJtbv0RkxDWvWMMl3MVT1duGYRb/OfDN1lTVIvYiPS
   zeaPp6xJJ//ULnn1am4rYOAiRyYkn7DfYB63Xa8g4jd8E+pXxr+GGFAem
   x79ZD0siwhZwD0g6HcT55XUWRjgI+xktYusVn6Ni/0uU7MwTSgCVMqFVp
   woS8J/xBt8To59bi9nFyJYJ19brD6eNHrlbB2IvxbMBlHxa3LpXi0vW5e
   SG23zQUD4GPiDzuUEUSEJEA5/jTEybFeJhqUZ70zvcVszqStG5Sg/YCNj
   A==;
X-CSE-ConnectionGUID: 34TYnX/KSxWuo4d1MyslEg==
X-CSE-MsgGUID: c5cDL78gRQm701CpXJ9ISg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73248591"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="73248591"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:40:22 -0700
X-CSE-ConnectionGUID: zu9TJGtgQQy+0cTlxhFhBA==
X-CSE-MsgGUID: yd0bVJBGRFql7n1aA3WKEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224389692"
Received: from gaggeryt-mobl.sc.intel.com ([172.25.65.89])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:40:20 -0700
From: gaggery.tsai@intel.com
To: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Cc: ckeepax@opensource.cirrus.com,
	mstrozek@opensource.cirrus.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	TsaiGaggery <gaggery.tsai@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SDCA: Fix NULL pointer dereference in sdca_jack_process()
Date: Tue, 10 Mar 2026 11:38:29 -0700
Message-ID: <20260310183829.2907805-1-gaggery.tsai@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CFB532567E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-224546-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaggery.tsai@intel.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,cirrus.com:email]
X-Rspamd-Action: no action

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

Fix this by deferring the rwsem and kctl initialization until after
a NULL check on card and card->snd_card, returning -ENODEV if the
card is not available. This is consistent with the same defensive
pattern used by existing SDCA codec drivers (e.g. rt721-sdca.c,
rt712-sdca.c).

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
 sound/soc/sdca/sdca_jack.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

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


