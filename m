Return-Path: <stable+bounces-232162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPlxKAkFzGnPNQYAu9opvQ
	(envelope-from <stable+bounces-232162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:31:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0136EE17
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37C26315C003
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E18425CD6;
	Tue, 31 Mar 2026 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ktJlR2T+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25430421EE4;
	Tue, 31 Mar 2026 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976037; cv=none; b=cW55qRRrRyPIM0ZoOHpN5ifWOqrcgaOVQsX0Sx4mA1iDGjwPkdmaaAi1Rarpj7+1/O6PybBr+f16YLPj7l+9zKSgJkll5mosx8/r7tQrvuiMaD45+4N9PrHGR3si/vLkrlArc0d9yw4N0QuR3lAkiP241NI4npQShl9bDy01qfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976037; c=relaxed/simple;
	bh=swD8lb4zec28pCEqvHnQAvdCfZ2tqTG84Th0NR1rmOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukrmuiJU+jEYUBEgyti3I4TMa8KLj0zCag1YvNruZfBLNtZTpl6nNjzwHQjwJ/y2qntTOqTl5Aiph6/+GCowz+Img4SNPSlPvNyEgnDa+vP5eOLs7Dp4LFF35Re9rqE6VGA3E0lkJ6EryKeGsmr5Z2o+ImPqFeIPxdFQGZHkjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ktJlR2T+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B165AC19423;
	Tue, 31 Mar 2026 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976037;
	bh=swD8lb4zec28pCEqvHnQAvdCfZ2tqTG84Th0NR1rmOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktJlR2T+gu+SieqsbKqL2baHgzmFeecUjKb3IVBePWR9w8e8vzWl/MHm11FeXcg4w
	 0D0X5wUbyqbV+fza34u80/CQMVPFZQCfRDisYgevcCiS3t2jBs95aN5g5fCKzQfhOI
	 +0lQwk/YpC8bpgceUgqRYLs60r6Q3vI4tAmN6oIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anthony Durrer <anthonydev@fastmail.com>,
	Simon Weber <simon.weber.39@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.12 183/244] ext4: fix journal credit check when setting fscrypt context
Date: Tue, 31 Mar 2026 18:22:13 +0200
Message-ID: <20260331161748.516981785@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-232162-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,fastmail.com,gmail.com,kernel.org,mit.edu];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,fastmail.com:email]
X-Rspamd-Queue-Id: D0E0136EE17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Weber <simon.weber.39@gmail.com>

commit b1d682f1990c19fb1d5b97d13266210457092bcd upstream.

Fix an issue arising when ext4 features has_journal, ea_inode, and encrypt
are activated simultaneously, leading to ENOSPC when creating an encrypted
file.

Fix by passing XATTR_CREATE flag to xattr_set_handle function if a handle
is specified, i.e., when the function is called in the control flow of
creating a new inode. This aligns the number of jbd2 credits set_handle
checks for with the number allocated for creating a new inode.

ext4_set_context must not be called with a non-null handle (fs_data) if
fscrypt context xattr is not guaranteed to not exist yet. The only other
usage of this function currently is when handling the ioctl
FS_IOC_SET_ENCRYPTION_POLICY, which calls it with fs_data=NULL.

Fixes: c1a5d5f6ab21eb7e ("ext4: improve journal credit handling in set xattr paths")

Co-developed-by: Anthony Durrer <anthonydev@fastmail.com>
Signed-off-by: Anthony Durrer <anthonydev@fastmail.com>
Signed-off-by: Simon Weber <simon.weber.39@gmail.com>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Link: https://patch.msgid.link/20260207100148.724275-4-simon.weber.39@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/crypto.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -163,10 +163,17 @@ static int ext4_set_context(struct inode
 	 */
 
 	if (handle) {
+		/*
+		 * Since the inode is new it is ok to pass the
+		 * XATTR_CREATE flag. This is necessary to match the
+		 * remaining journal credits check in the set_handle
+		 * function with the credits allocated for the new
+		 * inode.
+		 */
 		res = ext4_xattr_set_handle(handle, inode,
 					    EXT4_XATTR_INDEX_ENCRYPTION,
 					    EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
-					    ctx, len, 0);
+					    ctx, len, XATTR_CREATE);
 		if (!res) {
 			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
 			ext4_clear_inode_state(inode,



