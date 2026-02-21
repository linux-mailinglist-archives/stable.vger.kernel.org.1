Return-Path: <stable+bounces-217651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NxeKsMLmml+YAMAu9opvQ
	(envelope-from <stable+bounces-217651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:47:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497E16DB9A
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B1B3018094
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86791F8691;
	Sat, 21 Feb 2026 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="mbysv6h1"
X-Original-To: stable@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F341C62
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703198; cv=none; b=RnlD1XZrd2mQwhisgsHFXjsCep45bJfbcLE7/hXI0ueiyE9gAkj6NJHdC2vtKXIxWqizF6Hx9xCYYoGdlp3cD/7Edeap9MX+gl8IBW+fvaLIOJT2ZLus5LGQw37U4zSA8eCFuPTyI++/QqpgyIIIVonJwswyYuYCzABs1ffPfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703198; c=relaxed/simple;
	bh=v+W8xbtamI2htlpziFFed/w0p3/rkOGsxT7dpGrab8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W66nGLbdA/5DnP4YJr0SJ281+a7P6O1lP7pTwMFyG9G1uXGTFzk0OAcUjBsrTjJwUefxTFzo/26Mmw1F7mFoW478GcQG/8temc8calCq6iIFYqipwsoXyi3NMpSJpd5AY/YV2O6MTZsfmv8E4PEEcS28Pl8p7qxPMiQTq22dMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=mbysv6h1; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B883A240028
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 20:40:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1771702858; bh=gmsbcqCAwI9cOm8W07FOuYrIANdFs2WUVKTI4eQiIm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=mbysv6h11OtsgG2oqVSSPkWulBThrQWnW9Ng3WS1opHkG5jX5eCL+a2qeTbRRMQWJ
	 yzT6eTJiY1w0EcMVvBTiEqo9j2h1OvrL2Cg1s7wVQfQVQvV7iP/Rp1epDzFxZcGY6C
	 poFuI+SE2n64FvsasptTYn/L3FOwQxdBy5NDVjDkxT17SAgWumX1+NhpttEDnfv4NH
	 bx9fHepE5e+CvA2dtvzQiJYy3xTdDx5ZnYuRIatdwsxdsdKzWN98+LOADKKbC469u+
	 vtAvnEF7JO09E6ofXfg3+2wn/tRC8YDddwu+B4gXhNRh3XTrVVeBO4VfTRlBNChKRb
	 VQhN4zuQ2uKnA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fJHXn2sMfz9rxG;
	Sat, 21 Feb 2026 20:40:57 +0100 (CET)
From: Panagiotis Foliadis <pfoliadis@posteo.net>
Date: Sat, 21 Feb 2026 19:40:58 +0000
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Acer Aspire V3-572G
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-fix-detect-mic-v1-1-b6e427b5275d@posteo.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bkGthPpKdChdaw9ZqEQg/T3pO
 DAzBRJFpgSjKBDp5sRnqKAaAXZfwkbIrjJoqY3UWqHnBx1lshkPtuil7QfTkjPdCjW6IlXjH07
 z+37P1pLOYAAAAA==
X-Change-ID: 20260221-fix-detect-mic-f0c5963ed64b
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Charalampos Mitrodimas <charmitro@posteo.net>, 
 Panagiotis Foliadis <pfoliadis@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771702857; l=1655;
 i=pfoliadis@posteo.net; s=20260221; h=from:subject:message-id;
 bh=v+W8xbtamI2htlpziFFed/w0p3/rkOGsxT7dpGrab8M=;
 b=mUGTMjRO+PqVoN3wSnXZXYM1mLc0YKTNjLUvlBeBCh0Pt6rUSi0tsmggr8YBQA4cETTyM6whb
 mOHgKimxKASB+RR7gLXb5wNSchj6g1WwIyqDvQQcfL9evDE7X5HWqZd
X-Developer-Key: i=pfoliadis@posteo.net; a=ed25519;
 pk=qQknvoFAg4AxPHIZdU7+befQmFNi/JfQaur0XrbY00I=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[posteo.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217651-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfoliadis@posteo.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[posteo.net:mid,posteo.net:dkim,posteo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2497E16DB9A
X-Rspamd-Action: no action

The Acer Aspire V3-572G has a combo jack (ALC283) but the BIOS
sets pin 0x19 to 0x411111f0 (not connected), so the headset mic
is not detected.

Add a quirk to override pin 0x19 as a headset mic and enable
headset mode.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221075
Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 80f0be13b69f5a14e32d7d5ca4bdb848914c241c..1022886e2fa2fd13aca00273979f102cd11a079e 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6581,6 +6581,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x080d, "Acer Aspire V5-122P", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x0840, "Acer Aspire E1", ALC269VB_FIXUP_ASPIRE_E1_COEF),
+	SND_PCI_QUIRK(0x1025, 0x0943, "Acer Aspire V3-572G", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x100c, "Acer Aspire E5-574G", ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1025, 0x101c, "Acer Veriton N2510G", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),

---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260221-fix-detect-mic-f0c5963ed64b

Best regards,
-- 
Panagiotis Foliadis <pfoliadis@posteo.net>


