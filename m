Return-Path: <stable+bounces-234009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEvSCt2Z1mmgGggAu9opvQ
	(envelope-from <stable+bounces-234009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:09:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8F03C008B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1178300D4DF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B63D4134;
	Wed,  8 Apr 2026 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m4DhiMtd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3A3D88E1;
	Wed,  8 Apr 2026 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671750; cv=none; b=cPifldZ+lZEnJ8tH/7jZ5tRRATpm15pRacDvJB4lU/P32VUi2H186A+WBIk9OkMJTuRaKf9xkc7PLMlpaUQxFEzS8bO0tgsyAVexvcOsPvHWwCvWB+SL2ot4IPBorPeDZh3rOoirCB/P+ao6RQ6ASmjau+s8JvEvz93NgSMD3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671750; c=relaxed/simple;
	bh=q8DUmNgMRlYqEBwz11n1RaHaEDlcAjRs9sLHY4aa0Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg79mBazdu6A6Y0brq421P1RCAUhwlIj6TAtZQAFvY1L5BoqKF8Cxc6Ux2O+7/D2Qjo6m3GI6GQSq4agRtxVssKAdMGCLTWIuZLNrjZom6kJn8Tty6EXULjlEyF6l/RNJlBSVXSRrc5PWzZNYZkg7dDe8JpCqhtZVz3CBdg1QrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m4DhiMtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E808C19421;
	Wed,  8 Apr 2026 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671750;
	bh=q8DUmNgMRlYqEBwz11n1RaHaEDlcAjRs9sLHY4aa0Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4DhiMtdPrgkxDFBzjD+hF/CnmMZ//nJdehyWVtLLzrQG2mqKz4cjOb+nb6YqGKJm
	 KjaTsletxukvBi8kK3jc6QTbnq2AzmJQjnSIHixA7NHBAfNUBdFR6uwZBaGz8D9Mhf
	 MYc3P6h4IWFBmI2Di8RwwLtcmpD61PA4mEhbJvvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Uzair Mughal <contact@uzair.is-a.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/312] ALSA: hda/realtek: Add headset jack quirk for Thinkpad X390
Date: Wed,  8 Apr 2026 19:58:58 +0200
Message-ID: <20260408175934.521100015@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234009-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 1B8F03C008B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uzair Mughal <contact@uzair.is-a.dev>

[ Upstream commit 542127f6528ca7cc3cf61e1651d6ccb58495f953 ]

The Lenovo ThinkPad X390 (ALC257 codec, subsystem ID 0x17aa2288)
does not report headset button press events. Headphone insertion is
detected (SW_HEADPHONE_INSERT), but pressing the inline microphone
button on a headset produces no input events.

Add a SND_PCI_QUIRK entry that maps this subsystem ID to
ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK, which enables
headset jack button detection through alc_fixup_headset_jack()
and ThinkPad ACPI integration. This is the same fixup used by
similar ThinkPad models (P1 Gen 3, X1 Extreme Gen 3).

Signed-off-by: Uzair Mughal <contact@uzair.is-a.dev>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260307012906.20093-1-contact@uzair.is-a.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1f069d7c3829f..9d6b3a6b8ed26 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10345,6 +10345,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x17aa, 0x2288, "Thinkpad X390", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c1, "Thinkpad P1 Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
-- 
2.51.0




