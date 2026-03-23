Return-Path: <stable+bounces-229566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKU9FypywWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:02:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA02F9559
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 653BA3059DFE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E128506C;
	Mon, 23 Mar 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IE8x6Y4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA2284881;
	Mon, 23 Mar 2026 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282267; cv=none; b=UegOJK/eUSU9pRg1Y37sMAmh5pqhDvsAWhLrNftKnuuSqmyeHT1BjE1KjuNQf0Ugsj+uwgA1Q6y42NQP+2Bj/nMcqh1TvMcU4yjhnUshwt3SL7nSqjnNpWFnSPbnVwa0cv8XOLwApnhCPep+lst8EOi8pffisc0bbwc6ns5SH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282267; c=relaxed/simple;
	bh=CaKjdepu4vgGoQgmu54JWLJPXS8ysGGaYA0b36EhQJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr7NokTorLO4XQlNspfmM+jeH33+mBBi7JpM6dcVdQ3YgK3heOa1GJTcwa1OjSZB2Fj99mLORotmqqQW/1ZU/WF+BVbT1SgeTPQ9NwyTEKJMbK5//OJoYZGULf/0e9464dVs3B34Sj2SM4TFBd7UtP9tdAkDGi1WAm48TBjKFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IE8x6Y4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F23AC4CEF7;
	Mon, 23 Mar 2026 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282267;
	bh=CaKjdepu4vgGoQgmu54JWLJPXS8ysGGaYA0b36EhQJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IE8x6Y4AsBZ59WGQ3EifF3wHddJO0BY7Eg3MZrGhWAQibLwzsWTHGNZmE3r6FBjuz
	 x1xgGgx6j5O2gEhtLCemOkW1pw6TYAVk32uBf2kPqm5uLGR4WjgP601Yp77lmifo74
	 z4MFJIqaeT4jpG5MppGgkBnOP9bEvYtPJOMHgBFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gou Hao <gouhao@uniontech.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/481] ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
Date: Mon, 23 Mar 2026 14:40:32 +0100
Message-ID: <20260323134526.447604596@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229566-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E4AA02F9559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gou Hao <gouhao@uniontech.com>

[ Upstream commit f2fec3e99a32d7c14dbf63c824f8286ebc94b18d ]

'blocks_per_page' is always 1 after 'if (blocks_per_page >= 2)',
'pnum' and 'block' are equal in this case.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231024035215.29474-1-gouhao@uniontech.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: bdc56a9c46b2 ("ext4: fix e4b bitmap inconsistency reports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2a385dc610704..899d7eb6df3dc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1370,9 +1370,8 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 		return 0;
 	}
 
-	block++;
-	pnum = block / blocks_per_page;
-	page = find_or_create_page(inode->i_mapping, pnum, gfp);
+	/* blocks_per_page == 1, hence we need another page for the buddy */
+	page = find_or_create_page(inode->i_mapping, block + 1, gfp);
 	if (!page)
 		return -ENOMEM;
 	BUG_ON(page->mapping != inode->i_mapping);
-- 
2.51.0




