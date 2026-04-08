Return-Path: <stable+bounces-234073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNjhOHKa1mmTGggAu9opvQ
	(envelope-from <stable+bounces-234073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:12:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731A3C0274
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E06A03008C8C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA53D8917;
	Wed,  8 Apr 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="orZ3OH6s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B4347503;
	Wed,  8 Apr 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671915; cv=none; b=JI0LmoXqyyISY+eIxf5yZqaytvv/AmvWeCBpwlO0A3qKJYGxtVmBkuWVMC5ahFvLSqppnRM5qb0RAwEihguBAeRv9TBmhcFrn0mEAhKRw6lteulTmuWIZDvjKU0vwdzSLWnOnSGrRwqz/3WcK57k/PIDUrOI5zZVuEhChhJpNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671915; c=relaxed/simple;
	bh=rTlk4Oj33RB2uv6AsBBpoyBKIvWVUTmVUs/sNdlUpdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIiBXQx29k8cpYx/ew773f+FN+xdtN3uCT4By4O9vVunEK5AU2Bh8KoV+7EZmnupfuinR5hjShVnSBs7NmJ9XfsNzi0O52QFucqutlMUG2qJTq7k4i6OMopKca3b0w6SkG+b+cqbSJCESrsT6ttSrLQZwpTEgFYwUfY8LtFDxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=orZ3OH6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08586C19421;
	Wed,  8 Apr 2026 18:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671915;
	bh=rTlk4Oj33RB2uv6AsBBpoyBKIvWVUTmVUs/sNdlUpdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orZ3OH6s00il03XxaugRZP+To26wHazc3qYUkUvL+vCAOpw9VsrsFnkxBD5DaLn58
	 a+5EkDCQVtQF7Tbr3YA1GTBq0B/QzLLOgdHZIdXaRnUrst4kH853t+mDWlkKysTTWT
	 lb+pS6Z3ws0hj0uzSV5+LPpLMlld2e/UwTQn896c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.1 116/312] ext4: avoid allocate block from corrupted group in ext4_mb_find_by_goal()
Date: Wed,  8 Apr 2026 20:00:33 +0200
Message-ID: <20260408175938.102419593@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-234073-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,huawei.com,gmail.com,dilger.ca,suse.cz,mit.edu,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,suse.cz:email,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0731A3C0274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Bin <yebin10@huawei.com>

commit 46066e3a06647c5b186cc6334409722622d05c44 upstream.

There's issue as follows:
...
EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost

EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost

EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost

EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost

EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2243 at logical offset 0 with max blocks 1 with error 117
EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost

EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2239 at logical offset 0 with max blocks 1 with error 117
EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost

EXT4-fs (mmcblk0p1): error count since last fsck: 1
EXT4-fs (mmcblk0p1): initial error at time 1765597433: ext4_mb_generate_buddy:760
EXT4-fs (mmcblk0p1): last error at time 1765597433: ext4_mb_generate_buddy:760
...

According to the log analysis, blocks are always requested from the
corrupted block group. This may happen as follows:
ext4_mb_find_by_goal
  ext4_mb_load_buddy
   ext4_mb_load_buddy_gfp
     ext4_mb_init_cache
      ext4_read_block_bitmap_nowait
      ext4_wait_block_bitmap
       ext4_validate_block_bitmap
        if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
         return -EFSCORRUPTED; // There's no logs.
 if (err)
  return err;  // Will return error
ext4_lock_group(ac->ac_sb, group);
  if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) // Unreachable
   goto out;

After commit 9008a58e5dce ("ext4: make the bitmap read routines return
real error codes") merged, Commit 163a203ddb36 ("ext4: mark block group
as corrupt on block bitmap error") is no real solution for allocating
blocks from corrupted block groups. This is because if
'EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)' is true, then
'ext4_mb_load_buddy()' may return an error. This means that the block
allocation will fail.
Therefore, check block group if corrupted when ext4_mb_load_buddy()
returns error.

Fixes: 163a203ddb36 ("ext4: mark block group as corrupt on block bitmap error")
Fixes: 9008a58e5dce ("ext4: make the bitmap read routines return real error codes")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260302134619.3145520-1-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2236,8 +2236,12 @@ int ext4_mb_find_by_goal(struct ext4_all
 		return 0;
 
 	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
-	if (err)
+	if (err) {
+		if (EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info) &&
+		    !(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
+			return 0;
 		return err;
+	}
 
 	ext4_lock_group(ac->ac_sb, group);
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))



