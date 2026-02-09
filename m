Return-Path: <stable+bounces-214936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF+dOsnuiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:27:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BBD110434
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E4FA3019511
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CC37A4AE;
	Mon,  9 Feb 2026 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDNB7r3k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2E3793AC
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647129; cv=none; b=LFFLPLzbG2Tfp2G7G6zd37aXIA82X6MjROvVNHfg7oFq7relKWjDfhLRkJBvg4x5SBtAOLc1RvXeuW/5ftRc7W+NmLXovrV30iLe8QtDgFd/2cGqX8A234sdEUorl2rQrPtUk+8GqIbWuhV9XZe0k46nwmj04DsIbnvzTEk3AF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647129; c=relaxed/simple;
	bh=xifsbT5i+O2RlAXDVijzWYmYaIhD8SBP8V4eVqS0vz0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nk3cOOrvgU3GMJybSZvC55VQ53D9Rdwl2xfdR4OBiHpLQHy+iNjgKuJpaGcwwBE+oN8L3IRlvG6PhHwNiRZV982To6B0UqwTQyQDgKKebXZHEW0/SfM8yQ95/vxFmnJCFbO2C3OFW5tJk8+2+CB/1jNrrSOIkzlNenvAwzr8Pcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDNB7r3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A8C116C6;
	Mon,  9 Feb 2026 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647129;
	bh=xifsbT5i+O2RlAXDVijzWYmYaIhD8SBP8V4eVqS0vz0=;
	h=Subject:To:Cc:From:Date:From;
	b=eDNB7r3khDMG1b6oudiOUXL0suSme3sizPcJiixdF/n09wfysoBHjmFfAVEUo6vKk
	 wDLZW4STvk3yGxAVcusnPLd9/0SgPXjhvJ3R7DhUtw40//Gw1YvbytT/SGgM2/sWOz
	 r4cd66PlWa1pUzmw438mj9oQ9AIZOu1Nw6rQfgPU=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Really fix headset mic for TongFang" failed to apply to 5.15-stable tree
To: wse@tuxedocomputers.com,t.guttzeit@tuxedocomputers.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Feb 2026 15:10:24 +0100
Message-ID: <2026020924-criteria-grandma-757a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214936-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,tuxedocomputers.com:email,suse.de:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 32BBD110434
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1aaedafb21f38cb872d44f7608b4828a1e14e795
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020924-criteria-grandma-757a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1aaedafb21f38cb872d44f7608b4828a1e14e795 Mon Sep 17 00:00:00 2001
From: Werner Sembach <wse@tuxedocomputers.com>
Date: Fri, 23 Jan 2026 23:12:24 +0100
Subject: [PATCH] ALSA: hda/realtek: Really fix headset mic for TongFang
 X6AR55xU.

Add a PCI quirk to enable microphone detection on the headphone jack of
TongFang X6AR55xU devices.

The former quirk entry did not acomplish this and is removed.

Fixes: b48fe9af1e60 ("ALSA: hda/realtek: Fix headset mic for TongFang X6AR55xU")
Signed-off-by: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://patch.msgid.link/20260123221233.28273-1-wse@tuxedocomputers.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 770b21ad55c4..4b19d26d9822 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7347,6 +7347,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d05, 0x300f, "TongFang X6AR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d05, 0x3019, "TongFang X6FR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x3031, "TongFang X6AR55xU", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
@@ -7816,10 +7817,6 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60140},
 		{0x19, 0x04a11030},
 		{0x21, 0x04211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1d05, "TongFang", ALC274_FIXUP_HP_HEADSET_MIC,
-		{0x17, 0x90170110},
-		{0x19, 0x03a11030},
-		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0282, 0x1025, "Acer", ALC282_FIXUP_ACER_DISABLE_LINEOUT,
 		ALC282_STANDARD_PINS,
 		{0x12, 0x90a609c0},


