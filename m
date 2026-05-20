Return-Path: <stable+bounces-249899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFKAIuWkDWqh0wUAu9opvQ
	(envelope-from <stable+bounces-249899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:11:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE958D5E7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF06B30686E9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C83D75B1;
	Wed, 20 May 2026 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcjwA3lX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41EC3B6363
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278079; cv=none; b=TizyqVRb0gABhLRhhiHRhC9yoeGxMPnNMDgV7WmGIcrraVl3eCLStngV9GlHIMTmNkYBroEsxz0UTPwRSo7zrneV2odILPhTnhqpCFEYsR2auEbEUASu3HBtJrKqbTVdHFLYrST3gZR6PgBOsFpsqvh+Z2p3fa4PJjELKoBjV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278079; c=relaxed/simple;
	bh=Fbk6L2xWU/5AHw9ysBsi41NZk4qb/uQ4JMg6ayEU1dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOBDIgY8V3kkGioiRwEHsjWrkJASrK3SOPK4zuYTUXtRsIDDKfa3R2v/sz4aObPNNfABF9T1qNIKkXwVo2LFF4IDyjCND5ESYRBj6p3Y4oOQy7lYPtWXMEt13zyqtBYRndhqoHGjtc8ep0HBidu+LHkDIWBzM8li+FQdCCfwnmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcjwA3lX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1461F000E9;
	Wed, 20 May 2026 11:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779278078;
	bh=/KGXVQoTgRy3mCq6BugzaK/QWqod6LN+JeDPoLGoq/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VcjwA3lXgsFCn6OqXFvL0xIkbK6Si7batDRSdCqCnbSUA075WazyzXdnzsiUxp4K/
	 BpZU2c0EF9eXYKxmBo0jm0cGdRlunENuFascAzcSS3Y+U3sTbzOsrz+8X2tTNlmMLU
	 wr4bWwBHZfD5AK++nyeD4tHQeDA1Q0Me1GQvt7M39k0rEqBMv6mIuiZPVXFV7msV2g
	 Sw1nfMZ3K59z38PVnbx4gwwo24AAI4j8dYwnWU4OLY6bZMBsnqppfinNEU83u9deCp
	 /2lTI6ySruGaFAL95nSP4j4HyuptZWzEaOz5yEXJJ3KWJ1cycqDcarACeugPwGNYat
	 UoSGrvCx/XmYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shota Zaizen <s@zaizen.me>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: validate inherited ACE SID length
Date: Wed, 20 May 2026 07:54:35 -0400
Message-ID: <20260520115435.3487594-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051443-unsure-stretch-34de@gregkh>
References: <2026051443-unsure-stretch-34de@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249899-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zaizen.me:email]
X-Rspamd-Queue-Id: E9FE958D5E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shota Zaizen <s@zaizen.me>

[ Upstream commit 996454bc0da84d5a1dedb1a7861823087e01a7ae ]

smb_inherit_dacl() walks the parent directory DACL loaded from the
security descriptor xattr. It verifies that each ACE contains the fixed
SID header before using it, but does not verify that the variable-length
SID described by sid.num_subauth is fully contained in the ACE.

A malformed inheritable ACE can advertise more subauthorities than are
present in the ACE. compare_sids() may then read past the ACE.
smb_set_ace() also clamps the copied destination SID, but used the
unchecked source SID count to compute the inherited ACE size. That could
advance the temporary inherited ACE buffer pointer and nt_size accounting
past the allocated buffer.

