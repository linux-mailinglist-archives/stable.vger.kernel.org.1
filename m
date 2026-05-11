Return-Path: <stable+bounces-245094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKJDHkdbAWrlWAEAu9opvQ
	(envelope-from <stable+bounces-245094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:29:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA39507D60
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76C7530062E0
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 04:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992AF36A033;
	Mon, 11 May 2026 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk3aR6Ju"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E168351C06
	for <stable@vger.kernel.org>; Mon, 11 May 2026 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473794; cv=none; b=p+LD0tjqhJ6VK3e1DTUX+tnV2PeAvzu+uXFolAC3l4b5xh+PzoXcVXavtVDCliqjdq4hxt49W4ROyTd3ZpMEWAps9oZ7lCXcbSNSWijbBBB9mlxbyfE3YmotbPHmVUlVFTaDsW6pBNQOzWPn4gr5agQfdrqP0o/clFLi8/EVRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473794; c=relaxed/simple;
	bh=Fs0OJQxWXkrUkceQIIh8xUwlumLQ4eJxzykdIOR4reI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lhdBdeUuIc5d2MXr5ASo8d8dpHjnw+do/ZUjGBTOt/B6hX6uJsaw22TzrRa4B/3zfe+lRxax6CP6xb8OMpaHRHQEqL6QYdz8+riSqloPOzpiY49QWGJGOKK+jJBodDKkxV/S/Hn8tlXUCou1/soxOUxUagZe8KLqD+ltqtsnuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk3aR6Ju; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso2728879eec.0
        for <stable@vger.kernel.org>; Sun, 10 May 2026 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473792; x=1779078592; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Nn7+K5hKPTTZ9BGRsS3kwvWBcEqqW1Azh+i+IcZJ/Q=;
        b=Lk3aR6Ju/6g1Psr6gki748DjPaZiAMV7WJEw7kWHjkimwtOuqyI/G67S0lRUfQkhLm
         4oyOhrBDMugogjrQs5gtPbKQEKzN9AYn5pr2JiUGggVGCRexKho5O3waSElRPxvPNWkn
         nIOTBvKGbjFnztV1a1w/N+ZF2QtIRVE4gpfbqzZimTbYhPvzUDEGeViGzom7W3jDf77/
         0KHh+C0IDEI7ze7Qd9px7quTQbm4sSJ4NqmUZlaKFs3GhpB+c6N4sUJeLFqWcexCEHhk
         gIhLKErOvhgsQB/LCz4mOyb3JPh4fi4yV4zUsoFzZOqtDSmdaowaGfH9yeyC/4hTI0cW
         0OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473792; x=1779078592;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Nn7+K5hKPTTZ9BGRsS3kwvWBcEqqW1Azh+i+IcZJ/Q=;
        b=qE1uMPNhSqgTqkAZ6ViqK7wht8IF7rhGzEa8KseuBKUFj2kWlGVxReVpTVUdw/9t+Z
         8dyjxDLVDMB7HhPiPquI8/aMwEnQEH+bqnmhLHQp0yUj/PdFIPPeT2mOwgqkCyB8XMjO
         MvHc9GBNCcEDBP2++tb5WvH2gcJHsERgcPMz35ymrErcoKU/wrq+h+Hsznp9xxmUj52j
         3+CNVVjz7gzuUAfIHRxkRkNQMDW+YZOtY7Ks76D3AmoO50j/fT+Usn6u+QCXHLEreCcs
         HzNUzMhbceQK5FDv6k/OrxmVRrppdMVmDFSLz3IX+OHe6iC6s/8FGuScM+8MzKvfwdZf
         P8Og==
X-Forwarded-Encrypted: i=1; AFNElJ9DalL9t1oiugIQjQNbQCVKrdogRpBPqWLdsNHRvzDIWvdd99nE6+pfYklxJrohioqDE/GFKGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuGtnjE5hCyMwkE7k4CKc8DINUtrlH5OBboFhb9sceV6G8/aiy
	fc7+xdztdFM7p3DO7zjiCeC2NAPhisfHx+knlvKfvx45DjeM9iawKX+1IUs3Abi5
X-Gm-Gg: Acq92OFU2ofUpV+diwIA58lD0JAB6j56mjLOw+vk59PvcJQuffTpFN0ZUpxvs2jvzvF
	XEgCGehSOi+ZVFFA9TqytAN05OhjHWjh6Js0ztREnyOfqHuom/sX5v341rLbXKg+7GDCK3LV3hm
	JSPueIKS/TTeE4K5gTIKqgofHlhvpnOMSyQmFSx++VvnOXLSUq5pCL3+UGDqq3RXdJ3bvg0kIWG
	Yi4CEiio/B6td2qJ/yynhtK2FyE1RLBHq1KyORuUPcWjmLU4dumaGdQtzxu/VbvhMKGGjmBJlgP
	I0G75aX1WWDjqQDqkTKym7pIwqDys/uYaULnv9QqkV2nTh3Uk0qAj0zaSSJRcQ4ghKof3+E98GL
	jumm+scU/JwosgXMQHC/AFrocRnJny/kSed0zkWvWO2kXZ2eZlexqOHUwKbjBqGdaqTDH9GoQ6f
	qvqnpU7Z9jofXLWUnvN9z7ENtHijFVpDoxkK8EsHUYyFrnPSCwOpH5Vgo+7ovxu1ZwrxgvVK/9O
	AkpAWQvFm0y
X-Received: by 2002:a05:7300:2d07:b0:2d3:9c91:6c45 with SMTP id 5a478bee46e88-2f6e24f93acmr7143307eec.6.1778473792018;
        Sun, 10 May 2026 21:29:52 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885b87dsm14492043eec.21.2026.05.10.21.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:29:51 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 11 May 2026 01:29:34 -0300
Subject: [PATCH RESEND] ALSA: hda/cs35l41: Fix firmware load work teardown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-alsa-hda-cs35l41-fw-work-teardown-v1-1-1184e9bc4f25@gmail.com>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Takashi Iwai <tiwai@suse.com>, 
 Stefan Binding <sbinding@opensource.cirrus.com>, 
 Vitaly Rodionov <vitalyr@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6027;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=Fs0OJQxWXkrUkceQIIh8xUwlumLQ4eJxzykdIOR4reI=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFmM0dY8Ed07Xu0S+LLN8cbtLSEC/aoNXK+flJzUz+U6/
 E476ppsRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAExEvomRYcXCoPjplRPS/Nf9
 +XpTOYhZYav0hYiTSysfvjp93rf74xJGhulnnuvM4lhU9PfK9N3cGgenz73IP+OPX9N+pkuRyrb
 vrvMBAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: DFA39507D60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,opensource.cirrus.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245094-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

cs35l41_hda creates ALSA controls whose private data points at the
cs35l41_hda object. The firmware load control can also queue
fw_load_work.

Those controls are not removed on component unbind, and device remove
only cancels fw_load_work through cs35l41_remove_dsp(). That helper is
skipped when halo_initialized is false. With firmware_autostart
disabled, a firmware load can be requested before the DSP has been
initialized. If the component or device is removed before the queued
work runs, the worker can run after teardown and dereference driver
state that is no longer valid.

Track the created controls and remove them on unbind so no new control
callback can reach the driver data or queue more work. Then cancel
fw_load_work to drain any request that was already queued. Also cancel
the work unconditionally during device remove before runtime PM teardown.

Fixes: 47ceabd99a28 ("ALSA: hda: cs35l41: Support Firmware switching and reloading")
Fixes: 4c870513fbb0 ("ALSA: hda: cs35l41: Add read-only ALSA control for forced mute")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 77 +++++++++++++++++++++---------
 sound/hda/codecs/side-codecs/cs35l41_hda.h |  5 ++
 2 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index b64890006bb7..7f18be0ccf5a 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1325,6 +1325,43 @@ static int cs35l41_fw_type_ctl_info(struct snd_kcontrol *kcontrol, struct snd_ct
 	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(cs35l41_hda_fw_ids), cs35l41_hda_fw_ids);
 }
 
