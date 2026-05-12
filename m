Return-Path: <stable+bounces-245695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLILJ5c5A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:30:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4CC522895
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A65B309D2AA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1AA3A83B4;
	Tue, 12 May 2026 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rnXpb6Cy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26283A71BE
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594972; cv=none; b=amNMId3VANrZAizy4gK58Y/H1Ez+PPZSBMD795cXTnl1IS/ie/vXL+fosrfZBZcc0LqOiI6GCkBfDN3+ojOAvdQaVQipp9pCDl3nP5yZM4xWDhBnuBbOqNo44ePs+bFlnAz+fQoLhi2eiNV4hYGJOl6lYinkNl58VFL5PmxAljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594972; c=relaxed/simple;
	bh=tSyceQlw3t+X18cUCML2Zw5OCydD1uHDXieJfFla9+M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lu5BrRL7ZkV0onrsOUyzFSaNPAHNVNCFwxdW3I2cZZe9p3np5w38ARtY2oxBGtuuJPfDptr+ITMnFISmekxHQbPBHsO2AwrrzEZFYEjQ06cd/5gpidjIJNFjYgLMgHa64af8H9QFgUI1dbFYpwV+BcYD8+L7W1FrPP2E+wB4HJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rnXpb6Cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACCEC2BCB0;
	Tue, 12 May 2026 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594971;
	bh=tSyceQlw3t+X18cUCML2Zw5OCydD1uHDXieJfFla9+M=;
	h=Subject:To:Cc:From:Date:From;
	b=rnXpb6Cyjd06d1Hz4YExb5oE1Jgp2lEyv7wGQo12dtdzWg4nC9i8roxcBBpa8QfO4
	 SD5JdlliW70UG7gO4PfzM5HOSNbVpNfimieROD1WpRJ51K86DohefwJtiMDCevBubX
	 FIyyqMMLm8EBBwY+cpXyofHX6PDbZHzo7Jfn3yDA=
Subject: FAILED: patch "[PATCH] btrfs: do not mark inode incompressible after inline attempt" failed to apply to 6.12-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:08:10 +0200
Message-ID: <2026051210-undrafted-shelving-27b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA4CC522895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245695-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2e0e3716c7b6f8d71df2fbe709b922e54700f71b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051210-undrafted-shelving-27b2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e0e3716c7b6f8d71df2fbe709b922e54700f71b Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Mon, 16 Feb 2026 13:19:38 +1030
Subject: [PATCH] btrfs: do not mark inode incompressible after inline attempt
 fails

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

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6daa7bb027fc..2ae5a9b2f951 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1061,6 +1061,12 @@ static void compress_file_range(struct btrfs_work *work)
 			mapping_set_error(mapping, -EIO);
 		return;
 	}
+	/*
+	 * If a single block at file offset 0 cannot be inlined, fall back to
+	 * regular writes without marking the file incompressible.
+	 */
+	if (start == 0 && end <= blocksize)
+		goto cleanup_and_bail_uncompressed;
 
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a


