Return-Path: <stable+bounces-73867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D49706F6
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFDD281735
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A341156668;
	Sun,  8 Sep 2024 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="fNG/wcZl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+e2BokC"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DC4503C
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795364; cv=none; b=uFfKBVrFw0cVeIZsc+OdYrMvGKMz3/y4IpXLt9+5WBSykgf+gloRKWwMyKAPRz+Ql04NSqQ2B7nuuwzuSet1zMRkqD17QZcjwS1aNvV2XKTAPoQ68APBPg8TYBPlWEiOuvpEPqy1ZMfMI93OoTEh3UESo1TyqGaB8Bb6wxO0IZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795364; c=relaxed/simple;
	bh=PoQWrOxBngBXto+/buGXdnZea/0UPQiK8kC7AQh7CSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcRoT1gkt90PjrJipVPPJ9os4R20bqJyrm/vN+KrCmxRzpJWpOq1eQERAb7gXjmh09UwtHuZgd9t01anxwWDSzGbFoU9lz3J4QgL0IEAmaaM6c8S+2Hfekp5B9Wz9xXW6xlAlmZ/N3EGKyhnaPx4eQl8T3HvMCvbIW36mtA3Z5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=fNG/wcZl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+e2BokC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B7031140226;
	Sun,  8 Sep 2024 07:35:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 08 Sep 2024 07:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725795359; x=1725881759; bh=Hi4QbPFnMZ
	4xm/MGH+2x0pKoH02HgCGkIuiI6fVRHt4=; b=fNG/wcZlx1Pb+lH77dL0lYbsDH
	rYTPgsjhfhxgOnrRv59Rh0UQ5yg7ux3J+wAUDd5dP09m0syVAO8QU64PNs9neGe5
	jLxB6YO4E96QLla5nygNmclscz0aTqGzNQ53MUECZJKAuLlqLYb482csRTpTqDlm
	o56vMRDJ7lKSjTSkpVmGmFMnLi0wIdm5b3U2eVYsWgOOJomzcvir2WSe8KlU5rBC
	x/TCHJ7DM/vaIiw9NybN8Rlvp04YQEPXwyA4Wm7fWpcfXboSelp2AA1vKeiMV64y
	PlWkXc9J0DNWg179xhaT6Id+Q+I51iSWvOqOG5EzBKvutbZrFZ01JY4H9SjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725795359; x=
	1725881759; bh=Hi4QbPFnMZ4xm/MGH+2x0pKoH02HgCGkIuiI6fVRHt4=; b=R
	+e2BokC1XvEba90CGenI8oYj0Z/9UzgKxS1Ry3tvVWJYkzrORQatG5jV+nZ51VEL
	UOa7IuZIZe73F0n4uYcLJfcdjCha2MvMw7ERkpExSKmB3Iw8b4cihbVj8A07JDyJ
	IgdaHsqfndWUUMCADLzSnx0MNtqBrTgxdUo8GhZXQbUSGx9hRDS1b3DoL/DYYrLA
	/9p6wDqXsxD/oZoaghXZ0/fP6KMZdOLROVPhXiPl08GyreISIRpx60fCrxjfN5n2
	If4Qs+GDu4CgE3VBsTQY1p1gwtxuhIWZm+BfZTnLfqiX9c2Rhq57OLqGAVlEEqF8
	lrt0HAm9FWYe9dXHCcVNw==
X-ME-Sender: <xms:H4zdZjLTEOWFq6ytnXZlsxKZicLwke4PBhHKBhK13OFo0cyTjocp3g>
    <xme:H4zdZnL09vu9laO4DvxU3rSwrhwaCUxo2JQzjOFZAO2eOZB1MgiaVV9DtY5qCp25Y
    LVSzGucL1713Q>
X-ME-Received: <xmr:H4zdZrvYPFTC7RVKJhKt1gsk4WghBiO703-fpnI_rFFwfoOztOTnfbbfN9xjTVeEPPf38mSG72vlPnJgt_Z5ObX3WWgPncrWtFCVP1xkg1pVgFA6eac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoe
    hmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucgg
    tffrrghtthgvrhhnpeehueelheejveehueefudeuieehtdfhjeekgeekteetkedvleeihe
    fhueffffeuveenucffohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomhdprhgtphhtthhopehtihifrghisehsuhhsvgdruggv
X-ME-Proxy: <xmx:H4zdZsa158O9Pj3ve5HZQsh5MR6VrxQ55vG2gtRmFdm539QB9qJ_Ew>
    <xmx:H4zdZqYNxBlGU84aySo1f0svk8qHA51wusRNx9M2zTYKcMPfzDblzw>
    <xmx:H4zdZgCQqyYwP30Ru0VUe2z0Nz79EjrR88u8ukNKGxUlKYc-84yQog>
    <xmx:H4zdZobhCc28cDbWVMkWEv5ZPpkBRzVRTuAFRPZMQXt5m7Xs5sPJQg>
    <xmx:H4zdZpnpiOapLKZBdq8lMLNCOH9hUEZGMgUjUFNZU3I_4Cstcgr8J0nT>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 07:35:58 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.10.y] ALSA: hda/realtek: extend quirks for Clevo V5[46]0
Date: Sun,  8 Sep 2024 13:35:34 +0200
Message-ID: <20240908113535.13963-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090812-ample-stowaway-5c06@gregkh>
References: <2024090812-ample-stowaway-5c06@gregkh>
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
Link: https://patch.msgid.link/20240903124939.6213-1-marmarek@invisiblethingslab.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit 562755501d44cfbbe82703a62cb41502bd067bd1)
---
 sound/pci/hda/patch_realtek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1a7b7e790fca..374d25a450f4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7525,6 +7525,7 @@ enum {
 	ALC256_FIXUP_CHROME_BOOK,
 	ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7,
 	ALC287_FIXUP_LENOVO_SSID_17AA3820,
+	ALC245_FIXUP_CLEVO_NOISY_MIC,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9850,6 +9851,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_lenovo_ssid_17aa3820,
 	},
+	[ALC245_FIXUP_CLEVO_NOISY_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -10486,7 +10493,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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


