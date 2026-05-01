Return-Path: <stable+bounces-242299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPSRNtOI9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:04:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ECD4ABDEE
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55ACA3059AE1
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B6539B971;
	Fri,  1 May 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiunrzYs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FC35A38C
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633372; cv=none; b=iM7Hho9DI67qhLmrAngPIA/vbUoE6BQ3CpWbAsaKQ+lq1j6i11ddFNDYvQNMB3A1Xzz+vMOA9FEYKbSPPDZRXq+XAOK1Y4wv5EiqNLN4m8oNYxkkVxsE8QXNACZvBapjc6rqqyqJGemARH/0cXNpG9WSUyxbVC+KC1uZ01a3hUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633372; c=relaxed/simple;
	bh=YfU/zl+6DnYOZ53QANELydK6VE2h9OmRaMWQV8J1veo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbggdZVDHE0G1D87WFuiwy2oy41/W0WotLeasFs39G0MkL3G9q91KS8cLSRveV2LKv5auYlvOREMvv8VvGSly3YukeWclOOLcmXr4U/Hh90QWm2f2a14CUuCTwvlADmrFjUHZaClR+idMKfsM2DhGJ01Vg0JUV+fzB/yYZAHzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiunrzYs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so15306155e9.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633369; x=1778238169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+uMPXd4v7RJUPJ6ng6R0zk6Hnw9jnnZw4S2klEd/5k=;
        b=UiunrzYsaOFdKV5mKMeMB2Ny+akWz55rX0jUYPsADDcPq6XlcnJGhe3dZqeDMkNj3C
         KAq+fmstq7kWI9lXPwQ/E/0DQ9UMrLQf5WMmhMiCCmmtbUPirQDfXXo+MVWOjkxA8tEv
         AHzI4Ca1YlOJxWpcRwXg/l8pM0GQEZLRaOO9/F0KERSDS49VP/FEr8XKZIQJKbESZzv1
         wrxJUFYl+ngHyX98SHNCu/vHufJZCHka1i2J8dplSzayrXvIY6tUGd671UWWC0LwSj4e
         MYZVdalJ0hylMTNTuqsqWEtO/NFba8x+XaAw5CcrZbARSCG+aHjfBjD5iBHog470cXLR
         Uvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633369; x=1778238169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+uMPXd4v7RJUPJ6ng6R0zk6Hnw9jnnZw4S2klEd/5k=;
        b=CBGz0w095OatQm/7BcdJsuAqfVjvfTev8yu7pZI6erzmgXh4TZ0yPq4r6ge3Uhqvaw
         AfJcgOcQ5CkxTtOzysmEU7UeITOx2NBmPAc68Q/UzR8SzrSIju0AEXG95kwaK0h/Oxsk
         Vk8Akhtd3ZK83qq/oQfZEcjK4gaWE4JvuYiP1BRldSSecOTdwzgo6JnRUlATVTmwAUh0
         QzivVFKgoJK4trUHW+H3ThCQqup0ZWWv1mBZIu9ZGl7lmIeEjkdBEeDMcpST3bKPVjZV
         KCL6ZG8/Y2TftFxhpsUa+MA3oihUPgTtsiCkCfGPJvZLXvqWzNj+V0CkTnZtgOie/slj
         HeOg==
X-Forwarded-Encrypted: i=1; AFNElJ/es8Bzg9QwUwCYDX8dv+C/zAEYwTbGMajxbSjZj+loYyboQ3hudIVaSxL2wQAmSyzl0tykoNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzbcF3rU4oolhXsUPhk2kAoVEjztLblrQVwTFrSRNS7Njt7WF
	AeDh8bpDq9G+OUIawJcZWuoM9yS7b72qigUFJLuWRadaFrPh0Xz8LTYnjF8W1OU=
X-Gm-Gg: AeBDietFW9XpToN0cjy7vvAzs17pt4ldIY1GAVo/s9FCcX4sTXgjeekPAGYc6gBUDmb
	VxYsFs7m9DGVJHXhkIZBbTh8hdkN49ilg7Voze/hVMHquon5ArnOpmWz/VvwA6SCLUDHk8b1C2E
	ViSad3L5hTlcd492AuhkSasPxrTcIyrdPDMrGnG3GOd4yZmPnTwctwPddjvmus6j50cpEKcfAdV
	vepAAdEp79i2yNXi91GDZ2mhUbwCNTzBuXWS8wWZtD0zt1iVQxipX+a3qjdR9BLhs1QOShHwxfk
	Y09kuuFYJQ/LMJqqIwi+bTK0mbmg9eIHlLsAtaqc6IFJoBvk47sg5OZJNJk5lKG5v+Xr8T2rahZ
	vA1H59b8zcqui8/Wa6BKpONf7fm1L7AlrKBsnzAW7Swj+vtvxzjSgYe1RAF9bvbMzS56p1HU1cl
	AZNQw=
X-Received: by 2002:a05:600c:4f48:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-48a84465c97mr118813595e9.27.1777633368690;
        Fri, 01 May 2026 04:02:48 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm79491905e9.0.2026.05.01.04.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:48 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+44664704c1494ad5f7a0@syzkaller.appspotmail.com
Subject: [PATCH 2/3] jffs2: clean up xattr refs in jffs2_del_ino_cache instead of BUG_ON
Date: Fri,  1 May 2026 11:02:45 +0000
Message-ID: <20260501110246.50647-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501110246.50647-1-tristmd@gmail.com>
References: <20260501110246.50647-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88ECD4ABDEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242299-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,44664704c1494ad5f7a0];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]

From: Tristan Madani <tristan@talencesecurity.com>

jffs2_del_ino_cache() triggers BUG_ON(old->xref) when an inode cache
entry still has xattr references.  This can happen during unmount:
generic_shutdown_super() calls evict_inodes() before put_super(), but
jffs2_evict_inode -> jffs2_do_clear_inode -> jffs2_xattr_delete_inode
only clears xrefs when pino_nlink == 0.  For inodes with nlink > 0
at unmount time, xrefs survive past eviction, and the subsequent
jffs2_del_ino_cache() hits the BUG_ON.

Replace the BUG_ON with a call to jffs2_xattr_free_inode(), which
walks the xref list and frees each entry without writing delete markers
to flash.  This is appropriate during unmount since the flash state
will be reconstructed by the next mount scan anyway.

jffs2_xattr_free_inode() already exists for this purpose and is used
by jffs2_clear_xattr_subsystem() in the put_super path, but that
runs too late -- after jffs2_del_ino_cache has already been called
from evict_inode.

Reported-by: syzbot+44664704c1494ad5f7a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=44664704c1494ad5f7a0
Fixes: aa98d7cf59b5 ("[JFFS2][XATTR] XATTR support on JFFS2 (version 5)")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/jffs2/nodelist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/nodelist.c b/fs/jffs2/nodelist.c
index b86c78d178c60..9af269b78b241 100644
--- a/fs/jffs2/nodelist.c
+++ b/fs/jffs2/nodelist.c
@@ -459,7 +459,8 @@ void jffs2_del_ino_cache(struct jffs2_sb_info *c, struct jffs2_inode_cache *old)
 	struct jffs2_inode_cache **prev;
 
 #ifdef CONFIG_JFFS2_FS_XATTR
-	BUG_ON(old->xref);
+	if (old->xref)
+		jffs2_xattr_free_inode(c, old);
 #endif
 	dbg_inocache("del %p (ino #%u)\n", old, old->ino);
 	spin_lock(&c->inocache_lock);
-- 
2.47.3