+static void cs35l41_remove_controls(struct cs35l41_hda *cs35l41)
+{
+	if (!cs35l41->codec)
+		return;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->mute_override_ctl);
+	cs35l41->mute_override_ctl = NULL;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->fw_load_ctl);
+	cs35l41->fw_load_ctl = NULL;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->fw_type_ctl);
+	cs35l41->fw_type_ctl = NULL;
+}
+
+static int cs35l41_add_control(struct cs35l41_hda *cs35l41,
+			       struct snd_kcontrol_new *ctl,
+			       struct snd_kcontrol **kctl)
+{
+	int ret;
+
+	*kctl = snd_ctl_new1(ctl, cs35l41);
+	if (!*kctl)
+		return -ENOMEM;
+
+	ret = snd_ctl_add(cs35l41->codec->card, *kctl);
+	if (ret) {
+		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", ctl->name, ret);
+		*kctl = NULL;
+		return ret;
+	}
+
+	dev_dbg(cs35l41->dev, "Added Control %s\n", ctl->name);
+
+	return 0;
+}
+
 static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 {
 	char fw_type_ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
@@ -1360,32 +1397,23 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 	scnprintf(mute_override_ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s Forced Mute Status",
 		  cs35l41->amp_name);
 
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_type_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_type_ctl.name, ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_type_ctl.name);
-
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_load_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_load_ctl.name, ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_load_ctl.name);
+	ret = cs35l41_add_control(cs35l41, &fw_type_ctl, &cs35l41->fw_type_ctl);
+	if (ret)
+		goto err;
 
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&mute_override_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", mute_override_ctl.name,
-			ret);
-		return ret;
-	}
+	ret = cs35l41_add_control(cs35l41, &fw_load_ctl, &cs35l41->fw_load_ctl);
+	if (ret)
+		goto err;
 
