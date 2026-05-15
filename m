Return-Path: <stable+bounces-248118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EewDxtIB2rUwQIAu9opvQ
	(envelope-from <stable+bounces-248118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:21:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C58CB553184
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E11D30A7E75
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB23B0ADB;
	Fri, 15 May 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsvwVhAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4A3FF1AD;
	Fri, 15 May 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860918; cv=none; b=MRQwLRf9ogmnd0Pc3YgeUqEiXx+BXiD7M+fD7cujwAxf4uYxKl/iLxAauh4609LwBSvLCaT/2q92gFIjv5jYL0/zpLKfAwSN1HuyTlhjBkoQJImwqF+c4EdLRQw8ai9xfBGuECPe1PQxniiYyN62HYHO4oszphF1I7FfIWjMlFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860918; c=relaxed/simple;
	bh=DWFq06wH4MzNX+WA2DSCie7nv3Qf65cAnviDRo+y0lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cej9gr4ndaqQOx1GvWs0ysKaZBPdntx6poSeEq61JGNE62Dm4PjNuLCXx2wKop3TaG4Ie8pbq1sblEsuXEGhNrxXgFusMeY6MTTeQJ2ockycp9yb0OIL5JkCEnERuQ1EHGoQr3TFsoGvWYFRJ7/7W2qkjV7MUmQfWlbKvp0LIFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsvwVhAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C1CC2BCC7;
	Fri, 15 May 2026 16:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860918;
	bh=DWFq06wH4MzNX+WA2DSCie7nv3Qf65cAnviDRo+y0lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsvwVhAzCvhm6zrZLR7Z1mzYUSxplGT5My2DuSqAO4pZuNXi6NR2WM2LMKByk+wgQ
	 2uZz0tUUez7JxoPsxaSQI442ocnB8faKYrhkiXCnB25bsBC0wj8txLjR4JLHsBtFuT
	 nxwLtscCyo85oVEGj3w/jwgMpJz+Hh6laTC+ZBfY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sohei Koyama <skoyama@ddn.com>,
	Andreas Dilger <adilger@dilger.ca>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.6 112/474] ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()
Date: Fri, 15 May 2026 17:43:41 +0200
Message-ID: <20260515154717.459928818@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C58CB553184
X-Rspamd-Server: lfdr
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
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248118-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,ddn.com,dilger.ca,gmail.com,huawei.com,linux.alibaba.com,mit.edu];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,huawei.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ddn.com:email,iloc.bh:url,dilger.ca:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sohei Koyama <skoyama@ddn.com>

commit 77d059519382bd66283e6a4e83ee186e87e7708f upstream.

The commit c8e008b60492 ("ext4: ignore xattrs past end")
introduced a refcount leak in when block_csum is false.

ext4_xattr_inode_dec_ref_all() calls ext4_get_inode_loc() to
get iloc.bh, but never releases it with brelse().

Fixes: c8e008b60492 ("ext4: ignore xattrs past end")
Signed-off-by: Sohei Koyama <skoyama@ddn.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Link: https://patch.msgid.link/20260406074830.8480-1-skoyama@ddn.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1165,7 +1165,7 @@ ext4_xattr_inode_dec_ref_all(handle_t *h
 {
 	struct inode *ea_inode;
 	struct ext4_xattr_entry *entry;
-	struct ext4_iloc iloc;
+	struct ext4_iloc iloc = { .bh = NULL };
 	bool dirty = false;
 	unsigned int ea_ino;
 	int err;
@@ -1260,6 +1260,8 @@ ext4_xattr_inode_dec_ref_all(handle_t *h
 			ext4_warning_inode(parent,
 					   "handle dirty metadata err=%d", err);
 	}
+
+	brelse(iloc.bh);
 }
 
 /*



