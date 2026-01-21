Return-Path: <stable+bounces-211038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NKLLDopcWkqfAAAu9opvQ
	(envelope-from <stable+bounces-211038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:30:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822F5C308
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F87AC8F2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BBE3AA1B2;
	Wed, 21 Jan 2026 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jjTctD/w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FC3659F2;
	Wed, 21 Jan 2026 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020227; cv=none; b=nOSO40mEf63BO1rEF7rm++sdBUmgah46IwsdEAMiGIIPY+/be1zHQHBlIjfJLDmmC6AqY3ZiI7tXD0kJb/jDpq8E2l+pY74GVXmzwrg38EIQ/VIsKdPyZYnpHvX3t4kZJhNTfOaufhlc6cL3P2wYwUog9wIoWiQeKuXYLJQyZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020227; c=relaxed/simple;
	bh=G8PN1NmVSgEJsC2MMEBiscAebHpCPXVajUg7EpXBXaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbunvLe1ZpA9ucctXsWyLgXkUm53c4ttVL5jEPIrgs9X9tyEBFJ8GoB5zNYqKqB24I+sgs+xd6KVRRH/ySDFg3k/bs16mWKtRwuSjM8U6UG2zGgqnkdpjF039OEoGdn2yIBpKA10acqni2/Ph+4tNfNUFQkZ2hkWthydvXFTH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jjTctD/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC0C4CEF1;
	Wed, 21 Jan 2026 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020227;
	bh=G8PN1NmVSgEJsC2MMEBiscAebHpCPXVajUg7EpXBXaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjTctD/wQ7pPEH5YmdsEMYY7NiIHfB58/TxnLGAtut0CVZ/HmvtwvTnQRp3xn+k65
	 44PirM29Vo7CeD2vwbjfTU9k37RHmNhLtqIlNUtQjLuopjqoyoHc5Qup1hA9iPltz3
	 Wq86d1TFsU0TpgsSSjlP6SC4G3o4NiiiHt1qMeNM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baojun Xu <baojun.xu@ti.com>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 095/198] ALSA: hda/tas2781: Skip UEFI calibration on ASUS ROG Xbox Ally X
Date: Wed, 21 Jan 2026 19:15:23 +0100
Message-ID: <20260121181421.973813485@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211038-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,ti.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url,suse.de:email,linux.dev:email,antheas.dev:email]
X-Rspamd-Queue-Id: 5822F5C308
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Schwartz <matthew.schwartz@linux.dev>

commit b7e26c8bdae70832d7c4b31ec2995b1812a60169 upstream.

There is currently an issue with UEFI calibration data parsing for some
TAS devices, like the ASUS ROG Xbox Ally X (RC73XA), that causes audio
quality issues such as gaps in playback. Until the issue is root caused
and fixed, add a quirk to skip using the UEFI calibration data and fall
back to using the calibration data provided by the DSP firmware, which
restores full speaker functionality on affected devices.

Cc: stable@vger.kernel.org # 6.18
Link: https://lore.kernel.org/all/160aef32646c4d5498cbfd624fd683cc@ti.com/
Closes: https://lore.kernel.org/all/0ba100d0-9b6f-4a3b-bffa-61abe1b46cd5@linux.dev/
Suggested-by: Baojun Xu <baojun.xu@ti.com>
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20260108093650.1142176-1-matthew.schwartz@linux.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -60,6 +60,7 @@ struct tas2781_hda_i2c_priv {
 	int (*save_calibration)(struct tas2781_hda *h);
 
 	int hda_chip_id;
+	bool skip_calibration;
 };
 
 static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
@@ -491,7 +492,8 @@ static void tasdevice_dspfw_init(void *c
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
-	hda_priv->save_calibration(tas_hda);
+	if (!hda_priv->skip_calibration)
+		hda_priv->save_calibration(tas_hda);
 }
 
 static void tasdev_fw_ready(const struct firmware *fmw, void *context)
@@ -548,6 +550,7 @@ static int tas2781_hda_bind(struct devic
 	void *master_data)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct tas2781_hda_i2c_priv *hda_priv = tas_hda->hda_priv;
 	struct hda_component_parent *parent = master_data;
 	struct hda_component *comp;
 	struct hda_codec *codec;
@@ -573,6 +576,14 @@ static int tas2781_hda_bind(struct devic
 		break;
 	}
 
+	/*
+	 * Using ASUS ROG Xbox Ally X (RC73XA) UEFI calibration data
+	 * causes audio dropouts during playback, use fallback data
+	 * from DSP firmware as a workaround.
+	 */
+	if (codec->core.subsystem_id == 0x10431384)
+		hda_priv->skip_calibration = true;
+
 	pm_runtime_get_sync(dev);
 
 	comp->dev = dev;



