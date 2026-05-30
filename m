Return-Path: <stable+bounces-258026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCFQFeUhG2oN/ggAu9opvQ
	(envelope-from <stable+bounces-258026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:44:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBA61043A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D8AE3001CCF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5CA3469FC;
	Sat, 30 May 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ktTw9s4M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F4267B05;
	Sat, 30 May 2026 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162976; cv=none; b=qBdJWnxk/n/LPpN35/Bq0ByCJL0/Wa1bZM2IcW+YDGhnALKDYJpEQOvcuu2/igxQwsGMue4KQkt6RvQS6roXF9jtlGc2LFj/z1kCRKXUINzY67+c5db+5DcPwMxEOylrqmgKuFR3PKeoHQNIPyQ47MAKM1RpOXSm71IsRgIO+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162976; c=relaxed/simple;
	bh=/IsN+Lya1VgmvakCH77gQTlk2lNwvUw8gHd1/etr7H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQ59S22/Z2WEe3WoS0Blnzl4EbA/bqQjB+uGasIlPZEE/VrEFfiac2SObs2K0MEV0Adio9nHZ9qB+O0eY3zEoV0illwsD6u8y4tlz0GQ+x5fEGh69k6lUOsIn+MQhjiJHAxfDyVfpIe2ndQK1DCxTFWeQWJSQJsNlISGuD2QWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ktTw9s4M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354231F00893;
	Sat, 30 May 2026 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162974;
	bh=tREsLL1/RPNF9miUVnY/Wyl4pLVOp3TLEZcF+NQFfA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ktTw9s4MsjgO3+j4Nzo8IAlCsIKqrCtWQXtqnaAxARpZmzNAfUVGDqV1d8/yR+Lsb
	 UYZvyFfbflBgeM8MhZh33CcMtAD2X/yoBwar349ValJ/3yDhU5QkBh4OHg4ZdosHjC
	 zNtpBIfVaUY3B3vws7g1yTlMlwimMQl4Za1zNIzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+4e7919b09c67ffd198ae@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>,
	Robert Garcia <rob_garcia@163.com>
Subject: [PATCH 5.15 120/776] ALSA: control: Avoid WARN() for symlink errors
Date: Sat, 30 May 2026 17:57:14 +0200
Message-ID: <20260530160243.475302395@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258026-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,suse.de,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,4e7919b09c67ffd198ae];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,suse.de:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 59FBA61043A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b2e538a9827dd04ab5273bf4be8eb2edb84357b0 upstream.

Using WARN() for showing the error of symlink creations don't give
more information than telling that something goes wrong, since the
usual code path is a lregister callback from each control element
creation.  More badly, the use of WARN() rather confuses fuzzer as if
it were serious issues.

This patch downgrades the warning messages to use the normal dev_err()
instead of WARN().  For making it clearer, add the function name to
the prefix, too.

Fixes: a135dfb5de15 ("ALSA: led control - add sysfs kcontrol LED marking layer")
Reported-by: syzbot+4e7919b09c67ffd198ae@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/675664c7.050a0220.a30f1.018c.GAE@google.com
Link: https://patch.msgid.link/20241209095614.4273-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Use card->ctl_dev.kobj to keep struct consistent. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/control_led.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -693,10 +693,16 @@ static void snd_ctl_led_sysfs_add(struct
 			goto cerr;
 		led->cards[card->number] = led_card;
 		snprintf(link_name, sizeof(link_name), "led-%s", led->name);
-		WARN(sysfs_create_link(&card->ctl_dev.kobj, &led_card->dev.kobj, link_name),
-			"can't create symlink to controlC%i device\n", card->number);
-		WARN(sysfs_create_link(&led_card->dev.kobj, &card->card_dev.kobj, "card"),
-			"can't create symlink to card%i\n", card->number);
+		if (sysfs_create_link(&card->ctl_dev.kobj, &led_card->dev.kobj,
+				      link_name))
+			dev_err(card->dev,
+				"%s: can't create symlink to controlC%i device\n",
+				 __func__, card->number);
+		if (sysfs_create_link(&led_card->dev.kobj, &card->card_dev.kobj,
+				      "card"))
+			dev_err(card->dev,
+				"%s: can't create symlink to card%i\n",
+				__func__, card->number);
 
 		continue;
 cerr:



