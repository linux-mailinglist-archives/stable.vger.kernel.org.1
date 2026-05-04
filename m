Return-Path: <stable+bounces-242826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBAtI6fu92m9oAIAu9opvQ
	(envelope-from <stable+bounces-242826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 02:56:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1504B7D5C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 02:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3D793000FEE
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A8D1A5B90;
	Mon,  4 May 2026 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNSQcqCK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDA5C613
	for <stable@vger.kernel.org>; Mon,  4 May 2026 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777856162; cv=none; b=Lc4Pu4unj50fDEjys7KLmXyQWfGDh2m1/mCrmL+Iol6OwOpr/hp1AExiIZ+kMsmaMoamTiwqpjjwpiwYfbKe/30dCYbxQ6mwaE3nSh58F7OqQzNybeGgAFgT6l4jT8gApxpRMATjoVxS59xUpwifzZywssL4vViCKoJZ+vgQKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777856162; c=relaxed/simple;
	bh=ND0ebtMtgG2oFEY74U8JFQQZ+pCiMd7ihtIY2d/33g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CyJjU52NfskOApM6hQBHZt78gmyocahg4Q6yzrysUfDjXFI80EMH0avT/rUiLBFP7/6lyB0UWlM7P4GpbWS9eupuXakQ9w/af2m2xjShmygDWLuLOHn5jYfPuWNk97ZZgUuaPsLWz4VMYeKXznwCurZGQYfI4TIf6zZFhSHyB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNSQcqCK; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c1a170a50so4473187c88.0
        for <stable@vger.kernel.org>; Sun, 03 May 2026 17:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777856159; x=1778460959; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WqgkeVGdbgXGvlU7ikkEcZEa18Qa/BkxqtfZd1WqbAA=;
        b=oNSQcqCKgzcgrEha8y332ajiMymmIU8IXujZae0wBFxCCV0V1BQzTEGXZid68XQ7UK
         K7ifmscc64qVlT07MGhr4jXPDuBTb2T2bmJakEadRt2PLuq80YBAzQI8hHqg/ovjYizs
         Joqs8Oz0vpAKa42+Ie6xoON5XwBKuMwdOjy5zB/h/rQy5aMK2hqX/IXMa2RihryajOnB
         yClGXO8jnl3maPw+EaJZYThIT8dNR61SNh1kXGmVYpHtzRbgvZynal64t6ITUySNFUY+
         fUi791KtP4FKjVWzKxTRmtk8oB/pzEy3mL+Wr+5BeAKF5wkTb/84s4NZtzJ59seiYldh
         ZrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777856159; x=1778460959;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqgkeVGdbgXGvlU7ikkEcZEa18Qa/BkxqtfZd1WqbAA=;
        b=W9rJBVvoEREXCoO6bxtZ9zsw+by3oVaMF0MqMW8p6oJ/WKDZ6PeDz7OznhHVWszVNj
         TcWfxfGWBsOEpNjB/Q17C2G23vWwWM7HMAWx5USzOim/piYtiw9Z1LmNdBzAZ6buKsPa
         I7XmLXtgB67yTfzLLcqLtmkjulEWIL59zOyB6St3o/AOxgXsGw17/XbdS3DtWdW5E0tf
         m07uKOD6GYbtYfM6X4VD9zJztciZJO7OXe0QfgtrOAyE3AfIuLrCIHZQ1nuRtmaohVXs
         imXBuIeNLXjQ7MBZqu22H6alNyxghy4E2EuTg89DO2ME2jNdsBHgYXlQNgtHoM0hTGrL
         +bWg==
X-Forwarded-Encrypted: i=1; AFNElJ8Dv/pnRJTx3VFB/RhTv494QDvlLcqX8AJ2xkiH8g8Es8uEITBKdZ4QXXm6Xx4r41A5WRq+hOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5/VwN1/4Hd4vmu+kZul3NBMgh9GbdWk8d1GKgCy6H84U6NmH
	wbwNe05qCjNuEOlrMX4JwiBo1yBZ371NwkMEb0HJW/0u6ZMLqD813XhM
X-Gm-Gg: AeBDiet1TwHVzTqZTMQ2SU9vBokV0ays8hdANMzVTj4ZNQYa1DZ6u3cZGmimzl5MOT5
	4hZOSR9j7wvuVhwplSwIvwv8xRNgtg0OtvE0bimZHYtOvnWACxFVFLLaLewYylNPE3dnweCgBD8
	YuTVkHH1mrDi6xVY9pcXwG0/qmoun6mvSciIrpJ2gGnRHjtZAvK8t/NCQ/ysGxTYtmobBb59uIM
	BVd3mg+ZRoe19Tk2TcZyHiUZOUqZtChzsUkPHLZqB4zAFx9HhgiG1klYWLsfrv0dUO/zD5r4DaA
	vcccO9821PjbfgzQf2XilTW7nNsFG2JQwhEfmH1tIJIxIlrPFgERgBJ3g7ANoinYVbziTXzjSSm
	zxFF0AFdk/OuAFPIPLPvpQz2btvnAx3j8pvGzbtwsIp28yIFI1DkZM1Zeefdn9x1ZqpwWqxOAj/
	q0qei45bkiNp/j84BY8DfB13ufJd8BARrDKFQ1x4fAtklTRTTT4nG3CseJUu1jDhAe7upbqZ5bP
	3x3rbfVTlPx
X-Received: by 2002:a05:7022:4c:b0:12a:6c4b:9cf0 with SMTP id a92af1059eb24-12dfd7d3817mr3789870c88.3.1777856159242;
        Sun, 03 May 2026 17:55:59 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84252c0sm15864885c88.10.2026.05.03.17.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:55:58 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Sun, 03 May 2026 21:55:52 -0300
Subject: [PATCH v2] ALSA: firewire-tascam: Do not drop unread control
 events
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260503-alsa-firewire-tascam-read-queue-v2-1-126c6efd7642@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBCFr0K6dkxLEBJX3sOwmLYDjOFHOoAaw
 t0teAEXb/ElL997qxIKTKKuyaoCLSw89BHSU6Jcg31NwD6ySnWa64s2gK0gVBzoFQMTisMOAqG
 HcaaZoCCkyuhco7cqWp6BKn4fC/fyxzLbB7lp1+6NhmUawue4sJi99//aYsBAYREziwYzT7e6Q
 27PbuhUuW3bF/RSJHLgAAAA
X-Change-ID: 20260501-alsa-firewire-tascam-read-queue-7eaef1060adb
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=ND0ebtMtgG2oFEY74U8JFQQZ+pCiMd7ihtIY2d/33g0=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJnf381hvCgkvttW5P7x8pn3N9Yp6sj2ix5csbL09jrHz
 dWPOsI2dJSyMIhxMciKKbKsTlpkuafrwdX6uBUeMHNYmUCGMHBxCsBEzlgw/PdR1JzJ/vPhxCz/
 k3cm7jdhDdzhmFswvYhty84ZNx/YXXZmZDgqJrv8qPDeGWsvxOj+sq+J/rbXa+N2zpsnOr655m/
 f7csHAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 1A1504B7D5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242826-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]

