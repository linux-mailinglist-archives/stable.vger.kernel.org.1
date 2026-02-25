Return-Path: <stable+bounces-219623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKj1I3z+nmlAYgQAu9opvQ
	(envelope-from <stable+bounces-219623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:51:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08843198624
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D0173022553
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41F3D3001;
	Wed, 25 Feb 2026 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aID5Th/L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C253AEF34
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027219; cv=none; b=IeSIE0Ve81mpJBNlrRgQhwSYm5AlZmVb7o+OUdv43suKr4pp/c2DzfcgZXuQGN0YJYXpQkPe2s1efcP0gg9T1HnXNkD0a20NKfr6V1JdJV+WyixA21ljV2cRWHgYOW1tp5BPTObBNQv/32bsBD8TqGMO98ODAkzEpYxTPFr5xno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027219; c=relaxed/simple;
	bh=Qj5apVDtw0K3bVWdedzOk8xY5qcNUSkKm8wAKY4Fezc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ/NTfznUAalIhrguuLFKOXNi76GbGcgDfeW8OlRlFk7+WntFDSo7Lahy2w+pDLoBvyJefh/1K2/36sm+2YgEYhf0iRvjeRBH0ITT36GGkS2Q/WZNWpKc55zdiJ1u5eqvXNNWF8ZZ7YTvCtQi7ME6OrbnSpt6ctHFh499dj2kNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aID5Th/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76A5C116D0;
	Wed, 25 Feb 2026 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027219;
	bh=Qj5apVDtw0K3bVWdedzOk8xY5qcNUSkKm8wAKY4Fezc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aID5Th/LAsrRB4G58AnkV8FEc11Cvvb5OLuNK5m0RmC3cKvgVH3Yz6/C8wrmjtSsu
	 rfN8LD8moCOKiiT/iCjZVlZMhEZdWg01PuwZ8b/QIz08yXNpsv5qrjomsfMO6iEThq
	 W3tHyqlxSK2NpE7GpN805ABDXTXkfIHMjp1Q0mvF26Hfchn8i0lTYIfh7nU/uCYW2P
	 FxOrkuT4OJpdPlHKPTTIT7cwQwDpX+WLrbb3EZplxJhHO14TTi0oQm2kZY6cUwUNbC
	 giKHHZeMqAkVdUUeJDFLPLwX2+4j72zNlcUWlimpH1UohQNTPLbGfc/gT/s6i+ltcW
	 EBidPF/2gwTyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ext4: drop extent cache when splitting extent fails
Date: Wed, 25 Feb 2026 08:46:56 -0500
Message-ID: <20260225134656.309822-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022429-decline-tucking-14ad@gregkh>
References: <2026022429-decline-tucking-14ad@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219623-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:email]
X-Rspamd-Queue-Id: 08843198624
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 79b592e8f1b435796cbc2722190368e3e8ffd7a1 ]

When the split extent fails, we might leave some extents still being
processed and return an error directly, which will result in stale
extent entries remaining in the extent status tree. So drop all of the
remaining potentially stale extents if the splitting fails.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Message-ID: <20251129103247.686136-8-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ bring error handling pattern closer to upstream ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 35bc58a26f7f4..4da75cd7fcfda 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3233,7 +3233,9 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+	if (err && err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+		goto out_err;
+	if (!err)
 		goto out;
 
 	/*
@@ -3249,7 +3251,8 @@ static int ext4_split_extent_at(handle_t *handle,
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		return PTR_ERR(path);
+		err = PTR_ERR(path);
+		goto out_err;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3305,6 +3308,9 @@ static int ext4_split_extent_at(handle_t *handle,
 	 */
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
+out_err:
+	/* Remove all remaining potentially stale extents. */
+	ext4_es_remove_extent(inode, ee_block, ee_len);
 out:
 	ext4_ext_show_leaf(inode, *ppath);
 	return err;
-- 
2.51.0


