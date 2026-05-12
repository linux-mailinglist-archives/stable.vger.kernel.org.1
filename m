Return-Path: <stable+bounces-245619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH6fIm0xA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:55:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF662521C2D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2FEC30F65D8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61A399888;
	Tue, 12 May 2026 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nx1SPZ7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71A360EDD
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593708; cv=none; b=ewZPQaWoBPuXEc8WUnsVSlHB4c3LU05eyJgjqnCP3uEkLfSCyMR3ZUSurwArCM2TVtZimjXkLhV2TkSgb6+qBBOXnHaV9BLOI6YIUjN+MIihQM2EX6hOgPpkNneWupeaT94wHjNAhUcB2N0zlFBzcdISz+n1A/AoQKu5hc6hAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593708; c=relaxed/simple;
	bh=wTip1cqtaIHQKEaSkMWM1+j/aTIEsnq/8ud85puvK3Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s3veVSDt83eSRbygQA9mPqAHafY+ifs665GllbA+JR3NH1auvimoXM8TdfCavL6DR33hGoa5Ao0uW9on+Fm6iM4TO8bzekjMomSU2OwdGRXAWf4EHct5undTtD4jYupn5PlgQI+uqrmyf+ZTx26rw/sBb1znYLc8+aO745SikYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nx1SPZ7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ABCC2BCB0;
	Tue, 12 May 2026 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593707;
	bh=wTip1cqtaIHQKEaSkMWM1+j/aTIEsnq/8ud85puvK3Y=;
	h=Subject:To:Cc:From:Date:From;
	b=nx1SPZ7w8gVvYxo5ue92d7OOZt2HeUylftWg88rLb8p08cyHXF+uCTH0kU4K/is7d
	 0yoqmPur2SN2BBfT4CFxAFw/iCHO8X/93ND3tr26Gh0qP3ppbLKwf/6v4FyKT9fqzA
	 w0NsSQLgnU/zDsv8R6GCfHjs5NznZPicSoK6hWoI=
Subject: FAILED: patch "[PATCH] tracefs: Fix default permissions not being applied on initial" failed to apply to 6.12-stable tree
To: devnexen@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:48:32 +0200
Message-ID: <2026051232-congress-babble-1c1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF662521C2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245619-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,goodmis.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,msgid.link:url,linuxfoundation.org:dkim,goodmis.org:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e8368d1f4bedbb0cce4cfe33a1d2664bb0fd4f27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051232-congress-babble-1c1d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8368d1f4bedbb0cce4cfe33a1d2664bb0fd4f27 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 4 Apr 2026 14:47:47 +0100
Subject: [PATCH] tracefs: Fix default permissions not being applied on initial
 mount

Commit e4d32142d1de ("tracing: Fix tracefs mount options") moved the
option application from tracefs_fill_super() to tracefs_reconfigure()
called from tracefs_get_tree(). This fixed mount options being ignored
on user-space mounts when the superblock already exists, but introduced
a regression for the initial kernel-internal mount.

On the first mount (via simple_pin_fs during init), sget_fc() transfers
fc->s_fs_info to sb->s_fs_info and sets fc->s_fs_info to NULL. When
tracefs_get_tree() then calls tracefs_reconfigure(), it sees a NULL
fc->s_fs_info and returns early without applying any options. The root
inode keeps mode 0755 from simple_fill_super() instead of the intended
TRACEFS_DEFAULT_MODE (0700).

Furthermore, even on subsequent user-space mounts without an explicit
mode= option, tracefs_apply_options(sb, true) gates the mode behind
fsi->opts & BIT(Opt_mode), which is unset for the defaults. So the
mode is never corrected unless the user explicitly passes mode=0700.

Restore the tracefs_apply_options(sb, false) call in tracefs_fill_super()
to apply default permissions on initial superblock creation, matching
what debugfs does in debugfs_fill_super().

Cc: stable@vger.kernel.org
Fixes: e4d32142d1de ("tracing: Fix tracefs mount options")
Link: https://patch.msgid.link/20260404134747.98867-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index fa4c7e6aa5ff..5602baf980f6 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -468,6 +468,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	sb->s_op = &tracefs_super_operations;
+	tracefs_apply_options(sb, false);
 	set_default_d_op(sb, &tracefs_dentry_operations);
 
 	return 0;


