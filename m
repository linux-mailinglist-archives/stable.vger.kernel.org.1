Return-Path: <stable+bounces-245464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ETdEt8gA2r10gEAu9opvQ
	(envelope-from <stable+bounces-245464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:45:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F23520602
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96263308B597
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09ED4A3412;
	Tue, 12 May 2026 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ajiptSpu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72604C6F0D
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588891; cv=none; b=niG1OEHH2NHKjxXJUsvsldlkl/gZUfvvtuffnbVNVSrcE6YlZPdEI9E85jlsFpzdsaH6H36pSMh7vGYRvDjIrdZ+InpOK86xydMuAgtDNXt5u+rneN7ftlMQTsMFRdliD3d53qtAGuAXqF1H/+TAIQNiaVzMVLsdIbWRoXyl1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588891; c=relaxed/simple;
	bh=UNlOp2OiqZS1sECrXIYhoSkC/pYlky6LZXFQFYyPJ1c=;
	h=Subject:To:Cc:From:Date:Message-ID; b=CS18aZG0n32UsBczWJXlkUQz2ATkitf9I9BTefzvqohbr9oe3h8122lWy8sZlvJTa7utAIlhgunGm9uRte90mfE0nbP8vKgU242tbZekG3rsnmRadqvy3VlyFDTbVHi0U5HeP7j7uSmj7YnIik0Rtp0JXmyJQ0YUSiUuKRBcamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ajiptSpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EC5C2BCB0;
	Tue, 12 May 2026 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778588890;
	bh=UNlOp2OiqZS1sECrXIYhoSkC/pYlky6LZXFQFYyPJ1c=;
	h=Subject:To:Cc:From:Date:From;
	b=ajiptSpus9se7xgnxCJvhc+t6w8N2cEfnoonPEuYyCgaaO8yQ9UxtIgdqhvXwepNR
	 CmdBINNrrlpnU0AMTH2KiXUEVDzE5V3k4XFLohetRGkx8BlSw4Wi5C2t/WQfFuPo2W
	 hVo8fFM855B8tndLmfXmptlh1eVShIJJO4BTHO2k=
Subject: FAILED: patch "[PATCH] ALSA: hda: cs35l56: Propagate ASP TX source control errors" failed to apply to 6.6-stable tree
To: cassiogabrielcontato@gmail.com,rf@opensource.cirrus.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:28:02 +0200
Message-ID: <2026051202-kiln-obstinate-3d53@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B0F23520602
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245464-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[gmail.com,opensource.cirrus.com,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,cirrus.com:email,linuxfoundation.org:dkim]
X-Rspamd-Action: add header
X-Spam: Yes


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0faacc0841d66f3cf51989c10a83f3a82d52ff2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051202-kiln-obstinate-3d53@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0faacc0841d66f3cf51989c10a83f3a82d52ff2c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 23 Apr 2026 10:11:31 -0300
Subject: [PATCH] ALSA: hda: cs35l56: Propagate ASP TX source control errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index 1ace4beef508..dc25960a4f23 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -180,11 +180,15 @@ static int cs35l56_hda_mixer_get(struct snd_kcontrol *kcontrol,
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
@@ -203,15 +207,20 @@ static int cs35l56_hda_mixer_put(struct snd_kcontrol *kcontrol,
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


