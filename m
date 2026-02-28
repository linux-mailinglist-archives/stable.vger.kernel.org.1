Return-Path: <stable+bounces-220502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJHmGRw6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:55:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DDE1C6690
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6940831A7FA4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8993C97B3;
	Sat, 28 Feb 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5ambMn7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB63C97AA;
	Sat, 28 Feb 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300386; cv=none; b=RNUpqOVhJuovjAML/+RCdtKhZVHmmoY81QbHJJKOSh8pKl4inZwaFnVdnw5lKZwz20in1iCnHQgGSODMTJKUYaUFMcqQRNKEapzPFImAiv45zZD02ZZBpnTBu+UjlLXPzn8EcjMakOs4PT9X1ZBPLhtILoyx5CyE6wDWzk/JIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300386; c=relaxed/simple;
	bh=6Qso9r6u69JTBCvIc5ianu2/g1XD02SfiWBTrKGkfMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc5sBfSsxovb+g/gQa1GAt4in7uDK+Df0f9PWL5gU/TYVM6qjMrvdcjHQTOUwm5oBut7i3oQAGBVSo6DuxqaPN85G3GdkLVoTdCvXcdQTdO8vi5EjNfeLsSQoFmcKwL4K3cK+5Y//n8uoU/5E/aY8gd6RKg0/VfzkIOAR/d+zGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5ambMn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEABC116D0;
	Sat, 28 Feb 2026 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300386;
	bh=6Qso9r6u69JTBCvIc5ianu2/g1XD02SfiWBTrKGkfMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5ambMn7lLMBbTWEBNazXGfaLngcQnnxKrZ15KN4ZQyHqKGqyVCPsy6rgt968N8zM
	 gkK/VXNdE1ctzxW7CVzxL6IaQXI0E+eO1auuQcJN37WfBv834aP/uOiRm51519tIPl
	 uej8Elgnr7yrTBmdC6mFyAYPkx6biC8Y/DJJxDC1fRAnHaANI9/dXcki5MVbrW2szW
	 cZrnLHoAMQ24IZ3ItxDxpQV5qT7JzS8ixf8XokgfDkVXwdHpfaCGzv313LFyRhPc/q
	 GjAGQZyNeB09mZyTNIeKe99g7HdlVBD9ldohZhvr9IvBynmeOYEl/DHmPOZFe75hc2
	 KLc+rAP6blq4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baojun Xu <baojun.xu@ti.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 423/844] ALSA: hda/tas2781: Ignore reset check for SPI device
Date: Sat, 28 Feb 2026 12:25:36 -0500
Message-ID: <20260228173244.1509663-424-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220502-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E6DDE1C6690
X-Rspamd-Action: no action

From: Baojun Xu <baojun.xu@ti.com>

[ Upstream commit 908ef80e31e4d3bd953a0088fe57640cd9ae7b3e ]

In the SPI driver probe, the device should be in the default state, so the
device status check is not necessary. It should be forced to do the
firmware download as I2C device.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
Link: https://patch.msgid.link/20260211030946.2330-1-baojun.xu@ti.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../hda/codecs/side-codecs/tas2781_hda_spi.c  | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index b9a55672bf15d..488e35dac9524 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -634,7 +634,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	struct tasdevice_priv *tas_priv = context;
 	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
 	struct hda_codec *codec = tas_priv->codec;
-	int ret, val;
+	int ret;
 
 	pm_runtime_get_sync(tas_priv->dev);
 	guard(mutex)(&tas_priv->codec_lock);
@@ -673,20 +673,14 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tas_priv->rcabin.profile_cfg_id = 0;
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
-	ret = tasdevice_spi_dev_read(tas_priv, tas_priv->index,
-		TAS2781_REG_CLK_CONFIG, &val);
-	if (ret < 0)
-		goto out;
 
-	if (val == TAS2781_REG_CLK_CONFIG_RESET) {
-		ret = tasdevice_prmg_load(tas_priv, 0);
-		if (ret < 0) {
-			dev_err(tas_priv->dev, "FW download failed = %d\n",
-				ret);
-			goto out;
-		}
-		tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+	ret = tasdevice_prmg_load(tas_priv, 0);
+	if (ret < 0) {
+		dev_err(tas_priv->dev, "FW download failed = %d\n", ret);
+		goto out;
 	}
+	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+
 	if (tas_priv->fmw->nr_programs > 0)
 		tas_priv->tasdevice[tas_priv->index].cur_prog = 0;
 	if (tas_priv->fmw->nr_configurations > 0)
-- 
2.51.0


