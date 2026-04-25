Return-Path: <stable+bounces-241085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B26EdIM7Gn3TwAAu9opvQ
	(envelope-from <stable+bounces-241085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:37:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4CA46447E
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 055B6300DDDA
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52A1A6813;
	Sat, 25 Apr 2026 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVxPJRO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B91B808
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077440; cv=none; b=NNFrTJcBFhAIJEtVi0oXYFF3Fcp2Q/bHa3bfyqGGUcEYG6rxRVlVde+ddUYI6mZXrv3vh26vZGn7lW89OcTjA275zJEo0xXoPOtIzDGaVrSTAmtv5FHIgQGLkt6wj+FK415RuNQmW6siuQlk5ecy0uDGqYpa6CinbRvMB8Lo8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077440; c=relaxed/simple;
	bh=KOzt84UGQZnt6M2Z3kE+g6F91hlO05w5gDj/g+AmP+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEJ759/pXww9UUin9E4jEXgZGSbzPgTx+3rKC6MoGBfkMdpa9Q0PTuw/aR52G2f6BMHX+o/vPvIyoMVfUn3ZeXFKrF7GmjoE2hIm1+25eBRJce182DLAJL5mdDfczm8uuXVri/B9G+ewPnHvP88ydpzL0jfOECvYIaLyfCEb8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVxPJRO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD4FC19425;
	Sat, 25 Apr 2026 00:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777077440;
	bh=KOzt84UGQZnt6M2Z3kE+g6F91hlO05w5gDj/g+AmP+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVxPJRO9lOgICyzZukuOjjbUNBdfldHgJ5a7KHXCF4cktlPT4F+/JcPYY7D4zpSHV
	 JhrBg5rtLjnEhNZ91/b10w5z/fmnjVysDmS9NtjG6vR+YRAVuLHh4vls0iwtxwdM4/
	 3g4y/4wLuxERxETFa6HkffDsRzymk1mOY2FhCCVagCmY2UDblqVqlU7D4mC2VNeiHY
	 nV/41hWFwLA9Yh4WbJYa7vRX5XqZGHkY2qk1qllZNkIm9JVH12IvAIrVM0to7Lup6d
	 mUWa/VgyRRwmP7YDGxGoLj0RX8baPERIsQU9rYrkKBZtmJjZPz/5FUrlS25MuIMlXR
	 4Xuyt28kaLITg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: validate the whole DACL before rewriting it in cifsacl
Date: Fri, 24 Apr 2026 20:37:18 -0400
Message-ID: <20260425003718.2642374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042446-omen-saddling-ddde@gregkh>
References: <2026042446-omen-saddling-ddde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C4CA46447E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241085-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
[ renamed smb_acl/smb_ace/smb_sid/smb_ntsd to cifs_* and widened num_aces from u16 to u32 for 6.1's __le32 field ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 95 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index bf861fef2f0c3..b6dc3543a40f8 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -753,6 +753,78 @@ static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
 }
 #endif
 
+static int validate_dacl(struct cifs_acl *pdacl, char *end_of_acl)
+{
+	int i, ace_hdr_size, ace_size, min_ace_size;
+	u16 dacl_size;
+	u32 num_aces;
+	char *acl_base, *end_of_dacl;
+	struct cifs_ace *pace;
+
+	if (!pdacl)
+		return 0;
+
+	if (end_of_acl < (char *)pdacl + sizeof(struct cifs_acl)) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	dacl_size = le16_to_cpu(pdacl->size);
+	if (dacl_size < sizeof(struct cifs_acl) ||
+	    end_of_acl < (char *)pdacl + dacl_size) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	num_aces = le32_to_cpu(pdacl->num_aces);
+	if (!num_aces)
+		return 0;
+
+	ace_hdr_size = offsetof(struct cifs_ace, sid) +
+		offsetof(struct cifs_sid, sub_auth);
+	min_ace_size = ace_hdr_size + sizeof(__le32);
+	if (num_aces > (dacl_size - sizeof(struct cifs_acl)) / min_ace_size) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	end_of_dacl = (char *)pdacl + dacl_size;
+	acl_base = (char *)pdacl;
+	ace_size = sizeof(struct cifs_acl);
+
+	for (i = 0; i < num_aces; ++i) {
+		if (end_of_dacl - acl_base < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		pace = (struct cifs_ace *)(acl_base + ace_size);
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
 static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 		       struct cifs_sid *pownersid, struct cifs_sid *pgrpsid,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
@@ -760,7 +832,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 	int i;
 	int num_aces = 0;
 	int acl_size;
-	char *acl_base;
+	char *acl_base, *end_of_dacl;
 	struct cifs_ace **ppace;
 
 	/* BB need to add parm so we can store the SID BB */
@@ -772,11 +844,8 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 		return;
 	}
 
-	/* validate that we do not go past end of acl */
-	if (end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size)) {
-		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+	if (validate_dacl(pdacl, end_of_acl))
 		return;
-	}
 
 	cifs_dbg(NOISY, "DACL revision %d size %d num aces %d\n",
 		 le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
@@ -787,6 +856,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 	   user/group/other have no permissions */
 	fattr->cf_mode &= ~(0777);
 
+	end_of_dacl = (char *)pdacl + le16_to_cpu(pdacl->size);
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct cifs_acl);
 
@@ -804,7 +874,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 		for (i = 0; i < num_aces; ++i) {
 			ppace[i] = (struct cifs_ace *) (acl_base + acl_size);
 #ifdef CONFIG_CIFS_DEBUG2
-			dump_ace(ppace[i], end_of_acl);
+			dump_ace(ppace[i], end_of_dacl);
 #endif
 			if (mode_from_special_sid &&
 			    (compare_sids(&(ppace[i]->sid),
@@ -1262,10 +1332,9 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
 		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
-		if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
-			cifs_dbg(VFS, "Server returned illegal ACL size\n");
-			return -EINVAL;
-		}
+		rc = validate_dacl(dacl_ptr, end_of_acl);
+		if (rc)
+			return rc;
 	}
 
 	owner_sid_ptr = (struct cifs_sid *)((char *)pntsd +
@@ -1625,6 +1694,12 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
 			dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+			rc = validate_dacl(dacl_ptr, (char *)pntsd + secdesclen);
+			if (rc) {
+				kfree(pntsd);
+				cifs_put_tlink(tlink);
+				return rc;
+			}
 			if (mode_from_sid)
 				nsecdesclen +=
 					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
-- 
2.53.0


