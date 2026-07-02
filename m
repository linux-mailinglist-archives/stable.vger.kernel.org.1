Return-Path: <stable+bounces-271438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxdeE8amRmoJbAsAu9opvQ
	(envelope-from <stable+bounces-271438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:58:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A37026FBBE6
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:58:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Pxa5vMru;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271438-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271438-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4105032E323E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DDD317146;
	Thu,  2 Jul 2026 16:59:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64922D7B9;
	Thu,  2 Jul 2026 16:59:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011545; cv=none; b=pXxxT2PjxBY8CWzc/++q8LdYRt9sJap3SQ8jskJUmcS8f5alf2uuLIfyb7zRLp3fVhXPNzP7qrJPUC0EODhwaKdBLPVRypfa5ZF7hQqLBlkTzkdt5Z7xnQ9QV+WOq9dTnUdWktLwoUEU0le4ublSGw2sGy/QcFfl1mEzkWmg80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011545; c=relaxed/simple;
	bh=WvebYmwDFU/ddWCrcwk32kKNZft7rqKd0gWEZJTuTgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/I2HKMwQFrkM7qVmoaZvN2KXxPZwdU3nOFFjpHuuK4YrU8cJyxfUECCGifuJQzAyKk/8nfHykyIQwSXK+jJwobxP5mtUJPRUdI/jEA8YUCfYaxD1+rzfu4JSWUXh6iK9p+czbpMMl4sK+3D+1vDDHOQ3X4J8s8NJqwv86G428g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pxa5vMru; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604631F00A3A;
	Thu,  2 Jul 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011543;
	bh=x3YZb5Q2XXVY0HGd6m3ZNZA2R/MEgIRVwWqXu4yesHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pxa5vMru3JhoM89Agny0nBDcMtY0tZFVVNNtzeqSJ7xgSGX/2/7pG/ByD2ZTZPn9m
	 sQBPoWWHAxjETNb618EqPoE7wSGO4BJdH+e0o5i3CC5N9hBbQ68/M/OJ56JZGP4ZfA
	 lUCWdgBRYqFvpbnBX7cR7zoXTyKe1CNiYqrLf3o4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+81c7c6b52649fd07299d@syzkaller.appspotmail.com,
	Ian Bridges <icb@fastmail.org>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 7.1 039/120] fbdev: fix use-after-free in store_modes()
Date: Thu,  2 Jul 2026 18:20:35 +0200
Message-ID: <20260702155113.768751245@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271438-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+81c7c6b52649fd07299d@syzkaller.appspotmail.com,m:icb@fastmail.org,m:deller@gmx.de,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,fastmail.org,gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,81c7c6b52649fd07299d];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,syzkaller.appspot.com:url,fastmail.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A37026FBBE6

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Bridges <icb@fastmail.org>

commit 2c1c805c65fb7dc7524e20376d6987721e73a0b1 upstream.

store_modes() replaces a framebuffer's modelist with modes from userspace.
On success it frees the old modelist with fb_destroy_modelist(). Two
fields still point into that freed list.

One pointer is fb_display[i].mode, the mode a console is using.
fbcon_new_modelist() moves these pointers to the new list. It only does so
for consoles still mapped to the framebuffer. An unmapped console is
skipped and keeps its stale pointer. Unbinding fbcon, for example, sets
con2fb_map[i] to -1 but leaves fb_display[i].mode set. An
FBIOPUT_VSCREENINFO ioctl with FB_ACTIVATE_INV_MODE later reaches
fbcon_mode_deleted(). That function reads the stale fb_display[i].mode
through fb_mode_is_equal(). The read is a use-after-free.

The other pointer is fb_info->mode, the current mode. It is set through
the mode sysfs attribute. store_modes() does not update fb_info->mode, so
it is left pointing into the freed list. show_mode(), the attribute's read
handler, dereferences the stale fb_info->mode through mode_string(). The
read is a use-after-free.

Clear both pointers before freeing the list. Commit a1f305893074 ("fbcon:
Set fb_display[i]->mode to NULL when the mode is released") added the
helper fbcon_delete_modelist(). It clears every fb_display[i].mode that
points into a given list. So far it is called only from the unregister
path. Call it from store_modes() too, and set fb_info->mode to NULL.

Reported-by: syzbot+81c7c6b52649fd07299d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=81c7c6b52649fd07299d
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/ajjoDhAi2y4ArSlz@dev/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbsysfs.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -11,6 +11,7 @@
 #include <linux/major.h>
 
 #include "fb_internal.h"
+#include "fbcon.h"
 
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
@@ -111,8 +112,15 @@ static ssize_t store_modes(struct device
 	if (fb_new_modelist(fb_info)) {
 		fb_destroy_modelist(&fb_info->modelist);
 		list_splice(&old_list, &fb_info->modelist);
-	} else
+	} else {
+		/*
+		 * fb_display[i].mode and fb_info->mode both point into the old
+		 * list. Clear them before it is freed.
+		 */
+		fbcon_delete_modelist(&old_list);
+		fb_info->mode = NULL;
 		fb_destroy_modelist(&old_list);
+	}
 
 	unlock_fb_info(fb_info);
 	console_unlock();



