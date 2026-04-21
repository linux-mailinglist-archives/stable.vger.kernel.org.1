Return-Path: <stable+bounces-240162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLxFG45752nC9QEAu9opvQ
	(envelope-from <stable+bounces-240162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:28:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 283FF43B580
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A2A6305AC9E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55093A3E87;
	Tue, 21 Apr 2026 13:26:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDA19004A;
	Tue, 21 Apr 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777976; cv=none; b=tXsIhDX56PsIsgcrFRZq4bE8i1LJt63e7VQhHFZZVm5FnXI/Fk/Isz+TFdbaccepd5AXi6MS9B6ex7+vMcY1Nm4s09Hvx06g9M5xx3LE7iLI0qL+SYsFZDS+fSA83ejQIztiK73PXKF7hSHkzL9PTppFJUnTuP6bf1oeZYB7RW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777976; c=relaxed/simple;
	bh=oYn8wqJFenAgTBU6zT0gfzUkCUtPMUGM8nu/rQnPnV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pns8ZbxvCQAzEWP8tLiDz69kBQNS+iw3u5FPnOsLDMim79KVxQhAVzA5ZGG+OLt3z82qjfYJ2ITfllPvUxOgYsYJgndfzuCu5FTPjFXv6Nwi6JpOu0X1YlXD4eew3XKWTRMJC7zfqtRQ19Iow1hftaDm7g+g8/7JeJrq7JES0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 2E1C82338F;
	Tue, 21 Apr 2026 16:26:13 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] cifs: Fix connections leak when tlink setup failed
Date: Tue, 21 Apr 2026 16:26:12 +0300
Message-Id: <20260421132612.38517-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240162-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,altlinux.org:mid,altlinux.org:email,huawei.com:email,cjr.nz:email]
X-Rspamd-Queue-Id: 283FF43B580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

commit 1dcdf5f5b2137185cbdd5385f29949ab3da4f00c upstream.

If the tlink setup failed, lost to put the connections, then
the module refcnt leak since the cifsd kthread not exit.

Also leak the fscache info, and for next mount with fsc, it will
print the follow errors:
  CIFS: Cache volume key already in use (cifs,127.0.0.1:445,TEST)

Let's check the result of tlink setup, and do some cleanup.

Fixes: 56c762eb9bee ("cifs: Refactor out cifs_mount()")
Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ kovalev: bp to fix CVE-2022-49822; adapted to use direct xid/ses/tcon
  variables instead of mnt_ctx struct fields due to the older kernel not
  having the corresponding cifs_mount() refactoring (see upstream commit
  c88f7dcd6d64) ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/cifs/connect.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 769c7759601d..3161155fd069 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4786,9 +4786,13 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb_vol *vol)
 	vol->prepath = NULL;
 
 out:
-	free_xid(xid);
 	cifs_try_adding_channels(ses);
-	return mount_setup_tlink(cifs_sb, ses, tcon);
+	rc = mount_setup_tlink(cifs_sb, ses, tcon);
+	if (rc)
+		goto error;
+
+	free_xid(xid);
+	return rc;
 
 error:
 	kfree(ref_path);
@@ -4820,9 +4824,12 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb_vol *vol)
 			goto error;
 	}
 
-	free_xid(xid);
+	rc = mount_setup_tlink(cifs_sb, ses, tcon);
+	if (rc)
+		goto error;
 
-	return mount_setup_tlink(cifs_sb, ses, tcon);
+	free_xid(xid);
+	return rc;
 
 error:
 	mount_put_conns(cifs_sb, xid, server, ses, tcon);
-- 
2.50.1


