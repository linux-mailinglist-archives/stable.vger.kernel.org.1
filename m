Return-Path: <stable+bounces-219181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFBvBLpvnmkvVQQAu9opvQ
	(envelope-from <stable+bounces-219181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:42:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BEE191420
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B802B300FEE7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4E02BD00C;
	Wed, 25 Feb 2026 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCWTFbSg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287879CD
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990965; cv=none; b=l6G40/mEWomnrYHTg3pCGtvCNjN3c86a0KuY4RtSxN+WGuaHBqc2lTVoD8sumJ0piOjaMV87D+MXK/IhxU2CkvWgC8nPsYbfG+BRA7hDBb8YmQIWNplA3A4xtUNdBcTmng2bI4j9uS70PeP46E85l0M5CABGv76YWucvh44p/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990965; c=relaxed/simple;
	bh=TkwQ6FzHt8vixhmtJ+Xw6L/HCerDWBm82ycMPIEDalE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWZ/MOe2RBhg+8jJlCCwwiQSVtvTSoofZJaD3ThPLq0RiQKvrE+te8+vz12xie8HrNRBTGpnCq0QH+0alTTsmtws07xqBOY0Fot4hCxob0jCCUBbsMlxFEJJ9lBUtO8P9ZxB1qsKyxndJPu44Z+5NMiXvy5T6dqYfXvmVFJ+84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCWTFbSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2BDC116D0;
	Wed, 25 Feb 2026 03:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771990964;
	bh=TkwQ6FzHt8vixhmtJ+Xw6L/HCerDWBm82ycMPIEDalE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCWTFbSgt0VY9wJGccV/i8YIulpkm6m97qKP3ZKsDrUAtEwftvAlel/iomfmVtfk9
	 Nvr9y1HxpHADSYEVthyxaNiWQBHfwsAIAP3WvhqPH2m9RdOAei3Ns27AFxFCE6+K29
	 xALVjPAKn81NoIwhMu1lcXhA/7KV5N1K/021S+BI+i4VaHWud8eoP5Vp6+HcDHmhix
	 rrv6cQhbZu742VrR4V7SHy8xTx3t7Qu+r3wEsqzMw+qBuUW/UengFVGR9aMl0GDjFo
	 oCFRyiTCd8D4dOcvaydsLKco6lwFP5EAQws1sJwpMTS0kXolT3l3KbHkKLumLWzJ/b
	 RPWV8cpzCA/Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gou Hao <gouhao@uniontech.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
Date: Tue, 24 Feb 2026 22:42:39 -0500
Message-ID: <20260225034242.3893844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022400-riverbank-wavy-2e99@gregkh>
References: <2026022400-riverbank-wavy-2e99@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219181-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 30BEE191420
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
index 5ba161bd66a3e..2a80c587ec7c9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1488,9 +1488,8 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
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


