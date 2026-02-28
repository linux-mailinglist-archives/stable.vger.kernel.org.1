Return-Path: <stable+bounces-220128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIVXK/kpo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCF51C516C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11C36308A812
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB4481656;
	Sat, 28 Feb 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdMqhcJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B348164B;
	Sat, 28 Feb 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300038; cv=none; b=QPs6rRZQLZxEe7j3AGPoCRQwDp7REq506o6YiL3gKlLXnAvXNMl5VyFxaWU9kkkbCPeCCfdS2ptWlFp5pvBUMfqX11lFismT65R3+J83IJFHPeG6Fi6jFjOBCO1tGqxJjCeop/t00FtnXq9lSil8rlI06pyhzsU8nZm+iEvgy8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300038; c=relaxed/simple;
	bh=lTdForvCOvrxAPpSHmdeGiymh4Jk0WDPoCxGqiaDsIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWoyYN6HoEn6j7uUrvkOpjtF+wP46+9ylFGgrK2SwanqRXPvnaboLTAevHKXeRgC78D8gS0Nh9smGAN4XrPXm3EuThwbMI4rblIQsop6ASGqOXn6Hv+ewy/+QPDiSy2sYjMhT4UqlkMcWE0MCrQRw8sa/JCMc8GbQWsLOR0Z7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdMqhcJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE82C19423;
	Sat, 28 Feb 2026 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300038;
	bh=lTdForvCOvrxAPpSHmdeGiymh4Jk0WDPoCxGqiaDsIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdMqhcJu+NgV8oVBrWM3BSw0up/Ys89nO68ymbjpwZd3Hefv8RQ4fDHDtKRpU3QFI
	 B9DKljsOqrcAGmnTTUyADGK/fWj1giqYW06A0FY+2BMIZ6pZ9X2QlU0kmLRiV1GKi4
	 AARto2rZcA7MuF3IlcTiX4o3qqKZXqxmtDbojIXKQJDfcom1yh5OwTOHjpOhARwy5h
	 yd2N/RMAJmlZncJGD9dBcx+4XzN9XnTswPYNMH8sSk28Ohi/d2pSBpjjob+s4bJlhW
	 ZB6EFGkrKn24nvYxh28tgFA26ZojHdAtELBxw8Ih/aZVTkJLkSVLIiIscBwHlsdnrL
	 KcrrXWhAP6GTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 050/844] btrfs: fallback to buffered IO if the data profile has duplication
Date: Sat, 28 Feb 2026 12:19:23 -0500
Message-ID: <20260228173244.1509663-51-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220128-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FCF51C516C
X-Rspamd-Action: no action

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7c2830f00c3e086292c1ee9f27b61efaf8e76c9a ]

[BACKGROUND]
Inspired by a recent kernel bug report, which is related to direct IO
buffer modification during writeback, that leads to contents mismatch of
different RAID1 mirrors.

[CAUSE AND PROBLEMS]
The root cause is exactly the same explained in commit 968f19c5b1b7
("btrfs: always fallback to buffered write if the inode requires
checksum"), that we can not trust direct IO buffer which can be modified
halfway during writeback.

Unlike data checksum verification, if this happened on inodes without
data checksum but has the data has extra mirrors, it will lead to
stealth data mismatch on different mirrors.

This will be way harder to detect without data checksum.

Furthermore for RAID56, we can even have data without checksum and data
with checksum mixed inside the same full stripe.

In that case if the direct IO buffer got changed halfway for the
nodatasum part, the data with checksum immediately lost its ability to
recover, e.g.:

" " = Good old data or parity calculated using good old data
"X" = Data modified during writeback

              0                32K                      64K
  Data 1      |                                         |  Has csum
  Data 2      |XXXXXXXXXXXXXXXX                         |  No csum
  Parity      |                                         |

In above case, the parity is calculated using data 1 (has csum, from
page cache, won't change during writeback), and old data 2 (has no csum,
direct IO write).

After parity is calculated, but before submission to the storage, direct
IO buffer of data 2 is modified, causing the range [0, 32K) of data 2
has a different content.

Now all data is submitted to the storage, and the fs got fully synced.

Then the device of data 1 is lost, has to be rebuilt from data 2 and
parity. But since the data 2 has some modified data, and the parity is
calculated using old data, the recovered data is no the same for data 1,
causing data checksum mismatch.

[FIX]
Fix the problem by checking the data allocation profile.
If our data allocation profile is either RAID0 or SINGLE, we can allow
true zero-copy direct IO and the end user is fully responsible for any
race.

However this is not going to fix all situations, as it's still possible
to race with balance where the fs got a new data profile after the data
allocation profile check.
But this fix should still greatly reduce the window of the original bug.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=99171
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/direct-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 07e19e88ba4b3..5443d69efe956 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -814,6 +814,8 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio;
+	const u64 data_profile = btrfs_data_alloc_profile(fs_info) &
+				 BTRFS_BLOCK_GROUP_PROFILE_MASK;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -827,6 +829,16 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) && IS_NOSEC(inode))
 		ilock_flags |= BTRFS_ILOCK_SHARED;
 
+	/*
+	 * If our data profile has duplication (either extra mirrors or RAID56),
+	 * we can not trust the direct IO buffer, the content may change during
+	 * writeback and cause different contents written to different mirrors.
+	 *
+	 * Thus only RAID0 and SINGLE can go true zero-copy direct IO.
+	 */
+	if (data_profile != BTRFS_BLOCK_GROUP_RAID0 && data_profile != 0)
+		goto buffered;
+
 relock:
 	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (ret < 0)
-- 
2.51.0


