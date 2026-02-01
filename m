Return-Path: <stable+bounces-213004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BwsDvuHf2lutAIAu9opvQ
	(envelope-from <stable+bounces-213004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 18:06:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A151FC6988
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 18:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDB53006B62
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5519257825;
	Sun,  1 Feb 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec9KAVJr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B12126C02;
	Sun,  1 Feb 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965552; cv=none; b=ir+4/54YXDPgRxkqcS+xROqHXQVSrWwtloIye0qi0Kcz+GNKGJosJNVym5vfPS2SVKwWi75dFXDLXmw9GeFPy3irPlny7POnI4IWtmIqy/hldantTMk2IWmT3JHIU4JI5CwxcOZOlFa+w5cwpKsNndK+P3EKrCZp2tbHsGPMLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965552; c=relaxed/simple;
	bh=v3ZnNB5Rl3F5t4u7Ylebj0GvWw7ysqQxa2V+IZ3dBRc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=lrokOlPA2+H4HQJZZYbBK81FeflXUA+EsAMqL4zfqrcy3D44K63lDuXfUcJV32Gnoe4PUnWA/mUEalXGC5jPyfSxd5rBjsgG6n/SFb/kX2eLXFQY3zfzLq09x2pAtcc+e2a0/WSEJ+ynaCFb1jfQ+tlgbr8suaowYvLwF+TDiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec9KAVJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02F2C4CEF7;
	Sun,  1 Feb 2026 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769965552;
	bh=v3ZnNB5Rl3F5t4u7Ylebj0GvWw7ysqQxa2V+IZ3dBRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ec9KAVJrbGmuD+cBR0hdQvFROza83pG+J5SI+ttwNZnNZb4JyBZgsd7ICKDHBClYt
	 azCSxfpFJRaTcSroKS/AX580O2/PpH1b/UBIN6s6Drt5YjbGQX/q0X6cd9ug4ZgmxV
	 J14N+GKqahLWQ/lxisHY6EoMOq7AYYMgqIhVvBQYll4VdfIbgcOdugHVFkyoGbkdXx
	 Q//YEr7hfYUy5vUf4xRQpGy+pVLeX/gmlYo7WrrKvEMAVfeHhoP+XJAY4WvcFSNoPb
	 NI3fb0BdPnkxqW4qhIXfUjI4XUmgI+EyqZAp7C12r68dgOaOKM8Z7rWSWn7lY2ACY8
	 3ych/JLbIDuLg==
Date: Sun, 01 Feb 2026 07:05:50 -1000
Message-ID: <f5fe5674adee792e663a86d680d836c5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Rosenberg <whrosenb@asu.edu>, Oliver Rosenberg <olrose55@gmail.com>,
 杜义恒 <duyiheng@tju.edu.cn>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] kernfs: fix NULL pointer dereference in __kernfs_new_node()
In-Reply-To: <AOoAIQD0J-9V1NW0JM55A4po.1.1769761572059.Hmail.3019244382@tju.edu.cn>
References: <AOoAIQD0J-9V1NW0JM55A4po.1.1769761572059.Hmail.3019244382@tju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213004-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[asu.edu,gmail.com,tju.edu.cn,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A151FC6988
X-Rspamd-Action: no action

Commit 382b1e8f30f7 ("kernfs: fix memory leak of kernfs_iattrs in
__kernfs_new_node") introduced an err_out4 error path which frees iattr
when security_kernfs_init_security() fails. However, iattr is only
allocated by __kernfs_setattr() when the node has non-default uid/gid.
If the node uses default ownership, iattr remains NULL, and
security_kernfs_init_security() failure would cause a NULL pointer
dereference when err_out4 tries to access kn->iattr->xattrs.

Add a NULL check before freeing iattr.

Fixes: 382b1e8f30f7 ("kernfs: fix memory leak of kernfs_iattrs in __kernfs_new_node")
Cc: stable@vger.kernel.org
Reported-by: 杜义恒 <duyiheng@tju.edu.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5c0efd6b239f..29baeeb97871 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -681,8 +681,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;

  err_out4:
-	simple_xattrs_free(&kn->iattr->xattrs, NULL);
-	kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
+	if (kn->iattr) {
+		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
+	}
  err_out3:
 	spin_lock(&root->kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
--
2.47.2

