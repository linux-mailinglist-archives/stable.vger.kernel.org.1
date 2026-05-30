Return-Path: <stable+bounces-258739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E7qMAsrG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:23:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E1611A16
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 583B3300468E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFE21B191;
	Sat, 30 May 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UipgmzbP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8217555;
	Sat, 30 May 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165376; cv=none; b=Jgipw/6NnRxjM1UlcZ/wpRJ1sjnbnLZcWS8yuqcPydi277OaUGmlUAiY4KZ/2is8UwksgQwXJDuOLJUDYx2hmVCXvONfFeYmmnCjn+deErAsBDK+5N5X3HuWTo1cyY+3sot2J53rAgJFrU5L6yT21WU8jqkOta2wiX1rL5CEiu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165376; c=relaxed/simple;
	bh=Nme/Ol/GYU2uCjXGdcUpmGDjuclTJtzivUQy1juhLLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX5H/hKYRV9EEXWT3DjXryYILLTgcIAONhxF25sEaHHcld2ec14l5FK3RtktZ+pqx4kygk5tVWS/hPmZKenxR9kTmDLYmcxtkW/PjHPJWHh7/tr/46oKCu7oBOC5jDYshghV2bVAl11qEltmqNePoNXk3w9dS6ORU55OJOWuTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UipgmzbP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33F31F00893;
	Sat, 30 May 2026 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165375;
	bh=qUWvIMTUnggbrSheLkzXUweUOh0iGYGuwCAlzaxLGVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UipgmzbP/tsTfn5Vq+GjPVSEsnhjhEAr9QPlkQeyAQHxZkeLam8fGqviCSIA4o5fv
	 jOWB7O727A6zUkAGQVMfmWqga9Pxp9MN8Y1mQuxHFLzAOyKMc+yqFldGv56HzCeP+J
	 voLigp20EnlDpyxfnmL5FEZjtI/r+3gz7jIBKecI=
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
Subject: [PATCH 5.10 032/589] af_unix: read UNIX_DIAG_VFS data under unix_state_lock
Date: Sat, 30 May 2026 17:58:33 +0200
Message-ID: <20260530160225.428735666@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258739-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,google.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C20E1611A16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 486276a1782ed..699fba7b7591d 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -25,18 +25,23 @@ static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
 
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




