Return-Path: <stable+bounces-246851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGHILlOABGrmKwIAu9opvQ
	(envelope-from <stable+bounces-246851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:44:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B39853448B
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4881031A946E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB724963A9;
	Wed, 13 May 2026 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrjSrQ0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91A23FC5A
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677874; cv=none; b=DrJQq4WHCMCkPiQ0UsGR4UUUinwW8y7CePkYym1xIIFyycA2IZhWu+GAp035v26SPI8qMRD9AVm3t4smLDFq05IIytx5snm86JYh1iBaLfLpk38I9QLsA5f9UaN7hphJL5UjWdXEQSVRFjzeb8pRv7Mv4/NA0lQUY48uVQTIgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677874; c=relaxed/simple;
	bh=N0Bscs7iaDtf8SLmQTmvvQnboDg6DvD0Q8EcTp8NQtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RouETgsejrituqnjbqGLpMaXId9h1FKHsWcVnF1IcBTvSnTlk4KlMWw9yyMi1zOvHkBRRvq4A4osicjkYssi8pNNXWYMKh61AvAF+4EfiHjbMm+qRsgf/5Ab7EAvp/yfmfIooSYz4D69fRV62FyJHoigfowl8pYSVvXxtJuY2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrjSrQ0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61010C2BCB7;
	Wed, 13 May 2026 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778677874;
	bh=N0Bscs7iaDtf8SLmQTmvvQnboDg6DvD0Q8EcTp8NQtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrjSrQ0tGaccNwQEydyluaYfraPB24zi6ggSmfc3XRLn6P4JVwBgw4SOW7iYtaGKp
	 zl3ZGzJVPdLK8m0osqcPOQTF2qB2itM+08hFTQpa6TnHhRc+wqyeW4Nme3Xs2VvCTq
	 AOrK5xIapnVk6AxX+sPjDkpmMiOdOycZ1S3MNnbhaqa0XO1Wumx0a7YexI78SoxqWV
	 m/H4+QO7nB7gHq1z0B4wt8YaZ3EwjRk4fS6wbJIQTXg1uYt24MCLfeNoRZMJ+q0xpQ
	 R4l9g7+oXWUkEHn+e9IsiisziU/Hm2k4DpPo/M3HNeIFefFh1uDCIQwFxJFW2Xhfx+
	 lwtho5PMEbw1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda: cs35l56: Propagate ASP TX source control errors
Date: Wed, 13 May 2026 09:11:11 -0400
Message-ID: <20260513131111.3723022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051201-viscosity-proven-0477@gregkh>
References: <2026051201-viscosity-proven-0477@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B39853448B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,opensource.cirrus.com,suse.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-246851-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cirrus.com:email]
X-Rspamd-Action: no action

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 0faacc0841d66f3cf51989c10a83f3a82d52ff2c ]

cs35l56_hda_mixer_get() ignores regmap_read() and
cs35l56_hda_mixer_put() ignores regmap_update_bits_check().

This makes the ASP TX source controls report success when a regmap
access fails. The write path returns no change instead of an error,
and the read path continues after a failed read instead of aborting
the control callback.

Propagate the regmap errors, matching the posture and volume controls
in this driver.

Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260423-alsa-cs35l56-asp-tx-source-errors-v1-1-17ea7c62ec31@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l56_hda.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 2a936f43fad2d..c868177712866 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -182,11 +182,15 @@ static int cs35l56_hda_mixer_get(struct snd_kcontrol *kcontrol,
 {
 	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int reg_val;
-	int i;
+	int i, ret;
 
 	cs35l56_hda_wait_dsp_ready(cs35l56);
 
-	regmap_read(cs35l56->base.regmap, kcontrol->private_value, &reg_val);
+	ret = regmap_read(cs35l56->base.regmap, kcontrol->private_value,
+			  &reg_val);
+	if (ret)
+		return ret;
+
 	reg_val &= CS35L56_ASP_TXn_SRC_MASK;
 
 	for (i = 0; i < CS35L56_NUM_INPUT_SRC; ++i) {
@@ -205,15 +209,20 @@ static int cs35l56_hda_mixer_put(struct snd_kcontrol *kcontrol,
 	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int item = ucontrol->value.enumerated.item[0];
 	bool changed;
+	int ret;
 
 	if (item >= CS35L56_NUM_INPUT_SRC)
 		return -EINVAL;
 
 	cs35l56_hda_wait_dsp_ready(cs35l56);
 
-	regmap_update_bits_check(cs35l56->base.regmap, kcontrol->private_value,
-				 CS35L56_INPUT_MASK, cs35l56_tx_input_values[item],
-				 &changed);
+	ret = regmap_update_bits_check(cs35l56->base.regmap,
+				       kcontrol->private_value,
+				       CS35L56_INPUT_MASK,
+				       cs35l56_tx_input_values[item],
+				       &changed);
+	if (ret)
+		return ret;
 
 	return changed;
 }
-- 
2.53.0


