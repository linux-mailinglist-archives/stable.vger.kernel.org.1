Return-Path: <stable+bounces-219158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CFeLlBlnmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:58:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D71D19116D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E6ED30E0512
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2996D29A9C9;
	Wed, 25 Feb 2026 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTCJwB/P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9C296BD1
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988257; cv=none; b=ercbJKls7R0SZcaG+oBTtB15fhm+NJskWrvCmVjBPamff4akIHrD8Kyy1YZ0Nx1QEewgxod5ZT3kQbVTgGxgtxT/VA6ymFPc7sA1c3TyfHnIp3TUP1MGtYd2faI8reTMc7h80J8fwNXyPIyV/3cqIDU+FH0iyuKpg8nCBh9GxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988257; c=relaxed/simple;
	bh=pkvmTAQZEAvcYU6s55Dcl5omaruk3nk/NrTVJY5YScI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OycPYeeUTfbwLn/BBaZhvfOIG1rv1ctqNAHxDx8CBf0B5kuwDsihTLzn7pzibXxypdhyEqWCdnhq9x6aj4Bpv4Url9vCMqZcxVezmcyOLEr1QYpvgMxBFs4cTCz0CF1CL5+lm4OE2bxwyZVQB1c8xfrF+gImuv481pWU8T5wdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTCJwB/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F41C116D0;
	Wed, 25 Feb 2026 02:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771988256;
	bh=pkvmTAQZEAvcYU6s55Dcl5omaruk3nk/NrTVJY5YScI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTCJwB/PB4QQMP8B/xk0oMyZaeZ+fgGKuRn4BCbZwlZ1awqsQRPZM73YJ5rYBaDL8
	 8M4ehPZ4Ukek6ZkGkq53nOFlk6D1yzfd+gB/1fBawDKMFx5WePabDpX5yAlNyFKz2X
	 AXychvOOocLzYQHsjRCGQ2mG0Zb/+D+UsQzj4bx+rZM9DJjFx6z9DPqpDqcGHhYwyk
	 sgtmQa4OAUXUVjIRspHlgUi0mv+IZNSvUmNJOEf25aU1BbB5DVNtX1UfhbVRJtpgL9
	 iXN0NABeUn50OHk7JEOcfvZqLavvPucHXqQeTGsu14dJzLoknUtsV/HS1IJ4H9/Bj/
	 cFPDDf1OK/cuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/6] ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
Date: Tue, 24 Feb 2026 21:57:29 -0500
Message-ID: <20260225025729.3839073-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225025729.3839073-1-sashal@kernel.org>
References: <2026022438-resample-unlit-c02b@gregkh>
 <20260225025729.3839073-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-219158-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D71D19116D
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 1bf6974822d1dba86cf11b5f05498581cf3488a2 ]

When allocating initialized blocks from a large unwritten extent, or
when splitting an unwritten extent during end I/O and converting it to
initialized, there is currently a potential issue of stale data if the
extent needs to be split in the middle.

       0  A      B  N
       [UUUUUUUUUUUU]    U: unwritten extent
       [--DDDDDDDD--]    D: valid data
          |<-  ->| ----> this range needs to be initialized

ext4_split_extent() first try to split this extent at B with
EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
ext4_split_extent_at() failed to split this extent due to temporary lack
of space. It zeroout B to N and mark the entire extent from 0 to N
as written.

       0  A      B  N
       [WWWWWWWWWWWW]    W: written extent
       [SSDDDDDDDDZZ]    Z: zeroed, S: stale data

ext4_split_extent() then try to split this extent at A with
EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and left
a stale written extent from 0 to A.

       0  A      B   N
       [WW|WWWWWWWWWW]
       [SS|DDDDDDDDZZ]

Fix this by pass EXT4_EXT_DATA_PARTIAL_VALID1 to ext4_split_extent_at()
when splitting at B, don't convert the entire extent to written and left
it as unwritten after zeroing out B to N. The remaining work is just
like the standard two-part split. ext4_split_extent() will pass the
EXT4_EXT_DATA_VALID2 flag when it calls ext4_split_extent_at() for the
second time, allowing it to properly handle the split. If the split is
successful, it will keep extent from 0 to A as unwritten.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Message-ID: <20251129103247.686136-3-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1a29c2056eef5..2d322b06ccd88 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3293,6 +3293,15 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 		}
 
 		if (!err) {
+			/*
+			 * The first half contains partially valid data, the
+			 * splitting of this extent has not been completed, fix
+			 * extent length and ext4_split_extent() split will the
+			 * first half again.
+			 */
+			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
+				goto fix_extent_len;
+
 			/* update the extent length and mark as initialized */
 			ex->ee_len = cpu_to_le16(ee_len);
 			ext4_ext_try_to_merge(handle, inode, path, ex);
@@ -3365,7 +3374,9 @@ static int ext4_split_extent(handle_t *handle,
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
 				       EXT4_EXT_MARK_UNWRIT2;
 		if (split_flag & EXT4_EXT_DATA_VALID2)
-			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
+			split_flag1 |= map->m_lblk > ee_block ?
+				       EXT4_EXT_DATA_PARTIAL_VALID1 :
+				       EXT4_EXT_DATA_ENTIRE_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
 		if (IS_ERR(path)) {
-- 
2.51.0


