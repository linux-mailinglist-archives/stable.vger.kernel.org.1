Return-Path: <stable+bounces-219174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKsADgFpnmmzVAQAu9opvQ
	(envelope-from <stable+bounces-219174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:14:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA6419124A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84CFE30AF59A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188D828D8DF;
	Wed, 25 Feb 2026 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbLQsQmb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3E288C08
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771989230; cv=none; b=n+l908akaASN0nzkJYZEF4yZGa1zqeboDs5cKKCwMCzwxWh65Qj1w9Te9bPZ56lpn9pRc/MOVFUo2EtRVnLlKNS4mOcxZQ9H63+7Rl4+NMwlw9s9BuuynwDwBAm2ww4gIHVQUIBD100Kh/sG/vF6IToqAFtMb4xBJPpL2oRZ3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771989230; c=relaxed/simple;
	bh=EFnbO20VHNgb4dGksiV7kasbqoFEeZWqSVfPZuoxO04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5m+Rd1pdIPemk5iv0pcVMhaDf+WYk0sP7a8lkyNwswf2R0OAtyTqHH4YEY+F7+CCO0AkJFldlIFh9pWTxLqQmAyYDd9ZsZEM/lZd8XG2VNrwOWzvZSyYobrRD/FXKGaOADazodrZan/pBrXQnPV8MeFeWT7MHjW1QhHVIudrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbLQsQmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB902C19422;
	Wed, 25 Feb 2026 03:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771989230;
	bh=EFnbO20VHNgb4dGksiV7kasbqoFEeZWqSVfPZuoxO04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dbLQsQmbqDB84FD1OhuReL7LwlFuOQvwDRT/M3pPTI5IFOxyC/vIcNGjO98AQLCB/
	 j28EFzU9WgA1kzAjm3Twb9j0G/ubuARiaYQzI04bvB61OEPsV+29buBlfOTOXCWB2s
	 2eWiBsgPF7ZeQthtahSKAWvlf5BNLizrA/E9WB5+TzkvrcMbLp2QKAr+T9L3DFA/NS
	 2pWRqUibhvfQayRACWZqdO34UUOBY1zUbGNSvORhdptHw9APmgM/WAl26/ejWVeUyz
	 Od1ZqjL6MG4ujgDFn4AgsXbhzD6vv94YFP8bUgV4/5fZjKEyqNXfWYIoCq8x9wYtHL
	 PCJzACz9cooig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/7] ext4: subdivide EXT4_EXT_DATA_VALID1
Date: Tue, 24 Feb 2026 22:13:42 -0500
Message-ID: <20260225031343.3858545-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225031343.3858545-1-sashal@kernel.org>
References: <2026022439-revered-giddily-d324@gregkh>
 <20260225031343.3858545-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219174-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email,huawei.com:email]
X-Rspamd-Queue-Id: BEA6419124A
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 22784ca541c0f01c5ebad14e8228298dc0a390ed ]

When splitting an extent, if the EXT4_GET_BLOCKS_CONVERT flag is set and
it is necessary to split the target extent in the middle,
ext4_split_extent() first handles splitting the latter half of the
extent and passes the EXT4_EXT_DATA_VALID1 flag. This flag implies that
all blocks before the split point contain valid data; however, this
assumption is incorrect.

Therefore, subdivid EXT4_EXT_DATA_VALID1 into
EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_DATA_PARTIAL_VALID1, which
indicate that the first half of the extent is either entirely valid or
only partially valid, respectively. These two flags cannot be set
simultaneously.

This patch does not use EXT4_EXT_DATA_PARTIAL_VALID1, it only replaces
EXT4_EXT_DATA_VALID1 with EXT4_EXT_DATA_ENTIRE_VALID1 at the location
where it is set, no logical changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Message-ID: <20251129103247.686136-2-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 1bf6974822d1 ("ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 476fa4bc351a0..dac8b758b6837 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -43,8 +43,13 @@
 #define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
 #define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
 
-#define EXT4_EXT_DATA_VALID1	0x8  /* first half contains valid data */
-#define EXT4_EXT_DATA_VALID2	0x10 /* second half contains valid data */
+/* first half contains valid data */
+#define EXT4_EXT_DATA_ENTIRE_VALID1	0x8   /* has entirely valid data */
+#define EXT4_EXT_DATA_PARTIAL_VALID1	0x10  /* has partially valid data */
+#define EXT4_EXT_DATA_VALID1		(EXT4_EXT_DATA_ENTIRE_VALID1 | \
+					 EXT4_EXT_DATA_PARTIAL_VALID1)
+
+#define EXT4_EXT_DATA_VALID2	0x20 /* second half contains valid data */
 
 static __le32 ext4_extent_block_csum(struct inode *inode,
 				     struct ext4_extent_header *eh)
@@ -3175,8 +3180,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	unsigned int ee_len, depth;
 	int err = 0;
 
-	BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2)) ==
-	       (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
+	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) == EXT4_EXT_DATA_VALID1);
+	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
+	       (split_flag & EXT4_EXT_DATA_VALID2));
 
 	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
 
@@ -3361,7 +3367,7 @@ static int ext4_split_extent(handle_t *handle,
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
 				       EXT4_EXT_MARK_UNWRIT2;
 		if (split_flag & EXT4_EXT_DATA_VALID2)
-			split_flag1 |= EXT4_EXT_DATA_VALID1;
+			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
 		if (IS_ERR(path)) {
@@ -3725,7 +3731,7 @@ static int ext4_split_convert_extents(handle_t *handle,
 
 	/* Convert to unwritten */
 	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
-		split_flag |= EXT4_EXT_DATA_VALID1;
+		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
 	/* Convert to initialized */
 	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
 		split_flag |= ee_block + ee_len <= eof_block ?
-- 
2.51.0


