Return-Path: <stable+bounces-220367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNPDMLo1o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A51C6055
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DBE5321833F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535793A2B1B;
	Sat, 28 Feb 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMFZ8Iag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A403A2B13;
	Sat, 28 Feb 2026 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300264; cv=none; b=XUAucoupCi6CHVtX9fihlwETGlTaXwSYr+zLV/SLIy3XW+QPzqDyloBKwEcDC7Qh3yO6qSRBNx0hVcBc2vMaCH8jfxLKe9YQH1QrEXT5+44YkKa6Q/cylPaqMQjcp9im1tcED7bfPpNGu1LGlITX7qTDBBXCWvXHOzeovqViqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300264; c=relaxed/simple;
	bh=zcsAsMU11jRd8t8/cx8CVmfm1W2kXBYAncOXj+P4M9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2qiP6dqno/cOgza6NzPsGP5/94dYqO1IDyyihcN5ZN6Dks9gOZI29FDm/LuFdrJzjflWlm5cU9ctqRvU369PivdJGJC/BwQPDTxMPQmGHXwS2tbtO//ShsMTVAAgLfpUi8q4zPDg4XhUaMQajn1eqKA7MpQN8dRQwQ35FPxRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMFZ8Iag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F230C19424;
	Sat, 28 Feb 2026 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300263;
	bh=zcsAsMU11jRd8t8/cx8CVmfm1W2kXBYAncOXj+P4M9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMFZ8IagNACZXFDnOL9BPz4tDMJklTM5VmT8dmw1LIvhWgiuXawK96uFeWCPMMM0u
	 zm8JOlLsquDw5161EaWuzI9VzkgG9cl3A7kefvcjAYZxG/EWDrbldmA3yQcm1rNJlA
	 RJQaMdIgrBuubcDOeQrAu4pwe5yrZ035vSj7fAcDfmba6/JHUeblF5zRu8KwKlHlZc
	 Y7Ut9JYtm/1nkc4ktk3lVjx+ZqoetgSNrcTqvjpMNfubDsoCD8gS/sPKibM1DPm4Dp
	 IOjpzUoAcL/3SjS65nExIbL5JKY9bWGctA92+6yFQrNtAg06GPyMoMkCQj9eGPpSE6
	 /j8yLJC7qgPnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 289/844] ext4: mark group extend fast-commit ineligible
Date: Sat, 28 Feb 2026 12:23:22 -0500
Message-ID: <20260228173244.1509663-290-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220367-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 284A51C6055
X-Rspamd-Action: no action

From: Li Chen <me@linux.beauty>

[ Upstream commit 1f8dd813a1c771b13c303f73d876164bc9b327cc ]

Fast commits only log operations that have dedicated replay support.
EXT4_IOC_GROUP_EXTEND grows the filesystem to the end of the last
block group and updates the same on-disk metadata without going
through the fast commit tracking paths.
In practice these operations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall
semantics harder to reason about and risks replay gaps if new call
sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible when
EXT4_IOC_GROUP_EXTEND grows the filesystem.
This forces those transactions to fall back to a full commit,
ensuring that the group extension changes are captured by the normal
journal rather than partially encoded in fast commit TLVs.
This change should not affect common workloads but makes online
resize via GROUP_EXTEND safer and easier to reason about under fast
commit.

Testing:
1. prepare:
    dd if=/dev/zero of=/root/fc_resize.img bs=1M count=0 seek=256
    mkfs.ext4 -O fast_commit -F /root/fc_resize.img
    mkdir -p /mnt/fc_resize && mount -t ext4 -o loop /root/fc_resize.img /mnt/fc_resize
2. Extended the filesystem to the end of the last block group using a
   helper that calls EXT4_IOC_GROUP_EXTEND on the mounted filesystem
   and checked fc_info:
    ./group_extend_helper /mnt/fc_resize
    cat /proc/fs/ext4/loop0/fc_info
   shows the "Resize" ineligible reason increased.
3. Fsynced a file on the resized filesystem and confirmed that the fast
   commit ineligible counter incremented for the resize transaction:
    touch /mnt/fc_resize/file
    /root/fsync_file /mnt/fc_resize/file
    sync
    cat /proc/fs/ext4/loop0/fc_info

Signed-off-by: Li Chen <me@linux.beauty>
Link: https://patch.msgid.link/20251211115146.897420-6-me@linux.beauty
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 5109b005e0286..e5e197ac7d88b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1612,6 +1612,8 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
+			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE,
+						NULL);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
-- 
2.51.0


