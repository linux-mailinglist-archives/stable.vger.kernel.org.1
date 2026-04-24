Return-Path: <stable+bounces-240614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHw6JX0762mMKAAAu9opvQ
	(envelope-from <stable+bounces-240614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:44:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B945C6AB
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B2A3009CF1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AAC38AC78;
	Fri, 24 Apr 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syIMZAOa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10F38AC92
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023839; cv=none; b=ZPqIy2ElIiN6QqrtMs70QhBbq9TXXSXCPeRlLh+AxcgDIoYCV1NmaoKdROFjFWD7xxg66YNyhuSByWwt41VggvE7ZSPDvaHHCNRDyQTKJ5c1pNVVjIP+asWOi45rWYRWbhDBC+8JEvNEIzbRP232GrGqvkaUIp0v2qifbAwpMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023839; c=relaxed/simple;
	bh=i7t/6KO5v90953ozvr7glfHvhPGNdMtcF0cGfZ4gGOQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zm3AQMuNMNL1Fa4P0cidLXc5ntNW3Urn9cjfG7j9arRvLrtJ8do77xidXUU5OKolpOhF2gs3s9JCB2+CVtEBzciVeDKorq4prvOC55fHjisaoSb7I9ycqJD/zaRWhi9xZZL9aGFCPFS/KBiFq8PSBPc86J6DhO8viZlkxnrd/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=syIMZAOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BEBC19425;
	Fri, 24 Apr 2026 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023839;
	bh=i7t/6KO5v90953ozvr7glfHvhPGNdMtcF0cGfZ4gGOQ=;
	h=Subject:To:Cc:From:Date:From;
	b=syIMZAOaS4Qexsm2tNfDBdrcVY7rNbJ6YLEhkgtKeLlpg3BXelMs8C3QwsQV6RKUG
	 3jh2uifiXZFrlQWpMkkwsx5bHZTPpZ02oNNX5i9bCGUcIpYYRURQf/d1J8tt2DqPAE
	 UCCxS1H/44rGPXSNO0MOFZ+p30Ii1HtFWINJK2ww=
Subject: FAILED: patch "[PATCH] ksmbd: use check_add_overflow() to prevent u16 DACL size" failed to apply to 5.15-stable tree
To: tristan@talencesecurity.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:43:57 +0200
Message-ID: <2026042457-bullfrog-connected-a810@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 810B945C6AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240614-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 299f962c0b02d048fb45d248b4da493d03f3175d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042457-bullfrog-connected-a810@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 299f962c0b02d048fb45d248b4da493d03f3175d Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Fri, 17 Apr 2026 19:54:57 +0000
Subject: [PATCH] ksmbd: use check_add_overflow() to prevent u16 DACL size
 overflow

set_posix_acl_entries_dacl() and set_ntacl_dacl() accumulate ACE sizes
in u16 variables. When a file has many POSIX ACL entries, the
accumulated size can wrap past 65535, causing the pointer arithmetic
(char *)pndace + *size to land within already-written ACEs. Subsequent
writes then overwrite earlier entries, and pndacl->size gets a
truncated value.

Use check_add_overflow() at each accumulation point to detect the
wrap before it corrupts the buffer, consistent with existing
check_mul_overflow() usage elsewhere in smbacl.c.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index a1de89cc09be..4bbc2c27e680 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -596,6 +596,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 	struct smb_sid *sid;
 	struct smb_ace *ntace;
 	int i, j;
+	u16 ace_sz;
 
 	if (!fattr->cf_acls)
 		goto posix_default_acl;
@@ -640,8 +641,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 			flags = 0x03;
 
 		ntace = (struct smb_ace *)((char *)pndace + *size);
-		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
+		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
+		if (check_add_overflow(*size, ace_sz, size))
+			break;
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -650,8 +653,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		if (S_ISDIR(fattr->cf_mode) &&
 		    (pace->e_tag == ACL_USER || pace->e_tag == ACL_GROUP)) {
 			ntace = (struct smb_ace *)((char *)pndace + *size);
-			*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
+			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
+			if (check_add_overflow(*size, ace_sz, size))
+				break;
 			(*num_aces)++;
 			if (pace->e_tag == ACL_USER)
 				ntace->access_req |=
@@ -691,8 +696,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		}
 
 		ntace = (struct smb_ace *)((char *)pndace + *size);
-		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
+		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
+		if (check_add_overflow(*size, ace_sz, size))
+			break;
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -728,7 +735,8 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 				break;
 
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
-			size += nt_ace_size;
+			if (check_add_overflow(size, nt_ace_size, &size))
+				break;
 			aces_size -= nt_ace_size;
 			ntace = (struct smb_ace *)((char *)ntace + nt_ace_size);
 			num_aces++;


