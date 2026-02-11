Return-Path: <stable+bounces-215746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGZlO2QMjGnffQAAu9opvQ
	(envelope-from <stable+bounces-215746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:58:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C26121442
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E21D730138E4
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECA3451BD;
	Wed, 11 Feb 2026 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FFFcn8aI"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8A10FD;
	Wed, 11 Feb 2026 04:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770785885; cv=none; b=GWdKgtqhMqhL+J+aIMDCbP5mQf10RGKXEKVQrVKEDYibkZidCkFpGQwSQxyHh2quyQhQq+icHUGZkeuOJr/1mvsihwir+3ysH9FCxiFNKnBfPENujsioEqQjmQudJ66IK1AvaCV6Irp9hImJ7O3h/IWzXHd8QWOL7Zw+xr82dLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770785885; c=relaxed/simple;
	bh=+FA1W9Z2vbQjQK0j2jUNqimALwu8nHPzLir3ppUSooU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbU09GZjNxWywvTemCaqoK9dqdWOikuF7SYcGyg1HkKqRiy3jOy0P491FLNMUEOwuAd5Z/XKHVDLKXQ+Eb7Arw8x8jqKY7/lH8iWOMTLDMSBOUdXodezw61xnanIDsKOFjJpEl9StknXeCmVtmhSS81Kvc5sv/92Bq9iM3I2/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FFFcn8aI; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vq
	WDiSJjDTfe4TM7yCfDJmVRe3dt5YsEZvwC61BIbzM=; b=FFFcn8aIQ5YZNc43nB
	UvOdAmX8dG4VgmEon/K6ABR8cWMu75K+pKRaiG79lSqB+Cc3gPE+1r3ZVEnl8uOf
	evS3Qze9aZB1pdKhE4G55wA+9ohW9ccgGZxKfpziYrIuzEyL2XQt4aXjSpcWQxNY
	c7DSUjJy952bFWCkUUlcK6o7w=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3X6o0DIxpkN3MKg--.65390S2;
	Wed, 11 Feb 2026 12:57:24 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>,
	Shane Nehring <snehring@iastate.edu>,
	Steve French <stfrench@microsoft.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1.y] smb: client: set correct id, uid and cruid for multiuser automounts
Date: Wed, 11 Feb 2026 12:57:21 +0800
Message-Id: <20260211045721.3672020-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X6o0DIxpkN3MKg--.65390S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy5Gr4UZrWxJF1DXw18Zrb_yoW8ZFyxpr
	4rCr1rGrs5XF17GanIy3WYqasxJryvyF1xG3y7C3s29a4DZ39xWanFqa12vFy8trWFqa4F
	qrWqyr429ay2yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEGQ6NUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3RWNJ2mMDDVe9wAA3X
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,manguebit.com,iastate.edu,microsoft.com,163.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215746-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iastate.edu:email]
X-Rspamd-Queue-Id: 17C26121442
X-Rspamd-Action: no action

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 4508ec17357094e2075f334948393ddedbb75157 ]

When uid, gid and cruid are not specified, we need to dynamically
set them into the filesystem context used for automounting otherwise
they'll end up reusing the values from the parent mount.

Fixes: 9fd29a5bae6e ("cifs: use fs_context for automounts")
Reported-by: Shane Nehring <snehring@iastate.edu>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2259257
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ The context change is due to the commit 561f82a3a24c
("smb: client: rename cifs_dfs_ref.c to namespace.c") and the commit
0a049935e47e ("smb: client: get rid of dfs naming in automount code")
in v6.6 which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 fs/smb/client/cifs_dfs_ref.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/smb/client/cifs_dfs_ref.c b/fs/smb/client/cifs_dfs_ref.c
index 876f9a43a99d..d8a20283de0d 100644
--- a/fs/smb/client/cifs_dfs_ref.c
+++ b/fs/smb/client/cifs_dfs_ref.c
@@ -283,6 +283,21 @@ static int set_dest_addr(struct smb3_fs_context *ctx, const char *full_path)
 	return rc;
 }
 
+static void fs_context_set_ids(struct smb3_fs_context *ctx)
+{
+	kuid_t uid = current_fsuid();
+	kgid_t gid = current_fsgid();
+
+	if (ctx->multiuser) {
+		if (!ctx->uid_specified)
+			ctx->linux_uid = uid;
+		if (!ctx->gid_specified)
+			ctx->linux_gid = gid;
+	}
+	if (!ctx->cruid_specified)
+		ctx->cred_uid = uid;
+}
+
 /*
  * Create a vfsmount that we can automount
  */
@@ -333,6 +348,7 @@ static struct vfsmount *cifs_dfs_do_automount(struct path *path)
 	tmp.source = full_path;
 	tmp.UNC = tmp.prepath = NULL;
 
+	fs_context_set_ids(&tmp);
 	rc = smb3_fs_context_dup(ctx, &tmp);
 	if (rc) {
 		mnt = ERR_PTR(rc);
-- 
2.34.1


