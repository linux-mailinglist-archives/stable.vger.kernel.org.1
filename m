Return-Path: <stable+bounces-240786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CGqJkFy62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:38:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A145F43A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 476193029C3B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090D3D3D04;
	Fri, 24 Apr 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x9+CkSQ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677623645D;
	Fri, 24 Apr 2026 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037836; cv=none; b=uf6LntuGLDbDyWYoHy0bG1pa4imc15FfTGlbf8XVZwmH8uhrUs6uos3SX+TSMVumg34sdnuL9uu5LNyjVvfASosGyvJ45mxxOUJAACToEJFXUMHpFlpBAMtHMqRy5VIkkPP5ghIoquGynwDT/nSyvxvSE7D3QGJyEPSvyc+ymVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037836; c=relaxed/simple;
	bh=7wZDVrHq1U2e8qao3SHU2/sXDYweg0i3hZThqbrOEN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3uuhsDhvHqgWRxqIR6V6CmR/yUPLaQBDtTopXTKW0eerH0Db3n/XaWwLbnExLrs3TTo0ts+HjTU45lYXS1ceZLJCceJL4rN1VM7vJUrP36hiF0lI9PMiDY00Hzmzqo78g+8v4UmB9mQswtL5KmHc81tNAUxpRLDhqbYc1IXIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x9+CkSQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA1DC19425;
	Fri, 24 Apr 2026 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037836;
	bh=7wZDVrHq1U2e8qao3SHU2/sXDYweg0i3hZThqbrOEN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x9+CkSQ3ic04wm73CBmPNX7M2F9srY3gidIio5FpMybUCpCebcxew545YiX/NGDHF
	 8LsJguBKAq9z7hijCkBVLscHv/ByZRA0UoTp8bSxVfDHTX/N226Td+0KXFHEL62ZXG
	 /u4/hjsvOjpDTDfgJ1XBAtOPT5Z7z5I6tdCiTWgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 056/166] af_unix: read UNIX_DIAG_VFS data under unix_state_lock
Date: Fri, 24 Apr 2026 15:29:30 +0200
Message-ID: <20260424132544.553087501@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 117A145F43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240786-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,google.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiexun Wang <wangjiexun2025@gmail.com>

[ Upstream commit 39897df386376912d561d4946499379effa1e7ef ]

Exact UNIX diag lookups hold a reference to the socket, but not to
u->path. Meanwhile, unix_release_sock() clears u->path under
unix_state_lock() and drops the path reference after unlocking.

Read the inode and device numbers for UNIX_DIAG_VFS while holding
unix_state_lock(), then emit the netlink attribute after dropping the
lock.

This keeps the VFS data stable while the reply is being built.

Fixes: 5f7b0569460b ("unix_diag: Unix inode info NLA")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260407080015.1744197-1-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/diag.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index a6bd861314df0..169d068064bba 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -26,18 +26,23 @@ static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
 
 static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
 {
-	struct dentry *dentry = unix_sk(sk)->path.dentry;
+	struct unix_diag_vfs uv;
+	struct dentry *dentry;
+	bool have_vfs = false;
 
+	unix_state_lock(sk);
+	dentry = unix_sk(sk)->path.dentry;
 	if (dentry) {
-		struct unix_diag_vfs uv = {
-			.udiag_vfs_ino = d_backing_inode(dentry)->i_ino,
-			.udiag_vfs_dev = dentry->d_sb->s_dev,
-		};
-
-		return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
+		uv.udiag_vfs_ino = d_backing_inode(dentry)->i_ino;
+		uv.udiag_vfs_dev = dentry->d_sb->s_dev;
+		have_vfs = true;
 	}
+	unix_state_unlock(sk);
 
-	return 0;
+	if (!have_vfs)
+		return 0;
+
+	return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
 }
 
 static int sk_diag_dump_peer(struct sock *sk, struct sk_buff *nlskb)
-- 
2.53.0




