Return-Path: <stable+bounces-251545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK4XF/r1DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:57:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B798594F7C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63DE031BCEAB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ECF36F421;
	Wed, 20 May 2026 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6VMBJ4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789492367DF;
	Wed, 20 May 2026 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298258; cv=none; b=S8zJL2ivWfcWy2e1rk5lCL7oGOyd4Ze+stVQTNtgvOZ9Sy93DZkkHSNPvFfxFZDaGVwLtnUumkm5KeDNv79egmzYpP62F24CN8hSYEAzUrE6kezYCLN6Tb5LBl1RA5sIGQxwuxq0IDyFQdA9r6+2WV2M3beRVIGWbFmKWmG/YFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298258; c=relaxed/simple;
	bh=AB2Yd5vD5v3BWPQEp3e7D01/A5FK1HdvnsjHoiXtH3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIDuEyi8cd1eyHSg1rwjX3e8aGUfflSmKIXFScxjdt2tYxMFbtTXUupqao6GK5EpCXs/UlPXPTVd0Cu/IoZgHChVhI6yOxaDrEEzwIKmnnnfnCfvehdCXK7tCqEUK7h4ZEDXY0/4OtAQ6tEO+WE2DgmnKBYNUPUsKY2J0dgFKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6VMBJ4U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF7A1F000E9;
	Wed, 20 May 2026 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298257;
	bh=sD8YefttCSAdPU9cRB0kW6tdVOGEDXtOCUoFjJrNpzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b6VMBJ4U31vPhFb9ohKQ443A1ya28rxU/7OgzX1mFl3dxDegGPrOA/LWQuR4DLSsz
	 nUzfBKRtlsf9wekYAZpQNso0ACM9I3STJywGkosIWkK3b7Wj2uCnhwPYC0KLYns0d6
	 /SbVh3E6mk9RFB+DhjCWSlAiCEzzgyglN0tvJP40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 341/957] gfs2: Call unlock_new_inode before d_instantiate
Date: Wed, 20 May 2026 18:13:44 +0200
Message-ID: <20260520162141.927769497@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251545-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,0ea5108a1f5fb4fcc2d8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2B798594F7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 2ff7cf7e0640ff071ebc5c7e3dc2df024a7c91e6 ]

As Neil Brown describes in detail in the link referenced below, new
inodes must be unlocked before they can be instantiated.

An even better fix is to use d_instantiate_new(), which combines
d_instantiate() and unlock_new_inode().

Fixes: 3d36e57ff768 ("gfs2: gfs2_create_inode rework")
Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-fsdevel/177153754005.8396.8777398743501764194@noble.neil.brown.name/
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 03dd54fb7e8c8..12e5792190650 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -892,7 +892,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		goto fail_gunlock4;
 
 	mark_inode_dirty(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	/* After instantiate, errors should result in evict which will destroy
 	 * both inode and iopen glocks properly. */
 	if (file) {
@@ -904,7 +904,6 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_glock_dq_uninit(&gh);
 	gfs2_glock_put(io_gl);
 	gfs2_qa_put(dip);
-	unlock_new_inode(inode);
 	return error;
 
 fail_gunlock4:
-- 
2.53.0




