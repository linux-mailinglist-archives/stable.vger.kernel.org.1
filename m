Return-Path: <stable+bounces-230934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBvzG3IryWknvgUAu9opvQ
	(envelope-from <stable+bounces-230934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:38:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1035245B
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8D66300A7CF
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789137883D;
	Sun, 29 Mar 2026 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCRCbxKY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9536EAA4
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791535; cv=none; b=lotMJI2eZn4VLh7NQeUqQOCwShFBRG2SRPlKw7Wo6lQeG/NCrvWDpPOYKda/d6f4AK/okEbWbkFqx2v9pxf00XsQe4BGYjSZLCpHrWggmbmKVbocyxv/F/U+NERjjMAopDesFJgVMy77ayw5SSME/eqTjU+/IJHbkILecCBlkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791535; c=relaxed/simple;
	bh=qWafS+rX9nxvXtbqHDoLW3WMpBkkmgZSJg+hRG7NBZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jqZLGK8L/9U0E89vgx1mTdRIyUhW6i8FwbBWSL1jqQ5DQ4dpFFUG+sQL3BdiTSdJL+pnXh3SsY7NsJnmKxhnnyO9F7vgjxv1h8Cv+WIAOA5lszw9KRkw7O3FJxKungc5Z9EhOsJkg1zNrbA97j3yfM5n0LSb41/DBygMCvjVScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qCRCbxKY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so44073415e9.3
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774791532; x=1775396332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=is6bs1NfbxZsQnjfbKTIDgjeronxzv4F25oTco18Foc=;
        b=qCRCbxKYtplEyoJ/CQJN7Kk2cwxGtfOJYTBjEpeDLUR/o+2aQzGamihefQMBRT4ySb
         2V4AuTfsfiLcFvUEVM70KivFFEzcPj0SqpXm4JwoD+93xR+4AdcB15zXjjRsxokRL7F2
         A2AbADeZUfvS+L4/INM2mcYwClX6wi7sUzKi9aN1t/M8LEjEzllYGk8KVqfQUIE5+nz5
         Et61cb5/1oS1Q9np6GUSw2lAd47ixCN5Ll2xpDY/PmylUKgCEaw5ChDDiDGzbf3H/bj6
         Rug3GDGFyAvVhGcxK0tj1TIEvB9QfV8S3yjsP296TPGLxv0si5yAkBOFBGURLoaGGj5w
         X0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774791532; x=1775396332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is6bs1NfbxZsQnjfbKTIDgjeronxzv4F25oTco18Foc=;
        b=o8NIVNqUpbMZQ3cK9Ok4J0TIfBlZkz8vLduhVaxGSjhuE+zc9qcZvSgHT3PhbQAa+8
         2SIzMik0DVFgJpb4t82607IK+FetQsqxpbwUgE7wIoJ4e7s+lgfLY6zcrWrOja0MoO+s
         5caqQNWsALgrKD4WBllgWmQFONPjw9N6zLFCHCQ2gTcUhEmtGYV568/Wjw6LNB+evGwW
         sKUI3Qhpub5ibC/LGuFbqtx3kSef5SFC2f5F1RhmMzFNP9d0zmVbcG6l13q8MqSr7WZn
         WmQ/bTuF060PyNFy7bJgERHAM0JiYwuDm1wAAR5nbrGOTM+sbO6voL0q/et8rDQJWR3r
         Ogaw==
X-Forwarded-Encrypted: i=1; AJvYcCViydkUGhO2Q/xfD/UKULRkDpExekJ3jKxhKbaje2gOQQXe8rlNAEkn77HmB4LrwGqMwHMyDho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+otL2Ebsu7Xf8euuwxbaQnXVAw3wiZNfyYyGogqCyXhFmY5P/
	ngrRs6PbdziJ7qP5yG6mxuezDgSlrbbJjsZI4i7baimChNbXrBmwj8er
X-Gm-Gg: ATEYQzw986nIFZ9ozevkMAsisKNeOnKipyD1WBC1o231QSa69AzFV9pfpYJYd6PA1vO
	hB1QmDf6MzNqpps3gWJizzGfr6QxZfHFrVCw7vnsKXvFcSpDCBi2s5irqAImE94DZghLzMZ9QoC
	frZH4hQejLpoLL/ZFpRh88taPTX6oOM6/WOz1fRwbZ8mU52u/v4MnJ8LjpmA+JUvk4oUOjJ0MRT
	8c49I+X/2ny9NuxJnpSaLuKGCJpg4TO36v7qlpYLtZ9DgjvuL7W5hXkwG5Cql7Sh8flQVBKcF8s
	AR1iSLbqU6IIzci3RsqwGkyPVZ8SE53DfWzxUPhAlycNfUcw+tjkBJpiWcLqwcSdi9cAECllrtz
	r42ySq08tekyTR9/ugwQ2nYILGgFvJfyR8dIabDZieyqZk+bDeyVkkyt8E5v2zFzGDuerfYLF52
	hquDhl3Wvaz2CEr0RX8CwW+YvVtXeBi5bndhYaI17M6fucGKXslgMb8P+OKvCOZqQ/pabYFA==
X-Received: by 2002:a05:600c:3f16:b0:486:fdba:f5db with SMTP id 5b1f17b1804b1-48727c86862mr156203735e9.0.1774791531900;
        Sun, 29 Mar 2026 06:38:51 -0700 (PDT)
Received: from localhost.localdomain ([176.40.241.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873062ee36sm106872935e9.8.2026.03.29.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 06:38:51 -0700 (PDT)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: zonque@gmail.com,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	andreyknvl@gmail.com,
	Berk Cem Goksel <berkcgoksel@gmail.com>
Subject: [PATCH] ALSA: caiaq: fix stack out-of-bounds read in init_card
Date: Sun, 29 Mar 2026 16:38:25 +0300
Message-Id: <20260329133825.581585-1-berkcgoksel@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230934-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4B1035245B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The loop creates a whitespace-stripped copy of the card shortname
where `len < sizeof(card->id)` is used for the bounds check. Since
sizeof(card->id) is 16 and the local id buffer is also 16 bytes,
writing 16 non-space characters fills the entire buffer,
overwriting the terminating nullbyte.

When this non-null-terminated string is later passed to
snd_card_set_id() -> copy_valid_id_string(), the function scans
forward with `while (*nid && ...)` and reads past the end of the
stack buffer, reading the contents of the stack.

A USB device with a product name containing many non-ASCII, non-space
characters (e.g. multibyte UTF-8) will reliably trigger this as follows:

  BUG: KASAN: stack-out-of-bounds in copy_valid_id_string
       sound/core/init.c:696 [inline]
  BUG: KASAN: stack-out-of-bounds in snd_card_set_id_no_lock+0x698/0x74c
       sound/core/init.c:718

The off-by-one has been present since commit bafeee5b1f8d ("ALSA:
snd_usb_caiaq: give better shortname") from June 2009 (v2.6.31-rc1),
which first introduced this whitespace-stripping loop. The original
code never accounted for the null terminator when bounding the copy.

Fix this by changing the loop bound to `sizeof(card->id) - 1`,
ensuring at least one byte remains as the null terminator.

Fixes: bafeee5b1f8d ("ALSA: snd_usb_caiaq: give better shortname")
Cc: stable@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Reported-by: Berk Cem Goksel <berkcgoksel@gmail.com>
Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
---
Tested on 6.19.0 and 7.0.0-rc5 with KASAN enabled (arm64, dummy_hcd):

[  302.559633] BUG: KASAN: stack-out-of-bounds in snd_card_set_id_no_lock+0x698/0x74c
[  302.559663] Read of size 1 at addr ffff8000a3ff6b10 by task kworker/1:4/2208
[  302.559701] Hardware name: linux,dummy-virt (DT)
[  302.559709] Workqueue: usb_hub_wq hub_event
[  302.559727] Call trace:
[  302.559751]  dump_stack_lvl+0x138/0x1c8
[  302.559793]  kasan_report+0xc0/0x100
[  302.559833]  __asan_report_load1_noabort+0x20/0x2c
[  302.559853]  snd_card_set_id_no_lock+0x698/0x74c
[  302.559873]  snd_card_set_id+0xa0/0xe4
[  302.559891]  snd_probe+0xc34/0xf04
[  302.559906]  usb_probe_interface+0x2c4/0x998

 sound/usb/caiaq/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index dfd820483..3a71bab8a 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -488,7 +488,7 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
 		memset(id, 0, sizeof(id));

 		for (c = card->shortname, len = 0;
-			*c && len < sizeof(card->id); c++)
+			*c && len < sizeof(card->id) - 1; c++)
 			if (*c != ' ')
 				id[len++] = *c;

--
2.34.1

