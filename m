Return-Path: <stable+bounces-220368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPXtNME1o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3AD1C606C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96B7C3185CD4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5613A3506;
	Sat, 28 Feb 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXj1vy/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29EF480344;
	Sat, 28 Feb 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300265; cv=none; b=MIA61EBdnoAt7Sy7s6OLAtdcSC+ohoXAEUs1FaS8oWt20VnStdC1jharfiJX/Tm9PWniajwoWjztRXWrx87cCFq27J09Woh0/Cek/ORvpooyqUGU86gRDRiT+pquKU8H1tx7dDETV31RBHA4vUHGhmqpY6TZnFm1RfHBPDb1d7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300265; c=relaxed/simple;
	bh=SKznDw+zv8hk4XVrg19OWTArrehnlIBvaSZw+NYYqQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dElatXuRNrcx8j7jgqwI5UZCOMfeVv5PzdroXKGBHBITDR7KgGKAtOMGKzafd3OUO4+E8jsoj3EVYi127IwNrfYILQqDGSSWj3jmdVdBFROhSw3a4SU1erXcndqRFs0QOfonLyDsRHI603ZF4TjHA/SA/u5ABSNWUj2WH9d68Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXj1vy/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1522C2BC87;
	Sat, 28 Feb 2026 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300264;
	bh=SKznDw+zv8hk4XVrg19OWTArrehnlIBvaSZw+NYYqQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXj1vy/3P1U1WvuNkzXVx1fRDj7VtyTowL8RR1VrhuP7RJLJymFtfeBlpPRWjtz5C
	 NnCy/p75hIB5CHbVXvKthwVncQOLzqKTbFJBHV3TJdGt+Dx/L6k+YMdAhdNLvtS9eg
	 EDUZZ2C7b1LTzXQXRMLIdjHntUd2ZzNiN/si7/pHm/sVgE/GhFA8gx8tFkJPgMql74
	 TRuAYAl77En3Jm/mXFgiyvn2r7RsNB7lwd38MtuFs7eDsgCFDbL4YV9xsUJWI7+LTo
	 m3o17lALER+C3f9dXUCDLXiM25e2dDsgEbpzV+nB61ChD2B8maX7aL0UAeykjFV9lM
	 xzj6zI8nB8Bng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 290/844] ext4: use reserved metadata blocks when splitting extent on endio
Date: Sat, 28 Feb 2026 12:23:23 -0500
Message-ID: <20260228173244.1509663-291-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220368-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1B3AD1C606C
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 01942af95ab6c9d98e64ae01fdc243a03e4b973f ]

When performing buffered writes, we may need to split and convert an
unwritten extent into a written one during the end I/O process. However,
we do not reserve space specifically for these metadata changes, we only
reserve 2% of space or 4096 blocks. To address this, we use
EXT4_GET_BLOCKS_PRE_IO to potentially split extents in advance and
EXT4_GET_BLOCKS_METADATA_NOFAIL to utilize reserved space if necessary.

These two approaches can reduce the likelihood of running out of space
and losing data. However, these methods are merely best efforts, we
could still run out of space, and there is not much difference between
converting an extent during the writeback process and the end I/O
process, it won't increase the risk of losing data if we postpone the
conversion.

Therefore, also use EXT4_GET_BLOCKS_METADATA_NOFAIL in
ext4_convert_unwritten_extents_endio() to prepare for the buffered I/O
iomap conversion, which may perform extent conversion during the end I/O
process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20260105014522.1937690-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 18b39eed75267..418c4351ef40c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3809,6 +3809,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	 * illegal.
 	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
+		int flags = EXT4_GET_BLOCKS_CONVERT |
+			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
 #ifdef CONFIG_EXT4_DEBUG
 		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
 			     " len %u; IO logical block %llu, len %u",
@@ -3816,7 +3818,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
 		path = ext4_split_convert_extents(handle, inode, map, path,
-						EXT4_GET_BLOCKS_CONVERT, NULL);
+						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-- 
2.51.0


