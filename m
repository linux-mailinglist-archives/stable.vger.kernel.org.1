Return-Path: <stable+bounces-215453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOp/Nzr2iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:59:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2FC11151F
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CAED30159C1
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E038E37BE8C;
	Mon,  9 Feb 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jCqN6jTP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC228312F;
	Mon,  9 Feb 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648842; cv=none; b=Oe+R/Q1dzrBsmHsSIo1+/rXYjFCWxbIt5SieeMefaiTk77w+Iv+y17Us8zMR8ukyXqcctIVLSomO6Dg4nTfspOsQ4BoS/cOSTJ6dC3dEZ7Qsz4fWuHJrL39lwY8vc0kbVN4C/0patsPk81jJqOlFZhv3fPtLklTpGu6RAGdl+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648842; c=relaxed/simple;
	bh=iMqgfUkkBspvbZ9+YXZz0hmlOjFX1VtwM7DM5Onjv74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=askhnY89fvr0uG/pHY8J9Dw4KYC9oEXgHWwADNRL1T97Ai33aF7p4zhF0SxZRbi9i7owcc1IaSJaJZhn3SsqViuVc0UgLYapjWUmCDSfZhSUxZLbHoWdyHVppMJydPEcPCqaH15RBsLGItnULMpPAxy3Q/ab1Uq3uQ9lHWUorHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCqN6jTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3B3C16AAE;
	Mon,  9 Feb 2026 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648842;
	bh=iMqgfUkkBspvbZ9+YXZz0hmlOjFX1VtwM7DM5Onjv74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCqN6jTPtmGuCi2VsIY0hOnnIWqN2mmF74EVVIG4gGN1+ts3Bo7BCDoi7OfHjBdi9
	 0/OOkJ7MlA0OXlUVXN9Z0nnZ5LIdk1D/rLcfSSq5PjtIMDAODCWhmCxqBs1JB6CMj+
	 8nlwCf1SC1aseug5mCfSKrzGEBKizdRgc5EFLN4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ruslan Krupitsa <krupitsarus@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 32/75] ALSA: hda/realtek: add HP Laptop 15s-eq1xxx mute LED quirk
Date: Mon,  9 Feb 2026 15:24:29 +0100
Message-ID: <20260209142303.003820587@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215453-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,suse.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 3E2FC11151F
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruslan Krupitsa <krupitsarus@outlook.com>

[ Upstream commit 9ed7a28225af02b74f61e7880d460db49db83758 ]

HP Laptop 15s-eq1xxx with ALC236 codec does not enable the
mute LED automatically. This patch adds a quirk entry for
subsystem ID 0x8706 using the ALC236_FIXUP_HP_MUTE_LED_COEFBIT2
fixup, enabling correct mute LED behavior.

Signed-off-by: Ruslan Krupitsa <krupitsarus@outlook.com>
Link: https://patch.msgid.link/AS8P194MB112895B8EC2D87D53A876085BBBAA@AS8P194MB1128.EURP194.PROD.OUTLOOK.COM
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 10f7f807e706e..839a7e957d42a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9333,6 +9333,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x863e, "HP Spectre x360 15-df1xxx", ALC285_FIXUP_HP_SPECTRE_X360_DF1),
 	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x86f9, "HP Spectre x360 13-aw0xxx", ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x8706, "HP Laptop 15s-eq1xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8716, "HP Elite Dragonfly G2 Notebook PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8720, "HP EliteBook x360 1040 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8724, "HP EliteBook 850 G7", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.51.0




