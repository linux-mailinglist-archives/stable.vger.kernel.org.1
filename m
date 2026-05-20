Return-Path: <stable+bounces-253059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ4fN8oaDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-253059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BB7599C7D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8447932F9201
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC233F660B;
	Wed, 20 May 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1PlOK8zj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C73E277C;
	Wed, 20 May 2026 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302296; cv=none; b=XhiQShV8jQowoCNgfxKOWOuea1tfNDOiNYgafQPq+6mX+CSuU2q0Mhz/TpKhzCTG6dJ1ooCYcphgZHxnAJjUo5/X0TR+TkjLAfeORyTbeif5nOQsA0uksG6+qRtQCBW4lYC+CSkaueDUljMHY9FN8CyaeRkIk6X/RIttHUtqXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302296; c=relaxed/simple;
	bh=2a6aCUz0zYyq+X9SJt7UEHzIQwzWSc3ELWC23qNdfwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kdeb+v6k50IhtY1UAIOyLK94YqNghChy4dcWM/PwkncULZw/OWHUYbNne/Vyrttf1A4dGk9w8Qddvk4cv2w+Cjfw9rn+pue6ia8IdYCEednX+NwnihYX38HAiVcKh52Yh5ivcqO6NK7MUHs/bjnZn7L6T+b1t7FJgafUBnR4vCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1PlOK8zj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424681F000E9;
	Wed, 20 May 2026 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302295;
	bh=9zGl7Fr4g4dUndDGeyUpwcAXBWgYZIy1XTfnM4/Lz8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1PlOK8zjMgwq73rXU8xsB9ynT90OHadMa06rJw2sfyLvrn8kXgJmt2P8Hc2wAgDYV
	 UcUAkEnamTh6doRxl3uctJCb4ZVcdrJjvaznMkns9LkUlKtpkDD7pFR6UD9zWVEMbF
	 2zbSePXHaTr6fsdiKhY4FrBDx4Dl+8lRapaxvQe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 172/508] gfs2: Call unlock_new_inode before d_instantiate
Date: Wed, 20 May 2026 18:19:55 +0200
Message-ID: <20260520162102.364971216@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253059-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,0ea5108a1f5fb4fcc2d8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D1BB7599C7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 45040622d316e..18f75beea0890 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -805,7 +805,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		goto fail_gunlock4;
 
 	mark_inode_dirty(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	/* After instantiate, errors should result in evict which will destroy
 	 * both inode and iopen glocks properly. */
 	if (file) {
@@ -817,7 +817,6 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_glock_dq_uninit(&gh);
 	gfs2_glock_put(io_gl);
 	gfs2_qa_put(dip);
-	unlock_new_inode(inode);
 	return error;
 
 fail_gunlock4:
-- 
2.53.0




