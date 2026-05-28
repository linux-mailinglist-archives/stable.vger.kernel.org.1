Return-Path: <stable+bounces-255107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AQZMGadGGr+lQgAu9opvQ
	(envelope-from <stable+bounces-255107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:54:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5B5F7657
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 721B93040E38
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8533B33CE8A;
	Thu, 28 May 2026 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yL1NxMi1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7B31159C;
	Thu, 28 May 2026 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997987; cv=none; b=uYdlQv1CG8FnmpNF+xeP2n7XU/QrS1T9CYBfKojt2+HQ+9VR3+TF7s+40QMapRe/UisdSY+wgpWedtKxcyBiJDYlYTsn4pPpsuW3gtTjiG3W8Yo7xWL5KC4WFXlQNRfO2eMn3DipUNO/IooftuwtaDtGWESTQzgAzqFec5OKkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997987; c=relaxed/simple;
	bh=wzsZfPEZ85JvjW1xVtqRpoARm9xqlz3C3To+fVz0ilA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcBoGCIAsJR7/31FgsPRv98AXhzuYSNIdfIhOY0WN2JTSLqg70AgPYzso7eEeHdsMk8m3qihF8jo4hO49FGudk7DBNq8KddTYzFM7kqMXMXZ/wox6ndDjy033Eq0VNLpnw+5RMIlXmXRa8skyEdTVcxcoZCnNu5X1JSWEivkhfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yL1NxMi1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BCA1F000E9;
	Thu, 28 May 2026 19:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779997985;
	bh=GyBwaKquvu9M8gY0TsOix/jyq/PSQGJNfE6bP00tNcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yL1NxMi1q1uRJ8bM79acKAj1x8nmEdp2Lq41WrIp8gFpqGPPYZxcmZGxDOPTSjp9y
	 kXlypi+Mv25WlyACD7a4FNVSo79D6NYu23pdJxphsj5CMa9VHbDirOTjVZYottWZ7h
	 5eMBj690xbP0duLhD5vNUOG83sz0/MlO3C98c1Pw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junyi Liu <moss80199@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 7.0 014/461] ksmbd: validate SID in parent security descriptor during ACL inheritance
Date: Thu, 28 May 2026 21:42:23 +0200
Message-ID: <20260528194647.271438073@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255107-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BEE5B5F7657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junyi Liu <moss80199@gmail.com>

commit 69f030cf95488ae1186c72ac8c66fd279664ea7f upstream.

Introduce smb_validate_ntsd_sid() helper to safely validate Owner SID
and Group SID inside the NT Security Descriptor (smb_ntsd) retrieved
from the parent directory.

Cc: stable@vger.kernel.org
Signed-off-by: Junyi Liu <moss80199@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smbacl.c |   66 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 16 deletions(-)

--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1096,6 +1096,40 @@ static int smb_append_inherited_ace(stru
 	return 0;
 }
 
+static int smb_validate_ntsd_sid(struct smb_ntsd *pntsd, size_t pntsd_size,
+				  unsigned int sid_offset, struct smb_sid **sid,
+				  size_t *sid_size)
+{
+	size_t sid_end;
+
+	*sid = NULL;
+	*sid_size = 0;
+
+	if (!sid_offset)
+		return 0;
+
+	if (sid_offset < sizeof(struct smb_ntsd) ||
+	    check_add_overflow(sid_offset, (size_t)CIFS_SID_BASE_SIZE,
+			       &sid_end) ||
+	    sid_end > pntsd_size)
+		return -EINVAL;
+
+	*sid = (struct smb_sid *)((char *)pntsd + sid_offset);
+	if ((*sid)->num_subauth > SID_MAX_SUB_AUTHORITIES)
+		return -EINVAL;
+
+	if (check_add_overflow((size_t)CIFS_SID_BASE_SIZE,
+			       sizeof(__le32) * (size_t)(*sid)->num_subauth,
+			       &sid_end))
+		return -EINVAL;
+
+	if (sid_offset > pntsd_size || sid_end > pntsd_size - sid_offset)
+		return -EINVAL;
+
+	*sid_size = sid_end;
+	return 0;
+}
+
 int smb_inherit_dacl(struct ksmbd_conn *conn,
 		     const struct path *path,
 		     unsigned int uid, unsigned int gid)
@@ -1108,28 +1142,28 @@ int smb_inherit_dacl(struct ksmbd_conn *
 	struct dentry *parent = path->dentry->d_parent;
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	int inherited_flags = 0, flags = 0, i, nt_size = 0, pdacl_size;
-	int rc = 0, pntsd_type, pntsd_size, acl_len, aces_size;
+	int rc = 0, pntsd_type, ppntsd_size, acl_len, aces_size;
 	unsigned int dacloffset;
 	size_t dacl_struct_end;
 	u16 num_aces, ace_cnt = 0;
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
 
-	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, idmap,
+	ppntsd_size = ksmbd_vfs_get_sd_xattr(conn, idmap,
 					    parent, &parent_pntsd);
-	if (pntsd_size <= 0)
+	if (ppntsd_size <= 0)
 		return -ENOENT;
 
 	dacloffset = le32_to_cpu(parent_pntsd->dacloffset);
 	if (!dacloffset ||
 	    check_add_overflow(dacloffset, sizeof(struct smb_acl), &dacl_struct_end) ||
-	    dacl_struct_end > (size_t)pntsd_size) {
+	    dacl_struct_end > (size_t)ppntsd_size) {
 		rc = -EINVAL;
 		goto free_parent_pntsd;
 	}
 
 	parent_pdacl = (struct smb_acl *)((char *)parent_pntsd + dacloffset);
-	acl_len = pntsd_size - dacloffset;
+	acl_len = ppntsd_size - dacloffset;
 	num_aces = le16_to_cpu(parent_pdacl->num_aces);
 	pntsd_type = le16_to_cpu(parent_pntsd->type);
 	pdacl_size = le16_to_cpu(parent_pdacl->size);
@@ -1243,19 +1277,19 @@ pass:
 		struct smb_ntsd *pntsd;
 		struct smb_acl *pdacl;
 		struct smb_sid *powner_sid = NULL, *pgroup_sid = NULL;
-		int powner_sid_size = 0, pgroup_sid_size = 0, pntsd_size;
+		size_t powner_sid_size = 0, pgroup_sid_size = 0, pntsd_size;
 		size_t pntsd_alloc_size;
 
-		if (parent_pntsd->osidoffset) {
-			powner_sid = (struct smb_sid *)((char *)parent_pntsd +
-					le32_to_cpu(parent_pntsd->osidoffset));
-			powner_sid_size = 1 + 1 + 6 + (powner_sid->num_subauth * 4);
-		}
-		if (parent_pntsd->gsidoffset) {
-			pgroup_sid = (struct smb_sid *)((char *)parent_pntsd +
-					le32_to_cpu(parent_pntsd->gsidoffset));
-			pgroup_sid_size = 1 + 1 + 6 + (pgroup_sid->num_subauth * 4);
-		}
+		rc = smb_validate_ntsd_sid(parent_pntsd, ppntsd_size,
+					   le32_to_cpu(parent_pntsd->osidoffset),
+					   &powner_sid, &powner_sid_size);
+		if (rc)
+			goto free_aces_base;
+		rc = smb_validate_ntsd_sid(parent_pntsd, ppntsd_size,
+					   le32_to_cpu(parent_pntsd->gsidoffset),
+					   &pgroup_sid, &pgroup_sid_size);
+		if (rc)
+			goto free_aces_base;
 
 		if (check_add_overflow(sizeof(struct smb_ntsd),
 				       (size_t)powner_sid_size,



