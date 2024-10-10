Return-Path: <stable+bounces-83363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03CE9988D4
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 16:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4EE289435
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52D1CB31B;
	Thu, 10 Oct 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="oD7avbpK"
X-Original-To: stable@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A651C9B67;
	Thu, 10 Oct 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569406; cv=none; b=N46pycW6V3VAqsABXMGIK5tLHHQNCqZS8FfEfAyW591asRiTaulvcdBzuE8otaoTrnw8h0e/8VewP804gV6OWdvSOtinIL23X9CSk9qS6XZe+OfuqduUcpEvSkfBXxsIQGToy7CNXfbI8y3KqMOiSTosYS6O3u+0TaUPYx1hfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569406; c=relaxed/simple;
	bh=rbj8Ml5y0TZf+zBBpOdNUB0GBpgNqjOeQWMM1fIVEE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ankt9jtCObK6wIDZ8Hf3ZNJgEUFmoW4RUwxres4MTKPUjc5JBAeRDCCV4jdY1cg2FMU51FnsLsMIdyM72fmh+gj0fSw5zzs+2EFsPEWDzy0KUNAKkwDOgT9+lX6QpfWS4FgEpSlRp6u8i/7uIeI/oCOk2TUQsX46yFBfi3EJT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=oD7avbpK; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 4355AC0009;
	Thu, 10 Oct 2024 17:02:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 4355AC0009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1728568941; bh=mTQWToLFTJPHNXH5pRrcnw/VZiXSpMsDPPC1XDk9tlU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oD7avbpK1yQRZUz3zoMzLnagyTS6LacMWi6uIXfkUIPeezg1exNspSln79ObJlDev
	 BogkCnD5JWoRJ3sFYvbKsN/MXKPGdm4F/n6uxDJNnwO3Gt4q+OrAOTweqLjNL61tAi
	 tSdDXf3pMaEGNvHzipKrACViHrfxv7Lm9iKT1LE7SC8lEunZ24zHxJZqBgEF7+GDcg
	 fMlCE50omIJ7huCXBc3O87r0SquYUmqS3O9FUXTtR0zRFEbjlJiszYxYvrdoLj5gCr
	 X9JdzdvY30jqvesqR7rOkll5bIByJgl55y7VigrosZIaOpgjR/t9EcPBfiyU1VaM0j
	 c9BErd69fOLgg==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu, 10 Oct 2024 17:02:21 +0300 (MSK)
Received: from localhost.maximatelecom.ru (10.0.247.250) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Thu, 10 Oct 2024 17:02:18 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Daniel Baluta
	<daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <sound-open-firmware@alsa-project.org>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 6.1/6.6] ASoC: SOF: Fix runtime pm usage counter balance after fw exception
Date: Thu, 10 Oct 2024 19:01:07 +0500
Message-ID: <20241010140110.1153-3-v.shevtsov@maxima.ru>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188361 [Oct 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, maxima.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2;msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/10 12:46:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/10 12:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/10 12:06:00 #26731330
X-KSMG-AntiVirus-Status: Clean, skipped

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit b30289e7fa927f921bfb4d0d04727461706ae822 upstream.

If the retain context is enabled we will unconditionally increment the
device's pm use count on each exception and when the drivers are unloaded
we do not correct this (as we don't know how many times we 'prevented
d3 entry').
Introduce a flag to make sure that we do not increment the use count more
than once and on module unload decrement the use count if needed to
balance it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240213114729.7055-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 sound/soc/sof/core.c     | 10 ++++++++++
 sound/soc/sof/debug.c    |  8 +++++---
 sound/soc/sof/sof-priv.h |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 0938b259f703..cba0af5b86aa 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -477,6 +477,16 @@ int snd_sof_device_remove(struct device *dev)
 	 */
 	snd_sof_machine_unregister(sdev, pdata);
 
+	/*
+	 * Balance the runtime pm usage count in case we are faced with an
+	 * exception and we forcably prevented D3 power state to preserve
+	 * context
+	 */
+	if (sdev->d3_prevented) {
+		sdev->d3_prevented = false;
+		pm_runtime_put_noidle(sdev->dev);
+	}
+
 	if (sdev->fw_state > SOF_FW_BOOT_NOT_STARTED) {
 		sof_fw_trace_free(sdev);
 		ret = snd_sof_dsp_power_down_notify(sdev);
diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index d547318e0d32..7c8aafca8fde 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -433,13 +433,15 @@ static void snd_sof_ipc_dump(struct snd_sof_dev *sdev)
 
 void snd_sof_handle_fw_exception(struct snd_sof_dev *sdev, const char *msg)
 {
-	if (IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_RETAIN_DSP_CONTEXT) ||
-	    sof_debug_check_flag(SOF_DBG_RETAIN_CTX)) {
+	if ((IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_RETAIN_DSP_CONTEXT) ||
+	    sof_debug_check_flag(SOF_DBG_RETAIN_CTX)) && !sdev->d3_prevented) {
 		/* should we prevent DSP entering D3 ? */
 		if (!sdev->ipc_dump_printed)
 			dev_info(sdev->dev,
 				 "Attempting to prevent DSP from entering D3 state to preserve context\n");
-		pm_runtime_get_if_in_use(sdev->dev);
+
+		if (pm_runtime_get_if_in_use(sdev->dev) == 1)
+			sdev->d3_prevented = true;
 	}
 
 	/* dump vital information to the logs */
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index d4f6702e93dc..b27a5f9e1bc8 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -593,6 +593,7 @@ struct snd_sof_dev {
 	struct list_head dfsentry_list;
 	bool dbg_dump_printed;
 	bool ipc_dump_printed;
+	bool d3_prevented; /* runtime pm use count incremented to prevent context lost */
 
 	/* firmware loader */
 	struct sof_ipc_fw_ready fw_ready;
-- 
2.46.2


