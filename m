Return-Path: <stable+bounces-247960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJJYGVhFB2qgvwIAu9opvQ
	(envelope-from <stable+bounces-247960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:10:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F423F552C15
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6974230C8F21
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E1175A87;
	Fri, 15 May 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sknFbLpO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE563FF1D1;
	Fri, 15 May 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860516; cv=none; b=UolZE4T0eGWTos9ztCUk6+XNzl19qQb3a/HT35AvRvN4ApLIqoazlyO1PXiIXCQ7KCrBT2wzr+wPLkEr+D3uHZsOXaaW0e2SPDtt+IAYYVYs11DHnZwqOKd2ruKmue2FL+HA2RuCbQKGBMDz484Nw9NpNyjgiBDzjiLdbnLEZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860516; c=relaxed/simple;
	bh=QuCERnIvtr+pXg2Nw/PG+u7T3OHCJuCOeScabzkz+fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ0Yxm2iQx84hP1DJeJZpcC4SkzUoRUXBAN8OQB8VAFEvdQgliR25vZNPCJXyCpbO0/0hD+Eo9Q9SNuTr4w4xUug3gxSXUXiadJoUOpSN2wW6poXBP6uM1ceTbEZIb7j8CdE9d5CXass+Zes6LpZEuI6nEWcIlxnyacOxFzZSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sknFbLpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25C7C2BCB0;
	Fri, 15 May 2026 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860516;
	bh=QuCERnIvtr+pXg2Nw/PG+u7T3OHCJuCOeScabzkz+fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sknFbLpO12a7MuOuUD6Ah3KDpIb4tFguhzhtM2+RdcKy87nQpyY0mbvp0s/F+/QJW
	 Vnbl6t/8jqt+ZTTDXouabU9GsW+//RACDeLfMzqdH9vXes/mVjBPVvWnRHeAEQdc/X
	 VsqIX9AWETTKNO5tupEgBR7Fv1k3tzdA1FJgEZ+8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 120/144] tracefs: Fix default permissions not being applied on initial mount
Date: Fri, 15 May 2026 17:49:06 +0200
Message-ID: <20260515154656.284998572@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: F423F552C15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247960-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,goodmis.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

[ Upstream commit e8368d1f4bedbb0cce4cfe33a1d2664bb0fd4f27 ]

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
[ kept 6.12's `sb->s_d_op = &tracefs_dentry_operations;` instead of upstream's `set_default_d_op()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -493,6 +493,7 @@ static int tracefs_fill_super(struct sup
 		return err;
 
 	sb->s_op = &tracefs_super_operations;
+	tracefs_apply_options(sb, false);
 	sb->s_d_op = &tracefs_dentry_operations;
 
 	return 0;



