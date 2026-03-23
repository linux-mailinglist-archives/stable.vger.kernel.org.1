Return-Path: <stable+bounces-228979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNdKCihrwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-228979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:32:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 937102F847D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296E93311ECC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858E3AEF51;
	Mon, 23 Mar 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cc7unCHs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1F3AA518;
	Mon, 23 Mar 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277675; cv=none; b=QoHAVMDFxB2c5Z1xH7/qy7cB6sAebVJD95RHIjW9RWOCEqmNZibJBZTIb0bvy0Cy6y55+uW0NXjetcD9Qgesm12C//BtaR3SzUypsVjXh8dB2A7p9StAism9Li/NQT1wOuh0bkIxlIj11cDKi6PkNvRoKq81biWhWMLQLJmKKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277675; c=relaxed/simple;
	bh=u2bmWsQ50Qp+KL1jlHs5At5tg63XhWc4wGTs9ZLItJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siHMY+NDu0+D1+PGKLDHM2y3F0/e4JyfFycdIXRG5hSs2KRDTJ75+GkV0+n/W6RJATefJypcst1j2wpNksUJc+odEKynx2/rnmHbDLhmLLi/S33F26ZH/qoBk43dxufCOfwr4nj2KcwqG6hgtiN9qYcSug+2GfNWFtW4No+zQf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cc7unCHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8619C4CEF7;
	Mon, 23 Mar 2026 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277675;
	bh=u2bmWsQ50Qp+KL1jlHs5At5tg63XhWc4wGTs9ZLItJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc7unCHsLEbOudzxmDFUKnpF8iky8Pm0Hgmt7G5OIuFv2z80XqfXOtyenb6mtM2qc
	 ONvz9GmvRmGFWJB6KaiX1LUUHHG+oltD9MXhIAAcLHPSbbPpVX0X59JeroLJwyqst2
	 aP8DIOEpIA+2r2wI2gaDpaunj7/zRDnJPUoInvxs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gou Hao <gouhao@uniontech.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 067/567] ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
Date: Mon, 23 Mar 2026 14:39:47 +0100
Message-ID: <20260323134535.478400614@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228979-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 937102F847D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index d095c4a218a3a..ade2090155c1c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1486,9 +1486,8 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
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




