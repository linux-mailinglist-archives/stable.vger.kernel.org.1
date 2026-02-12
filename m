Return-Path: <stable+bounces-215924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLkYDIuUjWmK4wAAu9opvQ
	(envelope-from <stable+bounces-215924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:51:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4240512B8E0
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57442302AE00
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FF2C029D;
	Thu, 12 Feb 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DDwpGHnt"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACB3EBF31;
	Thu, 12 Feb 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770886267; cv=none; b=t6YTVn7/+H5ozr4LwGDUb77HxlQEsuZLOy/gX0mDjGpgJlD3aZ9WkSQrRROBi6OFFG+6jIbPxsgAeVf68ZzSpkhRkeugXR9kHzourjWZ/L/ZoevlG1Q+76w2V8Kxpk+Seh4AD1X31K375boUDhLMgzHJPSealOaFP21VS+QrC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770886267; c=relaxed/simple;
	bh=0J6JT+pRT/6bpSeCt12bcjPyr9ZhBcdGVW1RGAQfCpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tza+ilP31+d2xMqO3n/gVYBPJ7EUOWAv3LIGdZAUtTzdbN3YcuuAKmMTJaCa+3jY0BN4zPSwBX0/3LwEcPvdaY0PUifdZkeUw2+ungKnkOyxJPSTjKlySb0EcxFG9W9URw1Us68IMl3WCiQ48E5EhlROeElFr0hg8mkH+yB3CLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DDwpGHnt; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hh
	iamvgDFTVo/jfUokbT0NnsjEgQXZGOUdH4cQDqKF4=; b=DDwpGHntAgKJjz4TCc
	+exg3YTCklhU2SOdVADtpkD3ZkYc7TCiM2USbSpTO8DWZiB45etnL9LOq/8Z3dZG
	lfBJvz5p/ysfJUy916gFeA8uWdTwSCXDFd1whGI3Z7XSSHuFap1z1tsQ7HuCGJ4G
	enq/dGGDhZpvx6PgKSP6E68L8=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAn8pVYlI1pMbLrKQ--.43069S2;
	Thu, 12 Feb 2026 16:50:34 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>,
	Shane Nehring <snehring@iastate.edu>,
	Steve French <stfrench@microsoft.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15.y] smb: client: set correct id, uid and cruid for multiuser automounts
Date: Thu, 12 Feb 2026 16:50:30 +0800
Message-Id: <20260212085030.372707-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn8pVYlI1pMbLrKQ--.43069S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy5Gr4UZrWxJF1DXw18Zrb_yoW8ZF15pr
	4rKr1rJr4rXF17KFsxC3WFq3sxGryvya1fuayUu3saqas8Z39xWwnFq3WjvryDtrW8ta43
	XrWktr1jgayjyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_7KsxUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3hr4kmmNlFpQswAA3n
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,manguebit.com,iastate.edu,microsoft.com,163.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215924-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iastate.edu:email]
X-Rspamd-Queue-Id: 4240512B8E0
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
 fs/cifs/cifs_dfs_ref.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index 020e71fe1454..2c6dee3f097b 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -258,6 +258,21 @@ char *cifs_compose_mount_options(const char *sb_mountdata,
 	goto compose_mount_options_out;
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
@@ -309,6 +324,7 @@ static struct vfsmount *cifs_dfs_do_automount(struct path *path)
 	tmp.source = full_path;
 	tmp.UNC = tmp.prepath = NULL;
 
+	fs_context_set_ids(&tmp);
 	rc = smb3_fs_context_dup(ctx, &tmp);
 	if (rc) {
 		mnt = ERR_PTR(rc);
-- 
2.34.1


