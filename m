Return-Path: <stable+bounces-26301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F5870DF6
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5CA1C20C8E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965051F93F;
	Mon,  4 Mar 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FFnCFIm/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641A8F58;
	Mon,  4 Mar 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588366; cv=none; b=UY3rwPCg+TTc1HZ4V/eEmKR1EOczF/iSZ/3K04WnrSSQ4olAqrt9NSnJL4JrQjQWDxb7oXOgglNmMvhYvgmqbHk0l2WwwiXyrAz6bbJzY5IVK9zPRruldQXhPhSG2eX+N3gmGQ6NKObizdoCMXDEXSQenmmp9jV3ER88YK1qVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588366; c=relaxed/simple;
	bh=ILCwAT38u20mZWRNNpJ0pIjejAVcO8eDPIucePubXCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZByacIL2eerjVNLlEI185yRB5QhqE/ivRojyiuMqNow5L1Aos6GjskOXxfdGy5anQ9chalTYs7DbBhNS8BQvu24UcOx6G5W5ntW8YsuarrKgCb0UpIH3/C35hei9r+vJHKLf8RRrUxshAlBfX49ttws8RGTRaOY+OVMgNNDpE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FFnCFIm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD670C433F1;
	Mon,  4 Mar 2024 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588366;
	bh=ILCwAT38u20mZWRNNpJ0pIjejAVcO8eDPIucePubXCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFnCFIm/+LQ6rlTYJ5pQckuCtrzJbd8JLuaQVzfUPqvw1Swi+F9Yhz+N8gpk/Tw+X
	 UuBUZUpsPTxn8ZX/y00Oj5sbC8Om3IXcU5BJLGWumR1DYIfLuJc+pEhQCP/G5/0797
	 cTk0qnl8G8XTjH3JMnV9gsMlHzxmA2b/0GDgKkR8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 055/143] ASoC: cs35l56: Fix deadlock in ASP1 mixer register initialization
Date: Mon,  4 Mar 2024 21:22:55 +0000
Message-ID: <20240304211551.688280749@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit c14f09f010cc569ae7e2f6ef02374f6bfef9917e ]

Rewrite the handling of ASP1 TX mixer mux initialization to prevent a
deadlock during component_remove().

The firmware can overwrite the ASP1 TX mixer registers with
system-specific settings. This is mainly for hardware that uses the
ASP as a chip-to-chip link controlled by the firmware. Because of this
the driver cannot know the starting state of the ASP1 mixer muxes until
the firmware has been downloaded and rebooted.

The original workaround for this was to queue a work function from the
dsp_work() job. This work then read the register values (populating the
regmap cache the first time around) and then called
snd_soc_dapm_mux_update_power(). The problem with this is that it was
ultimately triggered by cs35l56_component_probe() queueing dsp_work,
which meant that it would be running in parallel with the rest of the
ASoC component and card initialization. To prevent accessing DAPM before
it was fully initialized the work function took the card mutex. But this
would deadlock if cs35l56_component_remove() was called before the work job
had completed, because ASoC calls component_remove() with the card mutex
held.

This new version removes the work function. Instead the regmap cache and
DAPM mux widgets are initialized the first time any of the associated ALSA
controls is read or written.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 07f7d6e7a124 ("ASoC: cs35l56: Fix for initializing ASP1 mixer registers")
Link: https://lore.kernel.org/r/20240208123742.1278104-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 153 +++++++++++++++++--------------------
 sound/soc/codecs/cs35l56.h |   2 +-
 2 files changed, 73 insertions(+), 82 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 3a3782fb70bf0..83178d7c1197b 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -68,63 +68,7 @@ static const char * const cs35l56_asp1_mux_control_names[] = {
 	"ASP1 TX1 Source", "ASP1 TX2 Source", "ASP1 TX3 Source", "ASP1 TX4 Source"
 };
 
