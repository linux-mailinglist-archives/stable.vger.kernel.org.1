Return-Path: <stable+bounces-263676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kDZzNr42MWqGeAUAu9opvQ
	(envelope-from <stable+bounces-263676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:42:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED0568EE04
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S41OFjRa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263676-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263676-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5EF93034EF5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1E142DFF2;
	Tue, 16 Jun 2026 11:41:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC6349B19;
	Tue, 16 Jun 2026 11:41:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610108; cv=none; b=GOpdHG+YVkDHdJ3Bh8xsNwglEbzyhymawVd/yLzi7+qI9HDlwgo79zQsKakHI7HXy+TtKGjKc3xUopLmqlWDWpBNXwxY4BZhsn1fs6FfAZ+sKTCKhqmAzY/gFLMCueYKkAzdGrhgbe7toiCrMIxEVUHoKEB3JGn+Nu4OOLTz5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610108; c=relaxed/simple;
	bh=iQ/c7WwMFf2YvGr58yE5+rc9rQlcYCHXsCIOXQuojP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=foOJ8VI8SGmnscV2uILYXy7VrI0axTk26Dg00Uri108GU5lgx7aEBJOlxPFC9XuYjaHxxQKC7Au1Vg9+PPbqI8zDnpicZ5NvhOipeSJJenkWorzZ2uAp6cTc3hWb+1O8gCSER2FDtk/aP99ZPQmQ1C8crRnWrVjYcLYKhy61V38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S41OFjRa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9AC1F000E9;
	Tue, 16 Jun 2026 11:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781610107;
	bh=4iwT/PwoTkVYTiCGBxS27rU7ACMvuuhbLIMNfCz83xY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S41OFjRakzf6u50dNiKEAMYtcroxBOjKd0z0KDkGAJEd3jk1+/n2yp1kyFIzmoeNS
	 y18ObMz7GeC6bUbUg8HYZVTTYob9h0ive6i6CH2e1w/o3zH+TUwZSA2anot+vxvY6B
	 EuQvIGs6HzJ+bD2A1UsrsoUAU6amXxeL7SiUYo60j65LAxcsEvByYZZvbZg/ad9lpb
	 SUaXFETwOEMwHd+GRbAQ0H8YH/8KETELMOfX1bUYKWmygMSYpsd7lEE1eCNg28jZqJ
	 62g5UZ17TStCSRYee+ih5Abv3ynw7Dj+EgbqFBKdEWfJ7e8HkxnwOUQ2JD2C3YR/m1
	 4rE4zKw6j7cfg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 13:41:13 +0200
Subject: [PATCH 4/7] btrfs: drain replace writes before freeing the target
 on cancel
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-work-btrfs-preexisting-fixes-v1-4-c4abe2f6d4f0@kernel.org>
References: <20260616-work-btrfs-preexisting-fixes-v1-0-c4abe2f6d4f0@kernel.org>
In-Reply-To: <20260616-work-btrfs-preexisting-fixes-v1-0-c4abe2f6d4f0@kernel.org>
To: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Filipe Manana <fdmanana@suse.com>, Naohiro Aota <naota@elisp.net>, 
 linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>, 
 Stefan Behrens <sbehrens@giantdisaster.de>, linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iQ/c7WwMFf2YvGr58yE5+rc9rQlcYCHXsCIOXQuojP4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZmmXnX8qtZi6ZbaPpksJTvqDk88y0l6bu1lsW3NaXU
 GabvvdNRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER2OzH8Yu6Ldz/7v/rFtnPt
 be7Z0z1nTPXhtgqetGm1aopEtIVELMN/Z7sCyWM3zq6W5JT2YpeM46tnmJ5btGse06F+6fzkG4/
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:clm@fb.com,m:dsterba@suse.com,m:quwenruo.btrfs@gmx.com,m:fdmanana@suse.com,m:naota@elisp.net,m:linux-btrfs@vger.kernel.org,m:anand.jain@oracle.com,m:sbehrens@giantdisaster.de,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[fb.com,suse.com,gmx.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263676-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5ED0568EE04

A device replace can be left SUSPENDED while the filesystem stays mounted
and writable.  btrfs_resume_dev_replace_async() leaves the replace
SUSPENDED with the target device still present when it cannot claim the
exclusive operation (e.g. a recovered paused balance owns it), and while
SUSPENDED btrfs_dev_replace_is_ongoing() stays true, so writes to the
source device are still duplicated to the target device (see
btrfs_map_block() and handle_ops_on_dev_replace()), accounted by
dev_replace->bio_counter.

If the replace is then canceled, btrfs_dev_replace_cancel() takes the
SUSPENDED case and frees the target with
btrfs_destroy_dev_replace_tgtdev().  That helper does a synchronize_rcu()
(to fence readers of the device list) but does not wait for the duplicated
write bios to drain.  A bio that completes after the free dereferences the
freed tgt_device (e.g. btrfs_log_dev_io_error() ->
btrfs_dev_stat_inc_and_print()), and btrfs_close_bdev() tears the block
device down while I/O is still in flight against it -- a use-after-free.

btrfs_dev_replace_finishing() handles this correctly on its own error
path: it calls btrfs_rm_dev_replace_blocked() -- which blocks new bios and
waits for bio_counter to reach zero -- before
btrfs_destroy_dev_replace_tgtdev(), then calls
btrfs_rm_dev_replace_unblocked().  The cancel path omitted the drain.

Mirror the finishing error path: drain the in-flight bios before
destroying the target.

Fixes: d189dd70e255 ("btrfs: fix use-after-free due to race between replace start and cancel")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/btrfs/dev-replace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 51665ed09798..e5090fb7fc11 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1161,8 +1161,11 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 			btrfs_dev_name(src_device), src_device->devid,
 			btrfs_dev_name(tgt_device));
 
+		/* Drain writes still duplicated to tgtdev before freeing it. */
+		btrfs_rm_dev_replace_blocked(fs_info);
 		if (tgt_device)
 			btrfs_destroy_dev_replace_tgtdev(tgt_device);
+		btrfs_rm_dev_replace_unblocked(fs_info);
 		break;
 	default:
 		up_write(&dev_replace->rwsem);

-- 
2.47.3


