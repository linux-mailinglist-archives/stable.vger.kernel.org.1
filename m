Return-Path: <stable+bounces-72834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB6969E51
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A12288291
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368341CA6B1;
	Tue,  3 Sep 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="SCTIEJoW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ke7gOsRH"
X-Original-To: stable@vger.kernel.org
Received: from pfhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123B5227;
	Tue,  3 Sep 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367793; cv=none; b=l8zUwOCtdiDkVuodGyvoo2JZNHZX7LAtufeZOa/yh5esuTSgQpOjqks92gLNb/gydcfslowM3AWDx+sH5+EzuRfS7rLeCthUt8LraJLRtpeVuRN9HGLvWQBZL39oOYh2z2oT6mfXYGs0hAlFiY2i/goH767s40JgxLvkQbGLitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367793; c=relaxed/simple;
	bh=f0KKhbrLThdJMjZSEehIjis59dSoFnO019R8uYSZr34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GJbuX+Xu/yeo6szU5rlQL8ACWo49a2WOV6m04fbPttdJLZYrJGIyj0nlYtmmamfY80kycNVwk7TWjB2U2ug3bo47R1Xpi6iGZbs6Kux9OXBvsKAY/6L9tvex4DXIN92KhTNrbtgbCukmSnRd+XaeHR/qqmFCTXX7XNeki5F334w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=SCTIEJoW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ke7gOsRH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEB041140312;
	Tue,  3 Sep 2024 08:49:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 03 Sep 2024 08:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1725367790; x=1725454190; bh=1E+BR3n5Z2r9Job4iJ8m7+Qj6dAdD2l1
	1Popp9sAYmE=; b=SCTIEJoWndflLhuisooQw4Fajc3sPxUIHH4AELiNjRpS2lAc
	coaBOMZQL6xbbqPdDWrO1bwlTMRnc2euR53c1UGRP4oghYwSC9ZuXMSR0rADu0rC
	tfQEbMFnvdFVROKDsx4cqtMyHQu5JM0H6OuuMaX0oWzxgOGJqqxdJbmR28/o6864
	hK8viT4V84uoMovvZPosV2H1iQNuowuRYCGmozb8hOBkeZD6GXBHNwG5QBxbU/zD
	IjCDLMN7Rc6Ik7o5EJ2adKkU0w7LMnvVwiangLjZjDZ5PIxd4ezL+kCYl6sEc8+e
	d/LV305FkcR88SOBSsbc0lB+OMNP4fazLKUVkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1725367790; x=1725454190; bh=1E+BR3n5Z2r9J
	ob4iJ8m7+Qj6dAdD2l11Popp9sAYmE=; b=ke7gOsRH5cfxHIwJqdYFsVFTuUo8x
	/4SzdEPACUSiNf1U4ekVEXYrWmF62Hpvp9Kte7AL596v6BQ7rs9PxeFjmGzz68Gh
	YsrS3o01CfFXzb/07G/CY97ZKzVaM7aBQ+r9VMG5YvXcsOBdyuqtFIUn7hZ1paTD
	pBelaNSs8tAuJMwEYgUWK2JDC9T93B6niYpbgVW3ZySD+WLH7gCkDSTSKjACq+12
	XF9/4Exyf/XkiQzDtzHPZxnpqtRt+Wp7S1lLiOBflwDqa0+4cRrE4J4oFC0G0Cyd
	3MFvvQWRYORHJXw6ECNMK0G9kOUYw7Wh534c/9bEYxparStJdpNHIyfbg==
X-ME-Sender: <xms:7QXXZroU0JDe7zPRYsPzIkDCocXmuqZY6hjjH7rb2yh8fFdVCs9Dbw>
    <xme:7QXXZloLpkr2EjMucq-Al0eQCxAclkGNb_NZGbSnzNZ31jH4PMYcY0KrZADsYUVHz
    Fd41nNaxpt0iA>
X-ME-Received: <xmr:7QXXZoMJPnENco3m9sWDtkmea9HPREBDsY_-eENQRyzk80iYNUl6sd1eNdijnwi3pjuF19PCm_LYbKsCfSK4h9PnH4vfdqkF4f5ddJ3ZWt8PoyRD6z0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrg
    hrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffr
    rghtthgvrhhnpeelkefhudelteelleelteetveeffeetffekteetjeehlefggeekleeghe
    fhtdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsg
    gprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrh
    hmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdprhgtphhtthho
    pehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthh
    grlhdrkhhophgvtgesfehmuggvsgdrtghomhdprhgtphhtthhopehpvghrvgigsehpvghr
    vgigrdgtiidprhgtphhtthhopehtihifrghisehsuhhsvgdrtghomhdprhgtphhtthhope
    hkrghilhgrnhhgsehrvggrlhhtvghkrdgtohhmpdhrtghpthhtohepshgsihhnughinhhg
    sehophgvnhhsohhurhgtvgdrtghirhhruhhsrdgtohhmpdhrtghpthhtohepshhimhhonh
    htsehophgvnhhsohhurhgtvgdrtghirhhruhhsrdgtohhm
X-ME-Proxy: <xmx:7QXXZu4qnZc0yP8zYaFPa2u2EW7WZnj5rOYx3PJbo5V6gu6jaZNBIQ>
    <xmx:7QXXZq7fKPZFc67adNu71liSYSm0S8zOvAofRlaEhKalPb20vAQl7A>
    <xmx:7QXXZmgtrCGCDEzlufIgzLvKcsUh2O---JKjyAb5Iqqqpp1PjuDJ-Q>
    <xmx:7QXXZs5WmIXAZnikbQ-hvRiZDnnuVNNXwhPehEaMDRttvteUpcaERQ>
    <xmx:7gXXZihqyLaLla69jKMWz3CClVBpO3mTb2F1VKVSNgnThQ3HbtVZozA1>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 08:49:48 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal.kopec@3mdeb.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org (open list:SOUND)
Subject: [PATCH] ALSA: hda/realtek: extend quirks for Clevo V5[46]0
Date: Tue,  3 Sep 2024 14:49:31 +0200
Message-ID: <20240903124939.6213-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mic in those laptops suffers too high gain resulting in mostly (fan
or else) noise being recorded. In addition to the existing fixup about
mic detection, apply also limiting its boost. While at it, extend the
quirk to also V5[46]0TNE models, which have the same issue.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Cc: <stable@vger.kernel.org>
---
Cc: Michał Kopeć <michal.kopec@3mdeb.com>
---
 sound/pci/hda/patch_realtek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 588738ce7380..01e2414b8839 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7637,6 +7637,7 @@ enum {
 	ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7,
 	ALC287_FIXUP_LENOVO_SSID_17AA3820,
 	ALCXXX_FIXUP_CS35LXX,
+	ALC245_FIXUP_CLEVO_NOISY_MIC,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9970,6 +9971,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35lxx_autodet_fixup,
 	},
+	[ALC245_FIXUP_CLEVO_NOISY_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -10619,7 +10626,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0xa763, "Clevo V54x_6x_TU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa741, "Clevo V54x_6x_TNE", ALC245_FIXUP_CLEVO_NOISY_MIC),
+	SND_PCI_QUIRK(0x1558, 0xa763, "Clevo V54x_6x_TU", ALC245_FIXUP_CLEVO_NOISY_MIC),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb022, "Clevo NH77D[DC][QW]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.46.0


