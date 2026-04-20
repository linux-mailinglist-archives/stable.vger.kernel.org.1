Return-Path: <stable+bounces-239412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AbUMR1k5mkuvwEAu9opvQ
	(envelope-from <stable+bounces-239412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:36:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE043194C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64B3735511D8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B1331A78;
	Mon, 20 Apr 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2S45e8hG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF42E093A;
	Mon, 20 Apr 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700180; cv=none; b=j56WXhde6/12VgFh5oN62EOUb/Tt0l/cHezPVJndwrw6o6F2dJgyif1Wb5x+VUor+dUUofaynmJrsJxZTzw4bGpItBEu4iAByvlnDydDW/iyprZLWKtzF2llpAlbHXtMSKCzFkime1pASr5IfIjCRtvE3B28ExFNLy6r/8iprCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700180; c=relaxed/simple;
	bh=+o6c9WYc0pAOZhoVra5Kqb7e1JRYMaENcd34ETtsSm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV5mqrpk/P9uajdGsXiBRc/xhdfRxbwBtwGnjA7djMy+wWRxoDqzi5kCmQ8gM5oi0oiPDfXsm/yDYQ9vpRFqZqmNO/VoNIFsmFTyRbWbHFyQrYQktJMgEhdhA0jrMh1UsthlvmuGCWOmQ5Ram5/9AcrnW6+QWFOvIegO4hyUrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2S45e8hG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B03C2BCB7;
	Mon, 20 Apr 2026 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700180;
	bh=+o6c9WYc0pAOZhoVra5Kqb7e1JRYMaENcd34ETtsSm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2S45e8hGgpDWlsgD1gHsPi2pb5Dg8H9ro3IXwOGPOzWKjpKh3WGmKTB2uT02YDxwJ
	 3seMcOGM0LUQxBSbyusObJL9+Qx6dGm5Y4DNSX6Nqb0nPaGtXYNEQM2f6G4gFd8wxK
	 8hJT+Q6GipgzEQIvHlp9VR6pDNGH6In1mL+72m+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fernando Garcia Corona <fgarcor@gmail.com>,
	songxiebing <songxiebing@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 040/220] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IAH10
Date: Mon, 20 Apr 2026 17:39:41 +0200
Message-ID: <20260420153935.480464653@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kylinos.cn,suse.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-239412-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,suse.de:email]
X-Rspamd-Queue-Id: 1EAE043194C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: songxiebing <songxiebing@kylinos.cn>

[ Upstream commit f0541edb2e7333f320642c7b491a67912c1f65db ]

The bass speakers are not working, and add the following entry
in /etc/modprobe.d/snd.conf:
options snd-sof-intel-hda-generic hda_model=alc287-yoga9-bass-spk-pin
Fixes the bass speakers.

So add the quick ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN here.

Reported-by: Fernando Garcia Corona <fgarcor@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221317
Signed-off-by: songxiebing <songxiebing@kylinos.cn>
Link: https://patch.msgid.link/20260405012651.133838-1-songxiebing@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 26bf942f0afb0..d954de3fd225e 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7671,6 +7671,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38fd, "ThinkBook plus Gen5 Hybrid", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3911, "Lenovo Yoga Pro 7 14IAH10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x391a, "Lenovo Yoga Slim 7 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TXNW2781_I2C),
-- 
2.53.0




