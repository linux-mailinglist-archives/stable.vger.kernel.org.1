Return-Path: <stable+bounces-215522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FcjFlMIimluFQAAu9opvQ
	(envelope-from <stable+bounces-215522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:16:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA891126B0
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 526B430138B4
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539937BE6A;
	Mon,  9 Feb 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yww2QzeE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GFEEXYVQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yww2QzeE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GFEEXYVQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854225A321
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653776; cv=none; b=g/ljLupCj5UrUMnsO+A93glgBk/Ev+8tR2AW9ctD9ys+KHAuMEIL0BNL6+t9+jGWX1GLqM6Q3Sg43/WfbZdWbBl2lcyS9wP5tec/F8GQd19XOzyiJhtsI3DbEwSqouhLXngBkHSvmKJMXWWlaws6AeB8kiRMCj7JXR03R4BiC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653776; c=relaxed/simple;
	bh=asyeiLwb13/UiZ78Sb8ZL8dOkblrC3eHZbLw+BrWNwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=heZYLjJRGX+XVcPpyI3AJDrOpfRAk6tpTzsfoRxTkMWQJVTAEt1/4BZMa9UWomATWFLw+2Qd3xKYvc/iygzelT54sVfns0LJ9eT8ffFr3HSuw0+klm3EdvPcHpbUiGRtyA/r79fL5UcuvzlpSZve/6ZCV1LsCHQ4H7qYWMew3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yww2QzeE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GFEEXYVQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yww2QzeE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GFEEXYVQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DF0A3E6FF;
	Mon,  9 Feb 2026 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770653774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X86IAh52a94rH8KQhJRtN5yCtrGXFChcLrcOuLe7rtg=;
	b=yww2QzeEvSskfSPAmRcIyoR7midu0P4M/jDxSniwcH8604TGzr7Wbk0/flStvQsiQf5lFW
	JegooLmiBfleDyjB0CRJDnCV0Tii8qbwstEWWfMU/LiLyi45Vw2nL2DqFb9YHlEegD3aLt
	97brbKaSV+MRg292pc0+FiuVkbHTyKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770653774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X86IAh52a94rH8KQhJRtN5yCtrGXFChcLrcOuLe7rtg=;
	b=GFEEXYVQ5qOXfo3KovAVxMn8j3hB8WL9C/rpZUdakbqlKnGHJuot8HBAWI84hAvH/CjfOR
	UkWkFtM3lvd1QIAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yww2QzeE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GFEEXYVQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770653774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X86IAh52a94rH8KQhJRtN5yCtrGXFChcLrcOuLe7rtg=;
	b=yww2QzeEvSskfSPAmRcIyoR7midu0P4M/jDxSniwcH8604TGzr7Wbk0/flStvQsiQf5lFW
	JegooLmiBfleDyjB0CRJDnCV0Tii8qbwstEWWfMU/LiLyi45Vw2nL2DqFb9YHlEegD3aLt
	97brbKaSV+MRg292pc0+FiuVkbHTyKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770653774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X86IAh52a94rH8KQhJRtN5yCtrGXFChcLrcOuLe7rtg=;
	b=GFEEXYVQ5qOXfo3KovAVxMn8j3hB8WL9C/rpZUdakbqlKnGHJuot8HBAWI84hAvH/CjfOR
	UkWkFtM3lvd1QIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E9793EA63;
	Mon,  9 Feb 2026 16:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WD3uCU4IimlcYgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 09 Feb 2026 16:16:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	geert@linux-m68k.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] fbcon: Remove struct fbcon_display.inverse
Date: Mon,  9 Feb 2026 17:15:43 +0100
Message-ID: <20260209161609.251510-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215522-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linux-m68k.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: BDA891126B0
X-Rspamd-Action: no action

The field inverse in struct fbcon_display is unused. Remove it.

The field apparently never did anything. Commit c7ef5e285c84 ("video:
fbdev: atari: Fix inverse handling") converted its final user to call
fb_invert_cmaps() instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: c7ef5e285c84 ("video: fbdev: atari: Fix inverse handling")
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
---
 drivers/video/fbdev/core/fbcon.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 1cd10a7faab0..fca14e9b729b 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -30,7 +30,6 @@ struct fbcon_display {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
     u_short scrollmode;             /* Scroll Method, use fb_scrollmode() */
 #endif
-    u_short inverse;                /* != 0 text black on white as default */
     short yscroll;                  /* Hardware scrolling */
     int vrows;                      /* number of virtual rows */
     int cursor_shape;
-- 
2.52.0


