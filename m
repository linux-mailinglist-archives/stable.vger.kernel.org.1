Return-Path: <stable+bounces-248918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG4pMsuJB2ol7gIAu9opvQ
	(envelope-from <stable+bounces-248918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:02:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 206DE5579C6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE4FF3011BE9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A903E9F8D;
	Fri, 15 May 2026 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UMRk2HAp"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7266305691
	for <stable@vger.kernel.org>; Fri, 15 May 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878835; cv=none; b=DKo/QBcvrblPIq4KFwwsNsHtZQW9Qnq5f/E2BNC45b3xOppzCacB9S19KOIbu7SjauAKLpWKXv+IbQGkxhRmlTKjfhgV1GMJd3WyKBbz+ityNLYH7g4oOsQl1JugfVlG9at/Aeev60Rcwg/5hEtUmP3vLxqcyLmb1jYH54hd324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878835; c=relaxed/simple;
	bh=DNrcjPDZp1vTRLO4V9Aw/mVVXk5GfYHbt9Axc/SCGP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKr8Ot8d2uMqRHZI6WeSbkW5/JZvHjCYmRjTPQaxSg0JgHY+8UD0tDt4yKpjrmEP36fX+DGYyYDrlYbrRVPGRByDDnSUgH1UEIpKgTjQNKCJqlqzLl3s8atLkbHjvgJACZ5TxIxBBh9HNkUwbPG4M4ai7KiNqhG+Nw6BQ+18eVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UMRk2HAp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EQkctFu1PhrSPsr6U1V8TCCdZXIpbzTTOSLQysxZDdw=; b=UMRk2HApvV9LdhqX26hvTDLpb9
	/xZ9VI6DcdES+CDXHP2yY2BlrZFgBpFQleNIVhMjr/IIuczrLljMyPrtE6XFqC2F3icGdDGoHsaBs
	WcwrZeugscz4Pc6P1bE8JG8wJL2syoRtRvImPwf7nrDn6cZdfHIHX2JjwJH04GAH/HGWn9sL8U79U
	JTBRzh08+PAxVy4ow0NWzbxm5NOZh4rPZUvGTFHKSZc376ksRvq/RWvgvsYByIh0nOOP6QE7+EIva
	Eum4xawlDC1JWNH1UITygtHKzfbKEdlHXW5kVY6Lk5ZNYv/BPXa7MqNTihSmmgDkLXtl9JJR/Uzjz
	hB7dUJkg==;
Received: from [187.90.172.56] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wNzdx-000gyk-KZ; Fri, 15 May 2026 23:00:26 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Vijendar.Mukunda@amd.com,
	venkataprasad.potturu@amd.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	stable@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>,
	Umang Jain <uajain@igalia.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Melissa Wen <mwen@igalia.com>
Subject: [PATCH 6.12.y] ASoC: amd: acp: Add DMI quirk for Valve Steam Deck OLED
Date: Fri, 15 May 2026 17:49:58 -0300
Message-ID: <20260515205733.196362-4-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260515205733.196362-2-gpiccoli@igalia.com>
References: <20260515205733.196362-2-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 206DE5579C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,perex.cz,suse.com,vger.kernel.org,igalia.com,kernel.org,collabora.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248918-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gpiccoli@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.630];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,igalia.com:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,collabora.com:email]
X-Rspamd-Action: no action

commit b0f6f4ac7d5d04fe2adcdd63ed1cd1ad505b8958 upstream.

Commit 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink creation for I2S BT instance")
introduced a change that "broke" Steam Deck's audio probe, in the OLED
model, as observed in the following dmesg snippet:

[...]
snd_sof_amd_vangogh 0000:04:00.5: Topology: ABI 3:26:0 Kernel ABI 3:23:1
sof_mach nau8821-max: ASoC: physical link acp-bt-codec (id 2) not exist
sof_mach nau8821-max: ASoC: topology: could not load header: -22
snd_sof_amd_vangogh 0000:04:00.5: tplg amd/sof-tplg/sof-vangogh-nau8821-max.tplg component load failed -22
snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP topology -22
snd_sof_amd_vangogh 0000:04:00.5: ASoC error (-22): at snd_soc_component_probe() on 0000:04:00.5
sof_mach nau8821-max: ASoC: failed to instantiate card -22
sof_mach nau8821-max: error -EINVAL: Failed to register card(sof-nau8821-max)
sof_mach nau8821-max: probe with driver sof_mach failed with error -22
[...]

Notice the quotes in "broke": it's not really a bug in such commit,
but instead a problem with a topology file from Steam Deck OLED. This
was discussed to great extent in [1], and Cristian proposed a pretty
simple and functional change that resolved the issue for the Deck's
issue. That change, though, would break other devices, so it wasn't
accepted upstream. And the proper suggested solution (fix the topology)
was never implemented, so Valve's kernel (and anyone that wants to boot
the mainline on Steam Deck OLED) is carrying that fix downstream.

