Return-Path: <stable+bounces-240603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE2ABxw762nRJwAAu9opvQ
	(envelope-from <stable+bounces-240603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:42:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE08145C604
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D68D430138B4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5A38B131;
	Fri, 24 Apr 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LUZp+ebG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057C38AC78
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023766; cv=none; b=XRDV/d3TEtcqI+PvbfK+Mj4lN5KeuafvZymwYqnbzhtsdbU+LzCPtI+lQkhPEg1b2U6Fh8xABYCJTsPcf28KVs2rcRsBMEB3B7HZ+AhuXU06rCPiJOoz8H85dt9Vu0DBLlnGYchPe17bIMyWK2c+L4vJe6/IepxKvuEyI0z6Brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023766; c=relaxed/simple;
	bh=pQyFxBDk2p9zLMjXO23YgwcJ6H/uhR2LWF1jWoo7ySU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=emFldNiTbTu0PY2bwRZW9jO+iWMqju1Z/leoSbjfSdiEblwyLCmkGOha6JZjavMREp57j8kZhK+akQ8LYsXCgSBFtMEPZIVsQueAGlTdDrMk33K/5jng2SWBzXL8EYWT07RuRWYPQFxQmrGBhsXhowe47ECtlIkr29SaeKxIFi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LUZp+ebG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D533CC19425;
	Fri, 24 Apr 2026 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023766;
	bh=pQyFxBDk2p9zLMjXO23YgwcJ6H/uhR2LWF1jWoo7ySU=;
	h=Subject:To:Cc:From:Date:From;
	b=LUZp+ebGaUK/0lkxGeHwH+mmXu/yi5xuwOUIHLDwbFWFBQ9BXNEW6Fw3i4iMgZW8C
	 k7VDwrdjg7qGvxNxtSIeGgAzviu1NLe/gyq6CxwLULGC3F9+bJy2bLvwTxqh1mleva
	 5Kk3jGhlEIHl+PsQqWqYWu9nlN7fVT6luoEhLDGk=
Subject: FAILED: patch "[PATCH] smb: client: validate the whole DACL before rewriting it in" failed to apply to 6.18-stable tree
To: michael.bommarito@gmail.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:42:43 +0200
Message-ID: <2026042443-canyon-unwed-b0bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE08145C604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240603-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0a8cf165566ba55a39fd0f4de172119dd646d39a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042443-canyon-unwed-b0bf@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a8cf165566ba55a39fd0f4de172119dd646d39a Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sun, 19 Apr 2026 20:11:31 -0400
Subject: [PATCH] smb: client: validate the whole DACL before rewriting it in
 cifsacl

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

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c920039d733c..cb4060ba5e31 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -758,6 +758,77 @@ static void dump_ace(struct smb_ace *pace, char *end_of_acl)
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
@@ -765,7 +836,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	int i;
 	u16 num_aces = 0;
 	int acl_size;
-	char *acl_base;
+	char *acl_base, *end_of_dacl;
 	struct smb_ace **ppace;
 
 	/* BB need to add parm so we can store the SID BB */
@@ -777,12 +848,8 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
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
@@ -793,6 +860,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	   user/group/other have no permissions */
 	fattr->cf_mode &= ~(0777);
 
+	end_of_dacl = (char *)pdacl + le16_to_cpu(pdacl->size);
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct smb_acl);
 
@@ -800,35 +868,15 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	if (num_aces > 0) {
 		umode_t denied_mode = 0;
 
-		if (num_aces > (le16_to_cpu(pdacl->size) - sizeof(struct smb_acl)) /
-				(offsetof(struct smb_ace, sid) +
-				 offsetof(struct smb_sid, sub_auth) + sizeof(__le16)))
-			return;
-
 		ppace = kmalloc_objs(struct smb_ace *, num_aces);
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
@@ -1662,6 +1710,12 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
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


