Return-Path: <stable+bounces-261066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rZT/EGlFJWpBFgIAu9opvQ
	(envelope-from <stable+bounces-261066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:18:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A257F64F7E7
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="cJwnK3/Q";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261066-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261066-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E98063016EEA
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C23308F0A;
	Sun,  7 Jun 2026 10:12:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20B1E98EF;
	Sun,  7 Jun 2026 10:12:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827147; cv=none; b=Rihzfq773W8hJYD+WxttYCPOkPG8Xzr92bJEpXW1x0jnZQXeA28M7KoDWM1hChki6MrQpefLJkTq/WdLGZqFaFJ15bY0nbsBTj3B89BL+ydFGjSFRX2VJtORzW8bHruzYvxTvAwfxdqoT+nxBz3aEm1dKGM4TIiqdzdSdp9hUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827147; c=relaxed/simple;
	bh=WcauQXdlMtOoji67+3EccowflYAYYcljPP2z2UjqyLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjyvR7bws4HxG9o3i+vFzIolpaZrcztlM0EgTnZjVTs3EeflH2Y9UTYL+/06C+FysGWB7kWFgc8bK7cNturQfdYs4nbwZ9qXeWxh6QlkRWu8BUGKCJabuU+f9Z7Up0XUuITttXh3bv25MmVa5004YKoRuM2bPrXUQEDljLjf4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cJwnK3/Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AE71F00893;
	Sun,  7 Jun 2026 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827146;
	bh=l1sBlPPyPamQ+xfcUWCukIxHBuekhRWUIIH+qwVtRvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJwnK3/QS7u5V5TIdbkJbK2Wm7G+GAl5XiSL0QrhtYu5DqWPhnd4iuzefV52WcgLv
	 LnIxv0Q+9+vm2VOeQB7CDG+BGDGH/UulaFmh5KOc2AOZrUL4GbHMV+5ivAeGD3G6W7
	 y0I0uKnyxQsfdPlJiZeNKD0Vy4N8H9usTXmOcI9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8e498074a794999eb41c@syzkaller.appspotmail.com,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 029/315] ALSA: pcm: oss: Fix setup list UAF on proc write error
Date: Sun,  7 Jun 2026 11:56:56 +0200
Message-ID: <20260607095728.581749465@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261066-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,suse.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+8e498074a794999eb41c@syzkaller.appspotmail.com,m:cassiogabrielcontato@gmail.com,m:tiwai@suse.de,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable,8e498074a794999eb41c];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A257F64F7E7

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 4cc54bdd54b337e77115be5b55577d1c58608eae ]

snd_pcm_oss_proc_write() links a newly allocated setup entry into the
OSS setup list before duplicating the task name. If the task-name
allocation fails, the error path frees the already linked entry and
leaves setup_list pointing at freed memory.

A later OSS device open can then walk the stale list entry in
snd_pcm_oss_look_for_setup() and dereference freed memory.

Allocate the task name and initialize the setup entry before publishing
the entry on setup_list. Also fetch the initial proc read iterator only
after taking setup_mutex, so all setup_list traversal follows the same
list lifetime rules.

Reported-by: syzbot+8e498074a794999eb41c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a1062b7.170a0220.35b2b7.0003.GAE@google.com
Closes: https://syzkaller.appspot.com/bug?extid=8e498074a794999eb41c
Fixes: 060d77b9c04a ("[ALSA] Fix / clean up PCM-OSS setup hooks")
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260522-alsa-pcm-oss-setup-uaf-v1-1-40bdcc4d17e8@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/oss/pcm_oss.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 9b5a3def8d2ce9..59d5153d111329 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2965,8 +2965,10 @@ static void snd_pcm_oss_proc_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct snd_pcm_str *pstr = entry->private_data;
-	struct snd_pcm_oss_setup *setup = pstr->oss.setup_list;
+	struct snd_pcm_oss_setup *setup;
+
 	guard(mutex)(&pstr->oss.setup_mutex);
+	setup = pstr->oss.setup_list;
 	while (setup) {
 		snd_iprintf(buffer, "%s %u %u%s%s%s%s%s%s\n",
 			    setup->task_name,
@@ -3051,6 +3053,13 @@ static void snd_pcm_oss_proc_write(struct snd_info_entry *entry,
 				buffer->error = -ENOMEM;
 				return;
 			}
+			template.task_name = kstrdup(task_name, GFP_KERNEL);
+			if (!template.task_name) {
+				kfree(setup);
+				buffer->error = -ENOMEM;
+				return;
+			}
+			*setup = template;
 			if (pstr->oss.setup_list == NULL)
 				pstr->oss.setup_list = setup;
 			else {
@@ -3058,12 +3067,7 @@ static void snd_pcm_oss_proc_write(struct snd_info_entry *entry,
 				     setup1->next; setup1 = setup1->next);
 				setup1->next = setup;
 			}
-			template.task_name = kstrdup(task_name, GFP_KERNEL);
-			if (! template.task_name) {
-				kfree(setup);
-				buffer->error = -ENOMEM;
-				return;
-			}
+			continue;
 		}
 		*setup = template;
 	}
-- 
2.53.0




