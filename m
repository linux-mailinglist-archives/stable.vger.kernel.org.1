Return-Path: <stable+bounces-232941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDU/I+IszmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:46:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B5C3863EA
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DB3A311A032
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965F3C5DDA;
	Thu,  2 Apr 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/FgGiS+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFA3BC69C
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119163; cv=none; b=cltu+CWyD0JFe86MEjz6XJcVNkA8jr1PTs+VVEV+DlAInp/6vqIRjBFNZp5mT2jSM2tloBoULJW7f5kchGCWve/GhyV9F5tktFpu3JDBQhdz6qv27hZP6vYBvlaRNpk7D1HqTfxOP6hKqkEjAAl9ki9PKKX7IR2yYeOwpDqjgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119163; c=relaxed/simple;
	bh=cwiMGb+QvJPPbyOUbTGVlCDSVPPTs9vIaN+NXNJAVn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKpTHaLnaFSWazZEkN6uQ/oPoEMvi4oCUB7MoP7ug3FcV6X89FxukkSF/PGLrmqBc76DqliMYyh85cpU10UCfnbk35PqmP0OaLOYzn5hjhgq3ncOIYII06iFxdSmvl6BR0U0BQ4uwub92QJMJVUT57EIvUaQayhD/SToWC/dcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/FgGiS+; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128ebee22caso1100596c88.0
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775119161; x=1775723961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eITVDgwa5tEdf7gs96GHN8iyQzNKskoC8moYtKLcKc=;
        b=K/FgGiS+3PI2cFIE2N+jYPaP3BbsprXkLelxACmeih+ZJPGr6NWju/f1916TjbFFkf
         hZe/o0+7Mi9Nh8LR39DkgNxuql0TvOgBtyNcn1eupfqiLol1ElVgjyYZR+Z8PlS4FUBE
         7jRTE9z5OvIAyBmxLHB9M+3u5Q/wfYaqkcEvbBY70NJPMbUDyALNBmj/2rjWlr9+XU9s
         oEZt77sdmJCjDlY3137MMUZLABPhV1KibPuvqW/3dyFG6aQuDsPk7Ocbx2P6e6QcOYNw
         d+JugzOrlkOzt5+fw89gpYcKlXSuZDxFsSJX/CTvk7oDCSVYAXzPlMbzdiN6cfqaiK3N
         292g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775119161; x=1775723961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eITVDgwa5tEdf7gs96GHN8iyQzNKskoC8moYtKLcKc=;
        b=G+p4zaOhLG1sVvzHy8NxAj/Jjj2ebCoufWGAckn8dnRSDKy7tJ7n3bANsNMR1dyEnf
         kgiWqu2wR9UjDKhBwk8xT0sMS9BGPKeg2e+wg8EYiagpPAebNnTuf8QdyZv9B0yx5b+Y
         ZsHzbYIteXuuplqiqh11TD20Z5HryT/MIWA97fTYa7y9fe0gm7+kkNddmDkY1tsCdlms
         OwW8z3eXb+Qv2LmwZwy6bkc0ZGqekQ1Ab34EDu+xiSJauDozSJ2CiAIQXwXEznPh81cZ
         N5v7wFLSEPwDzzAq5l+Oby/hKDM7/dq/y901LKqgHFndA8sZ7m1vJpeuF6jqfmgnFg6t
         AWig==
X-Forwarded-Encrypted: i=1; AJvYcCWf2schdICC9itmVwUkXKo9AdKH7Pd8NESlSHrCFuqaxN1LL08mpO6waGM2F5MB8r1jLHBjlb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ZwKauxM8wMMFct7pAYw6mNNx//6cZItdV6W0eS/eDTknFWDi
	RImXqtRecErgPNZYKlfgaam6YuuuOb6CDFH/XYVruR84l7UW2Afep5fG
