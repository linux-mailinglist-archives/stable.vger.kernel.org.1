Return-Path: <stable+bounces-240983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELN9Cj9/62lLNgAAu9opvQ
	(envelope-from <stable+bounces-240983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:33:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E746040B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C8F4300646C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBBC3DA7FC;
	Fri, 24 Apr 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmJQbvjc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AD3BC666
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041212; cv=none; b=ZiYCqN70WgNZPZcPy/G4Mn7FFG0A4aN5DtgNkQbK2FiVbuA7sqUKhcGqri42tZBdMjTZN9AK34mnkwkS5Z9Nb7oBCnmmR4PK+sRuO3Q7QeNvsuj4JjjTgraSOwyYlQl310OdETs2EM2pqLs20o6d0y9Vtk8xpJoEqKx9WpgcOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041212; c=relaxed/simple;
	bh=eWpLfqLCqjAQvwz6AOdM4K6mJXz1b5JjQyvnMwhMKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L37H6MMEX+aOTtx+oFRq0wmLxS6BDkMKHJYDsfw7kcvcG2wsb/NLqFnUJs3P+2NzEoErGjDD6GDgbCV2vsI0iP1Ub/W6281VL+CJnmdCxkXSEJKUIFuuxJDsVlE4dWwM8boKSsaGiiyTR4HibCvbmWR+gI+yATT2GGW2nwtIt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmJQbvjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C435C19425;
	Fri, 24 Apr 2026 14:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777041211;
	bh=eWpLfqLCqjAQvwz6AOdM4K6mJXz1b5JjQyvnMwhMKhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmJQbvjcoZaV9Sju8AbfagTG/yGjHU6Vwlqklj5VRIpU6a0iY6OWtz0QU4xuflgOl
	 /BpKGug0CJDAnEcUbPOHlHVKbZHH7RGYurmxRU7Vk7hVmp7R+a+//QccHPKoMs0J+e
	 iMcL8OBb7TgsBNLOav09Pq1b1YwzGR2P8MFSZpm928iXHY2ZavXwR//6gZiUBfIudh
	 EtLj75k7TQniOAw8VQeL6GnQBIseYCTah2HbuHzs1iaIrJtWl561C5NhssrqeV/QFl
	 s6JAGO4702GBOjRaMi1VdCFwWhil5WoNe6cDLSeJl22hIgDD3VCWSkLzKvkBiCvOwW
	 LA7eeKk7BEf+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: validate the whole DACL before rewriting it in cifsacl
Date: Fri, 24 Apr 2026 10:33:28 -0400
Message-ID: <20260424143328.2171417-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042443-canyon-unwed-b0bf@gregkh>
References: <2026042443-canyon-unwed-b0bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C00E746040B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240983-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 0a8cf165566ba55a39fd0f4de172119dd646d39a ]

build_sec_desc() and id_mode_to_cifs_acl() derive a DACL pointer from a
server-supplied dacloffset and then use the incoming ACL to rebuild the
chmod/chown security descriptor.

The original fix only checked that the struct smb_acl header fits before
reading dacl_ptr->size or dacl_ptr->num_aces.  That avoids the immediate
header-field OOB read, but the rewrite helpers still walk ACEs based on
pdacl->num_aces with no structural validation of the incoming DACL body.

A malicious server can return a truncated DACL that still contains a
header, claims one or more ACEs, and then drive
replace_sids_and_copy_aces() or set_chmod_dacl() past the validated
extent while they compare or copy attacker-controlled ACEs.

Factor the DACL structural checks into validate_dacl(), extend them to
validate each ACE against the DACL bounds, and use the shared validator
before the chmod/chown rebuild paths.  parse_dacl() reuses the same
validator so the read-side parser and write-side rewrite paths agree on
what constitutes a well-formed incoming DACL.

Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file ownership.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ no kmalloc_objs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 116 +++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index ce2ebc213a1d9..897de9501da24 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -757,6 +757,77 @@ static void dump_ace(struct smb_ace *pace, char *end_of_acl)
 }
 #endif
 
