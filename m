Return-Path: <stable+bounces-232913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMiBHoQAzmntkAYAu9opvQ
	(envelope-from <stable+bounces-232913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:37:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE13840A5
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E793034DC7
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 05:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923A3659F9;
	Thu,  2 Apr 2026 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vEKoZVEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FC175A92;
	Thu,  2 Apr 2026 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108220; cv=none; b=Mi1I3pe7bgJFZJPdwb6laIDXwBQaNxnzk7mJnwpMCIhEp2SqVkPT2VaDc1SwcrVbf1fCazXomUJrQX0IgSy/Pb7OiecW2QoOZ4ZK8S/PwRex78dsE0GVUKQ73CQsm8Jkdnw+kmwC0sJHZ57MkCXDk0Z6BtuH4XLML8+IGAsBCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108220; c=relaxed/simple;
	bh=xZVGlTPTiBBef2iARx0bzLIZG1HD0uA8NNBbqan+D9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aXoBhUb1pa911344bjkVF1WeY9k/2A/NVvrB7nbtm1WB4FK7RFPzayvJGjIKZASHeYF+fjQuTRcQQYWM4tUzv5GCyDA6so+bE3Kf6HzkqH9pBn9x4KpCrGIH5DN95fCIByg6vm4mY7/erfZUFY2VoajbhLKGONPBbGEDqi7bLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vEKoZVEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E51DC19423;
	Thu,  2 Apr 2026 05:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1775108220; bh=xZVGlTPTiBBef2iARx0bzLIZG1HD0uA8NNBbqan+D9U=;
	h=From:Date:Subject:To:Cc:From;
	b=vEKoZVEmWxoGRzwZVrq05zgRE2eslBBrh33ToF9pXGRlYvAJbLrEjbCCdKO/k8aPQ
	 G8LAQfRC5s/I5FfejpyNFJCJ+0H77qK4Bq8XfAb0twVyQ37WluD4VXdjX55S6HHBfd
	 nGBLRQTxG6XpFarPolw+NRoe5hGrAmxrC97vwvpE=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113DACC6B03;
	Thu,  2 Apr 2026 05:37:00 +0000 (UTC)
From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Date: Thu, 02 Apr 2026 13:36:57 +0800
Subject: [PATCH] ALSA: usb-audio: apply quirk for MOONDROP JU Jiu
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-syy-v1-1-068d3bc30ddc@linux.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwMj3eLKSt00IMvcJDnRzNzCSAmosqAoNS2zAmxKdCyEX1yalJWaXAL
 SqlRbCwCXVPFBZwAAAA==
X-Change-ID: 20260402-syy-f04074ca6782
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhanjun@uniontech.com, niecheng1@uniontech.com, kernel@uniontech.com, 
 =?utf-8?q?=E8=83=A1=E8=BF=9E=E5=8B=A4?= <hulianqin@vivo.com>, 
 Kagura <me@mail.kagurach.uk>, stable@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775108219; l=1249;
 i=cryolitia.pukngae@linux.dev; s=20260401; h=from:subject:message-id;
 bh=xZVGlTPTiBBef2iARx0bzLIZG1HD0uA8NNBbqan+D9U=;
 b=mN3VdwexnabeNtKme5CRAJUjMvNNN1boW1QiGM2+lyrdAETxPdhUbqOUPZwxKGaze+gHotoHZ
 NY8El/k505lBjtBAc29jTvff3lv6XwLH0SNoh7rBQtVFVtjk0ENHwwr
X-Developer-Key: i=cryolitia.pukngae@linux.dev; a=ed25519;
 pk=kF6wBkp7j9167keuk8Q9RvPgMRPuHlJztbLy0vbJ3K0=
X-Endpoint-Received: by B4 Relay for cryolitia.pukngae@linux.dev/20260401
 with auth_id=712
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232913-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cryolitia.pukngae@linux.dev,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: F3BE13840A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It(ID 31b2:0111 JU Jiu) reports a MIN value -12800 for volume control, but
will mute when setting it less than -10880.

Thanks to my girlfriend Kagura for reporting this issue.

Cc: Kagura <me@mail.kagurach.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
---
Btw, is it a good idea for turn the volume_control_quirks from
switch-case to a table and sort it accroding to USB VID&PID?
---
 sound/usb/mixer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 69026cf54979..a25e8145af67 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1204,6 +1204,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->min = -11264; /* Mute under it */
 		}
 		break;
+	case USB_ID(0x31b2, 0x0111): /* MOONDROP JU Jiu */
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				       "set volume quirk for MOONDROP JU Jiu\n");
+			cval->min = -10880; /* Mute under it */
+		}
+		break;
 	}
 }
 

---
base-commit: 872c7433582a3570dd0c827967ba291450096bf0
change-id: 20260402-syy-f04074ca6782

Best regards,
--  
Cryolitia PukNgae <cryolitia.pukngae@linux.dev>



