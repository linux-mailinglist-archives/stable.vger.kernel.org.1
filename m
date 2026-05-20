Return-Path: <stable+bounces-251547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KoRL90bDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:38:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EFF599E18
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F47833A799C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B735E931;
	Wed, 20 May 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1TfcWce"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B807B2D879E;
	Wed, 20 May 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298263; cv=none; b=ANBgZiY3ipXMaEmlsJV7M41uCDIVBDRGTx4Edw+ZR9Rd+MPYPUln1zkW6azq1wZtd62tV4NryhjxXsnom+29LdM0pD2sS0PhdJz0npsk+hsLW++NhpfaEUUHOjklpGJ6aopmLZxCunsj2SE6qX+1OtddkhTXoiWpUL8+krTdcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298263; c=relaxed/simple;
	bh=qTcdzUpvKy58cbVVlb56VM8vqqxdXgx+zEmXuddj2lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ8U8jYmMqb5bvGeAwYdPr/a56V5sbzldwp6Z5nSu4gWIZWUld8IP9YtyeeL1VISwB/ArUJBDHLx/iKdtHG55ekJNJCWhlPpFVtcuNV93clJ56dk2o4Eoa4egWmf6rbqMKH9911qrpSAj4pvyBjL2y0vudN6hsSv1GEDsJL0A44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1TfcWce; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EF51F000E9;
	Wed, 20 May 2026 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298262;
	bh=hgQeIrVNruSydDJe0C5JYijtcekYB3S3REEgNNA9KGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h1TfcWcekQe2ABu6f25Of64kNr2Dr7xDCQByRL7wT0COTAETVNP99zvunWkwhUgZy
	 JBL7hLpCeVNBXp2KVUAWJ/6Ddq4ffB/J2MotM7FrjT2ZMnuiG0hMK1HKWpY1cp9mh5
	 szgkF6jzuzSPh0AGc+Srw+iYkKBVDSJRxauY7WtU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 343/957] fanotify: call fanotify_events_supported() before path_permission() and security_path_notify()
Date: Wed, 20 May 2026 18:13:46 +0200
Message-ID: <20260520162141.970617700@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251547-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,gmail.com,paul-moore.com,suse.cz,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.cz:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,paul-moore.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 20EFF599E18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 66052a768d4726a31e939b5ac902f2b0b452c8d5 ]

The latter trigger LSM (e.g. SELinux) checks, which will log a denial
when permission is denied, so it's better to do them after validity
checks to avoid logging a denial when the operation would fail anyway.

Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc filesystem")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Link: https://patch.msgid.link/20260216150625.793013-3-omosnace@redhat.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1c05c11e3cb25..5c30f4d8c7c16 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1210,6 +1210,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 
 		*path = fd_file(f)->f_path;
 		path_get(path);
+		ret = 0;
 	} else {
 		unsigned int lookup_flags = 0;
 
@@ -1219,22 +1220,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 			lookup_flags |= LOOKUP_DIRECTORY;
 
 		ret = user_path_at(dfd, filename, lookup_flags, path);
-		if (ret)
-			goto out;
 	}
-
-	/* you can only watch an inode if you have read permissions on it */
-	ret = path_permission(path, MAY_READ);
-	if (ret) {
-		path_put(path);
-		goto out;
-	}
-
-	ret = security_path_notify(path, mask, obj_type);
-	if (ret)
-		path_put(path);
-
-out:
 	return ret;
 }
 
@@ -2074,6 +2060,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			goto path_put_and_out;
 	}
 
+	/* you can only watch an inode if you have read permissions on it */
+	ret = path_permission(&path, MAY_READ);
+	if (ret)
+		goto path_put_and_out;
+
+	ret = security_path_notify(&path, mask, obj_type);
+	if (ret)
+		goto path_put_and_out;
+
 	if (fid_mode) {
 		ret = fanotify_test_fsid(path.dentry, flags, &__fsid);
 		if (ret)
-- 
2.53.0




