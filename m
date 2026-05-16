Return-Path: <stable+bounces-249026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C8kjENnACGrC3wMAu9opvQ
	(envelope-from <stable+bounces-249026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:09:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857455D758
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D045C30086EC
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0635E1A4;
	Sat, 16 May 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndF2hgXO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE92405C31
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958549; cv=none; b=CQRMAUQ3bGWYecAsqJXFILxPXa08IrnIbabNSQRy+8td9lUeMFlkQuiPb41dfc4hr2GHPm1S6Ledv1nm9gaLsfaOAcuCIXC6F/r6c/rwplXavHtE7iCVuVUyqiTxJxlKs57/26qyXWb9CS29dagJU0aGZbWqcHfKHVN8HgKZEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958549; c=relaxed/simple;
	bh=hEJqAVpfLsj33tM4EtWZ5PzB4GzR9yCKEPDAmeApcFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9I9rth+TnoTCE3ZOBeIK+gXymtA7RZvit+wKVS/2nRP1khsUuBF4hqwaHMKV9BdwcwKL/vO4WgSGNJv9mo4Rf3zHoXykSu+TOY/bzDcPEl+8Zcq0i+qQwhRl1FtGXVMNDArexAfgzWoyLBgSHsLN1QF+mCJCywL2LbAYjkypr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndF2hgXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECD8C19425;
	Sat, 16 May 2026 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778958549;
	bh=hEJqAVpfLsj33tM4EtWZ5PzB4GzR9yCKEPDAmeApcFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndF2hgXO/3vO5caTnjpGSRqaK+T1dyTca6bxyCNxj+EeQ9xyXK9++o8ev8PLW1ac5
	 acWfbxUsCfMd0g5DphHEwZh6iZpttfvDVZfKp4UgAjJ3PC7vLGbvsOkrYXtPx+jEad
	 1oCrq1Th6uVDl8MO0tC1OVg7metF8PUu+Kqs1E+ss45EGiMMVlUK3SIOXiKHttXlL8
	 /2qPcno0NocBmoZjeVdwXzummkxny9XLELUX0UO6TKKXHng/MS2KWCoXgcLjbqHaff
	 tWF6YYxfOquMa1LlIP/4Uf3E/RvMeNJh1Wv6wbQhG69TcR5xTnyxF7aWv2Ifix5Vb5
	 +HfyQg3stwJNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] btrfs: do not mark inode incompressible after inline attempt fails
Date: Sat, 16 May 2026 15:09:07 -0400
Message-ID: <20260516190907.4016888-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051210-encourage-bagel-d5d1@gregkh>
References: <2026051210-encourage-bagel-d5d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8857455D758
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249026-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Action: no action

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 2e0e3716c7b6f8d71df2fbe709b922e54700f71b ]

[BUG]
The following sequence will set the file with nocompress flag:

  # mkfs.btrfs -f $dev
  # mount $dev $mnt -o max_inline=4,compress
  # xfs_io -f -c "pwrite 0 2k" -c sync $mnt/foobar

The inode will have NOCOMPRESS flag, even if the content itself (all 0xcd)
can still be compressed very well:

	item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
		generation 9 transid 10 size 2097152 nbytes 1052672
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 257 flags 0x8(NOCOMPRESS)

Please note that, this behavior is there even before commit 59615e2c1f63
("btrfs: reject single block sized compression early").

[CAUSE]
At compress_file_range(), after btrfs_compress_folios() call, we try
making an inlined extent by calling cow_file_range_inline().

But cow_file_range_inline() calls can_cow_file_range_inline() which has
more accurate checks on if the range can be inlined.

One of the user configurable conditions is the "max_inline=" mount
option. If that value is set low (like the example, 4 bytes, which
cannot store any header), or the compressed content is just slightly
larger than 2K (the default value, meaning a 50% compression ratio),
cow_file_range_inline() will return 1 immediately.

And since we're here only to try inline the compressed data, the range
is no larger than a single fs block.

Thus compression is never going to make it a win, we fall back to
marking the inode incompressible unavoidably.

[FIX]
Just add an extra check after inline attempt, so that if the inline
attempt failed, do not set the nocompress flag.

As there is no way to remove that flag, and the default 50% compression
ratio is way too strict for the whole inode.

CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index feaa6de8a90f2..efdc075027393 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1006,6 +1006,12 @@ static void compress_file_range(struct btrfs_work *work)
 			mapping_set_error(mapping, -EIO);
 		goto free_pages;
 	}
+	/*
+	 * If a single block at file offset 0 cannot be inlined, fall back to
+	 * regular writes without marking the file incompressible.
+	 */
+	if (start == 0 && end <= blocksize)
+		goto cleanup_and_bail_uncompressed;
 
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a
-- 
2.53.0


