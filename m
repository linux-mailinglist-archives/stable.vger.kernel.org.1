Return-Path: <stable+bounces-219160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHrPCE5nnmmWVAQAu9opvQ
	(envelope-from <stable+bounces-219160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:06:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 768701911BA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01CE830528AD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1AE288C08;
	Wed, 25 Feb 2026 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNXhbccI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415827280F
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988809; cv=none; b=p7FZCtmxFhOnxevXhYB9xp8PgYB3mG5DkYf+Mf2VZgpITMOAZBDiN9irC3mrjQcnszYnQinBOqO/+LrAub/sEZsIwtE3S4jmpRxaEghIDqShu15rJloRjfbcrINv3EJA9poT3aAiVUDtNBivEEr6ft6u6PzPDT9PdpR5AS1OuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988809; c=relaxed/simple;
	bh=iMchNC3d/vr4iB3oaXqwqqiXQeW4ws42QjARTO/clf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqFgB65kChUS4MNl9rhngYHj5+3UFQLHc0yTtEw6d4BU6nhBg3CT63ThIefDiB+sn9VttXNcp56MFYzPCjHO/08/54fFjQPV4X2AlxFkJud3sNj8kVALuQ/bfClELZftpBhgFh5z/CkmIMp4lP5DllaGm3K2Si5PKOwfpZBZc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNXhbccI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B1FC116D0;
	Wed, 25 Feb 2026 03:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771988809;
	bh=iMchNC3d/vr4iB3oaXqwqqiXQeW4ws42QjARTO/clf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNXhbccI4PLnHUslaSJAw9T396X94tBP1qxiC/r+d3P/HAH0GCbmPrlGu9MoHTm3g
	 c5VEWqFNpV75pwxUqeRJJVSogdUw+z+ABrIKb/ZyQmzwzTvMIcU//2etktdtZ9Y9vR
	 xNmKHjqY2klh6yqw4ttbxgG1mRpl41oXPZ14E45iWdOrC64+SGrOzR9Dg0o0371a7K
	 r37tkbLug1ykGVJ7hpzFW+xAt8KGIwJIaMnTZdwraqefW8gofqXJ15lqRjAmGEb12S
	 WQBAKeqyFVh4sGcgUxAzFt+XDKnByYwIFtZjZozrEoI56pDH6ajgir9G4eZj52OxC7
	 P4vzN1mKpUq/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O
Date: Tue, 24 Feb 2026 22:06:46 -0500
Message-ID: <20260225030646.3846438-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022423-fossil-tux-e902@gregkh>
References: <2026022423-fossil-tux-e902@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219160-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 768701911BA
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit feaf2a80e78f89ee8a3464126077ba8683b62791 ]

When allocating blocks during within-EOF DIO and writeback with
dioread_nolock enabled, EXT4_GET_BLOCKS_PRE_IO was set to split an
existing large unwritten extent. However, EXT4_GET_BLOCKS_CONVERT was
set when calling ext4_split_convert_extents(), which may potentially
result in stale data issues.

Assume we have an unwritten extent, and then DIO writes the second half.

   [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
   [UUUUUUUUUUUUUUUU] extent status tree
            |<-   ->| ----> dio write this range

First, ext4_iomap_alloc() call ext4_map_blocks() with
EXT4_GET_BLOCKS_PRE_IO, EXT4_GET_BLOCKS_UNWRIT_EXT and
EXT4_GET_BLOCKS_CREATE flags set. ext4_map_blocks() find this extent and
call ext4_split_convert_extents() with EXT4_GET_BLOCKS_CONVERT and the
above flags set.

Then, ext4_split_convert_extents() calls ext4_split_extent() with
EXT4_EXT_MAY_ZEROOUT, EXT4_EXT_MARK_UNWRIT2 and EXT4_EXT_DATA_VALID2
flags set, and it calls ext4_split_extent_at() to split the second half
with EXT4_EXT_DATA_VALID2, EXT4_EXT_MARK_UNWRIT1, EXT4_EXT_MAY_ZEROOUT
and EXT4_EXT_MARK_UNWRIT2 flags set. However, ext4_split_extent_at()
failed to insert extent since a temporary lack -ENOSPC. It zeroes out
the first half but convert the entire on-disk extent to written since
the EXT4_EXT_DATA_VALID2 flag set, but left the second half as unwritten
in the extent status tree.

   [0000000000SSSSSS]  data                S: stale data, 0: zeroed
   [WWWWWWWWWWWWWWWW]  on-disk extent      W: written extent
   [WWWWWWWWWWUUUUUU]  extent status tree

Finally, if the DIO failed to write data to the disk, the stale data in
the second half will be exposed once the cached extent entry is gone.

Fix this issue by not passing EXT4_GET_BLOCKS_CONVERT when splitting
an unwritten extent before submitting I/O, and make
ext4_split_convert_extents() to zero out the entire extent range
to zero for this case, and also mark the extent in the extent status
tree for consistency.

Fixes: b8a8684502a0 ("ext4: Introduce FALLOC_FL_ZERO_RANGE flag for fallocate")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Message-ID: <20251129103247.686136-4-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ different function signatures ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 35bc58a26f7f4..0641b13a32c39 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3705,11 +3705,15 @@ static int ext4_split_convert_extents(handle_t *handle,
 	/* Convert to unwritten */
 	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
 		split_flag |= EXT4_EXT_DATA_VALID1;
-	/* Convert to initialized */
-	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
+	/* Split the existing unwritten extent */
+	} else if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
+			    EXT4_GET_BLOCKS_CONVERT)) {
 		split_flag |= ee_block + ee_len <= eof_block ?
 			      EXT4_EXT_MAY_ZEROOUT : 0;
-		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
+		split_flag |= EXT4_EXT_MARK_UNWRIT2;
+		/* Convert to initialized */
+		if (flags & EXT4_GET_BLOCKS_CONVERT)
+			split_flag |= EXT4_EXT_DATA_VALID2;
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
 	return ext4_split_extent(handle, inode, ppath, map, split_flag, flags);
@@ -3874,7 +3878,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
 		ret = ext4_split_convert_extents(handle, inode, map, ppath,
-					 flags | EXT4_GET_BLOCKS_CONVERT);
+					 flags);
 		if (ret < 0) {
 			err = ret;
 			goto out2;
-- 
2.51.0


