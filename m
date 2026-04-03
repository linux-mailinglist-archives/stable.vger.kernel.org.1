Return-Path: <stable+bounces-233179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPwSO+epz2noywYAu9opvQ
	(envelope-from <stable+bounces-233179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:52:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60376393D02
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519B23024113
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB33BC680;
	Fri,  3 Apr 2026 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwcs7qHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2843BAD88
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217030; cv=none; b=nfnzA3XsJdYKHSqXq5a+bW1sqih8/wAdqZfpe9TGUs9lo+c0E06Ew50LxS5lDXVa+3oFekH9+NGI0Ky8C9bmbbxCJP208moG55zSnHiWg4zqEvm4ftlSz5Any9Db+jR/H0EQv9cImGO2mN81uwP/ZyyIrBH1Tk++pa5nWPjx83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217030; c=relaxed/simple;
	bh=D0MM/bivFIpoXHBs8eRKn1Kb1rdqGN6NYJhogEsRtUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrfULuwrDmdajLAU1E68WPV5QIhsabSoYky5H+3r9yCBcGfuOZV3J8f8hup8Je1A64AUDrgAPI97FLQ4OfLqJRhelNX2MoLgH+VIqVV+75BkuB5G1uLlhzS7Bvt80NHbDiWThCW8u17X64RQoY9f8wZ+Eax12qBs0O7w4h2EEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwcs7qHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A956C4CEF7;
	Fri,  3 Apr 2026 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775217030;
	bh=D0MM/bivFIpoXHBs8eRKn1Kb1rdqGN6NYJhogEsRtUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwcs7qHJjxFlCgas1utn4bmUB0twuCN1xyYViP5wUzBgvLar76tgixiGSfiEyvgbd
	 Ms/jiCpRRPPPGj1sEsTaba2YfUAS4I3OQbPtd7eKL+KeiSJxvH3ZU8pn4gbnVX+1Yh
	 UCcetvGr8M4ZTwSL9S//uUk84c0OqI8mZVH9cFqfG7MkEs0DuLQ9jiiBJe1qEXCUyH
	 vtVgNFHZQb0bevw+3ZtDAmHxMzSVhJWQoydHBKxLDYGgR5RjYHUi1vYHgz3CsdJUiw
	 FfCeG2kfZ6oXUt34TxSW+tx1oKshpoPncwVSwZd5gQ/ygIaM45b7cCtbCTw95AqrSu
	 Wwr9mcbAuHITg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun@linux.alibaba.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ext4: handle wraparound when searching for blocks for indirect mapped blocks
Date: Fri,  3 Apr 2026 07:50:27 -0400
Message-ID: <20260403115027.2051682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033043-showbiz-unruffled-5462@gregkh>
References: <2026033043-showbiz-unruffled-5462@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233179-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,suse.cz:email,alibaba.com:email]
X-Rspamd-Queue-Id: 60376393D02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit bb81702370fad22c06ca12b6e1648754dbc37e0f ]

Commit 4865c768b563 ("ext4: always allocate blocks only from groups
inode can use") restricts what blocks will be allocated for indirect
block based files to block numbers that fit within 32-bit block
numbers.

However, when using a review bot running on the latest Gemini LLM to
check this commit when backporting into an LTS based kernel, it raised
this concern:

   If ac->ac_g_ex.fe_group is >= ngroups (for instance, if the goal
   group was populated via stream allocation from s_mb_last_groups),
   then start will be >= ngroups.

   Does this allow allocating blocks beyond the 32-bit limit for
   indirect block mapped files? The commit message mentions that
   ext4_mb_scan_groups_linear() takes care to not select unsupported
   groups. However, its loop uses group = *start, and the very first
   iteration will call ext4_mb_scan_group() with this unsupported
   group because next_linear_group() is only called at the end of the
   iteration.

After reviewing the code paths involved and considering the LLM
review, I determined that this can happen when there is a file system
where some files/directories are extent-mapped and others are
indirect-block mapped.  To address this, add a safety clamp in
ext4_mb_scan_groups().

Fixes: 4865c768b563 ("ext4: always allocate blocks only from groups inode can use")
Cc: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://patch.msgid.link/20260326045834.1175822-1-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e9be0c0a8042c..73b27ddafe915 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2892,6 +2892,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 * from the goal value specified
 		 */
 		group = ac->ac_g_ex.fe_group;
+		if (group >= ngroups)
+			group = 0;
 		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
 		prefetch_grp = group;
 
-- 
2.53.0


