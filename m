Return-Path: <stable+bounces-198082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460AC9B6DA
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9540A34225E
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFAE272813;
	Tue,  2 Dec 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LIW7qHmN"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9D1C84D0
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677096; cv=none; b=unneyocviJB/00MbKptpePD01wvTMbuqfrvA6JvgP3kU9sVqEZp7aoncvP3CRiC5qO14RXpVwrMts3SNyVJ3um95ckglzGL3lxgfLBNpMgorA8B1Y0P0QYktJY3J3bONTIt9iX9L0AlGz8c/Tpet1aab0fvNa0XYkofPRIaEPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677096; c=relaxed/simple;
	bh=jl3x1VDBydpWphjV4ZdL66FlkOvIBFLrA82qpJOrg/U=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YWqKhAaAbW0VsxIKQjKZwWFaBhrYLhyNLycli1aLM7AQryKWiIOSmEKwEWnA5T1bW/7S5BIx+dXcA3K8R/TKFnpCEuWeNzX6/NT4XslNeSGUdwQ/0vER75qS68TjgvG3XtF/olrym43KKJyD48w44VQt2rX6kuA95XRt3JgyUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LIW7qHmN; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764677083; bh=2PBc9D+z7keebTpyrXgs9nGaKHouQRsHimPICn/Nbqg=;
	h=From:To:Cc:Subject:Date;
	b=LIW7qHmN2grs0WKyl9v625HJN+9KFnAo7zRT3l+G2cjuk0q2lYmESaB1oQmZLrdfl
	 OLCw5847lswFV8+uQPxyu97jZ7J1Rj041F/XMF6r3iZBv9XSnfCcecepeuolH/oWyL
	 c38zV1dqL3tZ4qCwxtajF6h5YwgM9IDUeHmw3uDE=
Received: from ubuntu24.. ([120.244.194.103])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D92B063; Tue, 02 Dec 2025 20:03:25 +0800
X-QQ-mid: xmsmtpt1764677005tmuvoslfm
Message-ID: <tencent_1C06EA434AF2CC3A0A871786BDE18996A505@qq.com>
X-QQ-XMAILINFO: MmXTV/GPeIxTZYBVWvT4TYZPN9j8tWs3T7Ci5NfE4JMVCEE7Dkfn0lqrZT/dJy
	 6tvR8RPwlF+vG9iPjJ4ve+nt/XySlm6itlc5m/YNrZGEhskhcUEpqzxS08u9FJDvaf2EtQG8Qwn0
	 4NubCcNUZx8AdoZ1icSA3qj3Sb1E+Q+MYd5KOgVb6k1nAAqacjd/u++nTF8BhsW1FsRxLQKp8LF8
	 C+n0A0EZSL5O8ko+H9Jv6kgqz0iteSN48ITftsEvUkOKnmrM3QCSW0osTkeTGre/Z6EN6LQNiH9W
	 z6CYQWTy4yPhin1uguYNFyr6DixV0TsQaLujdQpCF7L9kDrg3tASaM/zZiQnN8W11wfTqFclqbYS
	 xRMAMdOK811nKW6eKTK2m33GmEBF1iDY9RBCrigDUWsKz7s0bXagixrRQJ7v4ST+16rcWYmQbKfn
	 /B3JQfXeCDmUBGGmOyrkKxYHx0xCRvA4lf6PCZyiO+HdJ8B8vqhhj+eQf3vLdoczJhLjiZAdjHrM
	 AK2ehnPK54PIgOaaPQplaS4ZkePKhxhiCIInDRARQfjFkvkbDy6LDJWPW+7QhQOwHaVcRCadB9CF
	 iwJl1B904QtKfLosb2ADELwcIACnPRq/nW/V83YfF4MpTj0EByprtu7rgw4NUPGZ12StBpAJpVgy
	 PPvDe4zy6IJAKzQ7EoL6qWkmUZOnnf0URw4LdKuLxARIwoXsQhIOG+huIoS5oEj+jAzpRBovsuTF
	 sEbGU8R4jgwBsoK+Q5jk11JstpsVkk1JgsGQEnuJRGbRabSlo2R4lHdta8Jd6NFiizcap+3+kAR7
	 9lAT6LNAO2a/3I7Vo8Tjp64DClhJzdSznGW5BBP0IXw67YnyeYJCCJR9rEa/hsrQyoejR++JEbW1
	 SGMdkKvZ8UtBa7fqRT8vWtikdXosRSZVmVpRTRKttISi4B21tGUtPxjXFqkuueL/wFSo6ndNqJA4
	 DIodTa5YtvcqyFyxy179qqGz8Xs+BUf6v/AMT8W8JuclglfS8N2y/OfiXmkg2waBpqJfPZ7rbiZo
	 zbkj8afT8pbDecn0Z/kInpnhwdvGqAzmqW2gH/9/raRVAy4kT/N8cc8DpPB8AS83o5SQBsDn4eMx
	 E5vSEx
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	syzbot+316db8a1191938280eb6@syzkaller.appspotmail.com,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 5.10.y] ovl: fix UAF in ovl_dentry_update_reval by moving dput() in ovl_link_up
Date: Tue,  2 Dec 2025 12:03:16 +0000
X-OQ-MSGID: <20251202120316.4369-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit c84e125fff2615b4d9c259e762596134eddd2f27 ]

The issue was caused by dput(upper) being called before
ovl_dentry_update_reval(), while upper->d_flags was still
accessed in ovl_dentry_remote().

Move dput(upper) after its last use to prevent use-after-free.

BUG: KASAN: slab-use-after-free in ovl_dentry_remote fs/overlayfs/util.c:162 [inline]
BUG: KASAN: slab-use-after-free in ovl_dentry_update_reval+0xd2/0xf0 fs/overlayfs/util.c:167

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 ovl_dentry_remote fs/overlayfs/util.c:162 [inline]
 ovl_dentry_update_reval+0xd2/0xf0 fs/overlayfs/util.c:167
 ovl_link_up fs/overlayfs/copy_up.c:610 [inline]
 ovl_copy_up_one+0x2105/0x3490 fs/overlayfs/copy_up.c:1170
 ovl_copy_up_flags+0x18d/0x200 fs/overlayfs/copy_up.c:1223
 ovl_rename+0x39e/0x18c0 fs/overlayfs/dir.c:1136
 vfs_rename+0xf84/0x20a0 fs/namei.c:4893
...
 </TASK>

Fixes: b07d5cc93e1b ("ovl: update of dentry revalidate flags after copy up")
Reported-by: syzbot+316db8a1191938280eb6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=316db8a1191938280eb6
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://lore.kernel.org/r/20250214215148.761147-1-kovalev@altlinux.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Minor context change fixed. ]
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 fs/overlayfs/copy_up.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 65ac504595ba..a1ec45fc77d8 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -469,7 +469,6 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ovl_dentry_upper(c->dentry), udir, upper);
-		dput(upper);
 
 		if (!err) {
 			/* Restore timestamps on parent (best effort) */
@@ -477,6 +476,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 			ovl_dentry_set_upper_alias(c->dentry);
 			ovl_dentry_update_reval(c->dentry, upper);
 		}
+		dput(upper);
 	}
 	inode_unlock(udir);
 	if (err)
-- 
2.43.0


