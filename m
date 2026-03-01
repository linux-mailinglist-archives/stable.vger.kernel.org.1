Return-Path: <stable+bounces-221858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG6+CWWao2kwIAUAu9opvQ
	(envelope-from <stable+bounces-221858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:46:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E01CBA11
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE2FA3033251
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B732D5937;
	Sun,  1 Mar 2026 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOsTHtfn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF62C0294;
	Sun,  1 Mar 2026 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329306; cv=none; b=FzDPzhkrvZc8B9VL7iI0t+BaQSoeKLmiCdX4QjztZKN855Ddv/xJ/OlV0tv/mujcIgklnU8sSJNCSYHZGWu3IyCQOOslMOV6sXR/POM62exp0zlqbiqhiPZWQHTKE6jt3/9mfvCesnohMmyU1VIG/qUGhQ509/oGv5odz+nDfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329306; c=relaxed/simple;
	bh=CIIr3NGEKkFaMC9e9pMh/KuEXB73QvfJAuEq6KNACa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnmhPIv+l60fjIq/yWaN3VL0QLHekJgYPhju/Mo9P+s0b5Ciczyzl2AElzQEX3X1ETTwGIOrX2L7gQ2C/aBKCK8eJdOCRWrTn9Qhejwmih4I5vJi8twbOAt6CAuIgIUKvjRucmh++f9yjiLCHGLgDaMsF5blAj28wt4hANkrGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOsTHtfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB713C19421;
	Sun,  1 Mar 2026 01:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329306;
	bh=CIIr3NGEKkFaMC9e9pMh/KuEXB73QvfJAuEq6KNACa4=;
	h=From:To:Cc:Subject:Date:From;
	b=LOsTHtfndjt9qBC3ZEFAHvNyFFX8GFdAIYOQ3UBEKTlh+q1/DjeTgQuiO2CUO+V0q
	 DC5uFDK0Hsyee44rFvP7Yh9sx14yYV7JTDtfTbxpSobw75K/7NqN+StYmsN+0g1mnG
	 utytV8ZkqoTi4zAuq2imGXvK9LocdAefp+a283eyuy+Z89Zl5ppHKJkeWkTQ2dW54r
	 gBIVU4UtB7JBcgLgmyJifbKCBunS+GofijBiciP4qIYSVROjKLUacJ+TGPu3YCcyuo
	 DITZt+MhCgVnIikreW4VK0W/Q0NfDLTvDNe2FzAWRDwE7HnvaTnGeBJEHeInNtrDPb
	 tSPAJcPL+NPSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev
Subject: FAILED: Patch "dm-integrity: fix a typo in the code for write/discard race" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:41:44 -0500
Message-ID: <20260301014144.1703446-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221858-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE9E01CBA11
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c698b7f417801fcd79f0dc844250b3361d38e6b8 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 12 Jan 2026 21:15:27 +0100
Subject: [PATCH] dm-integrity: fix a typo in the code for write/discard race

If we send a write followed by a discard, it may be possible that the
discarded data end up being overwritten by the previous write from the
journal. The code tries to prevent that, but there was a typo in this
logic that made it not being activated as it should be.

Note that if we end up here the second time (when discard_retried is
true), it means that the write bio is actually racing with the discard
bio, and in this situation it is not specified which of them should win.

Cc: stable@vger.kernel.org
Fixes: 31843edab7cb ("dm integrity: improve discard in journal mode")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 170bf67a2edd9..79d60495454a5 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2411,7 +2411,7 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 
 		new_pos = find_journal_node(ic, dio->range.logical_sector, &next_sector);
 		if (unlikely(new_pos != NOT_FOUND) ||
-		    unlikely(next_sector < dio->range.logical_sector - dio->range.n_sectors)) {
+		    unlikely(next_sector < dio->range.logical_sector + dio->range.n_sectors)) {
 			remove_range_unlocked(ic, &dio->range);
 			spin_unlock_irq(&ic->endio_wait.lock);
 			queue_work(ic->commit_wq, &ic->commit_work);
-- 
2.51.0





