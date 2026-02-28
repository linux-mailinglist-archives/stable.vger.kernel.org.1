Return-Path: <stable+bounces-220293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDe5DFk0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46451C5E26
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C721F32A1DBF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782ED3884D0;
	Sat, 28 Feb 2026 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFbmIxoV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F293884C7;
	Sat, 28 Feb 2026 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300197; cv=none; b=EQDc8Pmcou+RWzYiGxzBAkEmydiPv+xKuwIR0GtHs/MRQkHokUrYUeESQRBSIsJ3b0sDgeFp2vaEmhOHrobVwVk4sBdbpZGXpQwmPxvY7DVTLy0PYce+rVcMJonQt39JLh8es5G3D0OubFTLgkAwDGXhQs0CMk+qHnwalQ2vOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300197; c=relaxed/simple;
	bh=ihM/50EQk5ZYXzXdh2AxqEuLIbEdjM8Y4qOk8e9bSf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwW9o1/ANztsYZbYg62/KRwO4LHlaBiPx3oQuWL2E08l264Sdk40lsrz32JbIymXcqGVWccdThsaO0JjPIlyVB4AaTN3Nqpd9FTinay6wRm/YCv1CIC1Z7tY+F5FZnKU8/uN8hA7r6DKyHsTjJuX/sEE9NYY11TD7PIC3K/C5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFbmIxoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B8DC19424;
	Sat, 28 Feb 2026 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300197;
	bh=ihM/50EQk5ZYXzXdh2AxqEuLIbEdjM8Y4qOk8e9bSf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFbmIxoVgeAoe0xvip0i86judlWrQq7JdvgVVSLu1jw1UBT8EJCzHh2CBMBMVVgb8
	 A94xbuvrGOzBogP5Yb5m1/dduaVFI2eLakpXtD0Qdnyv5DH1Iy5hF9vOkMEBr3ql9H
	 Ntaa9+oXOsvyTABurM78CrDPf74At2mWDWnk+JxKrsREB8iW0CN3FnbX0By5HvbmVm
	 sX/NI52j4BtFNuuQ62dIueTZesshkjBhJ8Wnwe/ZcabsM92VoA4wXgNq9bQjSE0Vzo
	 4EYOnMUiNBIMpr2cMsSp5KywguJGkKCJDv0Y7bLC/7NkuNWshoUzR7vQMmWY2Im/UF
	 82S6M8m/7oBNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: gongqi <550230171hxy@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 215/844] ALSA: hda/conexant: Add headset mic fix for MECHREVO Wujie 15X Pro
Date: Sat, 28 Feb 2026 12:22:08 -0500
Message-ID: <20260228173244.1509663-216-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220293-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A46451C5E26
X-Rspamd-Action: no action

From: gongqi <550230171hxy@gmail.com>

[ Upstream commit f2581ea2d9f30844c437e348a462027ea25c12e9 ]

The headset microphone on the MECHREVO Wujie 15X Pro requires the
CXT_FIXUP_HEADSET_MIC quirk to function properly. Add the PCI SSID
(0x1d05:0x3012) to the quirk table.

Signed-off-by: gongqi <550230171hxy@gmail.com>
Link: https://patch.msgid.link/20260122155501.376199-5-550230171hxy@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 0c517378a6d28..f71123a475464 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -1134,6 +1134,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad/Ideapad", CXT_FIXUP_LENOVO_XPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
+	SND_PCI_QUIRK(0x1d05, 0x3012, "MECHREVO Wujie 15X Pro", CXT_FIXUP_HEADSET_MIC),
 	HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
 	HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
-- 
2.51.0