-static int cs35l56_dspwait_asp1tx_get(struct snd_kcontrol *kcontrol,
-				      struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
-	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	int index = e->shift_l;
-	unsigned int addr, val;
-	int ret;
-
-	/* Wait for mux to be initialized */
-	cs35l56_wait_dsp_ready(cs35l56);
-	flush_work(&cs35l56->mux_init_work);
-
-	addr = cs35l56_asp1_mixer_regs[index];
-	ret = regmap_read(cs35l56->base.regmap, addr, &val);
-	if (ret)
-		return ret;
-
-	val &= CS35L56_ASP_TXn_SRC_MASK;
-	ucontrol->value.enumerated.item[0] = snd_soc_enum_val_to_item(e, val);
-
-	return 0;
-}
-
-static int cs35l56_dspwait_asp1tx_put(struct snd_kcontrol *kcontrol,
-				      struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
-	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
-	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	int item = ucontrol->value.enumerated.item[0];
-	int index = e->shift_l;
-	unsigned int addr, val;
-	bool changed;
-	int ret;
-
-	/* Wait for mux to be initialized */
-	cs35l56_wait_dsp_ready(cs35l56);
-	flush_work(&cs35l56->mux_init_work);
-
-	addr = cs35l56_asp1_mixer_regs[index];
-	val = snd_soc_enum_item_to_val(e, item);
-
-	ret = regmap_update_bits_check(cs35l56->base.regmap, addr,
-				       CS35L56_ASP_TXn_SRC_MASK, val, &changed);
-	if (!ret)
-		return ret;
-
-	if (changed)
-		snd_soc_dapm_mux_update_power(dapm, kcontrol, item, e, NULL);
-
-	return changed;
-}
-
-static void cs35l56_mark_asp1_mixer_widgets_dirty(struct cs35l56_private *cs35l56)
+static int cs35l56_sync_asp1_mixer_widgets_with_firmware(struct cs35l56_private *cs35l56)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cs35l56->component);
 	const char *prefix = cs35l56->component->name_prefix;
