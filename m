Return-Path: <stable+bounces-256677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDmtDH7NGWqNzAgAu9opvQ
	(envelope-from <stable+bounces-256677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03F6067F3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49BB2308D28A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA0137DEAB;
	Fri, 29 May 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adwi7ZW0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEA3806CE
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075503; cv=none; b=CL/eSeXW2kmgUdY1soH2S/hYgVtHqNtKDXpJKRDoOs4ZDJCNU6/mohY1QPvWSjdq9OdO1cCrBXqMsZ86Kowpfn/dOGbub8CeTC6A/TXt+nSxqYXXrTIZB+BorbSPw85txpNwHJvn+AepKpTbWzaJMvhoHstRAJ2h42qshlBKcr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075503; c=relaxed/simple;
	bh=ZiWJm8Nna4i0+XbJ5qCtrBY4bc+4DzBlotK1qtqOGoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3ZFcQFkYeGcO9EJfFJrMaBCcGKReGH12J1aMKGs0R9UqGi8xKYqt5I1VsmrboMQgQBcYT8t2X9Ro8tn3ScL5nCbOEE3IAo9nvoqRI4qkujxsEOeb/qKlyo9jwpseP0VQPgCqsuMt4HCs54vPxJ0W10WBj9UY1STPLdoVMUy2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adwi7ZW0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A471F00893;
	Fri, 29 May 2026 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075502;
	bh=uLynTnXu2vR7EzAgKGdC1YO6OipEK3xYz9id7TJCz4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=adwi7ZW0d/fsJW/XKtX0Rf+eGyeiFmRvzZcNS2czAe9ZzuS2eH4GFsv6+GqQ9Ba2t
	 oGO5Sxe7RSFr+xhlTgv2ziHlJp2V37hwW+xwVdf3v8M0MKU93+c/BpdKJnmZWIZJfE
	 OSKUsDzcbOIY/q9UJqi6/8ST8Lfd96Cb2a9NJLpxhy/3fGoPvOpKXIyG1OvZrGQSBB
	 iaSqFxRGFg8f7LsIi0HkPEnlgfkQgRTBw5XwwQF8DWDWBjakeMYuBvjekyxPTCZW2l
	 kDFAnKwHgEz+TkPC4xpwErX/fUiMkagzt8wOKSU5DHcHTKZRWN4rXNJro/UwXfswqB
	 s/eM9ZBdI0ZaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ALSA: scarlett2: Return ENOSPC for out-of-bounds flash writes
Date: Fri, 29 May 2026 13:24:59 -0400
Message-ID: <20260529172500.1327796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052816-limelight-debtor-c8aa@gregkh>
References: <2026052816-limelight-debtor-c8aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256677-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[104.64.211.4:from];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.103.45.18:received,100.90.174.1:received];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:email,msgid.link:url,b4.vu:email]
X-Rspamd-Queue-Id: 0A03F6067F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit 74641bfcbf4e698b770b1b62a74e73934843e90e ]

When writing to flash, return ENOSPC instead of EINVAL if the requested
write would exceed the size of the flash segment.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/3a4af07b0329bed5ffb6994594e4f7bd202aad0f.1727971672.git.g@b4.vu
Stable-dep-of: a69b677e47a8 ("ALSA: scarlett2: Allow flash writes ending at segment boundary")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index ef5945aa40e4a..564a9b04a443a 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -9523,7 +9523,7 @@ static long scarlett2_hwdep_write(struct snd_hwdep *hw,
 		     SCARLETT2_FLASH_BLOCK_SIZE;
 
 	if (count < 0 || *offset < 0 || *offset + count >= flash_size)
-		return -EINVAL;
+		return -ENOSPC;
 
 	if (!count)
 		return 0;
-- 
2.53.0


