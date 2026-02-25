Return-Path: <stable+bounces-219614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI/NFLj4nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F51980CC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73596310D76B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7F43B8D74;
	Wed, 25 Feb 2026 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcHPWWLj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298D34F49A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025786; cv=none; b=H7xUJK9ubybjSCTwBfsGFfYeceRcsqBpJ6RUiIgWqJ3XNascMnjE1CJz1O/+xLeO3hfTbC2ISxnZWHF8VccBrp6KAeDl0IfFBrYj45bTXgZQAKtgj/JBcUZzmGSdi4YZr2JR72Mj773iM4JCDk62mL1pjhWpbBdGb5LbA6jBs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025786; c=relaxed/simple;
	bh=SrwUEZ1QRmSoU7b+sfAjmjPwp14MhL0gHOo7VMx0V4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKnLlpDgXtsaXNmC99hIsjircNC9PNxtD+2/Vt1Sf16ofmTFB91rRu2EL8pSBKzixUjsRWYWY/McIa2ED+9FMuHgo99SXsxLNjXEF7EUjUA6J8U+A0+ICmUGCbP7u6NHE/Z9oougAit1MvCxP95328/GMFx+VWmAyMA6ow+0lF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcHPWWLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C93C19423;
	Wed, 25 Feb 2026 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025786;
	bh=SrwUEZ1QRmSoU7b+sfAjmjPwp14MhL0gHOo7VMx0V4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcHPWWLjajOn80FsVdXFn5mdBe12o5d+EZBa5Wnuy+NJxo5LnNjitM6OXR4VTdNNu
	 1x1nMrY0kcO2HMmte+wYjU04KvIZOHjKIvvPkB8coBsByTGRHR+KLRagn5qAXrm3zh
	 z6srIaOPdtY0qXAWDWRzsfX7QJwpfILjRL+uwpj9pjZHIUUoYq8ayQ108I3QYp9C4+
	 rK5xNu5Iin9yXpQQ8EDUYHNJGyNKDwZgbsTzoCyyfSVRY6gRyDh6PXhHtb/mXO8jSv
	 Y/AmQ6307Mncztbv6oMODFvXASRzxNNsDTKUlxX1UEgaxI6rHGuKt6fvc+mRjDXlb5
	 WozgbQSMq/4ZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gou Hao <gouhao@uniontech.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/6] ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
Date: Wed, 25 Feb 2026 08:22:59 -0500
Message-ID: <20260225132302.222887-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225132302.222887-1-sashal@kernel.org>
References: <2026022401-arose-calm-3e73@gregkh>
 <20260225132302.222887-1-sashal@kernel.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219614-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email]
X-Rspamd-Queue-Id: AC1F51980CC
X-Rspamd-Action: no action

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
index e44dd404fe407..11454fcee3a62 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1372,9 +1372,8 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
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


