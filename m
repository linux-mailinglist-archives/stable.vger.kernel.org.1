Return-Path: <stable+bounces-219120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP4WGPZXnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-219120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:01:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0318419065C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9281B3071BF8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6E825A642;
	Wed, 25 Feb 2026 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQOEmra2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4F21257E
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984696; cv=none; b=TOOro4pU4W2buGNohYH3xssMpb4WEYQQV+G3CLnglZjnqd+k3w11MFx78r1+fdMor5SIMOeFnFSO6WEymd76++Z8Iz/WE7/bufRGmdMN5U4rLg3G8Eh+tYJyKH7Uoy0G97MSZP8/+ggfZ+SNgPjJ+DxY1Ldcq0S37FpKZMxacvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984696; c=relaxed/simple;
	bh=LuJgXqbxSFn/t0T3FWFCsESk6JIz+X1kPaiq1VRRJzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5eZtq4lE3v5Mpn2dz1Qesno3V3enQdOBu2QXIF6qaqoLXhNJ1opf2tseup0qR425DsEJczc57M5/VBVYZxymBWFYelYpvJMcuBByxR5/vYvTAcLDg9JoXRcnzhiL0LkAcztNwid1q7cqgAEK6HQgPymew5nXvdzPpL3Hw31InA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQOEmra2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589CDC116D0;
	Wed, 25 Feb 2026 01:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984696;
	bh=LuJgXqbxSFn/t0T3FWFCsESk6JIz+X1kPaiq1VRRJzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQOEmra2jsyUwAX/zKmfaOBxv+a2MtoYbHScBkz+0Ff2MFCxm/Xd9Yw+uNHPgJ1L3
	 Vn9FQ78mVaO0xRlchv8nAZdfArFPNqtndtLduDcizHNbMGcbwJuTosZ3P1iXhweysH
	 7rqqebmGG+R4CYS4Ecdnm+dK4cD2qpewAAtmlNnDHQkk2LQ657ZFq/Vfn8bPZgN36A
	 Ia3TRDYXSBtKoPyRtak0t4UTpr9tTV/7OSvWhJOnn26X92TIUDzTUV4ykP+m5l7Vvc
	 ruXkqL8NakHY6O890SUzlXBNhv6B+q9NB6vViLMVvbvwa+zfg+10kVf35yq3BbieA0
	 PuI57VuofCUDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O
Date: Tue, 24 Feb 2026 20:58:11 -0500
Message-ID: <20260225015811.3777135-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225015811.3777135-1-sashal@kernel.org>
References: <2026022419-bonsai-gorged-49c6@gregkh>
 <20260225015811.3777135-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219120-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:email]
X-Rspamd-Queue-Id: 0318419065C
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f960d06de7dce..ec6c52b17abba 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3733,15 +3733,19 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	/* Convert to unwritten */
 	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
 		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
-	/* Convert to initialized */
-	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
+	/* Split the existing unwritten extent */
+	} else if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
+			    EXT4_GET_BLOCKS_CONVERT)) {
 		/*
 		 * It is safe to convert extent to initialized via explicit
 		 * zeroout only if extent is fully inside i_size or new_size.
 		 */
 		split_flag |= ee_block + ee_len <= eof_block ?
 			      EXT4_EXT_MAY_ZEROOUT : 0;
-		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
+		split_flag |= EXT4_EXT_MARK_UNWRIT2;
+		/* Convert to initialized */
+		if (flags & EXT4_GET_BLOCKS_CONVERT)
+			split_flag |= EXT4_EXT_DATA_VALID2;
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
 	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
@@ -3917,7 +3921,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
 		path = ext4_split_convert_extents(handle, inode, map, path,
-				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
+						  flags, allocated);
 		if (IS_ERR(path))
 			return path;
 		/*
-- 
2.51.0


