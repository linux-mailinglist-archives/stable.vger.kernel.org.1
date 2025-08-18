Return-Path: <stable+bounces-171060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC452B2A709
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA277BA8DB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2220D335BD4;
	Mon, 18 Aug 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pYLtqKde"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4951335BAA;
	Mon, 18 Aug 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524687; cv=none; b=GSRGVfZYxl3/za8C5i2OAt6Qwb5TvCE5O7qR4d/WWS4VfXe1v9IP/0laOryLhxQziKsvYVF35vpAgcMnBvzKtovN1cOFBj7j3U4JolAWBvOftos6sTTqjVYIaxNWphez1V1YD9CZC0I/3g12+GWgbNMyUMtNx6D13hegsiMiQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524687; c=relaxed/simple;
	bh=tqrLMsgtuvU7TJvkof5TrMAlgds8rn25aWUgUMO3HzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6yGWGmQuDT9r2e+8rhim6VbKDzI4jhU8hoGCS0ZT9C62HH5GyBIOlS3JP65z82UTQHhG/MI/i1vqBXJyJy6LBzvwRLApukm8Okc/gN810N23QdD5239iy64rCkH6GrTlXH9VZaJlG6P8VlrzBW8gUPjwGmubnK7+tozSu6RDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pYLtqKde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4151DC4CEEB;
	Mon, 18 Aug 2025 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524687;
	bh=tqrLMsgtuvU7TJvkof5TrMAlgds8rn25aWUgUMO3HzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYLtqKde0SK9BdCb3q4P1AizpFVCe3JRuDmMREG2gvu1gVuqRsZYtL3PWEzc9dm9t
	 YSerRU7MlE5ru3xVh5a6r3zlxmwF/vBYpv8huWCrVcSw5fDnBBJbkkAOTyL1DBBN+L
	 m5gfBNfbyHRCKr154l8vkZPZgOatQK3Kha1uIUS4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.16 008/570] ALSA: hda/realtek: Fix headset mic on HONOR BRB-X
Date: Mon, 18 Aug 2025 14:39:55 +0200
Message-ID: <20250818124506.107241285@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasiliy Kovalev <kovalev@altlinux.org>

commit b26e2afb3834d4a61ce54c8484ff6014bef0b4b7 upstream.

Add a PCI quirk to enable microphone input on the headphone jack on
the HONOR BRB-X M1010 laptop.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250811132716.45076-1-kovalev@altlinux.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11430,6 +11430,7 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1ee7, 0x2078, "HONOR BRB-X M1010", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),



