Return-Path: <stable+bounces-246115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOofHqpsA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:08:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 848CD526DD4
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42EA9307091F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239FF328B77;
	Tue, 12 May 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vgQ3o6wm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2430BB80;
	Tue, 12 May 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608396; cv=none; b=ITzcqWNHNfxoCoZG56DIW6TMC7KuCuhsb9UV78ckzMy1xtllqya/cLUvQsczrPFJwBfklm0McW96JwkbF/4HNwBXxF7J0fBDdOLQ2l0yHJghdpZN6D5dIm5s4Jis7mH6AANk72z0Pf5IKX6KaV9thKeTd8pnU33JVJPy+Pjskqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608396; c=relaxed/simple;
	bh=U59UaCmmwF1Kf2+RVgntDlwobxIF8hqKskstU2TpUXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebLJrbn07kjP0y8szvy/hGuXIB7sypyl2QpH+Kp9MXwTiAl94X+IXG3hfInlfz5IA9LLxXQxKXlVwtvStDmB+EpgdSNh8Xb5DNsYxJKJKlGM51iwA6vASeoAfEXC49I1aKVcXJCW0g/fFMbsqrtDv97cGWQwQ7Cv7MpL7TUTHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vgQ3o6wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAE1C2BCB0;
	Tue, 12 May 2026 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608396;
	bh=U59UaCmmwF1Kf2+RVgntDlwobxIF8hqKskstU2TpUXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vgQ3o6wmX2a0OAY/RURnrToQOdpmVFkqC1yCTlLSg8mycaDKL3SOQYkD4CvQwOgfP
	 NyTSt7NB9y4mwcfpVVkSvJDAp3F0O9gKm+GAiBa175JP2jZsmUTI5eo1W2Pg2xfsgc
	 2Ic5UPvsxWZq2HbJQNxEgJXQQ4NkjUdjvH2LkCKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Windsor <dwindsor@gmail.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.18 062/270] selinux: dont reserve xattr slot when we wont fill it
Date: Tue, 12 May 2026 19:37:43 +0200
Message-ID: <20260512173939.757852592@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 848CD526DD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246115-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,paul-moore.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,paul-moore.com:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Windsor <dwindsor@gmail.com>

commit 1e5a8eed7821e7a43a31b4c1b3675a91be6bc6f6 upstream.

Move lsm_get_xattr_slot() below the SBLABEL_MNT check so we don't leave
a NULL-named slot in the array when returning -EOPNOTSUPP; filesystem
initxattrs() callbacks stop iterating at the first NULL ->name, silently
dropping xattrs installed by later LSMs.

Cc: stable@vger.kernel.org
Signed-off-by: David Windsor <dwindsor@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/hooks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2931,7 +2931,7 @@ static int selinux_inode_init_security(s
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
-	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr *xattr;
 	u32 newsid, clen;
 	u16 newsclass;
 	int rc;
@@ -2957,6 +2957,7 @@ static int selinux_inode_init_security(s
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
+	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);