-	dev_dbg(cs35l41->dev, "Added Control %s\n", mute_override_ctl.name);
+	ret = cs35l41_add_control(cs35l41, &mute_override_ctl, &cs35l41->mute_override_ctl);
+	if (ret)
+		goto err;
 
 	return 0;
+
+err:
+	cs35l41_remove_controls(cs35l41);
+	return ret;
 }
 
 static bool cs35l41_dsm_supported(acpi_handle handle, unsigned int commands)
@@ -1522,6 +1550,10 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
 		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
 		unlock_system_sleep(sleep_flags);
 		memset(comp, 0, sizeof(*comp));
+
+		cs35l41_remove_controls(cs35l41);
+		cancel_work_sync(&cs35l41->fw_load_work);
+		cs35l41->codec = NULL;
 	}
 }
 
@@ -2058,6 +2090,7 @@ void cs35l41_hda_remove(struct device *dev)
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
+	cancel_work_sync(&cs35l41->fw_load_work);
 
 	pm_runtime_get_sync(cs35l41->dev);
 	pm_runtime_dont_use_autosuspend(cs35l41->dev);
diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.h b/sound/hda/codecs/side-codecs/cs35l41_hda.h
index 7d003c598e93..56ec07c0bb74 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.h
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.h
@@ -57,6 +57,8 @@ enum control_bus {
 	SPI
 };
 
+struct snd_kcontrol;
+
 struct cs35l41_hda {
 	struct device *dev;
 	struct regmap *regmap;
@@ -75,6 +77,9 @@ struct cs35l41_hda {
 	int speaker_id;
 	struct mutex fw_mutex;
 	struct work_struct fw_load_work;
+	struct snd_kcontrol *fw_type_ctl;
+	struct snd_kcontrol *fw_load_ctl;
+	struct snd_kcontrol *mute_override_ctl;
 
 	struct regmap_irq_chip_data *irq_data;
 	bool firmware_running;

---
base-commit: 1bc46462f4c09f8d429ae8ec17f92886d604659f
change-id: 20260421-alsa-hda-cs35l41-fw-work-teardown-48cdba14a9cd

Best regards,
--
Cássio Gabriel <cassiogabrielcontato@gmail.com>
-- 
Cássio Gabriel <cassiogabrielcontato@gmail.com>