Fix this by validating the parent ACE SID count and SID length before
using the SID during inheritance. Compute the inherited ACE size from the
copied SID so the size matches the bounded destination SID. Reject the
inherited DACL if size accumulation would overflow smb_acl.size or the
security descriptor allocation size.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Shota Zaizen <s@zaizen.me>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 66 +++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 0a3a26e63ebc0..ff59217b4bea8 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1025,7 +1025,26 @@ static void smb_set_ace(struct smb_ace *ace, const struct smb_sid *sid, u8 type,
 	ace->flags = flags;
 	ace->access_req = access_req;
 	smb_copy_sid(&ace->sid, sid);
-	ace->size = cpu_to_le16(1 + 1 + 2 + 4 + 1 + 1 + 6 + (sid->num_subauth * 4));
+	ace->size = cpu_to_le16(1 + 1 + 2 + 4 + 1 + 1 + 6 +
+				(ace->sid.num_subauth * 4));
+}
+
+static int smb_append_inherited_ace(struct smb_ace **ace, int *nt_size,
+				    u16 *ace_cnt, const struct smb_sid *sid,
+				    u8 type, u8 flags, __le32 access_req)
+{
+	int ace_size;
+
+	smb_set_ace(*ace, sid, type, flags, access_req);
+	ace_size = le16_to_cpu((*ace)->size);
+	/* pdacl->size is __le16 and includes struct smb_acl. */
+	if (check_add_overflow(*nt_size, ace_size, nt_size) ||
+	    *nt_size > U16_MAX - (int)sizeof(struct smb_acl))
+		return -EINVAL;
+
+	(*ace_cnt)++;
+	*ace = (struct smb_ace *)((char *)*ace + ace_size);
+	return 0;
 }
 
 int smb_inherit_dacl(struct ksmbd_conn *conn,
@@ -1090,6 +1109,12 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		if (pace_size > aces_size)
 			break;
 
+		if (parent_aces->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+		    pace_size < offsetof(struct smb_ace, sid) +
+				CIFS_SID_BASE_SIZE +
+				sizeof(__le32) * parent_aces->sid.num_subauth)
+			break;
+
 		aces_size -= pace_size;
 
 		flags = parent_aces->flags;
@@ -1119,22 +1144,24 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		}
 
 		if (is_dir && creator && flags & CONTAINER_INHERIT_ACE) {
-			smb_set_ace(aces, psid, parent_aces->type, inherited_flags,
-				    parent_aces->access_req);
-			nt_size += le16_to_cpu(aces->size);
-			ace_cnt++;
-			aces = (struct smb_ace *)((char *)aces + le16_to_cpu(aces->size));
+			rc = smb_append_inherited_ace(&aces, &nt_size, &ace_cnt,
+						      psid, parent_aces->type,
+						      inherited_flags,
+						      parent_aces->access_req);
+			if (rc)
+				goto free_aces_base;
 			flags |= INHERIT_ONLY_ACE;
 			psid = creator;
 		} else if (is_dir && !(parent_aces->flags & NO_PROPAGATE_INHERIT_ACE)) {
 			psid = &parent_aces->sid;
 		}
 
-		smb_set_ace(aces, psid, parent_aces->type, flags | inherited_flags,
-			    parent_aces->access_req);
-		nt_size += le16_to_cpu(aces->size);
-		aces = (struct smb_ace *)((char *)aces + le16_to_cpu(aces->size));
-		ace_cnt++;
+		rc = smb_append_inherited_ace(&aces, &nt_size, &ace_cnt, psid,
+					      parent_aces->type,
+					      flags | inherited_flags,
+					      parent_aces->access_req);
+		if (rc)
+			goto free_aces_base;
 pass:
 		parent_aces = (struct smb_ace *)((char *)parent_aces + pace_size);
 	}
@@ -1144,7 +1171,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		struct smb_acl *pdacl;
 		struct smb_sid *powner_sid = NULL, *pgroup_sid = NULL;
 		int powner_sid_size = 0, pgroup_sid_size = 0, pntsd_size;
-		int pntsd_alloc_size;
+		size_t pntsd_alloc_size;
 
 		if (parent_pntsd->osidoffset) {
 			powner_sid = (struct smb_sid *)((char *)parent_pntsd +
@@ -1157,8 +1184,19 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pgroup_sid_size = 1 + 1 + 6 + (pgroup_sid->num_subauth * 4);
 		}
 
-		pntsd_alloc_size = sizeof(struct smb_ntsd) + powner_sid_size +
-			pgroup_sid_size + sizeof(struct smb_acl) + nt_size;
+		if (check_add_overflow(sizeof(struct smb_ntsd),
+				       (size_t)powner_sid_size,
+				       &pntsd_alloc_size) ||
+		    check_add_overflow(pntsd_alloc_size,
+				       (size_t)pgroup_sid_size,
+				       &pntsd_alloc_size) ||
+		    check_add_overflow(pntsd_alloc_size, sizeof(struct smb_acl),
+				       &pntsd_alloc_size) ||
+		    check_add_overflow(pntsd_alloc_size, (size_t)nt_size,
+				       &pntsd_alloc_size)) {
+			rc = -EINVAL;
+			goto free_aces_base;
+		}
 
 		pntsd = kzalloc(pntsd_alloc_size, GFP_KERNEL);
 		if (!pntsd) {
-- 
2.53.0


