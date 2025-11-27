Return-Path: <stable+bounces-197464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E3FC8F184
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF99E34F085
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A25333436D;
	Thu, 27 Nov 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YNiRnRvY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7FF24E4A8;
	Thu, 27 Nov 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255895; cv=none; b=ksDXXuOsFuk3poUKe9FiYBOH7tXFcY/+awaCyOJ06YCSr8gRPgvRroqigPzLQvqKCKyVFyRatGJGAatmPyK9u64fUZu+kE9RlGtulHPEmoZeWW46G7GegyV314DFDvtKZNQ/2YIZp8qAhm5onn11AiUx4VdPoksF3V9FS9xfK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255895; c=relaxed/simple;
	bh=JgmGiiSX1t2F1II0BDwe8Igo3RCIz9dQDeBsZrBaJRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFF1rb1XvWvKtxJRRkvlpiP4B/B18qy3DQR496T9WuCEfoxv8H42QMy6ryi3qLSgsaviGbrOkaPQqAA6t5Hfkp5REEGooI7XdtQDXvc/O1zt7d3RvNgayk1btgA24nFYodFJp9sgxGc5aWyAN5tMPfQCqVeWsj1F0iD719w4y2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YNiRnRvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0CDC4CEF8;
	Thu, 27 Nov 2025 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255895;
	bh=JgmGiiSX1t2F1II0BDwe8Igo3RCIz9dQDeBsZrBaJRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNiRnRvYnOuLLPsYMTq2l9Zr3YWl7XHdx1wzXka9Rc5VL4iS5XCNY+zI2hz69n3wt
	 v+VSZWuP9tvWiIXSTT84CwfXHAFW+0ga/xAzxvL1v6mf9E4vvDWaBHsA73B43cR7We
	 K24byDbFeOAa0idm/zVeVnkgRfrsvVw6j098QadQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	J-Donald Tournier <jdtournier@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 134/175] ALSA: hda/realtek: Add quirk for Lenovo Yoga 7 2-in-1 14AKP10
Date: Thu, 27 Nov 2025 15:46:27 +0100
Message-ID: <20251127144047.851935224@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J-Donald Tournier <jdtournier@gmail.com>

[ Upstream commit 1386d16761c0b569efedb998f56c1ae048a086e2 ]

This laptop requires the same quirk as Lenovo Yoga9 14IAP7 for
fixing the bass speaker problems.

Use HDA_CODEC_QUIRK to match on the codec SSID to avoid conflict with
the Lenovo Legion Slim 7 16IRH8, which has the same PCI SSID.

Signed-off-by: J-Donald Tournier <jdtournier@gmail.com>
Link: https://patch.msgid.link/20251018145322.39119-1-jdournier@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 19604352317dd..20f0ad43953f4 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7082,6 +7082,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38a9, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
+	HDA_CODEC_QUIRK(0x17aa, 0x391c, "Lenovo Yoga 7 2-in-1 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.51.0




