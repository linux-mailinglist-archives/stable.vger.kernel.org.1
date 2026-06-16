Return-Path: <stable+bounces-265646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PvPFIBuNMWqymQUAu9opvQ
	(envelope-from <stable+bounces-265646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:51:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853DA6938BC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="RXC/OlJI";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265646-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265646-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6004F3002B49
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF643D4E9;
	Tue, 16 Jun 2026 17:50:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F032A3C9;
	Tue, 16 Jun 2026 17:50:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632257; cv=none; b=BOEvJuu5+TmTgT1j1PiRqVBvTmmVHt9Sxy2xXQiTTK1dstlOPrTy3g065AE02vAUjTJUR0zDKD0jEwZl9CKGUl/3psfCkC1tWXDeoIRSNNE5g5uPJN2Y0ravgJU2AAm+2Suc5nZaeMfS/NHu1nwPG3oPWU/0BfPL5mdrIZqUMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632257; c=relaxed/simple;
	bh=HhFnFmmNTxqY5bV+uHYELeANELdm+zn5qi/4qeDBxls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfvkH6Z/84uNJHsid3VoWEj4YtBRheS8T9ELSq/5CNRo05Gl2aVOF5Hf4+uH+3vrLnZLsvXmfc2kQJhGmQct3obZswjnh85t0RSj+ZdnAmg0Bfv9qZzXnLnyx2BZmu9FjDn+UvdUMPYKPMp+bGRJI5+ZP56vhs1FlDg2BEtIhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXC/OlJI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC471F000E9;
	Tue, 16 Jun 2026 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632256;
	bh=ze2lXB8E0aMO17X5xnmQXb07UNJ6WebAAG3TzvBVtII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RXC/OlJI6Ce0GCKbIOo4FrSTo02krssb6uDaCIYLXdZNZi9bR2wbJnz4pt03USdcq
	 wNJ5qamaL6RGfD37dHbnApglZmkRjramnt+0Ma4EPJNPM2Ovjm1YgMJFzS49s7MRtY
	 x4a4I4CEYACQ8kfShuUEl86d/95o/l8YLwvVz3R4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 334/522] ksmbd: require minimum ACE size in smb_check_perm_dacl()
Date: Tue, 16 Jun 2026 20:28:01 +0530
Message-ID: <20260616145141.449373576@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	TAGGED_FROM(0.00)[bounces-265646-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:sashal@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 853DA6938BC

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit d07b26f39246a82399661936dd0c853983cfade7 ]

Both ACE-walk loops in smb_check_perm_dacl() only guard against an
under-sized remaining buffer, not against an ACE whose declared
`ace->size` is smaller than the struct it claims to describe:

  if (offsetof(struct smb_ace, access_req) > aces_size)
      break;
  ace_size = le16_to_cpu(ace->size);
  if (ace_size > aces_size)
      break;

The first check only requires the 4-byte ACE header to be in bounds;
it does not require access_req (4 bytes at offset 4) to be readable.
An attacker who has set a crafted DACL on a file they own can declare
ace->size == 4 with aces_size == 4, pass both checks, and then

  granted |= le32_to_cpu(ace->access_req);               /* upper loop */
  compare_sids(&sid, &ace->sid);                         /* lower loop */

reads access_req at offset 4 (OOB by up to 4 bytes) and ace->sid at
offset 8 (OOB by up to CIFS_SID_BASE_SIZE + SID_MAX_SUB_AUTHORITIES
* 4 bytes).

Tighten both loops to require

  ace_size >= offsetof(struct smb_ace, sid) + CIFS_SID_BASE_SIZE

which is the smallest valid on-wire ACE layout (4-byte header +
4-byte access_req + 8-byte sid base with zero sub-auths).  Also
reject ACEs whose sid.num_subauth exceeds SID_MAX_SUB_AUTHORITIES
before letting compare_sids() dereference sub_auth[] entries.

parse_sec_desc() already enforces an equivalent check (lines 441-448);
smb_check_perm_dacl() simply grew weaker validation over time.

Reachability: authenticated SMB client with permission to set an ACL
on a file.  On a subsequent CREATE against that file, the kernel
walks the stored DACL via smb_check_perm_dacl() and triggers the
OOB read.  Not pre-auth, and the OOB read is not reflected to the
attacker, but KASAN reports and kernel state corruption are
possible.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ changed le16_to_cpu to le32_to_cpu for num_aces field which is __le32 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smbacl.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1297,10 +1297,13 @@ int smb_check_perm_dacl(struct ksmbd_con
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
-			if (offsetof(struct smb_ace, access_req) > aces_size)
+			if (offsetof(struct smb_ace, sid) +
+			    aces_size < CIFS_SID_BASE_SIZE)
 				break;
 			ace_size = le16_to_cpu(ace->size);
-			if (ace_size > aces_size)
+			if (ace_size > aces_size ||
+			    ace_size < offsetof(struct smb_ace, sid) +
+				       CIFS_SID_BASE_SIZE)
 				break;
 			aces_size -= ace_size;
 			granted |= le32_to_cpu(ace->access_req);
@@ -1318,13 +1321,19 @@ int smb_check_perm_dacl(struct ksmbd_con
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
-		if (offsetof(struct smb_ace, access_req) > aces_size)
+		if (offsetof(struct smb_ace, sid) +
+		    aces_size < CIFS_SID_BASE_SIZE)
 			break;
 		ace_size = le16_to_cpu(ace->size);
-		if (ace_size > aces_size)
+		if (ace_size > aces_size ||
+		    ace_size < offsetof(struct smb_ace, sid) +
+			       CIFS_SID_BASE_SIZE)
 			break;
 		aces_size -= ace_size;
 
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+			break;
+
 		if (!compare_sids(&sid, &ace->sid) ||
 		    !compare_sids(&sid_unix_NFS_mode, &ace->sid)) {
 			found = 1;



