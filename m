Return-Path: <stable+bounces-250417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFzEIjzyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-250417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F5D5944B1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BDB333E6989
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595ED3E2AAD;
	Wed, 20 May 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJKDboWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575F3E1D1B;
	Wed, 20 May 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295360; cv=none; b=TSp263vvPGpovCMpUv2fUjkBahGcCFsdCEORa42iTbRLina0/+XxvlUniNMhZOJ5RpdeBJy8dyzsqFqhKh/cGAMdrK2RbKMIzHRkCpfwg8KeH1fA5nNJhZJt/eWCG8JZDBGAt8ncM/ONBiRavUKBNUWCk9ug7p8pK/tqYQt2x/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295360; c=relaxed/simple;
	bh=qP0Pka6aP3IiUvA0C7ZOOcYbYa4AVK0EZwc6AEjQ1Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQuvZInh/MkzzRz59veB8xVIQi4mYE0kJVTAOkS0qI7uAZDYKAV9/iETEIi+A/ae1f1C2vZJlHrLN3hEgnUU4yYAH2Z4mXBkyek237OBnd8HcFu0xYxLquDW4VpoyItmsuQd4hDnX3KPtjTCp3cnvH4Tq20lRrx+O3r3mfFXlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pJKDboWO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5140E1F000E9;
	Wed, 20 May 2026 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295358;
	bh=xN+VTsTZrgpD9w8frbtH0wt3P3CWYZWjkPX2tLKOMls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pJKDboWOtv8A6XSH2/wJdBLpx6CAi8zqy3USzFbdGIfFhBCjTsWynrR53nHS+pUgO
	 XSOtD/YKSchqXXGWQd6+6UWDOCksLLZgA+IGnrUXvnWnmh/MG/hOPkUwjbxzfy+7yX
	 qAreWj5nIp3NMdmUhnIZcye4wyhy2QM3iM9TQ4nk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lei Huang <huanglei@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0348/1146] ALSA: hda/realtek: fix bad indentation for alc269
Date: Wed, 20 May 2026 18:09:58 +0200
Message-ID: <20260520162156.075486177@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250417-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,suse.de:email,kylinos.cn:email]
X-Rspamd-Queue-Id: D6F5D5944B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lei Huang <huanglei@kylinos.cn>

[ Upstream commit c1258a2924d3a2453a6e7a6581acd8d6e5c6ba70 ]

Mention complains about this coding style:

  ERROR: code indent should use tabs where possible
  #6640: FILE: sound/hda/codecs/realtek/alc269.c:6640:
  +        [ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY] = {$

fix it up.

Fixes: 5de5db35350d ("ALSA: hda/realtek - Enable Mute LED for Lenovo platform")
Signed-off-by: Lei Huang <huanglei@kylinos.cn>
Link: https://patch.msgid.link/20260331024036.30782-1-huanglei814@163.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index ded6e78142a07..8e135bcaa28e6 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6657,10 +6657,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc288_fixup_surface_swap_dacs,
 	},
-        [ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY] = {
-                .type = HDA_FIXUP_FUNC,
-                .v.func = alc233_fixup_lenovo_gpio2_mic_hotkey,
-        },
+	[ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc233_fixup_lenovo_gpio2_mic_hotkey,
+	},
 	[ALC245_FIXUP_BASS_HP_DAC] = {
 		.type = HDA_FIXUP_FUNC,
 		/* Borrow the DAC routing selected for those Thinkpads */
-- 
2.53.0