X-Gm-Gg: ATEYQzw9gewE1rA8W3VJd22z9ZyM4WxM0McuUZeuS1XFkZdySwe/SWn1VP0etgu34fU
	lWsF2TfCInjgexqJ/ZxygS1OKzrIDg8Jk0BHI4Z1uQcJ1xivb1A0kevmiGek/pG+FSWzV5nZhEo
	DG1ckzOziDfnbIgL+SLQ1iLH4qGm5b+AbA9AAoYQFklSRQtfaynPXr4LFd8deOjnvHala8uWL78
	/C/sLPmZg8aTrq6MNA+ZAj2VR0LqFILYKxF/0lYnFVaqDfkJm9zKAC9IYvS9K6NjKCoQhcBj9l1
	PNX3TvWAo/RFPk1lfgzgjujnwoqk1zmgGVDakEdyWFRi+By8SsMfoKIc8VL+/UdyiEuOzszDK21
	nm6QK7yrwZBrP7fOkIM1Wqg+WvYvc1WKSgES8mK4TedrKlCA5qDIUIzL+p+Dp/+B3J9aGpPYEre
	vgwk5v1prmg7txiA5+/1yKGBClrWAGiWyvpGQ4s6i6nPfw75xWnTRp3cZ8CA==
X-Received: by 2002:a05:7022:f8e:b0:119:e56b:957c with SMTP id a92af1059eb24-12bee613f8cmr1450943c88.1.1775119161057;
        Thu, 02 Apr 2026 01:39:21 -0700 (PDT)
Received: from ubuntu22-base.lan (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd4e4e3sm1716646c88.1.2026.04.02.01.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:39:20 -0700 (PDT)
From: munan Huang <munanevil@gmail.com>
To: linkinjeon@kernel.org,
	smfrench@gmail.com,
	senozhatsky@chromium.org,
	tom@talpey.com
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	munan Huang <munanevil@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix use-after-free in __ksmbd_close_fd() lock cleanup
Date: Thu,  2 Apr 2026 08:39:12 +0000
Message-Id: <20260402083912.457676-1-munanevil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232941-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,chromium.org,talpey.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[munanevil@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31B5C3863EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In __ksmbd_close_fd(), when cleaning up byte-range locks on a durable
file handle closed by the scavenger, the lock cleanup loop
unconditionally dereferences fp->conn->llist_lock to remove each lock
from the connection's list:

  list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
      spin_lock(&fp->conn->llist_lock);
      list_del(&smb_lock->clist);
      spin_unlock(&fp->conn->llist_lock);
  }

However, when a client disconnects without SMB2 LOGOFF, ksmbd preserves
durable file handles via session_fd_check(), which sets fp->conn to
NULL and arms the durable scavenger timeout, but does not detach the
byte-range locks from the dying connection's lock list.

When the scavenger timeout expires, ksmbd_durable_scavenger() calls
__ksmbd_close_fd(NULL, fp). At this point fp->conn is NULL and the
original connection object has already been freed by ksmbd_conn_free(),
so it would cause a use-after-free or NULL pointer dereference.

Fix by checking fp->conn for NULL before accessing fp->conn->llist_lock
in the lock cleanup loop. 

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Cc: stable@vger.kernel.org
Signed-off-by: munan Huang <munanevil@gmail.com>
---
 fs/smb/server/vfs_cache.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 168f2dd7e200..772a84d95fe3 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -463,9 +463,11 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 	 * there are not accesses to fp->lock_list.
 	 */
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
-		spin_lock(&fp->conn->llist_lock);
-		list_del(&smb_lock->clist);
-		spin_unlock(&fp->conn->llist_lock);
+		if (fp->conn) {
+			spin_lock(&fp->conn->llist_lock);
+			list_del(&smb_lock->clist);
+			spin_unlock(&fp->conn->llist_lock);
+		}
 
 		list_del(&smb_lock->flist);
 		locks_free_lock(smb_lock->fl);
-- 
2.34.1


