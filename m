Return-Path: <stable+bounces-21113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458185C72F
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBBB1F2365C
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E690C151CE1;
	Tue, 20 Feb 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hU/diUTY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF21509A5;
	Tue, 20 Feb 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463392; cv=none; b=nHjTWp1E6XobRXn7XIpOTgu01TW9NaALgR51SVxfRVCzCNfFcu8FN46+Vgs2gHVhBX9mPunqsMqsr64zcLSyBtltryp0lX26psDC3YGZmSwHNBYRmBndAjzXP5evat4/FJ7X1jAC06c0rJQh0GP2nOMKdMd38Q6jFp7+E93iVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463392; c=relaxed/simple;
	bh=hHyplAoI7TsPjYld/AaziVSdydDi4VfrNnF4IYGiHMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPNo0Kw/1465iwoLDElMmOTn+FLHPZYck/JvJUq7Dtq8LfbypWXk/YFHz6ChoewEgTkYvvVNkoQ5tl36c6ipGqt6sAayyh8H8JD6M+UsXplji0N8eGhfjujSn0d7vQYFXea7KCfC2CrGNRpMo3+cle2jCqM0qKcyEWr2NaoySqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hU/diUTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F52C433C7;
	Tue, 20 Feb 2024 21:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463392;
	bh=hHyplAoI7TsPjYld/AaziVSdydDi4VfrNnF4IYGiHMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hU/diUTYBhkuAl5eN9X1LoSpj2Iib9/az+Pk9yiCgdfOp4xVvB9J9KOO8VHSFH1zG
	 BytvpljVgXu+D8IQapcqOOdEfzrcX9YqglnVTRjU0fA0r5/WDTwULu3uSFjif9FCmP
	 HrDizh5ztgVDHK+ECJtthEUsIskEsMpew5Bdbar4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 022/331] ASoC: SOF: ipc3-topology: Fix pipeline tear down logic
Date: Tue, 20 Feb 2024 21:52:18 +0100
Message-ID: <20240220205638.286673635@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit d7332c4a4f1a7d16f054c6357fb65c597b6a86a7 ]

With the change in the widget free logic to power down the cores only
when the scheduler widgets are freed, we need to ensure that the
scheduler widget is freed only after all the widgets associated with the
scheduler are freed. This is to ensure that the secondary core that the
scheduler is scheduled to run on is kept powered on until all widgets
that need them are in use. While this works well for dynamic pipelines,
in the case of static pipelines the current logic does not take this into
account and frees all widgets in the order they occur in the
widget_list. So, modify this to ensure that the scheduler widgets are freed
only after all other types of widgets in the widget_list are freed.

Link: https://github.com/thesofproject/linux/issues/4807
Fixes: 31ed8da1c8e5 ("ASoC: SOF: sof-audio: Modify logic for enabling/disabling topology cores")
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20240208133432.1688-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-topology.c | 55 ++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index 2c7a5e7a364c..d96555438c6b 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -2309,27 +2309,16 @@ static int sof_tear_down_left_over_pipelines(struct snd_sof_dev *sdev)
 	return 0;
 }
 
-/*
- * For older firmware, this function doesn't free widgets for static pipelines during suspend.
- * It only resets use_count for all widgets.
- */
-static int sof_ipc3_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verify)
+static int sof_ipc3_free_widgets_in_list(struct snd_sof_dev *sdev, bool include_scheduler,
+					 bool *dyn_widgets, bool verify)
 {
 	struct sof_ipc_fw_version *v = &sdev->fw_ready.version;
 	struct snd_sof_widget *swidget;
-	struct snd_sof_route *sroute;
-	bool dyn_widgets = false;
 	int ret;
 
-	/*
-	 * This function is called during suspend and for one-time topology verification during
-	 * first boot. In both cases, there is no need to protect swidget->use_count and
-	 * sroute->setup because during suspend all running streams are suspended and during
-	 * topology loading the sound card unavailable to open PCMs.
-	 */
 	list_for_each_entry(swidget, &sdev->widget_list, list) {
 		if (swidget->dynamic_pipeline_widget) {
-			dyn_widgets = true;
+			*dyn_widgets = true;
 			continue;
 		}
 
@@ -2344,11 +2333,49 @@ static int sof_ipc3_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verif
 			continue;
 		}
 
+		if (include_scheduler && swidget->id != snd_soc_dapm_scheduler)
+			continue;
+
+		if (!include_scheduler && swidget->id == snd_soc_dapm_scheduler)
+			continue;
+
 		ret = sof_widget_free(sdev, swidget);
 		if (ret < 0)
 			return ret;
 	}
 
+	return 0;
+}
+
+/*
+ * For older firmware, this function doesn't free widgets for static pipelines during suspend.
+ * It only resets use_count for all widgets.
+ */
+static int sof_ipc3_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verify)
+{
+	struct sof_ipc_fw_version *v = &sdev->fw_ready.version;
+	struct snd_sof_widget *swidget;
+	struct snd_sof_route *sroute;
+	bool dyn_widgets = false;
+	int ret;
+
+	/*
+	 * This function is called during suspend and for one-time topology verification during
+	 * first boot. In both cases, there is no need to protect swidget->use_count and
+	 * sroute->setup because during suspend all running streams are suspended and during
+	 * topology loading the sound card unavailable to open PCMs. Do not free the scheduler
+	 * widgets yet so that the secondary cores do not get powered down before all the widgets
+	 * associated with the scheduler are freed.
+	 */
+	ret = sof_ipc3_free_widgets_in_list(sdev, false, &dyn_widgets, verify);
+	if (ret < 0)
+		return ret;
+
+	/* free all the scheduler widgets now */
+	ret = sof_ipc3_free_widgets_in_list(sdev, true, &dyn_widgets, verify);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Tear down all pipelines associated with PCMs that did not get suspended
 	 * and unset the prepare flag so that they can be set up again during resume.
-- 
2.43.0




