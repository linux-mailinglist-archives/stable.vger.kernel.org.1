Return-Path: <stable+bounces-232290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LXKCiAGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FCB36EFDB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0933330BD1E4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD32425CC4;
	Tue, 31 Mar 2026 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScXkOD+N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDF423A88;
	Tue, 31 Mar 2026 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976367; cv=none; b=WlJbaGWlcaKnG5rw/LJT/PY/CyFv0/Vei4hUNoQrkVjgroJjlUingLbzsjg2PB4MlFlUWSjV7tzSuIxob+R5+RVed0Ak1Nx+8rWEk4s4vzN2cRkWfVTjUXT/dnqQ0lqCwifRXvsSzOaUGL9Sw5IFuKG1MSUt9g5iKhoYQHaGVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976367; c=relaxed/simple;
	bh=nEEKlVpCPpAAnlYPhLXdKtFIHi65ieQ/dl9EX9/Mdlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+yj4tyb8R18PwOVAobKfS6Dztvckf8qRsKMyFwc5LYglNY3jEN9VmGIyd1sk8NJXZkSwOmoCE3uvxIAw7j7WFrH/qUbpkFcUaSPA3RYTJadHCKH289vRln2aiVFb5jBqM97JquWrhOzyIy2vCUyvJmQoduTBkcqZEACzAn6+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScXkOD+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F34C2BCB1;
	Tue, 31 Mar 2026 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976367;
	bh=nEEKlVpCPpAAnlYPhLXdKtFIHi65ieQ/dl9EX9/Mdlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScXkOD+NcgkmQVby7Nb1rly9OMcLxOrCOR31OWzmijk4nU2L72pokJ/oMrPNIujd7
	 DkYtpHMleQa/PgIE4+30qcP60RqMhRdai4b0MJgfgXGW/hh7UCjwnUQFw4DcJv48aE
	 +SvihSFVcCBpW4hUq1Jdr00GpkYJrnt2EkOc14KU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liucheng Lu <luliucheng100@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 058/309] ALSA: hda/realtek: add HP Laptop 14s-dr5xxx mute LED quirk
Date: Tue, 31 Mar 2026 18:19:21 +0200
Message-ID: <20260331161755.622663305@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232290-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,suse.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39FCB36EFDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liucheng Lu <luliucheng100@outlook.com>

[ Upstream commit 178dd118c0f07fd63a9ed74cfbd8c31ae50e33af ]

HP Laptop 14s-dr5xxx with ALC236 codec does not handle the toggling of
the mute LED.
This patch adds a quirk entry for subsystem ID 0x8a1f using
ALC236_FIXUP_HP_MUTE_LED_COEFBIT2 fixup, enabling correct mute LED
behavior.

Signed-off-by: Liucheng Lu <luliucheng100@outlook.com>
Link: https://patch.msgid.link/PAVPR03MB9774F3FCE9CCD181C585281AE37BA@PAVPR03MB9774.eurprd03.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index a32a966be8ba1..437a7a2070e58 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6792,6 +6792,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89da, "HP Spectre x360 14t-ea100", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x89e7, "HP Elite x2 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8a1f, "HP Laptop 14s-dr5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a26, "HP Victus 16-d1xxx (MB 8A26)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
-- 
2.51.0




