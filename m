Return-Path: <stable+bounces-231340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKJLIUZxy2k3HwYAu9opvQ
	(envelope-from <stable+bounces-231340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:01:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A6D364B5D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 163B3301221A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9453B774B;
	Tue, 31 Mar 2026 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="CnkWA8Fn"
X-Original-To: stable@vger.kernel.org
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D803A8745
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940475; cv=none; b=FdMm7smqbFRcef5UkObXBpOqq4jCkUocB6EevfskuJzvtksYD/8cKOnzTwxTN/pO7PLjvpNDFw9LrdtBXcVq5Cey3Afm9MClcfefFTUTkJrb+e3fXzMT+kS2f1Rfa57vOsqnLTxRXDjuvBLHwbbOk7zhq577dMJoQx/BT316K2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940475; c=relaxed/simple;
	bh=M2wmi5yj3XHFFZnhpaczCRACrgVAh2vHUkmt62Gxaio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mIw/sOujsSKreDEKUu3CPtmHOWtBshmf3UacPR+KWJp8xxssY/dI2F5gMg/c0d3ZbHwUkPv8xRetu5CwbOzkBkvK1EFhXEt3KaGNgaqi5k8ESrYyJRt2uNm8p9MdDYoiPXfkCj+cFy1iUwGeesk5oZvk2pBngqg+qyB4NM+etG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=CnkWA8Fn; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774940471;
	bh=hZRTzXeo+f/qimGJsHFx65MwoVYeDkem54Ryrk9NRqA=;
	h=From:Subject:Date:Message-Id;
	b=CnkWA8Fn62O4NoTaCsZvZ8Eqd/iwsE8cuwJUmeuil1BLD+JcKNQKyR+MFFQFVFdfk
	 GZ1qoSjWUmIotlWqjMQ/MhoINDA5YDR0/N7gUUuzUmnHuNe2ydPJqLc3yIXpnOMi/b
	 Rz6csW3arE8Dd3dHV9lVZFIeaCRmlRo++C9IMVbg=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.23) with ESMTP
	id 69CB712A000051F4; Tue, 31 Mar 2026 15:01:00 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 9622848913361
X-SMAIL-UIID: C006AE8DB9B74ED79438E91759121FC9-20260331-150100-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shuhao Fu <sfual@cse.ust.hk>,
	Steve French <stfrench@microsoft.com>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] smb: client: Fix refcount leak for cifs_sb_tlink
Date: Tue, 31 Mar 2026 15:00:54 +0800
Message-Id: <20260331070054.4148997-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231340-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[ust.hk:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cse.ust.hk,microsoft.com,sina.com];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RSPAMD_EMAILBL_FAIL(0.00)[johnny_haocn.sina.com:query timed out,sfual.cse.ust.hk:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ust.hk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48A6D364B5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shuhao Fu <sfual@cse.ust.hk>

[ Upstream commit c2b77f42205ef485a647f62082c442c1cd69d3fc ]

Fix three refcount inconsistency issues related to `cifs_sb_tlink`.

Comments for `cifs_sb_tlink` state that `cifs_put_tlink()` needs to be
called after successful calls to `cifs_sb_tlink()`. Three calls fail to
update refcount accordingly, leading to possible resource leaks.

Fixes: 8ceb98437946 ("CIFS: Move rename to ops struct")
Fixes: 2f1afe25997f ("cifs: Use smb 2 - 3 and cifsacl mount options getacl functions")
Fixes: 366ed846df60 ("cifs: Use smb 2 - 3 and cifsacl mount options setacl function")
Cc: stable@vger.kernel.org
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 fs/cifs/inode.c   | 6 ++++--
 fs/cifs/smb2ops.c | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 30a9a89c141b..bb0b172c5a74 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2023,8 +2023,10 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
-	if (!server->ops->rename)
-		return -ENOSYS;
+	if (!server->ops->rename) {
+		rc = -ENOSYS;
+		goto do_rename_exit;
+	}
 
 	/* try path-based rename first */
 	rc = server->ops->rename(xid, tcon, from_path, to_path, cifs_sb);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 619905fc694e..0a62720590da 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3437,8 +3437,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
-		free_xid(xid);
-		return ERR_PTR(rc);
+		goto put_tlink;
 	}
 
 	oparms.tcon = tcon;
@@ -3466,6 +3465,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	}
 
+put_tlink:
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 
@@ -3506,8 +3506,7 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
-		free_xid(xid);
-		return rc;
+		goto put_tlink;
 	}
 
 	oparms.tcon = tcon;
@@ -3527,6 +3526,7 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	}
 
+put_tlink:
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 	return rc;
-- 
2.34.1