@@ -135,13 +79,19 @@ static void cs35l56_mark_asp1_mixer_widgets_dirty(struct cs35l56_private *cs35l5
 	unsigned int val[4];
 	int i, item, ret;
 
+	if (cs35l56->asp1_mixer_widgets_initialized)
+		return 0;
+
 	/*
 	 * Resume so we can read the registers from silicon if the regmap
 	 * cache has not yet been populated.
 	 */
 	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
 	if (ret < 0)
-		return;
+		return ret;
+
+	/* Wait for firmware download and reboot */
+	cs35l56_wait_dsp_ready(cs35l56);
 
 	ret = regmap_bulk_read(cs35l56->base.regmap, CS35L56_ASP1TX1_INPUT,
 			       val, ARRAY_SIZE(val));
@@ -151,12 +101,9 @@ static void cs35l56_mark_asp1_mixer_widgets_dirty(struct cs35l56_private *cs35l5
 
 	if (ret) {
 		dev_err(cs35l56->base.dev, "Failed to read ASP1 mixer regs: %d\n", ret);
-		return;
+		return ret;
 	}
 
-	snd_soc_card_mutex_lock(dapm->card);
-	WARN_ON(!dapm->card->instantiated);
-
 	for (i = 0; i < ARRAY_SIZE(cs35l56_asp1_mux_control_names); ++i) {
 		name = cs35l56_asp1_mux_control_names[i];
 
@@ -176,16 +123,65 @@ static void cs35l56_mark_asp1_mixer_widgets_dirty(struct cs35l56_private *cs35l5
 		snd_soc_dapm_mux_update_power(dapm, kcontrol, item, e, NULL);
 	}
 
-	snd_soc_card_mutex_unlock(dapm->card);
+	cs35l56->asp1_mixer_widgets_initialized = true;
+
+	return 0;
 }
 
-static void cs35l56_mux_init_work(struct work_struct *work)
+static int cs35l56_dspwait_asp1tx_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
 {
-	struct cs35l56_private *cs35l56 = container_of(work,
-						       struct cs35l56_private,
-						       mux_init_work);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int index = e->shift_l;
+	unsigned int addr, val;
+	int ret;
 
-	cs35l56_mark_asp1_mixer_widgets_dirty(cs35l56);
+	ret = cs35l56_sync_asp1_mixer_widgets_with_firmware(cs35l56);
+	if (ret)
+		return ret;
+
+	addr = cs35l56_asp1_mixer_regs[index];
+	ret = regmap_read(cs35l56->base.regmap, addr, &val);
+	if (ret)
+		return ret;
+
+	val &= CS35L56_ASP_TXn_SRC_MASK;
+	ucontrol->value.enumerated.item[0] = snd_soc_enum_val_to_item(e, val);
+
+	return 0;
+}
+
+static int cs35l56_dspwait_asp1tx_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int item = ucontrol->value.enumerated.item[0];
+	int index = e->shift_l;
+	unsigned int addr, val;
+	bool changed;
+	int ret;
+
+	ret = cs35l56_sync_asp1_mixer_widgets_with_firmware(cs35l56);
+	if (ret)
+		return ret;
+
+	addr = cs35l56_asp1_mixer_regs[index];
+	val = snd_soc_enum_item_to_val(e, item);
+
+	ret = regmap_update_bits_check(cs35l56->base.regmap, addr,
+				       CS35L56_ASP_TXn_SRC_MASK, val, &changed);
+	if (!ret)
+		return ret;
+
+	if (changed)
+		snd_soc_dapm_mux_update_power(dapm, kcontrol, item, e, NULL);
+
+	return changed;
 }
 
 static DECLARE_TLV_DB_SCALE(vol_tlv, -10000, 25, 0);
@@ -909,14 +905,6 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	else
 		cs35l56_patch(cs35l56);
 
-
-	/*
-	 * Set starting value of ASP1 mux widgets. Updating a mux takes
-	 * the DAPM mutex. Post this to a separate job so that DAPM
-	 * power-up can wait for dsp_work to complete without deadlocking
-	 * on the DAPM mutex.
-	 */
-	queue_work(cs35l56->dsp_wq, &cs35l56->mux_init_work);
 err:
 	pm_runtime_mark_last_busy(cs35l56->base.dev);
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
@@ -953,6 +941,13 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 	debugfs_create_bool("can_hibernate", 0444, debugfs_root, &cs35l56->base.can_hibernate);
 	debugfs_create_bool("fw_patched", 0444, debugfs_root, &cs35l56->base.fw_patched);
 
+	/*
+	 * The widgets for the ASP1TX mixer can't be initialized
+	 * until the firmware has been downloaded and rebooted.
+	 */
+	regcache_drop_region(cs35l56->base.regmap, CS35L56_ASP1TX1_INPUT, CS35L56_ASP1TX4_INPUT);
+	cs35l56->asp1_mixer_widgets_initialized = false;
+
 	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
 	return 0;
@@ -963,7 +958,6 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
 
 	cancel_work_sync(&cs35l56->dsp_work);
-	cancel_work_sync(&cs35l56->mux_init_work);
 
 	if (cs35l56->dsp.cs_dsp.booted)
 		wm_adsp_power_down(&cs35l56->dsp);
@@ -1034,10 +1028,8 @@ int cs35l56_system_suspend(struct device *dev)
 
 	dev_dbg(dev, "system_suspend\n");
 
-	if (cs35l56->component) {
+	if (cs35l56->component)
 		flush_work(&cs35l56->dsp_work);
-		cancel_work_sync(&cs35l56->mux_init_work);
-	}
 
 	/*
 	 * The interrupt line is normally shared, but after we start suspending
@@ -1188,7 +1180,6 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 		return -ENOMEM;
 
 	INIT_WORK(&cs35l56->dsp_work, cs35l56_dsp_work);
-	INIT_WORK(&cs35l56->mux_init_work, cs35l56_mux_init_work);
 
 	dsp = &cs35l56->dsp;
 	cs35l56_init_cs_dsp(&cs35l56->base, &dsp->cs_dsp);
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index dc2fe4c91e67b..d9fbf568a1958 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -34,7 +34,6 @@ struct cs35l56_private {
 	struct wm_adsp dsp; /* must be first member */
 	struct cs35l56_base base;
 	struct work_struct dsp_work;
-	struct work_struct mux_init_work;
 	struct workqueue_struct *dsp_wq;
 	struct snd_soc_component *component;
 	struct regulator_bulk_data supplies[CS35L56_NUM_BULK_SUPPLIES];
@@ -51,6 +50,7 @@ struct cs35l56_private {
 	u8 asp_slot_count;
 	bool tdm_mode;
 	bool sysclk_set;
+	bool asp1_mixer_widgets_initialized;
 	u8 old_sdw_clock_scale;
 };
 
-- 
2.43.0




