Return-Path: <stable+bounces-148255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85EAC8EE2
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227D21693C5
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19D266B59;
	Fri, 30 May 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsnMcCHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B14230BD0;
	Fri, 30 May 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608860; cv=none; b=n0BGMY+HF9QFKYG+BGeX7fq5L/vBduKwIjhwnFwKHqJWUNsm0mvBB852dAvBZFGZMutwLif3cm4r71AdKzZZs8eXFIvq4OKbple3UlI6zoM4kVBM+8nKNgA4Ihlk5GzM76OP3JHJgB0PcA1h4KjTNzNL6q+PVDkWb3kU21hxkOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608860; c=relaxed/simple;
	bh=y8c3UFgLw0haFkZl4lWo09XnzTc7RMyN7xru2PO1SNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XlDTOyOnfSUNCfWihk995Hi9+zFjGqN1ezaC416rJpyiiNEq+PzGXU4QSIJAgTzXXk4XhIWU33RVlBpE4x/SVWe77oGjyTYNdt7jwGBIEsX9+/Up71ZQSknPvQt3pZY71CvVnKtSPpfBdf40mNJTHVvXEIHsWiUK1Y+u+XJEzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsnMcCHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C61C4CEF0;
	Fri, 30 May 2025 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608860;
	bh=y8c3UFgLw0haFkZl4lWo09XnzTc7RMyN7xru2PO1SNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsnMcCHM88y73a4yuViq1tGSAWcCyp+Z2QVEKQKMuGdNJjamw9rcKQXIcu/uDpz7f
	 DGGZCzAy7RHc1C+utIrGv1zBKVHwyKAV2B8Pv/lJ4b9PNdx4YTqD8ldmx1O8qzOmAE
	 dXZ4j9pJ2iJ0CxmcYl4Mqlfi825uISI/iWTto48NrpzIqfRxvXQXRiLdB5uubhStQE
	 g/EpaevlXtqaLGvF+Wkjf7DqJSYf1bxMhrG6YyJ1ctdMDm21tHzBgNO50Yj1ui6Xz1
	 WqVBW4/im9v2bYAMZRSZlNyHIs22dh4cs5dSM+afWk7Yyvhf2eFOmxJA7PBykXgUT1
	 gzTbWSdnEd5jQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	James Calligeros <jcalligeros99@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/18] ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change
Date: Fri, 30 May 2025 08:40:38 -0400
Message-Id: <20250530124047.2575954-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124047.2575954-1-sashal@kernel.org>
References: <20250530124047.2575954-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit f529c91be8a34ac12e7599bf87c65b6f4a2c9f5c ]

The ISENSE/VSENSE blocks are only powered up when the amplifier
transitions from shutdown to active. This means that if those controls
are flipped on while the amplifier is already playing back audio, they
will have no effect.

Fix this by forcing a power cycle around transitions in those controls.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
Link: https://patch.msgid.link/20250406-apple-codec-changes-v5-1-50a00ec850a3@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees based on
my analysis of both the commit message and code changes. Here's my
extensive explanation: ## Bug Fix Analysis This commit addresses a
specific functional bug in the tas2770 audio codec driver where
ISENSE/VSENSE controls don't work properly when changed during active
playback. The commit message clearly states: "if those controls are
flipped on while the amplifier is already playing back audio, they will
have no effect." ## Code Changes Analysis The fix is contained and
minimal, involving three key changes to `sound/soc/codecs/tas2770.c`: 1.
**Addition of `sense_event` function (lines +21 to +43)**: This function
implements a power cycling mechanism that forces the amplifier through a
shutdown state when ISENSE/VSENSE controls are changed. This ensures the
changes take effect regardless of playback state. 2. **Modified DAPM
widget definitions (lines +45 to +48)**: The ISENSE and VSENSE switches
are changed from simple `SND_SOC_DAPM_SWITCH` to `SND_SOC_DAPM_SWITCH_E`
with event handling, connecting them to the new `sense_event` function.
3. **Event triggers**: The widgets respond to `SND_SOC_DAPM_PRE_REG` and
`SND_SOC_DAPM_POST_REG` events to perform the power cycling around
register changes. ## Why This Should Be Backported 1. **User-Affecting
Bug**: This fixes a real functional issue where audio controls don't
work as expected during playback, which directly impacts user
experience. 2. **Small and Contained**: The fix is confined to a single
driver file (`tas2770.c`) and doesn't affect other subsystems. The
changes are surgical and targeted. 3. **Low Risk**: The fix follows
established ASoC patterns using standard DAPM event handling. Similar
power cycling approaches are used throughout the ASoC subsystem. 4. **No
New Features**: This purely fixes existing functionality rather than
adding new features. 5. **Comparison with Similar Commits**: Looking at
the provided examples, this commit is very similar to "Similar Commit
#2" and "Similar Commit #5" which were both marked as backportable
(YES). Like commit #2, it fixes incorrect hardware behavior with a small
register/control change. Like commit #5, it addresses power state
management issues in audio hardware. 6. **Hardware-Specific Fix**: The
commit addresses a hardware limitation specific to the tas2770 chip
where ISENSE/VSENSE blocks are only powered up during shutdown-to-active
transitions. This is documented in the commit message and is a
legitimate hardware workaround. The fix ensures that software speaker
protection functionality works correctly by guaranteeing that IVSENSE
controls are functional, which is critical for protecting audio hardware
from damage.

 sound/soc/codecs/tas2770.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 5c6b825c757b3..181b16530e5bc 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -158,11 +158,37 @@ static const struct snd_kcontrol_new isense_switch =
 static const struct snd_kcontrol_new vsense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2770_PWR_CTRL, 2, 1, 1);
 
+static int sense_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * Powering up ISENSE/VSENSE requires a trip through the shutdown state.
+	 * Do that here to ensure that our changes are applied properly, otherwise
+	 * we might end up with non-functional IVSENSE if playback started earlier,
+	 * which would break software speaker protection.
+	 */
+	switch (event) {
+	case SND_SOC_DAPM_PRE_REG:
+		return snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
+						    TAS2770_PWR_CTRL_MASK,
+						    TAS2770_PWR_CTRL_SHUTDOWN);
+	case SND_SOC_DAPM_POST_REG:
+		return tas2770_update_pwr_ctrl(tas2770);
+	default:
+		return 0;
+	}
+}
+
 static const struct snd_soc_dapm_widget tas2770_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("ASI1", "ASI1 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_MUX("ASI1 Sel", SND_SOC_NOPM, 0, 0, &tas2770_asi1_mux),
-	SND_SOC_DAPM_SWITCH("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch),
-	SND_SOC_DAPM_SWITCH("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch),
+	SND_SOC_DAPM_SWITCH_E("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
 	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2770_dac_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUTPUT("OUT"),
-- 
2.39.5


