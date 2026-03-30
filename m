Return-Path: <stable+bounces-231160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCwqHD9Zymn27gUAu9opvQ
	(envelope-from <stable+bounces-231160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:06:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B3359EC1
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 665723065A98
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85963C3425;
	Mon, 30 Mar 2026 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0hT4VFGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B55E3C3BE7
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868473; cv=none; b=i/HImKCNG0U8Tke8SdBcrb6DnC9CWovkRKUbyOou/ctb6j5FPcZN0EkS/8bh7OTa1cIMQ69g8cr/PxbCkVKI2g+gWn9JIZwRjHy9DoLkuttb0VtC/WE/S05/iJ8lgZBNJxfr5Xdm4dj66Jqf27ihoofos6jSbaSbxX4RArQGjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868473; c=relaxed/simple;
	bh=3zZb3vyu/lE4vzacAm33p38LV/HfMdW9Z7L+FXBkYik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hD3k0dpbAJqNCAuaKuWaDTtmazi9baGFnqVESoN3TXjT4iHaBuvnyjXORdQI8P4G4fmPeeBqzUfRX2mMMbluCpA+KbZ0fhgtDGwABSckpRAzN2Aqrx/UHhEeqQ5I7Eoje4qOTlbRVtdU3xSQ24QfmNJYc3uZfJ03ZVVSr9ThERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0hT4VFGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33652C4CEF7;
	Mon, 30 Mar 2026 11:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774868472;
	bh=3zZb3vyu/lE4vzacAm33p38LV/HfMdW9Z7L+FXBkYik=;
	h=Subject:To:Cc:From:Date:From;
	b=0hT4VFGouo5AL2kTvolFn5QR9aFEFZ4yons939foImLfoCI247PwtJ3d99L2wSvPo
	 Yxmmtur1gKZXlfw2eRiVvjJVu3qAVZECZAZqnMxoDX7wQ9JSfzOyMqLhMg9UJuaHl8
	 V1AGlugDUmWs6SdQJfEcyrqffb0e9L0mY7u+Z4x0=
Subject: FAILED: patch "[PATCH] ext4: fix journal credit check when setting fscrypt context" failed to apply to 5.15-stable tree
To: simon.weber.39@gmail.com,anthonydev@fastmail.com,ebiggers@kernel.org,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 13:01:09 +0200
Message-ID: <2026033009-saxophone-anyplace-7b27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231160-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fastmail.com,kernel.org,mit.edu];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,linuxfoundation.org:dkim,fastmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 171B3359EC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b1d682f1990c19fb1d5b97d13266210457092bcd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033009-saxophone-anyplace-7b27@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1d682f1990c19fb1d5b97d13266210457092bcd Mon Sep 17 00:00:00 2001
From: Simon Weber <simon.weber.39@gmail.com>
Date: Sat, 7 Feb 2026 10:53:03 +0100
Subject: [PATCH] ext4: fix journal credit check when setting fscrypt context

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

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index cf0a0970c095..f41f320f4437 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -163,10 +163,17 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
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


