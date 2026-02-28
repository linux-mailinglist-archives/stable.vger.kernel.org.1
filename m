Return-Path: <stable+bounces-220365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPavKpY4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2D1C648A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5AA931444D0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BDF480331;
	Sat, 28 Feb 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbyTYbKq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F823A126A;
	Sat, 28 Feb 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300262; cv=none; b=ezNnIx8FS4rmpHnTi+wzcPTQfjLfnAmKbhAuWTFdFF0oOohCaghOMVSz1vtckvG5zOcICqqG/Uy8s8Z0pZKN3gIc+EOwGg8EOUFWMmAsZAUAXxNMShSdCfLse9v4r/SPCVJ6tKhODAS6x2glHNqzPxDlaYCSmtzNHw1IdqEGJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300262; c=relaxed/simple;
	bh=FZbg55rE1QtyCEP+zmNsooQMQIyxlLzDzWk3m6u9kuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etGMm8vCAqsbCCBObpm/Z5te+Ss4eke821FH94aQZrF5CkK/LW+q0A/ncMuqWZ7P3X9N4zuJTzAQ0e/RJ+f5kqBcbj0hX5p2wLROGAHke98pJpTuqkX8JfQYloXwj9ku2U+isZZwhoXyeDis7614jOHkBHDLUOcLDdFEOBca2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbyTYbKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2BCC116D0;
	Sat, 28 Feb 2026 17:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300261;
	bh=FZbg55rE1QtyCEP+zmNsooQMQIyxlLzDzWk3m6u9kuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbyTYbKqsWyLpMsu1glt9sr2+sfgaY/5xOYWo7OrpjP2Gk188u6eBuk530ZjMX5k3
	 a72cqSQXHnrN6WVWLiApiIYSQhTE1CfyNIL5/AF5IMimwQmjZ/Zxb+aJ7kYz2xCXfz
	 C7HucETBuq8OYtsVsRhLX1iCATnsX6w9sVEqnBPA/yEV6qBanQp5/HqKdH4POI9FS+
	 1f2UnFYbiEnSYGjVEZTVuBM5RuJNPP/nlHaH2OfhyD3+JyIAfR5Mr4UZMdbpKAX5Ij
	 3zye576bIYvaiZDj/wcMGa+WouQW62/ItZ49NOaD3WK5vnDTXKFm6FVS7MqAhtowh5
	 5MxCHBE5M/rWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 287/844] ext4: mark group add fast-commit ineligible
Date: Sat, 28 Feb 2026 12:23:20 -0500
Message-ID: <20260228173244.1509663-288-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220365-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D0C2D1C648A
X-Rspamd-Action: no action

From: Li Chen <me@linux.beauty>

[ Upstream commit 89b4336fd5ec78f51f9d3a1d100f3ffa3228e604 ]

Fast commits only log operations that have dedicated replay support.
Online resize via EXT4_IOC_GROUP_ADD updates the superblock and group
descriptor metadata without going through the fast commit tracking
paths.
In practice these operations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall
semantics harder to reason about and risks replay gaps if new call
sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible when
ext4_ioctl_group_add() adds new block groups.
This forces those transactions to fall back to a full commit,
ensuring that the filesystem geometry updates are captured by the
normal journal rather than partially encoded in fast commit TLVs.
This change should not affect common workloads but makes online
resize via GROUP_ADD safer and easier to reason about under fast
commit.

Testing:
1. prepare:
    dd if=/dev/zero of=/root/fc_resize.img bs=1M count=0 seek=256
    mkfs.ext4 -O fast_commit -F /root/fc_resize.img
    mkdir -p /mnt/fc_resize && mount -t ext4 -o loop /root/fc_resize.img /mnt/fc_resize
2. Ran a helper that issues EXT4_IOC_GROUP_ADD on the mounted
   filesystem and checked the resize ineligible reason:
    ./group_add_helper /mnt/fc_resize
    cat /proc/fs/ext4/loop0/fc_info
   shows "Resize": > 0.
3. Fsynced a file on the resized filesystem and verified that the fast
   commit stats report at least one ineligible commit:
    touch /mnt/fc_resize/file
    /root/fsync_file /mnt/fc_resize/file
    sync
    cat /proc/fs/ext4/loop0/fc_info
   shows fc stats ineligible > 0.

Signed-off-by: Li Chen <me@linux.beauty>
Link: https://patch.msgid.link/20251211115146.897420-5-me@linux.beauty
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ce0fc40aec2f..5109b005e0286 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -966,6 +966,7 @@ static long ext4_ioctl_group_add(struct file *file,
 
 	err = ext4_group_add(sb, input);
 	if (EXT4_SB(sb)->s_journal) {
+		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE, NULL);
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
-- 
2.51.0


