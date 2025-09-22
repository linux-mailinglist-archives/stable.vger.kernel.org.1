Return-Path: <stable+bounces-180960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A08B91828
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2156188399F
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291C30CB33;
	Mon, 22 Sep 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V4olzZ1s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jb4G78GC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V4olzZ1s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jb4G78GC"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187B425484B
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548952; cv=none; b=anel/+J6Zj6+9yIjfj+n3WSPz7CkW3rAqITf01u26SlZwXNcFRQiSUoQ2FSVe7zkRIDFep+plwxITxDP3Ar8YfSLtpbrrYlcr5fuLZMkcYjIxoata2+CwEu4TVKCIGtGhP6WtRl+mQ2+OT+WZ9wAbIqBLopoZAMjvDQtG1VOo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548952; c=relaxed/simple;
	bh=ngl7H2YJ1DHyIGZNomAJTEjURUQ4b0al6n5Rb1tJTz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=glzT4flIu6RDQI2zweZckglJZ4b0TK9DPbaFqwAAi8HObsQl7RYCiQI5lROXZvIBhWgSxzQBszJGYdVLKIO84+4cvBgUfNEamjC7K4qE9jZ0zYY2OawZBMgdvsQiu59Ked19Y5qIpZeBrKLXrUGm/BbR3sfe8qESMA7NM9LVH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V4olzZ1s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jb4G78GC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V4olzZ1s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jb4G78GC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 349621F79A;
	Mon, 22 Sep 2025 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758548949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7TzD8bMv0gdipWLQ/wOu3P08SLqKkylmdgnKiucqS+8=;
	b=V4olzZ1sVE6zlzQYJ9cqO2/GPIzc9f3v/C2WFa3nzC07/9UtK46eNSkp5Q+ZODqBIcq7km
	VxYXSBdkebX8PDURYy9lLZwtWInJuB8+7hav0DHWYEpCDNcaQOhJ/5cWcuQLGVOUdgfu0I
	2zCXR0pnzQPp4LmEf8mhpKM+JwofUU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758548949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7TzD8bMv0gdipWLQ/wOu3P08SLqKkylmdgnKiucqS+8=;
	b=Jb4G78GCOKJ7HMid6++qn5pfiNCZTNmUiXh/eihDkAn76Kw5FJyRTcWWt9V5qNxyIgl0A2
	vgE6apw3X4EBX/Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V4olzZ1s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jb4G78GC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758548949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7TzD8bMv0gdipWLQ/wOu3P08SLqKkylmdgnKiucqS+8=;
	b=V4olzZ1sVE6zlzQYJ9cqO2/GPIzc9f3v/C2WFa3nzC07/9UtK46eNSkp5Q+ZODqBIcq7km
	VxYXSBdkebX8PDURYy9lLZwtWInJuB8+7hav0DHWYEpCDNcaQOhJ/5cWcuQLGVOUdgfu0I
	2zCXR0pnzQPp4LmEf8mhpKM+JwofUU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758548949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7TzD8bMv0gdipWLQ/wOu3P08SLqKkylmdgnKiucqS+8=;
	b=Jb4G78GCOKJ7HMid6++qn5pfiNCZTNmUiXh/eihDkAn76Kw5FJyRTcWWt9V5qNxyIgl0A2
	vgE6apw3X4EBX/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C067313A63;
	Mon, 22 Sep 2025 13:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uN1KLdRT0WguAgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 22 Sep 2025 13:49:08 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jani.nikula@linux.intel.com,
	samasth.norway.ananda@oracle.com,
	simona@ffwll.ch,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	George Kennedy <george.kennedy@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH] fbcon: Fix OOB access in font allocation
Date: Mon, 22 Sep 2025 15:45:54 +0200
Message-ID: <20250922134619.257684-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,oracle.com,ffwll.ch,gmx.de];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmx.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,suse.de,oracle.com,linuxfoundation.org,linux.intel.com,ravnborg.org,163.com,kylinos.cn,kernel.org,c64.rulez.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 349621F79A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

Commit 1a194e6c8e1e ("fbcon: fix integer overflow in fbcon_do_set_font")
introduced an out-of-bounds access by storing data and allocation sizes
in the same variable. Restore the old size calculation and use the new
variable 'alloc_size' for the allocation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 1a194e6c8e1e ("fbcon: fix integer overflow in fbcon_do_set_font")
Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15020
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: George Kennedy <george.kennedy@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Qianqiang Liu <qianqiang.liu@163.com>
Cc: Shixiong Ou <oushixiong@kylinos.cn>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org> # v5.9+
Cc: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fbcon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5fade44931b8..c1c0cdd7597c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2518,7 +2518,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size;
+	int size, alloc_size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
 	int pitch = PITCH(font->width);
@@ -2551,10 +2551,10 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 		return -EINVAL;
 
 	/* Check for overflow in allocation size calculation */
-	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &size))
+	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &alloc_size))
 		return -EINVAL;
 
-	new_data = kmalloc(size, GFP_USER);
+	new_data = kmalloc(alloc_size, GFP_USER);
 
 	if (!new_data)
 		return -ENOMEM;
-- 
2.51.0