+static int validate_dacl(struct smb_acl *pdacl, char *end_of_acl)
+{
+	int i, ace_hdr_size, ace_size, min_ace_size;
+	u16 dacl_size, num_aces;
+	char *acl_base, *end_of_dacl;
+	struct smb_ace *pace;
+
+	if (!pdacl)
+		return 0;
+
+	if (end_of_acl < (char *)pdacl + sizeof(struct smb_acl)) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	dacl_size = le16_to_cpu(pdacl->size);
+	if (dacl_size < sizeof(struct smb_acl) ||
+	    end_of_acl < (char *)pdacl + dacl_size) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	num_aces = le16_to_cpu(pdacl->num_aces);
+	if (!num_aces)
+		return 0;
+
+	ace_hdr_size = offsetof(struct smb_ace, sid) +
+		offsetof(struct smb_sid, sub_auth);
+	min_ace_size = ace_hdr_size + sizeof(__le32);
+	if (num_aces > (dacl_size - sizeof(struct smb_acl)) / min_ace_size) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	end_of_dacl = (char *)pdacl + dacl_size;
+	acl_base = (char *)pdacl;
+	ace_size = sizeof(struct smb_acl);
+
+	for (i = 0; i < num_aces; ++i) {
+		if (end_of_dacl - acl_base < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		pace = (struct smb_ace *)(acl_base + ace_size);
+		acl_base = (char *)pace;
+
+		if (end_of_dacl - acl_base < ace_hdr_size ||
+		    pace->sid.num_subauth == 0 ||
+		    pace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		ace_size = ace_hdr_size + sizeof(__le32) * pace->sid.num_subauth;
+		if (end_of_dacl - acl_base < ace_size ||
+		    le16_to_cpu(pace->size) < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		ace_size = le16_to_cpu(pace->size);
+		if (end_of_dacl - acl_base < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
@@ -764,7 +835,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	int i;
 	u16 num_aces = 0;
 	int acl_size;
-	char *acl_base;
+	char *acl_base, *end_of_dacl;
 	struct smb_ace **ppace;
 
 	/* BB need to add parm so we can store the SID BB */
@@ -776,12 +847,8 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 		return;
 	}
 
-	/* validate that we do not go past end of acl */
-	if (end_of_acl < (char *)pdacl + sizeof(struct smb_acl) ||
-	    end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size)) {
-		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+	if (validate_dacl(pdacl, end_of_acl))
 		return;
-	}
 
 	cifs_dbg(NOISY, "DACL revision %d size %d num aces %d\n",
 		 le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
@@ -792,6 +859,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	   user/group/other have no permissions */
 	fattr->cf_mode &= ~(0777);
 
+	end_of_dacl = (char *)pdacl + le16_to_cpu(pdacl->size);
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct smb_acl);
 
@@ -799,36 +867,16 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	if (num_aces > 0) {
 		umode_t denied_mode = 0;
 
-		if (num_aces > (le16_to_cpu(pdacl->size) - sizeof(struct smb_acl)) /
-				(offsetof(struct smb_ace, sid) +
-				 offsetof(struct smb_sid, sub_auth) + sizeof(__le16)))
-			return;
-
 		ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *),
 				      GFP_KERNEL);
 		if (!ppace)
 			return;
 
 		for (i = 0; i < num_aces; ++i) {
-			if (end_of_acl - acl_base < acl_size)
-				break;
-
 			ppace[i] = (struct smb_ace *) (acl_base + acl_size);
-			acl_base = (char *)ppace[i];
-			acl_size = offsetof(struct smb_ace, sid) +
-				offsetof(struct smb_sid, sub_auth);
-
-			if (end_of_acl - acl_base < acl_size ||
-			    ppace[i]->sid.num_subauth == 0 ||
-			    ppace[i]->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
-			    (end_of_acl - acl_base <
-			     acl_size + sizeof(__le32) * ppace[i]->sid.num_subauth) ||
-			    (le16_to_cpu(ppace[i]->size) <
-			     acl_size + sizeof(__le32) * ppace[i]->sid.num_subauth))
-				break;
 
 #ifdef CONFIG_CIFS_DEBUG2
-			dump_ace(ppace[i], end_of_acl);
+			dump_ace(ppace[i], end_of_dacl);
 #endif
 			if (mode_from_special_sid &&
 			    (compare_sids(&(ppace[i]->sid),
@@ -870,6 +918,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 				(void *)ppace[i],
 				sizeof(struct smb_ace)); */
 
+			acl_base = (char *)ppace[i];
 			acl_size = le16_to_cpu(ppace[i]->size);
 		}
 
@@ -1293,10 +1342,9 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
 		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
-		if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
-			cifs_dbg(VFS, "Server returned illegal ACL size\n");
-			return -EINVAL;
-		}
+		rc = validate_dacl(dacl_ptr, end_of_acl);
+		if (rc)
+			return rc;
 	}
 
 	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
@@ -1669,6 +1717,12 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
+			rc = validate_dacl(dacl_ptr, (char *)pntsd + secdesclen);
+			if (rc) {
+				kfree(pntsd);
+				cifs_put_tlink(tlink);
+				return rc;
+			}
 			if (mode_from_sid)
 				nsecdesclen +=
 					le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
-- 
2.53.0


