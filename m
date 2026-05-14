Return-Path: <stable+bounces-247285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECJRBDQiBmodfgIAu9opvQ
	(envelope-from <stable+bounces-247285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:27:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F55465F1
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460B33032987
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE83A2E0C;
	Thu, 14 May 2026 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfJTHZkO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76721336897
	for <stable@vger.kernel.org>; Thu, 14 May 2026 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786801; cv=none; b=ECnIBaxXt6l/t3a7RMR/FX7Ju8NryTawlDaE+Gvc1VPEJapCD56BXFrfCUrP2u07r/hZuN+kkVZ43JmfJ08zCSvbRmm2IdySH/L9YuAwz7/PAjfdEcDNRmzkxZ2gUS5uM4s1CGn1NUXsQELdNFU+4IkSKh7GgXDoryRW+JWYp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786801; c=relaxed/simple;
	bh=I4lwGHKU0E4tZpylq5fWDhRp/3QxQSrMzRXgN8yHlAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifrd1EtZUQhC//yA0WLRRrh9GyX6FDnP8oSqV4VcM46az8F2aFHCRDkyOINiKqUWAYcAmRpYa0xdmw+XSnypDNGhIuOkIK+H71J/vcIUsmdFmGMwHmldUA6CrBbnDqCb/3DdX/Au9gtNkl9EKmghFe8QbJPzihNx0x801YWtyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfJTHZkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E5FC2BCB3;
	Thu, 14 May 2026 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778786801;
	bh=I4lwGHKU0E4tZpylq5fWDhRp/3QxQSrMzRXgN8yHlAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfJTHZkO8STQzISU14//fjGg1Ecm93I7b86llxKlaw1tBuQCxxNOKKiajIjRBrqoL
	 xLimjIUMX9yMn/looEvIdXaYAb5hmckqOUS4fQazaKBYwnNALctQiWFdFlDqUGBAFu
	 8Vh7I3Hwe6e3FvjT2iw+NSd98VBFnRxnvGmqNJun3MQyjzdYURhfl6tyUKeZd6o5MG
	 d4c0GThlbP4OJ34FLf4AeddLBHUQTUorIsct8eu9d1Q+c0wmcygk8JbK3eK1Z0Gsv0
	 4pP9pbUBzGDxtRnAT5ojpk7+TxmpQz9IcTTOmIXQGH6eF00QwKTFWV7BTPnPfZ+x51
	 SS7rQ+xpZZncQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tracefs: Fix default permissions not being applied on initial mount
Date: Thu, 14 May 2026 15:26:38 -0400
Message-ID: <20260514192638.1262074-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051232-congress-babble-1c1d@gregkh>
References: <2026051232-congress-babble-1c1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C9F55465F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,goodmis.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247285-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,goodmis.org:email]
X-Rspamd-Action: no action

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
---
 fs/tracefs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 8e5db8cc42188..feb5fcebe0a1d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -493,6 +493,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	sb->s_op = &tracefs_super_operations;
+	tracefs_apply_options(sb, false);
 	sb->s_d_op = &tracefs_dentry_operations;
 
 	return 0;
-- 
2.53.0


