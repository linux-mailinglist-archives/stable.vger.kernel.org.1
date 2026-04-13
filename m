Return-Path: <stable+bounces-237014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCJPMi4f3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-237014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF33F008F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9207A302E891
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF372D8364;
	Mon, 13 Apr 2026 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZNvKYm5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35D24E4A1;
	Mon, 13 Apr 2026 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098367; cv=none; b=EZ/ivIiPSk/LANa1Bl9YL51KTt/TUgOxtG4UsWCkrTtfgb4R7WS0EYbmAOkw44BZR4uzTHfpOWsMRBjaGmma9tPbtt+08QxDLPqUqY80Yp448IT6QtUe4zxLitTZI3QtjWfc/o7t0XCZJnzMHIKf9spwDLMgGe4nqGl9BweXwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098367; c=relaxed/simple;
	bh=phngn7FRYXmpyvSFK7JPhAs3FXrTy8huf6+3Yjtz1sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvvIKoPg9BkvK6E6H1F9zrW6b/pzTe/TAIDW4+YSfYSrDpxRgEZ2bXNwHBjOwT8jMNVkzwiiR0B0dXSWJY2zYpbNsiRUvyGFEkLpVYF1AIxzILEc51e6YIVer2R7u6+ij/jHUze/sheXFX5yFTuE8uMiFGa2BgKp6471bc+vuO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZNvKYm5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1525AC2BCAF;
	Mon, 13 Apr 2026 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098367;
	bh=phngn7FRYXmpyvSFK7JPhAs3FXrTy8huf6+3Yjtz1sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNvKYm5p856WeAJ3sqUT3Bc9Omes5KS7FDIp0xXc7yQMmB29T6eKRoFavjwZwwDjL
	 KnJEeCyR8Ny82Kv/isPd5VQCPBf4k2VNGggwSG7SWfNDCwvoBp9xOj1pMiaLREsHIN
	 gt9YapaMwNYMnzIsW0TCTNgOb6+dXox8lL8V5vkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuhao Fu <sfual@cse.ust.hk>,
	Steve French <stfrench@microsoft.com>,
	Johnny Hao <johnny_haocn@sina.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 497/570] smb: client: Fix refcount leak for cifs_sb_tlink
Date: Mon, 13 Apr 2026 18:00:28 +0200
Message-ID: <20260413155849.074959208@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,cse.ust.hk,microsoft.com,sina.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-237014-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ust.hk:email]
X-Rspamd-Queue-Id: C0AF33F008F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/inode.c   | 6 ++++--
 fs/cifs/smb2ops.c | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 30a9a89c141bb..bb0b172c5a74d 100644
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
index 619905fc694e4..0a62720590daf 100644
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
2.53.0




