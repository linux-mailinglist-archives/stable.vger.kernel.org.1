Return-Path: <stable+bounces-264985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8mXrEk2DMWo0lQUAu9opvQ
	(envelope-from <stable+bounces-264985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:09:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69497692CAE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:09:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=hfjTw6U8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264985-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264985-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28859302E9D5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66496478E53;
	Tue, 16 Jun 2026 16:55:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6A8169AD2;
	Tue, 16 Jun 2026 16:55:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628924; cv=none; b=WC3msuQNWLPZYYwQvEd3ksGMoMHQNHiSP1nJUefvidFcgPwldG6w9kSn++nH+4Qd/JebeUI0R8W5sliVqTwIZg95xLMLQFBGYeViIt2F+bcJ9hKPXVXFYHNqaWMiTNiTlU3l0Jmqz3EkJaqQGvcL+vzOlcA1RhZJIK9u3TrDg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628924; c=relaxed/simple;
	bh=4tqMiqRu5kJIfNM6QK+s2jkF8z8lmj/UZjFDXLByw+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KW7/G+zp8oHMP0KSI1HZdogUh9b//1FTEEe4iL6oVWwgKKD8qucd1kkmAKbGqT12eCUU3A61prHxSk7oQISBV4Ev72/B64/HBxhxZNeazkwZO0ZdFW3j6qmH1OYVuOkupkihMBNSMLV9HGI00rWVr2CVXnw1BAj3+b4s8y0/Y8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfjTw6U8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A8C1F000E9;
	Tue, 16 Jun 2026 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628923;
	bh=GNtCtP90g+5j46e+ZnNkcIzJWPP+zKQ6Yo8DSvLxqdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfjTw6U80v4N+AlMip8QBi7ur8CLBZZcJgKWtf5JotLR818HxT9IvpUhfkSLQ6BDD
	 zg1THxEdy4cpOvTWkwLT1h3kdhCunKBXD0vrleJZ5B0UKxt8b5ikcSSOtljLKnA+dG
	 fHe3j7n54Oc1JFpWyUNvCGqQcAFB6qM24BXWUxfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ali Ganiyev <ali.qaniyev@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 144/452] ksmbd: OOB read regression in smb_check_perm_dacl() ACE-walk loops
Date: Tue, 16 Jun 2026 20:26:11 +0530
Message-ID: <20260616145125.267591885@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264985-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ali.qaniyev@gmail.com,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:aliqaniyev@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69497692CAE

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ali Ganiyev <ali.qaniyev@gmail.com>

commit 0e60dafe97eca61721f3db456f97d97a80c6c8ae upstream.

Commit d07b26f39246 ("ksmbd: require minimum ACE size in
smb_check_perm_dacl()") introduced a transposed bounds check:

    if (offsetof(struct smb_ace, sid) + aces_size < CIFS_SID_BASE_SIZE)

Since offsetof(..sid) is 8 and CIFS_SID_BASE_SIZE is 8, this evaluates
to `aces_size < 0`. Because `aces_size` is always non-negative, this
check becomes dead code and never breaks the loop.

Worse, that commit removed the old 4-byte guard, meaning the loop now
reads `ace->size` (offset 2) even when `aces_size` is 0-3 bytes. This
re-opens a 2-byte heap out-of-bounds (OOB) read past the pntsd allocation
during subsequent SMB2_CREATE operations.

Fix this by properly transposing the comparison to require at least
16 bytes (8-byte offset + 8-byte SID base), matching the correct form
used in smb_inherit_dacl().

Fixes: d07b26f39246 ("ksmbd: require minimum ACE size in smb_check_perm_dacl()")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ganiyev <ali.qaniyev@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smbacl.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1342,8 +1342,8 @@ int smb_check_perm_dacl(struct ksmbd_con
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-			if (offsetof(struct smb_ace, sid) +
-			    aces_size < CIFS_SID_BASE_SIZE)
+			if (aces_size < offsetof(struct smb_ace, sid) +
+			    CIFS_SID_BASE_SIZE)
 				break;
 			ace_size = le16_to_cpu(ace->size);
 			if (ace_size > aces_size ||
@@ -1366,8 +1366,8 @@ int smb_check_perm_dacl(struct ksmbd_con
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-		if (offsetof(struct smb_ace, sid) +
-		    aces_size < CIFS_SID_BASE_SIZE)
+		if (aces_size < offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE)
 			break;
 		ace_size = le16_to_cpu(ace->size);
 		if (ace_size > aces_size ||



