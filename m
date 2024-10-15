Return-Path: <stable+bounces-85625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCEF99E823
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D011F21BBD
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3961E378C;
	Tue, 15 Oct 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hC3KV/0B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABF1C57B1;
	Tue, 15 Oct 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993744; cv=none; b=PxgtmtuLGaQb6BSAmcXvo2VGfGO5w2oVzCM/VAwceDqi1lAlh+cxfOBIyHqyD2jn6DuaUMrkEyXnGcYI+IOrCEYcnh//KAY0xXCW0yUbr98JlpS+Rgop4PuKJaKQEBC2Zn0COkTozhrKA5OkLTi5xQklmjZB3cIGEp141CnpUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993744; c=relaxed/simple;
	bh=ocuPszL8TBKfZBZUGoTWG0pPejyf9G6SfiZPNM8MFLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nup22v6WXZ3reoSnuN7wtS+/2E4+JTPk35F1uk9QR2gnpLTPywQpkZah/Bu7fffOA9euZaJloqD5ktZO0yiCoHb45jlJRZA5mXOuYtYbfSRkFe7Z1yfw9ZY1pj4Vqlg7pBD6L21P4XgwimUh0W5Kzjboo7Mg+dtr3ZyfwvzSitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hC3KV/0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE366C4CEC6;
	Tue, 15 Oct 2024 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993744;
	bh=ocuPszL8TBKfZBZUGoTWG0pPejyf9G6SfiZPNM8MFLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hC3KV/0BEn5r0YPnEzPXP2ZRnuUPKGuFkjDq50CJCi6pOOcelpZpYZZ5KuvP7zSJT
	 fU61xy++6qxmrYYEqePQjzVSBcfLZK2fmUJGjFh1WvVduT7fMbCzwwgnSDs4JM+pzx
	 2lFVQXQhg7tbUL4b2QZLGglxa6ItbbjT/sF46xDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ai Chao <aichao@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 502/691] ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9
Date: Tue, 15 Oct 2024 13:27:30 +0200
Message-ID: <20241015112500.268242938@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ai Chao <aichao@kylinos.cn>

commit dee476950cbd83125655a3f49e00d63b79f6114e upstream.

The headset mic requires a fixup to be properly detected/used.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240926060252.25630-1-aichao@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9503,6 +9503,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1849, 0xa233, "Positivo Master C6300", ALC269_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x19e5, 0x320f, "Huawei WRT-WX9 ", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x19e5, 0x3212, "Huawei KLV-WX9 ", ALC256_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1b35, 0x1235, "CZC B20", ALC269_FIXUP_CZC_B20),
 	SND_PCI_QUIRK(0x1b35, 0x1236, "CZC TMI", ALC269_FIXUP_CZC_TMI),
 	SND_PCI_QUIRK(0x1b35, 0x1237, "CZC L101", ALC269_FIXUP_CZC_L101),