So, we propose hereby a different approach: a DMI quirk, as many already
present in the sound drivers, to address this issue solely on Steam Deck
OLED, not breaking other devices and as a bonus, allowing simple patch
up in case eventually the topology file gets fixed (we'd just need to
check against any DMI info reflecting that or the topology/FW versions).

The motivation of such upstream quirk is related to users that want
to test latest kernel trees on their devices and get no only non-working
sound device, but seems some games (like Ori and the Blind Forest)
can't properly work without a proper functional audio device.
Example of such report can be seen at [2].

Cc: Mark Brown <broonie@kernel.org>
Cc: Robert Beckett <bob.beckett@collabora.com>
Cc: Umang Jain <uajain@igalia.com>
Fixes: 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink creation for I2S BT instance")
Link: https://lore.kernel.org/r/20231209205351.880797-11-cristian.ciocaltea@collabora.com/ [1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218677 [2]
Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Link: https://patch.msgid.link/20260423183505.116445-1-gpiccoli@igalia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[gpiccoli: git auto-merge due to simple context changes.]
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c |  2 +-
 sound/soc/amd/acp/acp-mach-common.c | 22 +++++++++++++++++++---
 sound/soc/amd/acp/acp-mach.h        |  4 ++++
 sound/soc/amd/acp/acp-sof-mach.c    |  2 +-
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index d104f7e8fdcd..4221fc0f081b 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -174,7 +174,7 @@ static int acp_asoc_probe(struct platform_device *pdev)
 		acp_card_drvdata->platform =  *((int *)dev->platform_data);
 
 	dmi_id = dmi_first_match(acp_quirk_table);
-	if (dmi_id && dmi_id->driver_data)
+	if (dmi_id && dmi_id->driver_data == (void *)QUIRK_TDM_MODE_ENABLE)
 		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
 
 	ret = acp_legacy_dai_links_create(card);
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index e9ff4815c12c..6c0a92d76b54 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -20,6 +20,7 @@
 #include <sound/soc.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/dmi.h>
 
 #include "../../codecs/rt5682.h"
 #include "../../codecs/rt1019.h"
@@ -37,15 +38,21 @@
 #define NAU8821_FREQ_OUT	12288000
 #define MAX98388_CODEC_DAI	"max98388-aif1"
 
-#define TDM_MODE_ENABLE 1
-
 const struct dmi_system_id acp_quirk_table[] = {
 	{
 		/* Google skyrim proto-0 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_FAMILY, "Google_Skyrim"),
 		},
-		.driver_data = (void *)TDM_MODE_ENABLE,
+		.driver_data = (void *)QUIRK_TDM_MODE_ENABLE,
+	},
+	{
+		/* Valve Steam Deck OLED */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		},
+		.driver_data = (void *)QUIRK_REMAP_DMIC_BT,
 	},
 	{}
 };
@@ -1385,6 +1392,7 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 	struct snd_soc_dai_link *links;
 	struct device *dev = card->dev;
 	struct acp_card_drvdata *drv_data = card->drvdata;
+	const struct dmi_system_id *dmi_id = dmi_first_match(acp_quirk_table);
 	int i = 0, num_links = 0;
 
 	if (drv_data->hs_cpu_id)
@@ -1562,6 +1570,9 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			links[i].codecs = &snd_soc_dummy_dlc;
 			links[i].num_codecs = 1;
 		}
+
+		if (dmi_id && dmi_id->driver_data == (void *)QUIRK_REMAP_DMIC_BT)
+			links[i].id = DMIC_BE_ID;
 		i++;
 	}
 
@@ -1577,6 +1588,11 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 		links[i].dpcm_capture = 1;
 		links[i].nonatomic = true;
 		links[i].no_pcm = 1;
+
+		if (dmi_id && dmi_id->driver_data == (void *)QUIRK_REMAP_DMIC_BT) {
+			links[i].id = BT_BE_ID;
+			dev_dbg(dev, "quirk REMAP_DMIC_BT enabled\n");
+		}
 	}
 
 	card->dai_link = links;
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 93d9e3886b7e..4b255cbde9ff 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -24,6 +24,10 @@
 
 #define acp_get_drvdata(card) ((struct acp_card_drvdata *)(card)->drvdata)
 
+/* List of DMI quirks - check acp-mach-common.c for usage. */
+#define QUIRK_TDM_MODE_ENABLE 1
+#define QUIRK_REMAP_DMIC_BT 2
+
 enum be_id {
 	HEADSET_BE_ID = 0,
 	AMP_BE_ID,
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index f36750167fa2..4c069a34fbe1 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -113,7 +113,7 @@ static int acp_sof_probe(struct platform_device *pdev)
 
 	acp_card_drvdata = card->drvdata;
 	dmi_id = dmi_first_match(acp_quirk_table);
-	if (dmi_id && dmi_id->driver_data)
+	if (dmi_id && dmi_id->driver_data == (void *)QUIRK_TDM_MODE_ENABLE)
 		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
 
 	ret = acp_sofdsp_dai_links_create(card);
-- 
2.50.1


