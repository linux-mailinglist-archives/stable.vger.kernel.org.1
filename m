Return-Path: <stable+bounces-87867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24B9ACCB2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6761C20DC7
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C631F4732;
	Wed, 23 Oct 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1Xq90r8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD671CACFE;
	Wed, 23 Oct 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693880; cv=none; b=MebiwvUJIbPo1D5pKbYQ2MQZWuxixOPlfH0KVcYNNoD9Wk38RCE6yhtznyj5tKSFeu3++CnmferOIb4hZf9dBLj3zjpjT6R1+oXzroE1JyLJyZoDKsRPhORyzZul7F0DtD82fugokzuFm/n9ey8n6aYA/q4t82Jpl5TARaGvENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693880; c=relaxed/simple;
	bh=YxegO79K1or3ElJWhXqhvPSiJqRLpJzuIvFGm7gjo8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUXBDKxi909toL4Q4rNdGsvAYaDjTgjbhBD1Hnq1xkrLRLwT+xEFfzUdx/m0PHn5xVUE1KGojZX8fixHwwEgCp5CHKlK9tPECvJvwsCYKdYnZml9+P7+tVHplh58sFPjvbZGh8XUi6Wjke1Hy2ddQOyy2yho/hG6vd0XkUifEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1Xq90r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFF5C4CEE4;
	Wed, 23 Oct 2024 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693880;
	bh=YxegO79K1or3ElJWhXqhvPSiJqRLpJzuIvFGm7gjo8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1Xq90r8HRpAyWXENLcYspXFoWyfIKhhtKvEBxBNiaaLFDTxWvRHveVaQoUefFvi3
	 FOx2FkYYQpLcb/aNmRie5SEIACZEoTP+UaYJllFPHh76PPp6yLZ18xIi97t72+dwDJ
	 xYvgpoyVUh4LEFqJxr5ElX8YMxgeZpzDPAhl639YBSiQ5VKkx/Zul+DRJt4GcPJhyg
	 NQu8pjiPILZjUgsI9JsIk/R2+IPHFzgDEvk0RNvhyS8yHunUFsJS28XYvzP7t6AOio
	 k9ZRKif4hocv7yT6QLxZWdej6oWTpSSVskg6tTNvz/qG+lQoUYlIba9OQQRyQ/+roy
	 dKHtf4MEzWt/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
	syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 02/23] 9p: Avoid creating multiple slab caches with the same name
Date: Wed, 23 Oct 2024 10:30:46 -0400
Message-ID: <20241023143116.2981369-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Pedro Falcato <pedro.falcato@gmail.com>

[ Upstream commit 79efebae4afc2221fa814c3cae001bede66ab259 ]

In the spirit of [1], avoid creating multiple slab caches with the same
name. Instead, add the dev_name into the mix.

[1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato@gmail.com/

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
Reported-by: syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com
Message-ID: <20240807094725.2193423-1-pedro.falcato@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/client.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index b05f73c291b4b..e7ea6c5c7463d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -978,6 +978,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
@@ -1034,15 +1035,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err)
 		goto close_trans;
 
+	cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
+	if (!cache_name) {
+		err = -ENOMEM;
+		goto close_trans;
+	}
+
 	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
 	 * followed by data accessed from userspace by read
 	 */
 	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+		kmem_cache_create_usercopy(cache_name, clnt->msize,
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
 
+	kfree(cache_name);
 	return clnt;
 
 close_trans:
-- 
2.43.0


