Return-Path: <stable+bounces-245953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADA5CtRoA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D255263FE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4BFF305C635
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FBB3D9693;
	Tue, 12 May 2026 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="17FJeHbx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DB2EBB84;
	Tue, 12 May 2026 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607980; cv=none; b=NEPVlclN3zFpFx01SG6yOHoRNg1AaCw0fMUDdoUd+bfuFaylohOknKWpD4mJM6kunBMzQNLAS0IvQ91aYdnHK4Lgs4pT9rSwFCtnAyuTIKmln1+wa3BhAo5UxuYN3tUWXJzi7LeQ+c549mR5AOJwkuSGmMMdv9Cf0Is1FLTCaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607980; c=relaxed/simple;
	bh=vrANMr+i7S8PbgJXsGzOPQAPTkV16j/BDOXQ9axX3bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bA368ReujHAN0ECuhnHPmwE4lP9KDTwqRB87P76DGmth5/9cA/7FNzO1x3AM020sH98mw1LLIwXFjo0jJzKkY4ELOGl9gazS6VrPfx3AmJOFE2ZSXtwTgrxlqMZ6TULQhxLBkUFGbglcmK1e+BSRjJOGHhM1L34feR1YZrEkR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=17FJeHbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A03C2BCB0;
	Tue, 12 May 2026 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607980;
	bh=vrANMr+i7S8PbgJXsGzOPQAPTkV16j/BDOXQ9axX3bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=17FJeHbxEk+SeqrghsvgqWKUFBTmCCCC0lYSEgX2qAS5nMMsjXVqwpNJNxg2IE3Bf
	 6KYSuz57lBJioV9PiJiwSfVgRyOj0ya+ihnGx7Jq3wzRY6ubPQ3mLM2pF8FjHjce92
	 tLClX2yelB20j2I454nsBht39xQz8OFanWzv6WOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Windsor <dwindsor@gmail.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.12 057/206] selinux: dont reserve xattr slot when we wont fill it
Date: Tue, 12 May 2026 19:38:29 +0200
Message-ID: <20260512173934.048345006@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 43D255263FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245953-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,paul-moore.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2916,7 +2916,7 @@ static int selinux_inode_init_security(s
 {
 	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
-	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr *xattr;
 	u32 newsid, clen;
 	u16 newsclass;
 	int rc;
@@ -2942,6 +2942,7 @@ static int selinux_inode_init_security(s
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
+	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);



