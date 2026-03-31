Return-Path: <stable+bounces-232177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOLKKTD+y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:02:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917136DB56
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBAC328C12F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E0B425CE4;
	Tue, 31 Mar 2026 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mg09ceVn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1AC425CC4;
	Tue, 31 Mar 2026 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976076; cv=none; b=YL4PDAPbNnaAsyJb/eAUq5DttkK+d7F1UzWUOGdVzz9hPYUU8KXbDaIkYcrCR2OZ4aFWiGO5QhM8L7dYv0gliXi9hTM/ZXpj2dnVBJPLe39hBHelrmdJDa8VjD6mcuGZVO3o7DzBsVS4Vq7Rz+jrwdAcUBuvLu8aOkT4eaav+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976076; c=relaxed/simple;
	bh=YEb6Llls5iJjeHBDDaDGPi43eTC35X5/EW2pejyMYQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t88I4xtO1xqVV13DtoT9OW8Hghw3lByPeJS7uctqRX10hMw21Fg0BF3isu0147nk3cN0o1UR6Puj6Edt8wONOt3zI2lr9f98Wnb80CFUReDBlVVoxakDoYe8rhMSSJSNsc7QR9suG5oQAvd1G5v/K31vPCprTbKt7TtYC98LpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mg09ceVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B30C19424;
	Tue, 31 Mar 2026 16:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976075;
	bh=YEb6Llls5iJjeHBDDaDGPi43eTC35X5/EW2pejyMYQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mg09ceVnbT81pDZCRenBWdfQNQdhumY/AkhuFsHV7CEy4+dNcBy+N83vaqHdS7ER2
	 O3aFawIRz4mRX5qfq2MRrKMeC/7i8/dmYnNBhSS3H5pKRBpShLFkA1FBfPDq63U2Ye
	 E/4stzD/ucsjxsCwbvNg+bD68Twg7NJQveR3uYPc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.12 197/244] ext4: always drain queued discard work in ext4_mb_release()
Date: Tue, 31 Mar 2026 18:22:27 +0200
Message-ID: <20260331161749.024821258@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232177-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 3917136DB56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 9ee29d20aab228adfb02ca93f87fb53c56c2f3af upstream.

While reviewing recent ext4 patch[1], Sashiko raised the following
concern[2]:

> If the filesystem is initially mounted with the discard option,
> deleting files will populate sbi->s_discard_list and queue
> s_discard_work. If it is then remounted with nodiscard, the
> EXT4_MOUNT_DISCARD flag is cleared, but the pending s_discard_work is
> neither cancelled nor flushed.

[1] https://lore.kernel.org/r/20260319094545.19291-1-qiang.zhang@linux.dev/
[2] https://sashiko.dev/#/patchset/20260319094545.19291-1-qiang.zhang%40linux.dev

The concern was valid, but it had nothing to do with the patch[1].
One of the problems with Sashiko in its current (early) form is that
it will detect pre-existing issues and report it as a problem with the
patch that it is reviewing.

In practice, it would be hard to hit deliberately (unless you are a
malicious syzkaller fuzzer), since it would involve mounting the file
system with -o discard, and then deleting a large number of files,
remounting the file system with -o nodiscard, and then immediately
unmounting the file system before the queued discard work has a change
to drain on its own.

Fix it because it's a real bug, and to avoid Sashiko from raising this
concern when analyzing future patches to mballoc.c.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Fixes: 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3874,13 +3874,11 @@ void ext4_mb_release(struct super_block
 	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
 	int count;
 
-	if (test_opt(sb, DISCARD)) {
-		/*
-		 * wait the discard work to drain all of ext4_free_data
-		 */
-		flush_work(&sbi->s_discard_work);
-		WARN_ON_ONCE(!list_empty(&sbi->s_discard_list));
-	}
+	/*
+	 * wait the discard work to drain all of ext4_free_data
+	 */
+	flush_work(&sbi->s_discard_work);
+	WARN_ON_ONCE(!list_empty(&sbi->s_discard_list));
 
 	group_info = rcu_access_pointer(sbi->s_group_info);
 	if (group_info) {



