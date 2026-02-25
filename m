Return-Path: <stable+bounces-219118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BMEJMFbnmlrUwQAu9opvQ
	(envelope-from <stable+bounces-219118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:17:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17148190CC0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42C2A30D0252
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE1252917;
	Wed, 25 Feb 2026 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVmMRU/Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A821257E
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984694; cv=none; b=NvqO4RBMQR+Hl5onu8+AaV9Az11MaXLG+2w1kQhfR1vZdos8cRpjS+uxV/TyQN6i9BT6EeUQL3hDjaDr9NP4h24zTIhkXaWyNCypukoCeI8w8zcTZgUMU/g751RhFm7nrI0b2coY7jrJ9GXmIQFzUWXsPQqKq9DQM1tSKWylkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984694; c=relaxed/simple;
	bh=+Wog90o4pOqSfp7X7/ITVQijS7ydBmsWDfJZxNAKwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtqFm/L2hazC4hMllAAI+gLVYCp9qDdP8+CdQYjZVUk3lSMZNsuMfLUyJS/IsER9LXggcrYNoKGMYarUqNwcNP1XPiFbfnGCWDym7ph82IOYRGI9AdYpu8EUB6L0JXywzHV19oTtGiDtuMTnGAHY7+R6YdSZs9pp898+7A3BGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVmMRU/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91156C116D0;
	Wed, 25 Feb 2026 01:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984694;
	bh=+Wog90o4pOqSfp7X7/ITVQijS7ydBmsWDfJZxNAKwcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVmMRU/QJG0t3dxyxtPjHF3m69WqQmof0mWUFPTBP7bz8rqmmbiVW3ujoVOOOKf6Y
	 DgYXsWttebqWUc2ovcTxQrFlpMQ66Qpc/rE7PMYoAVa658/NZMg8PNfZyniPRVN+hG
	 /AGz1xtNJCrDkykrEblRH7uITTjrwEKRYHu2jdy9mADUaBJeefugQ4lQZRtR3qDaDN
	 wOe+iwZMiePg2/G6s1cgq0aZijfdQgtOHi8TfyyZCxjS7AQdVeG/ppOCVQbQvjhxfX
	 AwWI73gBT2PomhOhDQAGnqJlrRIOv6QK7l7p2Tjfaim2AYYEYeRpcXtDEu0FxFyzXp
	 nJR1XPELIJUjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Erkun <yangerkun@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] ext4: correct the comments place for EXT4_EXT_MAY_ZEROOUT
Date: Tue, 24 Feb 2026 20:58:09 -0500
Message-ID: <20260225015811.3777135-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022419-bonsai-gorged-49c6@gregkh>
References: <2026022419-bonsai-gorged-49c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-219118-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 17148190CC0
X-Rspamd-Action: no action

From: Yang Erkun <yangerkun@huawei.com>

[ Upstream commit cc742fd1d184bb2a11bacf50587d2c85290622e4 ]

Move the comments just before we set EXT4_EXT_MAY_ZEROOUT in
ext4_split_convert_extents.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
Message-ID: <20251112084538.1658232-4-yangerkun@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: feaf2a80e78f ("ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2f9c3cd4f26cc..35c6511c4a753 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3719,10 +3719,6 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 			>> inode->i_sb->s_blocksize_bits;
 	if (eof_block < map->m_lblk + map->m_len)
 		eof_block = map->m_lblk + map->m_len;
-	/*
-	 * It is safe to convert extent to initialized via explicit
-	 * zeroout only if extent is fully inside i_size or new_size.
-	 */
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
 	ee_block = le32_to_cpu(ex->ee_block);
@@ -3733,6 +3729,10 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 		split_flag |= EXT4_EXT_DATA_VALID1;
 	/* Convert to initialized */
 	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
+		/*
+		 * It is safe to convert extent to initialized via explicit
+		 * zeroout only if extent is fully inside i_size or new_size.
+		 */
 		split_flag |= ee_block + ee_len <= eof_block ?
 			      EXT4_EXT_MAY_ZEROOUT : 0;
 		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
-- 
2.51.0


