Return-Path: <stable+bounces-39466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBC68A502B
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BAD1F210AB
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C24130496;
	Mon, 15 Apr 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocAQeneK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010887581B;
	Mon, 15 Apr 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185445; cv=none; b=RL1gxotVsRd6oLB60TpGmT3WLTgYzqQeaEHl6IhaAC7XBpj+R9qq/+VzGN1fMTZi1Su/KG3LdaAthceh+FQJBsQrFZhEUFCj0B0DSLzdbSAD2ZFGJBKshTniVTrZJZvkRCvFte8DYHXwKtcfa32ukaMz86o/az10I3Zc/h5lC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185445; c=relaxed/simple;
	bh=9WgubhEyjIntDb8goamQgfEtmkM2n3g7m1ut+oETaNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qc8SvhYc/nA4nOr8766llZnjrBnFvrDS/aTzauryy8TG1uwKeDxrGAVvJ+Ut4fK5gzOhyPxA07Ay+jPF3WLqiGO9aPMhrvIl8LM6VECZjvWJymOePddZnhykrdHmcw4/RVKSihY195/C9DivGUBjaiX+YqQJ7O6hHF38VBGHmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocAQeneK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF86BC113CC;
	Mon, 15 Apr 2024 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185444;
	bh=9WgubhEyjIntDb8goamQgfEtmkM2n3g7m1ut+oETaNg=;
	h=From:To:Cc:Subject:Date:From;
	b=ocAQeneKpzKhpF99Tt/dEaC7PxMcQsj/vF/dL/kHf8Z1Iws/J6ivQHe4iveyGR3UM
	 2xBGkiIzASN0AbQsqXYxwFu303Ye0uxV0Mr1RU+68vCcA6HIlfZvbJJ9fpO15qGgrC
	 IxQD57wiBWoICprZrQsyJ0aHSqysjbbENNRQQcv7eaDBDTzXdRhPZgK2PdTFcMXm74
	 /TVjr7ec+PaQ7bP7lx701VJBnPtza3cXC/6TjlTNxujccwbMulw91OvWT0AgGds6sl
	 BcWZh1BGrCsoND9+H4wnylUPFSQ3DHpY2Z4Td8M3b5HRUlmSx6r4JRMiRkJ2Qc8rdv
	 HiipbGnBGutwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/4] ALSA: line6: Zero-initialize message buffers
Date: Mon, 15 Apr 2024 06:04:43 -0400
Message-ID: <20240415100449.3127574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.155
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c4e51e424e2c772ce1836912a8b0b87cd61bc9d5 ]

For shutting up spurious KMSAN uninit-value warnings, just replace
kmalloc() calls with kzalloc() for the buffers used for
communications.  There should be no real issue with the original code,
but it's still better to cover.

Reported-by: syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/00000000000084b18706150bcca5@google.com
Message-ID: <20240402063628.26609-1-tiwai@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/line6/driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b67617b68e509..f4437015d43a7 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -202,7 +202,7 @@ int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 	struct urb *urb;
 
 	/* create message: */
-	msg = kmalloc(sizeof(struct message), GFP_ATOMIC);
+	msg = kzalloc(sizeof(struct message), GFP_ATOMIC);
 	if (msg == NULL)
 		return -ENOMEM;
 
@@ -688,7 +688,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 	int ret;
 
 	/* initialize USB buffers: */
-	line6->buffer_listen = kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
+	line6->buffer_listen = kzalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
 	if (!line6->buffer_listen)
 		return -ENOMEM;
 
@@ -697,7 +697,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 		return -ENOMEM;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
+		line6->buffer_message = kzalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
 		if (!line6->buffer_message)
 			return -ENOMEM;
 
-- 
2.43.0


