Return-Path: <stable+bounces-26046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50559870CC2
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34A01F22AD2
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEDF7B3C3;
	Mon,  4 Mar 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JhHRjQv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC808626B2;
	Mon,  4 Mar 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587704; cv=none; b=aOiCAYpU/pEp7t4XeRGqKLb1CUSD/s79Q10J99i6QpTvLFK7XRMPUx6ByPg9lZJlT9l1LXiSwsJzODNuDU5W9Z/IPHq81MpoplwJ418vHC/AoK/2PkkNJtVp182jYsPjQQ+zDHtRZQfBAf/XQsBlod2bFzIp7hBcI5zqJyLazK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587704; c=relaxed/simple;
	bh=YewuyJqqGMPdf4pEtPI0JKHebCgjLRevolXlQ0Bx1t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwvEWY0TBWWn/0xQ332gh/bEDH/Vqgx/CCCM8Sy2/90uY4w9/E4KI/zcG+7mqTTi5xGcz2QvqpiLIOX5TevDpqDHpg3BSNo1k9nom8lIQ8X7T09zTQiWQO7bgdKgfXB1f2TmaOcC1i9bxJRbJKWkyoMrB7YYnnWGplFSbQpKd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JhHRjQv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C59C433C7;
	Mon,  4 Mar 2024 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587703;
	bh=YewuyJqqGMPdf4pEtPI0JKHebCgjLRevolXlQ0Bx1t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JhHRjQv6WnVSblmPcj3UvsVqTG/yJn5duhB+yJEYcjaLCp4eWdFz0OdIJIEpcn1BP
	 sQghXyWVSM656sAUlAekPIKyO11jwH+5kIDiRVnaMwm3WN1v7pF85UMVY+7w0hzblP
	 JIzKLKPQNK8h669FHfIhnfugvDKlZLaHRCE22EpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 057/162] ASoC: cs35l56: Fix misuse of wm_adsp part string for silicon revision
Date: Mon,  4 Mar 2024 21:22:02 +0000
Message-ID: <20240304211553.677836362@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit f6c967941c5d6fa526fdd64733a8d86bf2bfab31 ]

Put the silicon revision and secured flag in the wm_adsp fwf_name
string instead of including them in the part string.

This changes the format of the firmware name string from

 cs35l56[s]-rev-misc[-system_name]

to
 cs35l56-rev[-s]-misc[-system_name]

No firmware files have been published, so this doesn't cause a
compatibility break.

Silicon revision and secured flag are included in the firmware
filename to pick a firmware compatible with the part. These strings
were being added to the part string, but that is a misuse of the
string. The correct place for these is the fwf_name string, which
is specifically intended to select between multiple firmware files
for the same part.

Backport note:
This won't apply to kernels older than v6.6.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 608f1b0dbdde ("ASoC: cs35l56: Move DSP part string generation so that it is done only once")
Link: https://msgid.link/r/20240129162737.497-12-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: eba2eb2495f4 ("ASoC: soc-card: Fix missing locking in snd_soc_card_get_kcontrol()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 30f4b9e9cc94c..f05fab577f037 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -886,6 +886,18 @@ static void cs35l56_dsp_work(struct work_struct *work)
 
 	pm_runtime_get_sync(cs35l56->base.dev);
 
+	/* Populate fw file qualifier with the revision and security state */
+	if (!cs35l56->dsp.fwf_name) {
+		cs35l56->dsp.fwf_name = kasprintf(GFP_KERNEL, "%02x%s-dsp1",
+						  cs35l56->base.rev,
+						  cs35l56->base.secured ? "-s" : "");
+		if (!cs35l56->dsp.fwf_name)
+			goto err;
+	}
+
+	dev_dbg(cs35l56->base.dev, "DSP fwf name: '%s' system name: '%s'\n",
+		cs35l56->dsp.fwf_name, cs35l56->dsp.system_name);
+
 	/*
 	 * When the device is running in secure mode the firmware files can
 	 * only contain insecure tunings and therefore we do not need to
@@ -905,7 +917,7 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	 * on the DAPM mutex.
 	 */
 	queue_work(cs35l56->dsp_wq, &cs35l56->mux_init_work);
-
+err:
 	pm_runtime_mark_last_busy(cs35l56->base.dev);
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
@@ -958,6 +970,9 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 
 	wm_adsp2_component_remove(&cs35l56->dsp, component);
 
+	kfree(cs35l56->dsp.fwf_name);
+	cs35l56->dsp.fwf_name = NULL;
+
 	cs35l56->component = NULL;
 }
 
@@ -1309,12 +1324,6 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret)
 		return ret;
 
-	/* Populate the DSP information with the revision and security state */
-	cs35l56->dsp.part = devm_kasprintf(cs35l56->base.dev, GFP_KERNEL, "cs35l56%s-%02x",
-					   cs35l56->base.secured ? "s" : "", cs35l56->base.rev);
-	if (!cs35l56->dsp.part)
-		return -ENOMEM;
-
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
 		cs35l56->soft_resetting = true;
-- 
2.43.0




