Return-Path: <stable+bounces-263675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /+DyGqg2MWp8eAUAu9opvQ
	(envelope-from <stable+bounces-263675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:42:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC668EDE9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:42:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bVdcl6L3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263675-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263675-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E01843046EEC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6053DB304;
	Tue, 16 Jun 2026 11:41:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D9436379;
	Tue, 16 Jun 2026 11:41:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610106; cv=none; b=fZhvStaiZ4PpPlSGyr1e1Z4+tlTR1iR9ItvZr7eL0EHQ8DUwNn8uMrZGJ1L7G4YFyqJcZNGoqVsrfhWwWWXbUKuqhFgK+njhal9Z0bkzLW/jv5VSJhrjnkRNZqggarGBTZ1Sz3679GKrNZ9/nInb2GMrPXZllYJVrQN+qKo3Ljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610106; c=relaxed/simple;
	bh=KU6B2ouUGWaYbPCy8RrA2wpa5QbDE9qsPtdm50LoypA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGQ+Bjs6+ov/ZULxp9nWCmvPmkNpoVf69h0AewIjrPujmQqz7C5ijLw6Z1BPGINLFwtyJa1B0NaAznr+qjmboglued2Pyt2ejXiD3j36bzzTQ37GEpPhZXZXceqYXgiXH9SK/dLHIv73TZFLbkq7Z4uNvnthJgNB3Ts45PXkEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVdcl6L3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415F11F00A3A;
	Tue, 16 Jun 2026 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781610104;
	bh=16Jn4FMguVa15xvSz09FsWdQYEAL9hOJuCINImTHpIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bVdcl6L3SI3W+X1vs4fd8Tc/4zMxJ3U7khUL94fPBCLcBmc2q9MFK7P12XW80X+rn
	 6LADkrvT7u1ZhC7aZwzSDkyQZIPVad9/ptpk1fKYpchGColEOORC+5rk05gF7mahM4
	 RHjwAiS1zriJHIJSUIYQAcRYqVzSaCpqjGtJ4s1UzGjPZvdJNRT/y0WaYTlDzvvKnB
	 fa3kjL8gFf0ofCwB+ZbeeZIQS9t6/rLqFNdMMuEWd6TnKD5DHUzHcV7igX+31jW0+c
	 AIYs4MqPlzC/mCWdXAo10rlF7/+qXEW6Ws3XkmWayjNN5CU/kqZ9EZeJPBGqA9Vc/6
	 8FNkRfDb/Rzuw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 13:41:12 +0200
Subject: [PATCH 3/7] btrfs: drain replace writes before freeing the target
 on start failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-work-btrfs-preexisting-fixes-v1-3-c4abe2f6d4f0@kernel.org>
References: <20260616-work-btrfs-preexisting-fixes-v1-0-c4abe2f6d4f0@kernel.org>
In-Reply-To: <20260616-work-btrfs-preexisting-fixes-v1-0-c4abe2f6d4f0@kernel.org>
To: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Filipe Manana <fdmanana@suse.com>, Naohiro Aota <naota@elisp.net>, 
 linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>, 
 Stefan Behrens <sbehrens@giantdisaster.de>, linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KU6B2ouUGWaYbPCy8RrA2wpa5QbDE9qsPtdm50LoypA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZmmV1C2gft5vYby+b0apnMVdStXtLy71iff/w94e/v
 j69Y05rRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ8/zP8T519f01PMPe+aUfY
 X8w+UKRrfP34Itel8n7b/vZxf+zKa2ZkeGy/7OE9/zbHWVM+XZMXP/W1aKnPy5Zn/X8uxllGGS+
 y4AIA
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
	TAGGED_FROM(0.00)[bounces-263675-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 14EC668EDE9

Once btrfs_dev_replace_start() has set the replace state to STARTED and
dropped dev_replace->rwsem, writes to the source device are duplicated
to the target device (see btrfs_map_block() and
handle_ops_on_dev_replace()), and the in-flight bios are accounted by
dev_replace->bio_counter.

If the following btrfs_start_transaction() then fails, the error path
resets the state to NEVER_STARTED, clears ->srcdev/->tgtdev and jumps to
the 'leave' label, which frees the target with
btrfs_destroy_dev_replace_tgtdev().  That helper does a synchronize_rcu()
(to fence readers of the device list) but does not wait for the
duplicated write bios to drain.  A bio that completes after the free
dereferences the freed tgt_device (e.g. btrfs_log_dev_io_error() ->
btrfs_dev_stat_inc_and_print()), and btrfs_close_bdev() tears the block
device down while I/O is still in flight against it -- a use-after-free.
btrfs_start_transaction() failing here is reachable (e.g. -ENOMEM, or
-EROFS on an aborted transaction).

btrfs_dev_replace_finishing() handles this correctly on its own error
path: it calls btrfs_rm_dev_replace_blocked() -- which blocks new bios
and waits for bio_counter to reach zero -- before
btrfs_destroy_dev_replace_tgtdev(), then calls
btrfs_rm_dev_replace_unblocked().  The start-failure path simply omitted
the drain.

Mirror the finishing error path: drain the in-flight bios before
destroying the target, and return directly.  The shared 'leave' label
stays for the earlier failure case (the unexpected STARTED/SUSPENDED
state), which never published ->tgtdev to btrfs_map_block() and so needs
no drain.

Fixes: e93c89c1aaaa ("Btrfs: add new sources for device replace code")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/btrfs/dev-replace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 318ddb790429..51665ed09798 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -66,6 +66,8 @@
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret);
 static int btrfs_dev_replace_kthread(void *data);
+static void btrfs_rm_dev_replace_blocked(struct btrfs_fs_info *fs_info);
+static void btrfs_rm_dev_replace_unblocked(struct btrfs_fs_info *fs_info);
 
 int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 {
@@ -690,7 +692,11 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		dev_replace->srcdev = NULL;
 		dev_replace->tgtdev = NULL;
 		up_write(&dev_replace->rwsem);
-		goto leave;
+		/* Drain writes already duplicated to tgtdev before freeing it. */
+		btrfs_rm_dev_replace_blocked(fs_info);
+		btrfs_destroy_dev_replace_tgtdev(tgt_device);
+		btrfs_rm_dev_replace_unblocked(fs_info);
+		return ret;
 	}
 
 	ret = btrfs_commit_transaction(trans);

-- 
2.47.3