tscm_hwdep_read_queue() copies as many queued control events as fit in
the userspace buffer. When the buffer is smaller than the current
contiguous queue segment, length is rounded down to the number of bytes
that can be copied.

However, after copying that shortened length, the code advances pull_pos
to the original tail_pos, marking the whole contiguous segment as
consumed. Any events between the copied portion and tail_pos are lost.

Limit tail_pos to the position after the entries actually copied before
updating pull_pos. When the whole segment fits, this is equivalent to the
old tail_pos update; when the buffer is smaller, the remaining events
stay queued for the next read.

Fixes: a8c0d13267a4 ("ALSA: firewire-tascam: notify events of change of state for userspace applications")
Cc: stable@vger.kernel.org
Suggested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Changes in v2:
- Recompute tail_pos after shortening length instead of adding a separate
  entries_copied variable, as suggested.
- Add Suggested-by tag.
- Link to v1: https://patch.msgid.link/20260501-alsa-firewire-tascam-read-queue-v1-1-7baa4ba1a4de@gmail.com
---
 sound/firewire/tascam/tascam-hwdep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
index 867b4ea1096e..6270263e7bf4 100644
--- a/sound/firewire/tascam/tascam-hwdep.c
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -73,6 +73,7 @@ static long tscm_hwdep_read_queue(struct snd_tscm *tscm, char __user *buf,
 			length = rounddown(remained, sizeof(*entries));
 		if (length == 0)
 			break;
+		tail_pos = head_pos + length / sizeof(*entries);
 
 		spin_unlock_irq(&tscm->lock);
 		if (copy_to_user(pos, &entries[head_pos], length))

---
base-commit: 9e8d6ddd7ecf2ad42d614243f86e50fcf0183b9e
change-id: 20260501-alsa-firewire-tascam-read-queue-7eaef1060adb

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


