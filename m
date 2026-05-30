Return-Path: <stable+bounces-257467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABloKcAaG2pR/QgAu9opvQ
	(envelope-from <stable+bounces-257467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:13:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F060F2BA
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 149A2301D03B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B034104B;
	Sat, 30 May 2026 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OO3W9n2f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C09EEA8;
	Sat, 30 May 2026 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161097; cv=none; b=tHn99ALD8TuszO9MM4r/NwwFnSkEpWRthY7vAAT5+RzuGFDGY07B5mHjJOeyUaThWH4QL96d0LU+a9oGWuhkkMWr+LJabdznNKZjA5MuIi0WZNzLrMMxw0ZQ7BmV8It3zmvCnryqOZuyR6XEOBTxZTAs4RlOkjLn49co1ngZUN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161097; c=relaxed/simple;
	bh=X557aFJjD7wunDvJXwn1nDwfoP2PSFI+JxmTzgQK6bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dB/KJI9VjdGWvFp/dCmBmIo4YPnRxrvoN1nnMJz+QOn+wkSKrFc/CyHVsy8ytuOGcvZlIuEfAkTOXdCyrPRHFw8/5/JjGZU05JyiwOO2n9QOqpdwuxXkhgqfj9lgINXNqb8SsvcqKv3dQ9BTpUSQhWlCuL5qkzmfM/FVuG4PEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OO3W9n2f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2201F00893;
	Sat, 30 May 2026 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161096;
	bh=SF7JJ9ylhNK54OxfIFHpcXEVD1/Hli/heFZhpT5bx8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OO3W9n2fMHsUtcxbUcVf+Y7Lu3yDYDZ1NSNHPELX/pdCaLKeODAigpkcVIIwexv8x
	 /KIg9Vm7MKO3g2xGOBR4++nKZWrEa2b9IYYcFd1vGNCFOhxr/nrm7SBNyuQ1PTeLhO
	 zMrhHpbS7ede4DA6nhMxl8S6iQSJTL4bBVLy1E4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Luke D. Jones" <luke@ljones.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 524/969] ALSA: hda/realtek: Whitespace fix
Date: Sat, 30 May 2026 18:00:48 +0200
Message-ID: <20260530160314.823854155@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257467-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 488F060F2BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luke D. Jones <luke@ljones.dev>

[ Upstream commit 72cea3a3175b50a4875b3c112fb13df20c6218a5 ]

Remove an erroneous whitespace.

Fixes: 31278997add6 ("ALSA: hda/realtek - Add headset quirk for Dell DT")
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20230704044619.19343-6-luke@ljones.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: d1888bf848ad ("ALSA: hda/realtek: fix code style (ERROR: else should follow close brace '}')")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0889dfd80fa44..9bda2f43394cb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6040,7 +6040,7 @@ static void alc_fixup_headset_mode_alc255_no_hp_mic(struct hda_codec *codec,
 		struct alc_spec *spec = codec->spec;
 		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
 		alc255_set_default_jack_type(codec);
-	} 
+	}
 	else
 		alc_fixup_headset_mode(codec, fix, action);
 }
-- 
2.53.0




